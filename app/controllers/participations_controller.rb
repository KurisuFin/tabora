class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:destroy]

  def create
		@participation = Participation.new(participation_params)
		@participation.user_id = current_user.id

    respond_to do |format|
      if @participation.save
        format.html { redirect_to @participation.tournament, notice: 'Participation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @participation }
      else
        format.html { redirect_to @participation.tournament }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
		tournament = @participation.tournament
    @participation.destroy

    respond_to do |format|
      format.html { redirect_to tournament }
      format.json { head :no_content }
    end
  end


  private
    def set_participation
      @participation = Participation.find(params[:id])
    end


    def participation_params
      params.require(:participation).permit(:user_id, :tournament_id)
    end
end
