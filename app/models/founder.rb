class Founder < ActiveRecord::Base
  belongs_to :startup
  belongs_to :user

  validates :name, presence: true
  validates :surname, presence: true
  # validates :startup, presence: true, on: :create

  before_save :set_user

  def full_name
    [name, surname].select(&:present?).join(' ')
  end

  def set_user
    self.user_id = startup.user_id
  end
end

# == Schema Information
#
# Table name: founders
#
#  id           :integer          not null, primary key
#  startup_id   :integer
#  name         :string
#  surname      :string
#  position     :string
#  description  :text
#  quote        :text
#  linkedin_url :string
#  photo_url    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_founders_on_startup_id  (startup_id)
#
