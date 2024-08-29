module Api
    module V1
      class ProductsController < ApplicationController
        skip_before_action :authenticate_user!, only: [:index]
  
        def index
          products = Product.all
          render json: { status: 'SUCCESS', message: 'Loaded all products', data: products }, status: :ok
        end
  
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
  
        def update
          product = Product.find_by(id: params[:id])
          if product.update(product_params)
            render json: { status: 'SUCCESS', message: 'Product updated', data: product }, status: :ok
          else
            render json: { status: 'ERROR', message: 'Product not updated', data: product.errors }, status: :unprocessable_entity
          end
        end
  
        def destroy
          product = Product.find_by(id: params[:id])
          if product&.destroy
            render json: { status: 'SUCCESS', message: 'Product deleted' }, status: :ok
          else
            render json: { status: 'ERROR', message: 'Product not deleted' }, status: :unprocessable_entity
          end
        end
  
        private
  
        def product_params
          params.require(:product).permit(:name, :description, :price)
        end
      end
    end
  end
  