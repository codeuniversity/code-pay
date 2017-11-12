class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /items
  def index
    if @collection
      @items = @collection.items
    else
      @items = Item.all
    end
    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    if @collection
      @item = @collection.items.new(item_params)
    else
      @item = Item.new(item_params)
    end

    if @item.collection && @item.collection.user != @current_user
      render json: {error:'you may not add an item to a foreign collection'}, status: 403 and return
    end

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.user != @current_user
      render json: {error:'you may not update an item of a foreign collection'}, status: 403 and return
    end

    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    if @item.user != @current_user
      render json: {error:'you may not delete an item of a foreign collection'}, status: 403 and return
    end
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :price, :amount, :collection_id)
    end
end
