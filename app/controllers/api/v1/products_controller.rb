# app/controllers/api/v1/products_controller.rb
module Api
    module V1
      class ProductsController < ApplicationController
        def create
          product = Product.new(product_params)
          if product.save
            render json: { status: 'SUCCESS', message: 'Product created', data: product }, status: :ok
          else
            render json: { status: 'ERROR', message: 'Product not created', data: product.errors }, status: :unprocessable_entity
          end
        end
  
        def show
          product = Product.find_by(id: params[:id])
          if product
            render json: { status: 'SUCCESS', message: 'Loaded product', data: product }, status: :ok
          else
            render json: { status: 'ERROR', message: 'Product not found', data: {} }, status: :not_found
          end
        end
  
        private
  
        def product_params
          params.require(:product).permit(:name, :description, :price)
        end
      end
    end
  end
  