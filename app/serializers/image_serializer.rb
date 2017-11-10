class ImageSerializer < ActiveModel::Serializer
  attributes :id, :thumb, :small, :large, :original

  def thumb
    object.image.url(:thumb)
  end

  def small
    object.image.url(:small)
  end

  def medium
    object.image.url(:medium)
  end

  def large
    object.image.url(:large)
  end

  def original
    object.image.url(:original)
  end
end
