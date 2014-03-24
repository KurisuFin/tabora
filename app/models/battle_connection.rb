class BattleConnection < ActiveRecord::Base
	belongs_to :battle
	belongs_to :postbattle, class_name: 'Battle'
end
