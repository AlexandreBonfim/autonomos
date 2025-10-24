class Api::V1::SessionsController < ApplicationController
  # No authenticate! here
  def signup
    user = User.new(signup_params)
    if user.save
      render json: { token: Auth::IssueToken.call(user) }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { token: Auth::IssueToken.call(user) }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def signup_params
    params.permit(:email, :name, :password, :password_confirmation, :tax_id)
  end
end
