class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true

  has_one_attached :item_image

  def get_item_image(width, height)
    unless item_image.attached?
      file.path = Rails.root.join('app/assets/images/準備中.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    else
      item_image.variant(resize_to_limit: [width, height]).processed
    end
  end

  def price_inc_tax
    (price * 1.1).to_i
  end
end
