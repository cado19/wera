class Maintenance::PostsController < Maintenance::BaseController
  before_action :authorize
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  layout "account"
  def index
    @posts = Post.all.order("created_at desc").paginate(page: params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Blog post was created"
      redirect to @post
    else
      render 'new'
      flash.now[:notice] = "blog was not created"
    end
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy
    @post.destroy
    flash[:notice] = "Post was deleted"
    redirect_to maintenance_posts_url
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
