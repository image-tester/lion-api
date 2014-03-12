# == Schema Information
#
# Table name: pull_requests
#
#  id                  :uuid             not null, primary key
#  base_repo_full_name :string(255)
#  number              :integer
#  user_id             :uuid
#  created_at          :datetime
#  updated_at          :datetime
#

class PullRequest < ActiveRecord::Base
  include Scorable

  belongs_to :user

  attr_accessor :data, :merged

  validates :user, presence: true
  validates :number, presence: true, numericality: true
  validates :base_repo_full_name, presence: true
  validate :must_be_merged

  def data=(data)
    self.user ||= User.where(nickname: data['user']['login']).first
    self.base_repo_full_name ||= data['base']['repo']['full_name']
    self.number ||= data['number']
    self.merged ||= data['merged'].to_s

    @data = data
  end

  private

  def self.points
    15
  end

  def must_be_merged
    errors.add(:base, 'PR must be merged') unless merged == 'true'
  end
end