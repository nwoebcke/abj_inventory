class PartsController < ApplicationController
	def list
		@parts = Part.order("parts.")
	end
end
