class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy, :pay]
  before_action :authenticate_user!

  # GET /transactions
  def index
    @transactions = @current_user.transactions.order(created_at: :desc)
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
    if @transaction.save(context: :create)
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def pay
    render json: { balance: "you dont have enough to pay" },status: :unprocessable_entity and return if @current_user.balance < @transaction.cost
    render json: { status: "you dont want to pay for a transaction, that was already paid" }, status: :unprocessable_entity and return if @transaction.status == "done"
    receiver = @transaction.receiver
    User.transaction do
      @current_user.balance -= @transaction.cost
      receiver.balance += @transaction.cost
      @transaction.status = 'done'
      receiver.save!
      @current_user.save!
      @transaction.save!
    end
    render json: @transaction
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
