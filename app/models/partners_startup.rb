class PartnersStartup < ActiveRecord::Base
  belongs_to :partner
  belongs_to :startup
end

# == Schema Information
#
# Table name: partners_startups
#
#  partner_id :integer
#  startup_id :integer
#
# Indexes
#
#  index_partners_startups_on_partner_id  (partner_id)
#  index_partners_startups_on_startup_id  (startup_id)
#
