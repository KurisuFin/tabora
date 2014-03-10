# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user1 = User.create! username:'jorma'
user2 = User.create! username:'pekka'
user3 = User.create! username:'hikikomori'

event1 = Event.create! name:'Hyper'
event2 = Event.create! name:'Mega'
event3 = Event.create! name:'Ultra'

game1 = Game.create! name:'Nintendo-peli'
game2 = Game.create! name:'Guilty Gear XX Accent Core Plus R'
game3 = Game.create! name:'Moonstone'
game4 = Game.create! name:'Generally'

tournament1 = Tournament.create! name:'Nintendo-mestaruus', event:event1, game:game1
tournament2 = Tournament.create! name:'Guilty Gear...', event:event1, game:game2
tournament3 = Tournament.create! event:event3, game:game2
tournament4 = Tournament.create! name:'Kurisu\'s Amiga Challenge', event:event3, game:game3

Participation.create! user:user1, tournament:tournament1
Participation.create! user:user1, tournament:tournament2
Participation.create! user:user1, tournament:tournament4
Participation.create! user:user2, tournament:tournament4