class Collections::ItemsController < ItemsController
    before_action :set_collection

    private
    def set_collection
        @collection = Collection.find(params[:collection_id])
    end
end