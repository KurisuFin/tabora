class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]
	before_action :ensure_that_operator, except: [:index, :show]

  def index
    @tournaments = Tournament.all
  end


  def show
		if current_user and @tournament.phase == 'enroll'
			if current_user.is_participant_of @tournament
				@participation = Participation.find_by user: current_user, tournament: @tournament
			else
				@participation = Participation.new
				@participation.tournament = @tournament
			end
		end
  end


  def new
    @tournament = Tournament.new
		@event = Event.find(params[:event_id])
		@games = Game.all
  end


  def edit
		@games = Game.all
  end


  def create
		params[:tournament][:event_id] = params[:event_id]
		modify_name
		@tournament = Tournament.new(tournament_params)
		@tournament.phase = 'enroll'

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tournament }
			else
				@event = Event.find(params[:event_id])
				@games = Game.all
        format.html { render action: 'new' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
		modify_name unless params[:tournament][:name].nil?

    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end

  private
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end


		def modify_name
			name = params[:tournament][:name].strip
			if name.length == 0
				params[:tournament][:name] = nil
			else
				params[:tournament][:name] = name
			end
		end


    def tournament_params
      params.require(:tournament).permit(:name, :event_id, :game_id, :phase)
		end

		def ensure_that_operator
			raise_forbidden if current_user.nil?
			event_id = params[:event_id] || @tournament.event_id
			event = Event.find(event_id)
			raise_forbidden unless current_user.is_operator_of event
		end
end
