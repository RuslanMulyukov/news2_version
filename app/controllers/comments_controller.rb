class CommentsController < ApplicationController
  before_filter :authenticate_user!
  uses_tiny_mce

  # POST /comments
  # POST /comments.xml
  def create
    if params[:article_id].present?
      article = Article.find(params[:article_id])
      if article.present?
        current_user.comments.create(:article_id => article.id, :description => params[:description])
        @comments = article.comments
      end
    else
      @error = true
    end

    response do
      format.js
    end
  end
end

