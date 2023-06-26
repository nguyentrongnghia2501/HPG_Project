class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: %i[show edit update destroy]

  def new
    @blog = Blog.new
  end

  def edit; end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    respond_to do |format|
      if @blog.save
        format.html { redirect_to root_path, notice: 'Blog was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @blog.user_id == current_user.id
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to root_path, notice: 'Blog was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'You do not have permission to edit this blog.' }
      end
    end
  end

  def destroy
    if @blog.user_id == current_user.id
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Blog was successfully destroyed.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'you do not have permission to delete this blog.' }
      end
    end
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :description, :active)
  end
end
