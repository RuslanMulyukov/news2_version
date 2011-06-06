class ArticlesController < ApplicationController
  before_filter :authenticate_user!
  uses_tiny_mce

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @categories = Category.all

    if @categories.present?
      @selected_category = params[:category_id] ? params[:category_id] : Category.first.id
      @article = current_user.articles.new
    else
      redirect_to new_user_category_path(current_user)
      return
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
    @category = @article.category
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = current_user.articles.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to(user_article_path(current_user, @article), :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = current_user.articles.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(user_article_path(current_user, @article), :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def search
    @articles = Article.order("created_at").page(params[:page]).per(3)
    @search_results = Article.find(:all, :conditions => ['title LIKE ? OR description LIKE ?', "%#{params[:search_key]}%", "%#{params[:search_key]}%"])

    render 'home/index'
  end

  def sort
    if params[:mode].present?
      if params[:mode] == 'max'
        @articles = Article.by_max_rating
      elsif params[:mode] == 'min'
        @articles = Article.by_min_rating
      elsif params[:mode] == 'date'
        @articles = Article.recent.page(params[:page]).per(3)
      end
    else
      redirect_to root_path
    end

    response do
      format.js
    end
  end
end

