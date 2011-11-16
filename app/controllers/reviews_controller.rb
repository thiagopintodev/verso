class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    review = Review.new(params[:review])
    review.criou.at = Time.now
    review.criou.user = current_user
    
    respond_to do |format|
      if review.save
        format.html { redirect_to project_path(review.project_id), :notice => 'Revisao Cadastrada Com Sucesso.' }
        format.js {  }
      else
        format.html { redirect_to project_path(review.project_id), :error => "Revisao Nao Cadastrada #{review.errors.messages}." }
        format.js {  }
      end
    end
  end
  
  def corrigiu
    review = Review.find(params[:id])
    review.corrigiu.user = current_user
    review.corrigiu.at = Time.now
    review.revisou.clear
    
    respond_to do |format|
      if review.save
        format.html { redirect_to project_path(review.project_id), notice: 'Revisao Atualizada Com Sucesso.' }
        format.js {  }
      else
        format.html { render action: "edit" }
        format.js {  }
      end
    end
  end
  
  def revisou_aprovou
    review = Review.find(params[:id])
    review.revisou.user = current_user
    review.revisou.at = Time.now
    review.revisou.aprovou = true
    
    respond_to do |format|
      if review.save
        format.html { redirect_to project_path(review.project_id), notice: 'Revisao Atualizada Com Sucesso.' }
        format.js {  }
      else
        format.html { render action: "edit" }
        format.js {  }
      end
    end
  end
  
  def revisou_reprovou
    review = Review.find(params[:id])
    review.revisou.user = current_user
    review.revisou.at = Time.now
    review.revisou.aprovou = false
    
    respond_to do |format|
      if review.save
        format.html { redirect_to project_path(review.project_id), notice: 'Revisao Atualizada Com Sucesso.' }
        format.js {  }
      else
        format.html { render action: "edit" }
        format.js {  }
      end
    end
  end
  
  
=begin
  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :ok }
    end
  end
=end
end
