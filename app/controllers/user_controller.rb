class UserController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  
  before_action :logged_in, only: %i[ gacha error like unlike market cancel sell buy ]
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to "/main", notice: "User was successfully created." }
        format.json { render "/main", status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  
  def new_user
    @user = User.new
  end
  
  def create_user
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to "/main", notice: "User was successfully created." }
      else
        format.html { redirect_to "/new_user",method: "post", status: :unprocessable_entity }
      end
    end
  end
  
  def login
    session[:user_id] = nil
    
    @user = User.new
    if(flash[:error])
      @user.errors.add :name, :login_failed, message: "Wrong Email or Password"
    end
  end
  
  def pre_login
    session[:user_id] = nil
    redirect_to "/main"
  end
  
  def logout
    session[:user_id] = nil
    redirect_to "/out"
  end
  
  def login_attempt
    
    @user = User.find_by(email: params[:user][:email])
    if(@user && @user.authenticate(params[:user][:password]))
      session[:user_id] = @user.id
      redirect_to "/gacha"
    else
    
      @user = User.new
      @user.errors.add :name, :login_failed, message: "Wrong Email or Password"
      redirect_to "/main", :flash => { :error => @user.errors }
    end
  end
  
  def gacha
    @banners = Banner.where("? >= startDate AND ? <= endDate",Date.today,Date.today)
    @banners.each do |banner|
      puts banner
    
    end
    puts "123aaa"
  end
  
  def error
  end
  
  def like
    @like = Like.new(user_id: session[:user_id], banner_id: params[:id])
    @like.save
    redirect_back(fallback_location:"/")
  end
  
  def unlike  
    
    @like = Like.find_by(user_id: session[:user_id], banner_id: params[:id])
    @like.destroy
    redirect_back(fallback_location:"/")
  end
  
  def market
    @rawitems = Item.where(onsale:"yes")
    @items = Array.new
    @number_items = Array.new
    @seller = Array.new
    @rawitems.each do |item|
      @onsale_item = Inventory.where(item_id: item.id)
      if(@onsale_item)
        @onsale_item.each do |inventory|
          if(inventory.user_id != session[:user_id])
            @items.push(item)
            @number_items.push([inventory.amount,inventory.price])
            @seller.push(inventory.user)
          end
        end
      end
    end
  end
  
  def cancel
    #find sell item from market
    @item = Item.find_by(name: params[:name],onsale: "yes")
    @sell_item = Inventory.find_by(item_id: @item.id,user_id: session[:user_id])
    @item = Item.find_by(name: params[:name],onsale: "no")
    @have_item = Inventory.find_by(item_id: @item.id,user_id: session[:user_id])
    if(@have_item)
      @have_item.amount += @sell_item.amount
      @have_item.save 
    else
      @inventory = Inventory.new(item_id: @item.id,user_id: session[:user_id],amount: @sell_item.amount)
      @inventory.save
    end
    @sell_item.destroy
    
    redirect_to "/inventory"
  end
  
  #sell stuff from inventory
  def sell
    #find item in inventory
    @item = Item.find_by(name: params[:name],onsale: "no")
    @have_item = Inventory.find_by(item_id: @item.id,user_id: session[:user_id])
    
    #check if sell more than amount you have
    if(params[:item][:amount].to_i > @have_item.amount)
      redirect_to "/inventory", notice: "please type in some reasonable amount number"
      return
    end
    @have_item.amount -= params[:item][:amount].to_i
    
    #find on sale item in inventory
    @sell_item = Item.find_by(name: params[:name],onsale: "yes")
    if(@sell_item)
      @sell_inventory = Inventory.find_by(item_id: @sell_item.id,user_id: session[:user_id])
      if(@sell_inventory)
        @sell_inventory.amount += params[:item][:amount].to_i
        @sell_inventory.save
      else
        @inventory = Inventory.new(item_id: @sell_item.id, user_id: session[:user_id], amount: params[:item][:amount].to_i,price: params[:item][:price])
        @inventory.save
      end
    end
    if(@have_item.amount==0)
      @have_item.destroy
    else
      @have_item.save
    end
    redirect_to "/inventory"
  end
  
  #buy stuff in market
  def buy
    #find sell item from market
    @item = Item.find_by(name: params[:name],onsale: "yes")
    @sell_item = Inventory.find_by(item_id: @item.id,user_id: params[:seller_id])
    
    #check if buy more than amount you have
    if(params[:item][:amount].to_i > @sell_item.amount)
      redirect_to "/market", notice: "please type in some reasonable amount number"
      return
    end
    
    @sell_item.amount -= params[:item][:amount].to_i
    #Tranfer Credit
    @buyer = User.find(session[:user_id])
    @seller = User.find(params[:seller_id]) 
    @total_pay = params[:item][:amount].to_i * @sell_item.price
    @buyer.credit -= @total_pay
    @seller.credit += @total_pay
    if(@buyer.credit < 0)
      redirect_to "/market", notice: "You don't have enough credit"
      return
    end
    
    #Log transanction
    @transanction = Transanction.new(buyer_id: session[:user_id], seller_id: params[:seller_id], item_id: @item.id, price: (@sell_item.price * params[:item][:amount].to_i),amount: params[:item][:amount].to_i)
    
    
    
    @item = Item.find_by(name: params[:name],onsale: "no")
    #find item in inventory
    @have_item = Item.find_by(name: params[:name],onsale: "no")
    if(@have_item)
      @have_inventory = Inventory.find_by(item_id: @have_item.id,user_id: session[:user_id])
      if(@have_inventory)
        @have_inventory.amount += params[:item][:amount].to_i
        @have_inventory.save
      else
        @inventory = Inventory.new(item_id: @have_item.id, user_id: session[:user_id], amount: params[:item][:amount].to_i)
        @inventory.save
      end
    end
    if(@sell_item.amount==0)
      @sell_item.destroy
    else
      @sell_item.save
    end
    @buyer.save
    @seller.save
    @transanction.save
    redirect_to "/market", notice: "Thank You for purchasing, Wish You Luck."
  end
  
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def logged_in
      if(session[:user_id])
        a = 1
      else
        session[:user_id] = nil
        redirect_to "/main", notice: "Please login"
        return
      end
    end
    
    
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password_digest, :credit)
    end
end
