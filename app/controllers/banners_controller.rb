class BannersController < ApplicationController
  before_action :set_banner, only: %i[ show edit update destroy ]

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
    if(!@banner)
      redirect_to "/error"
    end
  end
  def pull_one
    @banner = Banner.find_by(name: params[:name])
    #random something out once
    #put it in items
    #Add them to user inventory
    #
  end
  
  def pull_ten
    
    @banner = Banner.find_by(name: params[:name])
    #random something out ten times
    #put it in items for show
    #Add them to user inventory
    redirect_to "/banner/#{@banner.name}"
    @no = "randomsome"
  end
  
  def banner_gacha
    @banner = Banner.find_by(name: params[:name])
    if(!@banner)
      redirect_to "/error"
    end
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
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def banner_params
      params.require(:banner).permit(:bannerName, :bannerStartDate, :bannerEndDate)
    end
end
