# PostsController
class PostsController < ApplicationController
  before_action :require_login,  only: %i[create edit update]
  def index
    @posts = if params[:search]
      Post.search(params[:search])
    else
      Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post created successfully.'
      redirect_to @post
    else
      flash[:error] = 'There was a problem creating the post.'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = 'Post has been updated'
      redirect_to @post
    else
      flash[:error] = 'Post could not be updated'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def require_login
    return if current_user

    flash[:error] = 'You must be logged in to access this section'
    redirect_to new_user_session_path
  end
end
