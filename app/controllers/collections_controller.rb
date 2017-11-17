class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /collections
  def index
    mine = params[:mine] || false
    if mine
      @collections = @current_user.collections.order(created_at: :desc)
    else
      @collections = Collection.where(public: true)
    end
    render json: @collections
  end

  # GET /collections/1
  def show
    render json: @collection
  end

  # POST /collections
  def create
    @collection = Collection.new(collection_params)
    @collection.user = @current_user
    if @collection.save
      render json: @collection, status: :created, location: @collection
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /collections/1
  def update
    if @collection.user != @current_user
      render json: {error:'you may not update a foreign collection'}, status: 403 and return
    end
    if @collection.update(collection_params)
      render json: @collection
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  # DELETE /collections/1
  def destroy
    if @collection.user != @current_user
      render json: {error:'you may not destroy a foreign collection'}, status: 403 and return
    end
    @collection.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def collection_params
      params.require(:collection).permit(:name, :user_id)
    end
end
