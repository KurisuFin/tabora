class OperatorsController < ApplicationController
  before_action :set_operator, only: [:destroy]
	before_action :ensure_that_operator

  def new
    @operator = Operator.new
		@users = User.all
  end


  def create
    params[:operator][:event_id] = params[:event_id]
		@operator = Operator.new(operator_params)

    respond_to do |format|
      if @operator.save
        format.html { redirect_to @operator.event, notice: 'Operator was successfully created.' }
        format.json { render action: 'show', status: :created, location: @operator.event }
			else
				@users = User.all
				@events = Event.all
        format.html { render action: 'new' }
        format.json { render json: @operator.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @operator.destroy
    respond_to do |format|
      format.html { redirect_to @operator.event }
      format.json { head :no_content }
    end
  end


  private
    def set_operator
      @operator = Operator.find(params[:id])
    end


    def operator_params
      params.require(:operator).permit(:user_id, :event_id)
		end


		def ensure_that_operator
			raise_forbidden if current_user.nil?
			event_id = params[:event_id]
			event = Event.find(event_id)
			raise_forbidden unless current_user.is_operator_of event
		end
end
