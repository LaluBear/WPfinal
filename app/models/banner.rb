class Banner < ApplicationRecord
   
   has_many :likes
   has_many :banner_items
end
