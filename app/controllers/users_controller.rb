class UsersController < ApplicationController
  def index
    users = User.all
    render json: users, status: :ok
  end


  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone_number, :address, :region, :city)
    end
end
