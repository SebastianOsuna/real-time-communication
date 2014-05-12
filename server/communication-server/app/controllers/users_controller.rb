class UsersController < ApplicationController
    # POST@/users/
    # @param: username - User's name
    def identify
        user = User.find_or_create_by_name params[:username]
        render json: user
    end
end
