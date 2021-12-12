class BannerItemsController < ApplicationController
  before_action :set_banner_item, only: %i[ show edit update destroy ]
  before_action :logged_in, only: %i[]
  
  # GET /banner_items or /banner_items.json
  def index
    @banner_items = BannerItem.all
  end

  # GET /banner_items/1 or /banner_items/1.json
  def show
  end

  # GET /banner_items/new
  def new
    @banner_item = BannerItem.new
  end

  # GET /banner_items/1/edit
  def edit
  end

  # POST /banner_items or /banner_items.json
  def create
    @banner_item = BannerItem.new(banner_item_params)

    respond_to do |format|
      if @banner_item.save
        format.html { redirect_to @banner_item, notice: "Banner item was successfully created." }
        format.json { render :show, status: :created, location: @banner_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @banner_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banner_items/1 or /banner_items/1.json
  def update
    respond_to do |format|
      if @banner_item.update(banner_item_params)
        format.html { redirect_to @banner_item, notice: "Banner item was successfully updated." }
        format.json { render :show, status: :ok, location: @banner_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @banner_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banner_items/1 or /banner_items/1.json
  def destroy
    @banner_item.destroy
    respond_to do |format|
      format.html { redirect_to banner_items_url, notice: "Banner item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def logged_in
      if(session[:user_id])
        a = 1
      else
        session[:user_id] = nil
        redirect_to "/main", notice: "Please login"
        return
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_banner_item
      @banner_item = BannerItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def banner_item_params
      params.require(:banner_item).permit(:banner_id, :item_id, :rate, :amount)
    end
end
