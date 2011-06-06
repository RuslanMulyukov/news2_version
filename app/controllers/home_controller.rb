class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @articles = Article.order("created_at").page(params[:page]).per(3)
  end
end

