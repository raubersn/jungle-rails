class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "123"
  
  def show
  end
end
