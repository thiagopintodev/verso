class DegreesController < ApplicationController
  def index
    @degrees = Degree.all
  end

  def show
    @degree = Degree.find(params[:id])
  end

  def new
    @degree = Degree.new
  end

  def create
    @degree = Degree.new(params[:degree])
    if @degree.save
      redirect_to @degree, :notice => "Successfully created degree."
    else
      render :action => 'new'
    end
  end

  def edit
    @degree = Degree.find(params[:id])
  end

  def update
    @degree = Degree.find(params[:id])
    if @degree.update_attributes(params[:degree])
      redirect_to @degree, :notice  => "Successfully updated degree."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @degree = Degree.find(params[:id])
    @degree.destroy
    redirect_to degrees_url, :notice => "Successfully destroyed degree."
  end
end
