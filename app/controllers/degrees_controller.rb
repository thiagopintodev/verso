class DegreesController < ApplicationController
  before_filter :login_required
  
  # GET /degrees
  # GET /degrees.json
  def index
    @degrees = Degree.all
  end

  # GET /degrees/1
  # GET /degrees/1.json
  def show
    redirect_to :degrees
  end

  # GET /degrees/new
  # GET /degrees/new.json
  def new
    @degree = Degree.new
  end

  # GET /degrees/1/edit
  def edit
    @degree = Degree.find(params[:id])
  end

  # POST /degrees
  # POST /degrees.json
  def create
    @degree = Degree.new(params[:degree])

    if @degree.save
      redirect_to @degree, notice: 'Degree was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /degrees/1
  # PUT /degrees/1.json
  def update
    @degree = Degree.find(params[:id])

    if @degree.update_attributes(params[:degree])
      redirect_to :degrees, notice: 'Degree was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /degrees/1
  # DELETE /degrees/1.json
  def destroy
    #@degree = Degree.find(params[:id])
    #@degree.destroy
  end
end
