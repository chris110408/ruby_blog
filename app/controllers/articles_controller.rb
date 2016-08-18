class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user,except: [:index,:show]
  before_action :require_same_user, only: [:edit,:update,:destroy]
  # GET /articles
  def index
    @articles = Article.paginate(page: params[:page],per_page:5)
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create


    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = 'Article was successfully created.'
      redirect_to articles_path(@article)
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated.'
      redirect_to articles_path(@article)
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    flash[:danger] = 'Article was successfully destroyed.'
    redirect_to articles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user != @article.user
        flash[:danger] = "you are only edit or delete your own articles"
        redirect_to root_path
      end
    end
end
