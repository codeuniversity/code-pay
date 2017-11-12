class Collections::ImagesController < ImagesController
    before_action :set_imageable

    def index
        @images = @imageable.images
        render json: @images
    end

    private
        def set_imageable
            @imageable = Collection.find(params[:collection_id])
        end
end