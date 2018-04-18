class Api::BraintreeController < ApplicationController
  def token
    render json: ENV['BRAINTREE_DROPIN_TOKEN']
  end

  def payment
    result = Braintree::Transaction.sale(
      amount: params[:amount],
      payment_method_nonce: params[:nonce],
      options: {
        submit_for_settlement: true
      }
    )

      if result.success?
        render json: result.transaction.id
      elsif result.transaction
        text = "text: #{result.transaction.processor_reponse_text}"
        code = "code: #{result.transaction.processor_code}"

        render json: { errors: { text: text, code:}}

  end
end