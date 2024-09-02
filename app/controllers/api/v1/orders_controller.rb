# app/controllers/api/v1/orders_controller.rb
module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        order = current_api_v1_user.orders.new(order_params)

        if order_params[:order_items_attributes].blank?
          render json: { status: 'ERROR', message: 'Order items are required' }, status: :unprocessable_entity
          return
        end

        order.total_price = calculate_total_price(order_params[:order_items_attributes])

        if order.save
          create_order_items(order, order_params[:order_items_attributes])
          render json: { status: 'SUCCESS', message: 'Order created', data: order }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Order not created', errors: order.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        orders = current_api_v1_user.orders.includes(:order_items)
        render json: { status: 'SUCCESS', message: 'Loaded orders', data: orders }, status: :ok
      end

      def show
        order = current_api_v1_user.orders.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Loaded order', data: order }, status: :ok
      end

      def update
        order = current_api_v1_user.orders.find(params[:id])

        if order.update(order_params)
          render json: { status: 'SUCCESS', message: 'Order updated', data: order }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Order not updated', data: order.errors }, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.require(:order).permit(:status, :shipping_address, order_items_attributes: [:product_id, :quantity, :price])
      end

      def calculate_total_price(order_items_attributes)
        order_items_attributes.sum do |item|
          item[:quantity].to_i * item[:price].to_f
        end
      end

      def create_order_items(order, order_items_attributes)
        return unless order_items_attributes.present?

        order_items_attributes.each do |item_attrs|
          order.order_items.create(item_attrs)
        end
      end
    end
  end
end
