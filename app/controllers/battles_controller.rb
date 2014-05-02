class BattlesController < ApplicationController
  before_action :set_battle, only: [:update, :destroy]
	before_action :ensure_that_operator

  def update
		respond_to do |format|
      if @battle.update(battle_params)
        format.html { redirect_to @battle.tournament }
        format.json { head :no_content }
      else
        format.html { redirect_to @battle.tournament }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @battle.destroy
    respond_to do |format|
      format.html { redirect_to battles_url }
      format.json { head :no_content }
    end
  end


	private
    def set_battle
      @battle = Battle.find(params[:id])
    end


    def battle_params
      params.require(:battle).permit(:name, :state, :tournament_id)
		end


		def ensure_that_operator
			raise_forbidden if current_user.nil?
			battle = Battle.find(params[:id])
			raise_forbidden unless current_user.is_operator_of battle.tournament.event
		end
end
