class ReviewsController < ApplicationController
  before_filter :login_required
  
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    pr = params[:review]
    review = Review.new
    
    if review.cadastrar(current_user, pr[:project_id], pr[:tipo], pr[:texto])
      redirect_to project_path(review.project_id), :notice => 'Revisao Cadastrada Com Sucesso.'
    else
      flash[:error] = "Revisao Nao Cadastrada #{review.errors.messages}."
      redirect_to project_path(review.project_id)
    end
  end
  
  def create_aprovado
    review = Review.new
    
    if review.cadastrar_aprovada(current_user, params[:project_id], params[:tipo])
      redirect_to project_path(review.project_id), :notice => 'Revisao Cadastrada Com Sucesso.'
    else
      flash[:error] = "Revisao Nao Cadastrada #{review.errors.messages}."
      redirect_to project_path(review.project_id)
    end
  end
  
  #
  
  def corrigiu
    review = Review.find(params[:id])
    
    if review.corrigir(current_user)
      redirect_to project_path(review.project_id), notice: 'Revisao Atualizada Com Sucesso.'
    else
      flash[:error] = "Revisao Nao Cadastrada #{review.errors.messages}."
      redirect_to project_path(review.project_id)
    end
  end
  
  def revisou_aprovou
    review = Review.find(params[:id])
    
    if review.revisar(current_user, true)
      redirect_to project_path(review.project_id), notice: 'Revisao Atualizada Com Sucesso.'
    else
      flash[:error] = "Revisao Nao Cadastrada #{review.errors.messages}."
      redirect_to project_path(review.project_id)
    end
  end
  
  def revisou_reprovou
    review = Review.find(params[:id])
    
    if review.revisar(current_user, false)
      redirect_to project_path(review.project_id), notice: 'Revisao Atualizada Com Sucesso.'
    else
      flash[:error] = "Revisao Nao Cadastrada #{review.errors.messages}."
      redirect_to project_path(review.project_id)
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
