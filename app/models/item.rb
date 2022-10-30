class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  belongs_to :genre
  
  has_one_attached :item_image
  
  def get_item_image
    unless image.attached?
      file.path = Rails.root.join('app/assets/images/準備中.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    else
      image
    end
  end
  
  def price_inc_tax
    price * 1.1
  end
end
