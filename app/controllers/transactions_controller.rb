class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /transactions
  def index
    @transactions = @current_user.transactions.order(created_at: :desc).limit(10)
    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = @current_user
    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:amount, :item_id)
    end
end
