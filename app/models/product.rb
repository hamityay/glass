class Product < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :orders
  has_many :stocks

  has_attached_file :image, styles: { large: "300x300>", medium: "200x200>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
