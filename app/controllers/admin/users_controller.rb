class Admin::UsersController < Admin::ApplicationController

	def index
		@users = User.order(:email)
		@events = Event.all
	end
end
