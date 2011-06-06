class VotesController < ApplicationController
  before_filter :authenticate_user!

  def create
    if params[:article_id].present?
      article = Article.find(params[:article_id])
      if article.present?
        if current_user.votes.where(:article_id => article.id).present?
          @voted = true
        else
          current_user.votes.create(:article_id => article.id, :result => params[:result])
          if params[:result] == 'for'
            @votes_for = article.votes.for.where(:article_id => article.id).count
          elsif params[:result] == 'against'
            @votes_against = article.votes.against.where(:article_id => article.id).count
          end
        end
      end
    else
      @error = true
    end

    response do
      format.js
    end
  end
end

