class AddressesController < ApplicationController
    def index
        addresses = Address.all
        render json: orders, status: :ok
    end
    
      def show
      end
    
      def new
      
      end
    
      def edit
      end
    
      def create
      end
    
      # PATCH/PUT /orders/1 or /orders/1.json
      def update
      end
    
      # DELETE /orders/1 or /orders/1.json
      def destroy
      end
    
      private
    
        # Only allow a list of trusted parameters through.
        def order_params
          params.require(:address).permit(:user_id)
        end
end
