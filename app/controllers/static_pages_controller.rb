class StaticPagesController < ApplicationController
  def home
    blogs_query = Blog.where(active: true).or(Blog.where(user_id: current_user.id))
    @q = blogs_query.ransack(params[:q])
    @blogs = @q.result(distinct: true).order(id: :desc)
  end
end
