class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Your post has been created.'
      redirect_to @post
    else
      flash[:alert] = 'Halt, you fiend! You need an image to post here!'
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post updated hombre.'
      redirect_to @post
    else
      flash[:alert] = 'Something gone wrong... try again.'
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Post was successfully destroyed.'
      redirect_to posts_path
    else
      flash[:alert] = 'Something gone wrong... try again.'
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    return false if current_user == @post.user
    flash[:alert] = "That post doesn't belong to you!"
    redirect_to root_path
  end
end
