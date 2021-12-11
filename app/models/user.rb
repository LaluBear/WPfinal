class User < ApplicationRecord   
   has_many :buy_items, :class_name => 'Transanction', :foreign_key => 'buyer_id'
   has_many :sell_items, :class_name => 'Transanction', :foreign_key => 'seller_id'
   has_many :likes
   has_many :inventories 
   
   
  # validate do |person|
  #  errors.add :name, :too_plain, message: "is not cool enough"
  #end
  
  has_secure_password
  
  def get_inventories
    @user = self
    @array = []
    @user.inventories.each do |item| 
      if(item.item.onsale == "no")
        @array.push(item.item)
      end
    end
    @array
  end
  
  def get_sell_inventories
    @user = self
    @array = []
    @user.inventories.each do |item| 
      if(item.item.onsale == "yes")
        @array.push(item.item)
      end  
    end
    @array
  end
  
  def get_number_in_inventories
    @user = self
    @array = []
    @user.inventories.each do |item| 
      if(item.item.onsale == "no")
        @have_item = Inventory.find_by(item_id: item.item_id,user_id: self.id); 
        if(@have_item)
          @array.push(@have_item.amount)  
        end
      end
    end
    @array
  end
  
  def get_number_in_sell_inventories
    @user = self
    @array = []
    @user.inventories.each do |item| 
      if(item.item.onsale == "yes")
        @have_item = Inventory.find_by(item_id: item.item_id,user_id: self.id); 
        if(@have_item)
          @array.push(@have_item.amount)  
        end
      end
    end
    @array
  end
end
