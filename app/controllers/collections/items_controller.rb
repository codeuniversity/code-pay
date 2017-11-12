class Collections::ItemsController < ItemsController
    before_action :set_collection

    # GET /items
    def index
        @items = @collection.items
        render json: @items
    end

    private
    def set_collection
        @collection = Collection.find(params[:collection_id])
    end
end