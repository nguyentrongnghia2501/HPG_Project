module BlogsHelper
  def display_user_email(blog)
    user = User.find_by(id: blog.user_id)
    user.email if user
  end

  def current_user_is_author?(blog)
    blog.user_id == current_user.id
  end
end
