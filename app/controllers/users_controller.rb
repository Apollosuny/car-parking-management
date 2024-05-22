class UsersController < ApplicationController
    def users
        @users = User.where(:role => 'user')
    end
end