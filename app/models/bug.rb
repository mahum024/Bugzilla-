# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :creator, class_name: 'user', optional: true
  belongs_to :developer, class_name: 'user', optional: true
  belongs_to :project
  has_one_attached :screenshot

  enum type_of_bug: { feature: 0, bug: 1 }
  enum status: { new_bug: 0, started: 1, completed: 2, resolved: 3 }

  validates :title, :deadline, :type_of_bug, :status, :creator_id, :project_id, presence: true
  validates_associated :project
  validates :title, uniqueness: { scope: :project_id }
  validates :type_of_bug, inclusion: { in: type_of_bugs.keys }
  validates :status, inclusion: { in: statuses.keys }
  validate :screen_shot_type

  private

  def screen_shot_type
    return unless screenshot.attached? && !screenshot.content_type.to_s.in?(%('image/png image/gif'))
      errors.add(:screen_shot, 'only support .png or .gif')
    
  end
end
