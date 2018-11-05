class PicsController < ApplicationController
  before_action :set_pic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /pics
  # GET /pics.json
  def index
    # @pics = Pic.all.order("created_at DESC")
    @pics = current_user.feed.all.order("created_at DESC")
  end

  # GET /pics/1
  # GET /pics/1.json
  def show
  end

  # GET /pics/new
  def new
    @pic = Pic.new
  end

  # GET /pics/1/edit
  def edit

  end

  # POST /pics
  # POST /pics.json
  def create
    @pic = Pic.new(pic_params)
    @pic.user = current_user
    respond_to do |format|
      if @pic.save
        format.html { redirect_to root_url, notice: 'Pic was successfully created.' }
        format.json { render :show, status: :created, location: @pic }
      else
        format.html { render :new }
        format.json { render json: @pic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pics/1
  # PATCH/PUT /pics/1.json
  def update
    if current_user == @pic.user
      respond_to do |format|
        if @pic.update(pic_params)
          format.html { redirect_to @pic, notice: 'Pic was successfully updated.' }
          format.json { render :show, status: :ok, location: @pic }
        else
          format.html { render :edit }
          format.json { render json: @pic.errors, status: :unprocessable_entity }
        end
      end
    else
        respond_to do |format|
      format.html { redirect_to @pic, notice: 'Not your account' }
      format.json { render json: @pic.errors, status: :unprocessable_entity }
    end
    end
  end

  # DELETE /pics/1
  # DELETE /pics/1.json
  def destroy
    if current_user == @pic.user
      @pic.destroy
      respond_to do |format|
        format.html { redirect_to pics_url, notice: 'Pic was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pic
    @pic = Pic.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pic_params
    params.require(:pic).permit(:caption,:image, :user_id)
  end
end
