# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :creator, class_name: 'user', foreign_key: 'creator_id', optional: true
  belongs_to :developer, class_name: 'user', foreign_key: 'developer_id', optional: true
  belongs_to :project
  has_one_attached :screenshot

  enum type_of_bug: { feature: 0, bug: 1 }
  enum status: { new_bug: 0, started: 1, completed: 2, resolved: 3 }
end
