class HomeController < ApplicationController
  def index
    user = User.find(1)
    puts user.role
  end
end
