class CommentsController < ApplicationController
  http_basic_authenticate_with name: ENV.fetch("BLOG_ADMIN_USER", "admin"),
    password: ENV.fetch("BLOG_ADMIN_PASSWORD"), only: [:destroy]

  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    if @comment.save
      redirect_to article_path(@article, anchor: "comments"), notice: "Comment posted."
    else
      redirect_to article_path(@article, anchor: "comments"), alert: "Please enter your name and a comment."
    end
  end

  def destroy
    @article.comments.find(params[:id]).destroy!
    redirect_to article_path(@article, anchor: "comments"), status: :see_other, notice: "Comment removed."
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
