class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # POST /images
  def create
    @image = Image.new(image_params)

    if @image.save
      render json: @image, status: :created, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /images/1
  def update
    if @image.update(image_params)
      render json: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1
  def destroy
    @image.destroy
  end

  # GET /signed_image_url
  def signed_image_url
    # filename = params[:filename]
    # if !filename
    #   render json: {error:'No filename specified'},status:422
    #   return
    # end
    options = {
      key: "uploads/#{SecureRandom.uuid}/${filename}",
      success_action_status: '201',
      acl: 'public-read',
      # content_type_starts_with: ''
    }
    presigned_post = S3_TEMP_BUCKET.presigned_post(options)
    # byebug
    if presigned_post
      render plain: { presignedPost: { fields: presigned_post.fields, url: presigned_post.url } }.to_json, status: 200, content_type: 'application/json'
    else
      render plain: { error: 'No presigned urls.' }.to_json, status: 422, content_type: 'application/json'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:tmp_url, :imageable_id, :imageable_type)
    end
end
