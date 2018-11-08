#!/usr/bin/env ruby

# This script creates or updates WAV's admin role and admins.

# get rails env
require '/space/rxg/console/config/boot_script_environment'

# disable paging (for pasting into pry)
_pry_.config.pager = false

# admin dict
admin_and_public_keys = {
  'gns': 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAizOg1IZjezR22uwK7Qp4Qa1uGxS+y+3ae8hIyzq8u3TpvqbLcbZ/dq+22b+CEOYAWRUhfgM/5ltRdsVCzMEgkvL8w+jLdv7rxRtvHp1XhSjsOKW5pQoiiTetOlOUfNQ+eIPh78kcgHIkg3Z9ISz86mL840e4FWs/wyD2GSvskjEVUT5l6K7gDjJuVMFsEc49A9B6rePpjRDSCwQ3n7/TSwGkA5tsTnt27HvKbz3UQ6mNsg/QZmLVWiWDaMk3vKQEWPn+pbSOkBYXhT6mye05235nyu4f1rvzbd51Ko0ZBhiDoNArhpuF9KRCllip0QpETR1DJd15IB38K0CYE1A4NQ==',
  'sra': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnXlUQLDvYlCUTNhoSQAYpnKt82nlP7phW5lzdBIA0MY8PWUOIve5UGrubIo/RJOrCKZtMSD+GnzkV0Kq7+gr3MwfT9xPx3udN2yjCcliTG46DGQYAe6BSOPt2Qh/1ZaoAjHOMSsxUuEH3RtbfHpE5emWLx+9RNBMkKxYhcXks7hah8l0fAsk4zJXkBsxlI+sYlAiVTw5b/ejCsk/sz/Oyh5yUyNiH5FBGfIe15rtFZC+hrsRufjDsXA+bWd+P5KPiq2PgQnyA2j+Lkp28amGQv+oMZTMkcbL1r8JcYXyf8QaIM0AC+LWWg5S0bT1l1lWk7EpP3FVjlOlKApGat+KR',
}

# WAV admin role
ar = AdminRole.find_or_create_by(name: 'WAV')
ar.ssh_enabled = true
ar.smb_enabled = true
ar.master_permission = 'readwrite'
ar.system_permission = 'readwrite'
ar.identities_permission = 'readwrite'
ar.policies_permission = 'readwrite'
ar.billing_permission = 'readwrite'
ar.archives_permission = 'readwrite'
ar.instruments_permission = 'readwrite'
ar.conference_mode = 'admin'
ar.save!

# WAV admins
admin_and_public_keys.each do |admin, public_key|
  a = Admin.find_by(login: admin) || Admin.new
  a.login = admin
  if not a.crypted_password
    pw = rand(36**16).to_s(36).rjust(16, '0')
    a.password = pw
    a.password_confirmation = pw
  end
  a.admin_role = ar
  a.company = 'WAV, Inc.'
  a.ssh_public_key = public_key
  a.save!
end



