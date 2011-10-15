class UsersController < ApplicationController
  before_filter :login_required
  load_and_authorize_resource
end
