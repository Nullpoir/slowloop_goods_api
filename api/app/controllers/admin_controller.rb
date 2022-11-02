class AdminController < ApplicationController
  before_action :authenticate_api_user!
end
