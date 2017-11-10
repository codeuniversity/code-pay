class ImageWorker
    include Sidekiq::Worker

    def perform(image_id)
      image = Image.find(image_id)
      image.image = URI.parse(img.tmp_url)
      image.processed = true
      image.save!
    end
  end