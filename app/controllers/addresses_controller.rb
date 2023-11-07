class AddressesController < ApplicationController
    def index
        addresses = Address.all
        render json: orders, status: :ok
    end
    

    def edit
      @address = Address.find(params[:id])
    end
  
    def create
      address = Address.new(address_params)

      if address.save
        render json: address, status: :created
      else
        render json: address.errors, status: :unprocessable_entity
      end
    end
    
    def update
      address = Address.find(params[:id])

      if @address.update(address_params)
        render json: address, status: :ok
      else
        render json: address.errors, status: :unprocessable_entity
      end
    end
    
    def destroy
      address = Address.find(params[:id])
      address.destroy
    
      render json: { message: 'Address deleted successfully' }, status: :o
    end
    
    private
  
      # Only allow a list of trusted parameters through.
      def address_params
        params.require(:address).permit(:user_id)
      end
end
