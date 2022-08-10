# frozen_string_literal: true

class Project < ApplicationRecord
  has_and_belongs_to_many :users, dependent: :destroy
  has_many :bugs, dependent: :destroy
  validates :name, presence: true

 

end
