class Setup < ActiveRecord::Base
	has_many :tournaments

	validates :name,
						presence: true,
						uniqueness: true

end
