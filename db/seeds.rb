user1 = User.create! username:'admin', password:'sala', password_confirmation:'sala', admin:true
user2 = User.create! username:'kimmo', password:'sala', password_confirmation:'sala'
user3 = User.create! username:'jorma', password:'sala', password_confirmation:'sala'
user4 = User.create! username:'ilona', password:'sala', password_confirmation:'sala'
user5 = User.create! username:'maaria', password:'sala', password_confirmation:'sala'
user6 = User.create! username:'nikolas', password:'sala', password_confirmation:'sala'
user7 = User.create! username:'kaisa', password:'sala', password_confirmation:'sala'
user8 = User.create! username:'tilli', password:'sala', password_confirmation:'sala'

event1 = Event.create! name:'Ultra'
event2 = Event.create! name:'Mega'

game1 = Game.create! name:'Nintendo-peli'
game2 = Game.create! name:'Guilty Gear XX Accent Core Plus R'
game3 = Game.create! name:'Moonstone'
game4 = Game.create! name:'Generally'

tournament1 = Tournament.create! event:event1, game:game1, phase: 'ended', name:'Nintendo-mestaruus'
tournament2 = Tournament.create! event:event1, game:game2, phase: 'ongoing'
tournament3 = Tournament.create! event:event1, game:game3, phase: 'ongoing', name:'Kuukiven metsästys'
tournament4 = Tournament.create! event:event1, game:game4, phase: 'enroll', name:'Gurulan kingi'
tournament5 = Tournament.create! event:event2, game:game2, phase: 'enroll'
tournament6 = Tournament.create! event:event2, game:game3, phase: 'enroll', name:'Kurisu\'s Amiga Challenge'

Operator.create! user:user2, event:event1


# Tournament 1 - finished
Participation.create! user:user1, tournament:tournament1
Participation.create! user:user2, tournament:tournament1
Participation.create! user:user3, tournament:tournament1
Participation.create! user:user4, tournament:tournament1
battle_t1_1 = Battle.create! tournament:tournament1, name: 'Battle #1', state:'finished'
battle_t1_2 = Battle.create! tournament:tournament1, name: 'Battle #2', state:'finished'
battle_t1_3 = Battle.create! tournament:tournament1, name: 'Battle #3', state:'finished'
battle_t1_1.postbattles = [battle_t1_3]
battle_t1_2.postbattles = [battle_t1_3]
Act.create! user:user1, battle:battle_t1_1, score:1
Act.create! user:user2, battle:battle_t1_1, score:0
Act.create! user:user3, battle:battle_t1_2, score:0
Act.create! user:user4, battle:battle_t1_2, score:1
Act.create! user:user1, battle:battle_t1_3, score:1
Act.create! user:user4, battle:battle_t1_3, score:0

# Tournament 2 - ongoing, partly played
Participation.create! user:user1, tournament:tournament2
Participation.create! user:user2, tournament:tournament2
Participation.create! user:user3, tournament:tournament2
Participation.create! user:user4, tournament:tournament2
Participation.create! user:user5, tournament:tournament2
Participation.create! user:user6, tournament:tournament2
Participation.create! user:user7, tournament:tournament2
Participation.create! user:user8, tournament:tournament2
battle_t2_1 = Battle.create! tournament:tournament2, name: 'Battle #1', state:'finished'
battle_t2_2 = Battle.create! tournament:tournament2, name: 'Battle #2', state:'finished'
battle_t2_3 = Battle.create! tournament:tournament2, name: 'Battle #3', state:'finished'
battle_t2_4 = Battle.create! tournament:tournament2, name: 'Battle #4', state:'pending'
battle_t2_5 = Battle.create! tournament:tournament2, name: 'Battle #5', state:'pending'
battle_t2_6 = Battle.create! tournament:tournament2, name: 'Battle #6', state:'pending'
battle_t2_7 = Battle.create! tournament:tournament2, name: 'Battle #7', state:'pending'
battle_t2_1.postbattles = [battle_t2_5]
battle_t2_2.postbattles = [battle_t2_5]
battle_t2_3.postbattles = [battle_t2_6]
battle_t2_4.postbattles = [battle_t2_6]
battle_t2_5.postbattles = [battle_t2_7]
battle_t2_6.postbattles = [battle_t2_7]
Act.create! user:user1, battle:battle_t2_1, score:1
Act.create! user:user2, battle:battle_t2_1, score:0
Act.create! user:user3, battle:battle_t2_2, score:1
Act.create! user:user4, battle:battle_t2_2, score:0
Act.create! user:user5, battle:battle_t2_3, score:1
Act.create! user:user6, battle:battle_t2_3, score:0
Act.create! user:user7, battle:battle_t2_4, score:1
Act.create! user:user8, battle:battle_t2_4, score:0
Act.create! user:user1, battle:battle_t2_5, score:0
Act.create! user:user3, battle:battle_t2_5, score:0
Act.create! user:user5, battle:battle_t2_6, score:0

# Tournament 3 - ongoing, just started
Participation.create! user:user1, tournament:tournament3
Participation.create! user:user2, tournament:tournament3
Participation.create! user:user3, tournament:tournament3
Participation.create! user:user4, tournament:tournament3
battle_t3_1 = Battle.create! tournament:tournament3, name: 'Battle #1', state:'pending'
battle_t3_2 = Battle.create! tournament:tournament3, name: 'Battle #2', state:'pending'
battle_t3_3 = Battle.create! tournament:tournament3, name: 'Battle #3', state:'pending'
battle_t3_1.postbattles = [battle_t3_3]
battle_t3_2.postbattles = [battle_t3_3]
Act.create! user:user1, battle:battle_t3_1, score:0
Act.create! user:user2, battle:battle_t3_1, score:0
Act.create! user:user3, battle:battle_t3_2, score:0
Act.create! user:user4, battle:battle_t3_2, score:0

# Tournament 4 - enroll, ready to be started
Participation.create! user:user5, tournament:tournament4
Participation.create! user:user6, tournament:tournament4
Participation.create! user:user7, tournament:tournament4
Participation.create! user:user8, tournament:tournament4

# Tournament 5 - enroll, three participations
Participation.create! user:user1, tournament:tournament5
Participation.create! user:user2, tournament:tournament5
Participation.create! user:user3, tournament:tournament5


















