class User < ApplicationRecord   
   has_many :buy_items, :class_name => 'Transanction', :foreign_key => 'buyer_id'
   has_many :sell_items, :class_name => 'Transanction', :foreign_key => 'seller_id'
   has_many :likes
   has_many :inventories 
   
   
  # validate do |person|
  #  errors.add :name, :too_plain, message: "is not cool enough"
  #end
  
  has_secure_password
end
