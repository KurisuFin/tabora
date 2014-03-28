class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]
	before_action :ensure_that_operator, except: [:index, :show]


  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
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

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
		set_other_instance_variables
  end

  # GET /tournaments/1/edit
  def edit
		@games = Game.all
		@setups = Setup.all
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
		params[:tournament][:event_id] = params[:event_id]
		modify_name
		@tournament = Tournament.new(tournament_params)

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tournament }
			else
				set_other_instance_variables
        format.html { render action: 'new' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
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

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

		def set_other_instance_variables
			@event = Event.find(params[:event_id])
			@games = Game.all
			@setups = Setup.all
		end

		def modify_name
			name = params[:tournament][:name].strip
			if name.length == 0
				params[:tournament][:name] = nil
			else
				params[:tournament][:name] = name
			end
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:name, :event_id, :game_id, :setup_id, :phase)
		end

		def ensure_that_operator
			raise_forbidden if current_user.nil?
			event_id = params[:event_id] || @tournament.event_id
			event = Event.find(event_id)
			raise_forbidden unless current_user.is_operator_of event
		end
end
