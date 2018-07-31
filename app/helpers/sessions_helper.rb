module SessionsHelper
	#Log in given user
	def login_user(user)
		session[:user_id] = user.id
	end

	#Log in owner
  def login_owner(owner)
    session[:owner_id] = owner.id
  end

	#Return Current logged in user if any
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def current_owner
    @current_owner ||= Owner.find_by(id: session[:owner_id])
  end

	def user_logged_in?
		!current_user.nil?
	end

	def owner_logged_in?
    !current_owner.nil?
  end
end
