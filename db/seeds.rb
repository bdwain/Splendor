# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl_rails'

#for easier testing
if Rails.env == "development"
  user1 = FactoryGirl.create(:confirmed_user)
  user2 = FactoryGirl.create(:confirmed_user)
  game = Game.new({num_players: 2})
  game.creator = user1
  game.save
  game.add_user?(user2)
  game.save
end