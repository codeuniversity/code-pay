class PaypalController < ApplicationController

    before_action :authenticate_user!

    def create_payment
        render json: {error: 'no outstanding transactions'},status: 422 and return unless @current_user.has_outstanding_transactions

        build_payment
        if @payment.create
            render json: {payment_id: @payment.id}     # Payment Id
        else
            render json: @payment.error, status: 422  # Error Hash
        end
    end

    def execute_payment
        payment = PayPal::SDK::REST::Payment.find(paypal_params[:payment_id])
        if payment.execute(payer_id: paypal_params[:payer_id])
            fulfill_transactions(payment)
            render json: {status: "succes"}
        else
            redner json: payment.error, status: 422
        end
    end

    private
    def build_payment
        transactions = @current_user.outstanding_transactions
        amount = @current_user.outstanding_money
        item_list = transactions.map do |t|
            {
                name: t.item.name,
                sku: t.id,
                quantity: t.amount,
                price: t.item.price,
                currency: 'EUR'
            }
        end

        @payment = PayPal::SDK::REST::Payment.new({
            :intent =>  "sale",
            :payer =>  {
              :payment_method =>  "paypal" },
            :redirect_urls => {
              :return_url => "http://localhost:3005/",
              :cancel_url => "http://localhost:3005/" },
            :transactions =>  [{
              :item_list => {
                :items => item_list},
              :amount =>  {
                :total =>  amount.to_s,
                :currency =>  "EUR" },
              :description =>  "This is the payment transaction description." }]})
    end

    def fulfill_transactions(payment)
        payment.transactions.each do |transaction|
            transaction.item_list.items.each do |item|
                t = Transaction.find(item.sku)
                t.status = 'done'
                receiver = t.receiver
                receiver.balance += t.cost
                Transaction.transaction do
                    receiver.save!
                    t.save!
                end
            end
        end
    end

    def paypal_params
        # byebug
        params.require(:paypal).permit(:payment_id, :payer_id)
      end
end
