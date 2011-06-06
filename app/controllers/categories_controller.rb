class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @user = current_user
    @category = current_user.categories.new(:user_id => current_user.id)
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = current_user.categories.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(new_user_article_path(current_user, :category_id => @category.id), :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end
end

