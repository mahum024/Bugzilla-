# frozen_string_literal: true

class CreateUsersProjectsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :projects
  end
end
