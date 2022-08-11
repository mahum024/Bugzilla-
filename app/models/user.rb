# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum user_type: { developer: 0, manager: 1, qa: 2 }
  has_and_belongs_to_many :projects
  has_many :bugs, dependent: :destroy

  validates :user_type, inclusion: { in: user_types.keys }
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
end
