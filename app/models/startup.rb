class Startup < ActiveRecord::Base
  belongs_to :user
  belongs_to :category, required: true
  has_many :founders, dependent: :destroy
  has_many :references, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :partners

  accepts_nested_attributes_for :founders

  validates :name, presence: true

  scope :active, -> { where is_active: true }
  scope :submit_for_review, -> { where submit_for_review: true }

  after_destroy :cleanup_founders

  def cleanup_founders
    founders.update_all startup_id: nil
  end
end

# == Schema Information
#
# Table name: startups
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  category_id       :integer
#  name              :string
#  logo_url          :string
#  description       :text
#  pitch             :text
#  twitter_url       :string
#  facebook_url      :string
#  google_url        :string
#  linkedin_url      :string
#  youtube_url       :string
#  instagram_url     :string
#  crowdfunding_url  :string
#  is_active         :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  submit_for_review :boolean          default(FALSE), not null
#
# Indexes
#
#  index_startups_on_category_id  (category_id)
#  index_startups_on_user_id      (user_id)
#
