class EventsController < ApplicationController
	before_action :set_event, only:[:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except:[:index, :show]
	# before_action :authorize_owner!, only: [:edit, :update, :destroy]
	
	def currentuser

    @events = Event.where(user_id: current_user).order('created_at DESC')
	end

	def index
		if params[:query].present?
      		@events = Event.search(params[:query])
		else
			@events = Event.all.order("created_at DESC")
		end
		@categories = Category.order(:name)
		authorize @events, :index?
	end

	def new
		@event  = Event.new

		authorize @event, :new?
	end

	def create
		@event = Event.new(event_params)
		@event.organizer = current_user

		authorize @event, :create?

		if @event.save
			flash[:notice] = "Event was created"
			redirect_to @event 
		else
			flash.now[:alert] = "Event was not created"
			render 'new'
		end
	end

	def show
	end

	def edit
		authorize @event, :edit?
	end

	def update
		authorize @event, :update?

		if @event.update(event_params)
			redirect_to @event 
		else
			render 'edit'
		end
	end

	def destroy
		authorize @event, :destroy?
		@event.destroy
		flash[:alert] = "Event deleted successfully"
		redirect_to events_path
	end

	private

	def event_params
		params.require(:event).permit(:title, :description, :start_date, :end_date, :venue, :location, :image)
	end

	def set_event
		@event = Event.friendly.find(params[:id])
		
		rescue ActiveRecord::RecordNotFound
			flash[:alert] = "The page you requested does not exist"
			redirect_to root_path
	end

	# def authorize_owner!
	# 	authenticate_user!

	# 	unless @event.organizer == current_user 
	# 		flash[:alert] = "You do not have permission to '#{action_name}' the '#{@event.title.upcase}' event"
	# 		redirect_to root_path
	# 	end
	# end
end
