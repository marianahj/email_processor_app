class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end
  def show
    @order = Order.find(params[:id])
    @emails = @order.emails
    @processed_emails = @order.processed_emails
  end
end