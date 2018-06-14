class Maintenance::BaseController < ApplicationController
	skip_around_action :scope_current_account
	before_action :authorize
end