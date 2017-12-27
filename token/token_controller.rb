class Portal::TokenController < PortalController

# WARNING: modifying this file is not recommended unless you are familiar with
# developing for the Ruby on Rails web application framework!
#
# This class inherits the default portal's action methods from PortalController.
# Methods defined here will be available as custom of this custom portal
# controller.
  before_action :authorize
  before_action :disable_footnotes
  skip_before_action :enforce_configured_portal_controller

  def current_admin
    @current_admin ||= Admin.find_by_id(session[:admin_id]) if session[:admin_id]
  end

  def admin_logged_in?
    !!current_admin
  end

  def authorize
    unless admin_logged_in?
      session[:pre_login_uri] = request.fullpath
      return redirect_to :controller => '/admin/sessions', :action => :new
    end
=begin
    unless @current_admin.admin_role.read_archives?
      session[:pre_login_uri] = request.fullpath
      return redirect_to :controller => '/admin/sessions', :action => :destroy, :method => :delete
    end
=end
  end

  def disable_footnotes
    params[:footnotes]='false'
  end

  def show_tokens
    # Generate the Tokens
    t = Token.new
    t.character_code = 4
    t.length = 8
    if params[:qty].to_i <= 0
      t.copies = 1
    else
      t.copies = params[:qty]
    end
    t.usage_expiration = 0.days.from_now.end_of_day
    if params[:usage_mins].to_i <= 0
      t.usage_minutes = 120
    else
      t.usage_minutes = params[:usage_mins]
    end
    if params[:usage_mb].to_i <= 0
      t.usage_mb_down = 2001
      t.usage_mb_up = 2001
    else
      t.usage_mb_down = params[:usage_mb]
      t.usage_mb_up = params[:usage_mb]
    end
    t.account_group_id = params[:group][:id]
    t.save!

    tokens = Token.where(last_name: t.batch)
    if params[:pdf].to_i == 1
      # Generate the PDF
      labels = Prawn::Labels.render(tokens, type: 'Avery5160') do |pdf, token|
      pdf.font('Courier')
      pdf.move_down(10)
      pdf.text token.pretty_code, :align => :center, :size => 18
      pdf.move_down(10)
      pdf.text t.usage_expiration.to_date.to_s, :align => :center, :size => 10
      end
      send_data(labels, type: 'application/pdf', filename: sprintf('tokens-%s.pdf', t.batch))
    else
      @tokens = tokens
    end
  end

end
