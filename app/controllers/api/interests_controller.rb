class Api::InterestsController < Api::ApplicationController
	before_filter :authenticate
	def new
		render :text=>params.inspect
	end

end