# app/controllers/api/v1/carts_controller.rb
module Api
    module V1
      class CartsController < ApplicationController
        before_action :authenticate_api_v1_user!, except: [:index, :show]
  
        def show
          cart = @current_user.cart || @current_user.create_cart
          render json: { status: 'SUCCESS', message: 'Loaded cart', data: cart.as_json(include: :cart_items) }, status: :ok
        end
  
        def add_item
            cart = current_user.cart || current_user.create_cart
            item = cart.cart_items.find_by(product_id: params[:product_id])
    
            if item
              item.quantity += params[:quantity].to_i
            else
              item = cart.cart_items.build(product_id: params[:product_id], quantity: params[:quantity])
            end
    
            if item.save
              render json: { status: 'SUCCESS', message: 'Item added to cart', data: cart.as_json(include: :cart_items) }, status: :ok
            else
              render json: { status: 'ERROR', message: 'Failed to add item to cart', data: item.errors.full_messages }, status: :unprocessable_entity
            end
        end
  
        def remove_item
          cart = @current_user.cart
          item = cart.cart_items.find_by(product_id: params[:product_id])
          if item&.destroy
            render json: { status: 'SUCCESS', message: 'Item removed from cart', data: cart.as_json(include: :cart_items) }, status: :ok
          else
            render json: { status: 'ERROR', message: 'Failed to remove item from cart' }, status: :unprocessable_entity
          end
        end
  
        def clear_cart
          cart = @current_user.cart
          cart.cart_items.destroy_all
          render json: { status: 'SUCCESS', message: 'Cart cleared', data: cart }, status: :ok
        end
      end
    end
  end
  