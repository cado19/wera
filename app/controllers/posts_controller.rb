class PostsController < ApplicationController
  skip_around_action :scope_current_account
  layout "welcome"
  def index
    @posts = Post.all.order("created_at desc")
  end

  def show
    @post = Post.find(params[:id])
  end
end
