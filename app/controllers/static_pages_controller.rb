class StaticPagesController < ApplicationController
  def home
    return unless current_user.present?

    blogs_query = Blog.where(active: true).or(Blog.where(user_id: current_user.id))
    @q = blogs_query.ransack(params[:q])
    @blogs = @q.result(distinct: true).order(id: :desc).paginate(page: params[:page], per_page: 5)
  end
end
