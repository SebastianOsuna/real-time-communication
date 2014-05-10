class UsersController < ApplicationController
    # POST@/users/
    def identify
        user = User.find_or_create_by_name params[:username]
        render json: user
    end
end
