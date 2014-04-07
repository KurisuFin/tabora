class ActsController < ApplicationController
	before_action :set_act, only: [:update, :destroy]

	def update
		respond_to do |format|
			if @act.update(act_params)
				format.html { redirect_to @act.battle.tournament, notice: 'Act was successfully updated.' }
				format.json { head :no_content }
			else
				#TODO: Is this branch possible?
			end
		end
	end


	def destroy
		@act.destroy
		respond_to do |format|
			format.html { redirect_to @act.battle.tournament }
			format.json { head :no_content }
		end
	end


	private
		def set_act
			@act = Act.find(params[:id])
		end


		def act_params
			params.require(:act).permit(:user_id, :battle_id, :score)
		end
end
