# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(name: "Herr Soundso", email: "test@test2.com", password: "123", password_confirmation: "123", state:15, account_type: 0)
if u.save
  STDOUT.puts "Herr Soundso created!"
else
  STDOUT.puts "Something went wrong!"
end
u = User.create(name: "Ibo", email: "test1@test.com", password: "123", password_confirmation: "123", capabilities: "admin", state:15, account_type: 0)
if u.save
  STDOUT.puts "Ibo created!"
else
  STDOUT.puts "Something went wrong!"
end
u = User.create(name: "Alex", email: "test2@test.com", password: "123", password_confirmation: "123", capabilities: "admin", state:15, account_type: 0)
if u.save
  STDOUT.puts "Alex created!"
else
  STDOUT.puts "Something went wrong!"
end

