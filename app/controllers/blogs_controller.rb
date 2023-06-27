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
        format.html { redirect_to root_path, notice: I18n.t('notice.blogs_create.success') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if user_is_author(@blog, current_user)
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to root_path, notice: I18n.t('notice.blogs_update.success') }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: I18n.t('notice.blogs_update.permission') }
      end
    end
  end

  def destroy
    if user_is_author(@blog, current_user)
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: I18n.t('notice.blogs_destroy.success') }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: I18n.t('notice.blogs_destroy.permission') }
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

  def user_is_author(blog, user)
    blog.user_id == user.id
  end
end
