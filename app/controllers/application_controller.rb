require 'authentication'
class ApplicationController < ActionController::Base
  include Authentication
  include ApplicationHelper
  protect_from_forgery
end
