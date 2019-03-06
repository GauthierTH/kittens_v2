class ChargesController < ApplicationController

    def new
        @order = Order.find(params[:order_id])
        @amount = @order.amount
        @amount_in_cents = (@amount * 100).round
    end
    
    def create
      # Amount in cents
      @order = Order.find(params[:order_id])
      @amount = @order.amount
      @amount_in_cents = (@amount * 100).round
    
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
    
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @amount_in_cents,
        description: 'Rails Stripe customer',
        currency: 'usd',
      })

      @order.status = "paid"
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

end
