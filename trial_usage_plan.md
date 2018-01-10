# Trial Usage Plan

## The Idea

The goal of a trial usage plan is to offer a service that can only be used once every n units of time.

This method will accomplish this by only permitting the user to select the plan if the user's usage has expired. This prevents them from continuously "purchasing" the free trial plan. To do this, set the usage plan expiration to the trial timeframe, and the time plan to the desired amount of access time the user should have within the trial frame.

Example: 2-hour trial per month:
 - Usage Expiration: 1 month
 - Time Plan: 2 hours

## The Implementation

In your portal, edit the `views/usage_plan_list.erb` file and add the following if statement:

```erb
<% if @current_account.usage_plan != usage_plan || @current_account.usage_expiration.past? %>
```

(of course, also the `end` tag must be inserted.)

The surrounding code should then look like this:

```erb
<div class='uk-grid'>

  <% @usage_plans.each do |usage_plan|  %>

    <% if not @current_account or
          @current_account.usage_plan != usage_plan or
          usage_plan.name != 'trial' or
          @current_account.usage_expiration.past? %>
      <div class="uk-width-small-1-1 uk-width-large-1-2">

        <%= render :partial => 'usage_plan', :object => usage_plan %>

        <div class="rg-purchase-button">
          <%= render :partial => 'usage_plan_purchase_link', :locals => { :usage_plan => usage_plan, :merchant => @merchant } %>
        </div>

        <br/>

      </div>

    <% end %>

  <% end %>

</div>
```
