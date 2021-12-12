class TransanctionsController < ApplicationController
  before_action :set_transanction, only: %i[ show edit update destroy ]

  # GET /transanctions or /transanctions.json
  def index
    @transanctions = Transanction.all
  end

  # GET /transanctions/1 or /transanctions/1.json
  def show
  end

  # GET /transanctions/new
  def new
    @transanction = Transanction.new
  end

  # GET /transanctions/1/edit
  def edit
  end

  # POST /transanctions or /transanctions.json
  def create
    @transanction = Transanction.new(transanction_params)

    respond_to do |format|
      if @transanction.save
        format.html { redirect_to @transanction, notice: "Transanction was successfully created." }
        format.json { render :show, status: :created, location: @transanction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transanction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transanctions/1 or /transanctions/1.json
  def update
    respond_to do |format|
      if @transanction.update(transanction_params)
        format.html { redirect_to @transanction, notice: "Transanction was successfully updated." }
        format.json { render :show, status: :ok, location: @transanction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transanction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transanctions/1 or /transanctions/1.json
  def destroy
    @transanction.destroy
    respond_to do |format|
      format.html { redirect_to transanctions_url, notice: "Transanction was successfully destroyed." }
      format.json { head :no_content }
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
    
    
    def set_transanction
      @transanction = Transanction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transanction_params
      params.require(:transanction).permit(:user_id, :user_id, :item_id, :price, :amount)
    end
end
