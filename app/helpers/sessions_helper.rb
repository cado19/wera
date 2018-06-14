module SessionsHelper
	#Log in given user
	def login(user)
		session[:user_id] = user.id
	end

	#Return Current logged in user if any
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end

	
end
