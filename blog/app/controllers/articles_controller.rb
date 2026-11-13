class ArticlesController < ApplicationController
  http_basic_authenticate_with name: ENV.fetch("BLOG_ADMIN_USER", "admin"),
    password: ENV.fetch("BLOG_ADMIN_PASSWORD"), except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.includes(:comments)
    @selected = params[:meal].presence
    if Article::MEALS.include?(@selected)
      @articles = @articles.where(meal: @selected)
    end
    @quick_only = params[:quick] == "1"
    @articles = @articles.where("prep_minutes <= 30") if @quick_only
    @articles = @articles.order(created_at: :desc)
    @quick_count = Article.where("prep_minutes <= 30").count
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article published."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Changes saved."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_path, status: :see_other, notice: "Article deleted."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :meal, :prep_minutes, :difficulty, :ingredients)
  end
end
