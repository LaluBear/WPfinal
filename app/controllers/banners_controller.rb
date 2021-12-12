class BannersController < ApplicationController
  before_action :set_banner, only: %i[ show edit update destroy ]

  before_action :logged_in, only: %i[ banner_gacha pull_one pull_ten how_to_obtain ]
  
  # GET /banners or /banners.json
  def index
    @banners = Banner.all
  end

  # GET /banners/1 or /banners/1.json
  def show
  end

  # GET /banners/new
  def new
    @banner = Banner.new
  end

  # GET /banners/1/edit
  def edit
  end

  # POST /banners or /banners.json
  def create
    @banner = Banner.new(banner_params)

    respond_to do |format|
      if @banner.save
        format.html { redirect_to @banner, notice: "Banner was successfully created." }
        format.json { render :show, status: :created, location: @banner }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banners/1 or /banners/1.json
  def update
    respond_to do |format|
      if @banner.update(banner_params)
        format.html { redirect_to @banner, notice: "Banner was successfully updated." }
        format.json { render :show, status: :ok, location: @banner }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banners/1 or /banners/1.json
  def destroy
    @banner.destroy
    respond_to do |format|
      format.html { redirect_to banners_url, notice: "Banner was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def banner_gacha
    @banner = Banner.find_by(name: params[:name])
    if(@banner)
    else
      redirect_to "/error"
      return
    end
    puts @banner
    @rate = Array.new
    @all_rate = 0
    @banner.banner_items.each do |item|
      @rate.push([item.rate.to_i,item.item])
      @all_rate += item.rate.to_i
    end
  end
  def pull_one
    @banner = Banner.find_by(name: params[:name])
    @all_items = @banner.banner_items
    @roll = Array.new
    @all_items.each do |item|
      @roll+= [item.item]*item.rate.to_i
      puts @roll.size
    end
    
    #Calculate the price
    @user = User.find(session[:user_id])
    if(@user.credit.to_i < @banner.price.to_i)
      redirect_to "/banner/#{params[:name]}", notice: "You don't have enough credit"
      return
    else
      @user.credit -= @banner.price
    end
    
    #random something out once
    #Add them to user inventory
    @got_items = Array.new
    for i in 1..1 do
      @roll = @roll.shuffle
      @item = @roll.sample
      @got_items.push(@item)
      @inventory = Inventory.find_by(user_id: session[:user_id], item_id: @item.id)
      if(@inventory)
        @inventory.amount+=1
        @inventory.save
      else
        @inventory = Inventory.new(user_id: session[:user_id], item_id: @item.id,amount: 1)
        @inventory.save
      end
    end
    @user.save
    
  end
  
  def pull_ten
    @banner = Banner.find_by(name: params[:name])
    @all_items = @banner.banner_items
    @roll = Array.new
    @all_items.each do |item|
      @roll+= [item.item]*item.rate.to_i
      puts @roll.size
    end
    
    #Calculate the price
    @user = User.find(session[:user_id])
    if(@user.credit < @banner.price*10)
      redirect_to "/banner/#{params[:name]}", notice: "You don't have enough credit"
      return
    else
      @user.credit -= @banner.price*10
    end
    
    #random something out once
    #Add them to user inventory
    @got_items = Array.new
    @each_items = Hash.new
    for i in 1..10 do
      @roll = @roll.shuffle
      @item = @roll.sample
      @got_items.push(@item)
      if(@each_items[@item])
        @each_items[@item] += 1
      else
        @each_items[@item] = 1
      end
      @inventory = Inventory.find_by(user_id: session[:user_id], item_id: @item.id)
      if(@inventory)
        @inventory.amount+=1
        @inventory.save
      else
        @inventory = Inventory.new(user_id: session[:user_id], item_id: @item.id,amount: 1)
        @inventory.save
      end
    end
    
    
    
    @user.save
    
    #generate Modal
    @attr = @got_items.join('').html_safe
    #redirect_to "/banner/#{params[:name]}", :flash => { :items => @got_items }
  end
  
  
  def how_to_obtain
    @item = Item.find_by(name: params[:name],onsale: "no")
    @banner_item = BannerItem.where(item_id: @item.id)
    @banners = Array.new
    @banner_item.each do |banner|
      @banners.push(banner.banner)
    end
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
    
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def banner_params
      params.require(:banner).permit(:name, :startDate, :endDate, :price)
    end
end
