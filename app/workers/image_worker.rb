class ImageWorker
    include Sidekiq::Worker
    sidekiq_options queue: :default, retry: 3

    def perform(image_id)
      image = Image.find(image_id)
      p 'parsing...'
      image.image = URI.parse(image.tmp_url)
      p 'saving...'
      image.save!
      image.processed = true
      image.save!
    end
  end