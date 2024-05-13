class SettingsController < ApplicationController
    def profile
        @profile = Profile.find(current_user.id)
    end

    def security
        @resource = current_user
    end
  end
  