class WelcomeController < ApplicationController
	skip_around_action :scope_current_account
end
