# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


begin
  user = User.new
  user.name = 'Developer'
  user.email = 'developer@devsinc.com'
  user.password = '123456'
  user.password_confirmation = '123456'
  user.user_type = :developer
  user.save!
rescue ActiveRecord::RecordInvalid => invalid
  puts invalid.record.errors.full_messages
end

begin
 user = User.new
 user.name = 'Admin'
 user.email = 'admin@devsinc.com'
 user.password = '123456'
 user.password_confirmation = '123456'
 user.user_type = :manager
 user.save!
rescue ActiveRecord::RecordInvalid => invalid
  puts invalid.record.errors.full_messages
end
  
begin
   project1 = Project.create(name: "Project1",created_at: Date.today, updated_at: Date.today)
rescue ActiveRecord::RecordInvalid => invalid
    puts invalid.record.errors.full_messages
end

begin
  bug1 = Bug.create(title: "Bug1", description: "New Bug", deadline: Date.today, type_of_bug: "feature", status: "new_bug", creator_id: User.first.id, developer_id: User
  .first.id, created_at: Date.today, updated_at: Date.today, project_id: Project.first.id)
rescue ActiveRecord::RecordInvalid => invalid
    puts invalid.record.errors.full_messages
end
 
