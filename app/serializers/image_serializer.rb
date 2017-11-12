AWS_PREFIX = 'https://code-pay-development.s3.amazonaws.com/'
class ImageSerializer < ActiveModel::Serializer
  attributes :id, :thumb, :small, :large, :original

  def thumb
    object.processed ? AWS_PREFIX + object.image.path(:thumb) : nil
  end

  def small
    object.processed ? AWS_PREFIX + object.image.path(:small) : nil
  end

  def medium
    object.processed ? AWS_PREFIX + object.image.path(:medium) : nil
  end

  def large
    object.processed ? AWS_PREFIX + object.image.path(:large) : nil
  end

  def original
    object.processed ? AWS_PREFIX + object.image.path(:original) : nil
  end
end
