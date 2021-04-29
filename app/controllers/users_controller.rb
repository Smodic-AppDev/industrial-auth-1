class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :check_if_current_user, only: %i[ feed discover ]

  
  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def check_if_current_user
      if params[:username]
        if params.fetch(:username) != current_user.username
          redirect_back fallback_location: "/#{current_user.username}/feed", alert: "You can not view the feed or discover pages of other users."
        end
      end
    end

end