class Api::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def show
    user = User.find(params[:id])
    render json: user, methods: [:avatar_url]
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :avatar)
  end
end
