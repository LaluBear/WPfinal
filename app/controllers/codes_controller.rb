class CodesController < ApplicationController
  before_action :set_code, only: %i[ show edit update destroy ]
  
  
  before_action :logged_in, only: %i[ redeem redeem_code ]
  # GET /codes or /codes.json
  def index
    @codes = Code.all
  end

  # GET /codes/1 or /codes/1.json
  def show
  end

  # GET /codes/new
  def new
    @code = Code.new
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes or /codes.json
  def create
    @code = Code.new(code_params)

    respond_to do |format|
      if @code.save
        format.html { redirect_to @code, notice: "Code was successfully created." }
        format.json { render :show, status: :created, location: @code }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codes/1 or /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        format.html { redirect_to @code, notice: "Code was successfully updated." }
        format.json { render :show, status: :ok, location: @code }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1 or /codes/1.json
  def destroy
    @code.destroy
    respond_to do |format|
      format.html { redirect_to codes_url, notice: "Code was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def redeem
    #not here
    @code = Code.new
    if(flash[:error])
      @code.errors.add :code, :redeem_failed, message: "with Wrong Code or Expired or Already Redeemed"
    end
  end
  
  def redeem_code
    #not here
    @code = Code.find_by(code: params[:code][:code])
    
    if(!@code)
      
      @code = Code.new
      @code.errors.add :code, :redeem_failed, message: "with Wrong Code or Expired"
      redirect_to "/redeem", :flash => { :error => @code.errors }
      return
    end
    if(@code.status != "available")
      @code.errors.add :code, :redeem_failed, message: "with Wrong Code or Expired"
      redirect_to "/redeem", :flash => { :error => @code.errors }
      return
    end
    
    @user = User.find(session[:user_id])
    @user.credit += @code.creditAmount
    @code.status = "redeemed"
    @code.save
    @user.save
    redirect_to "/redeem", :notice => "Redeem Successfully"
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
    
    def set_code
      @code = Code.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def code_params
      params.require(:code).permit(:creditAmount, :status, :code)
    end
end
