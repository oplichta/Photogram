class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :owned_comment, only: [:destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = 'Your comment has been created.'
      redirect_to :back
    else
      flash[:alert] = 'Something gone wrong. Check your comment form.'
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      flash[:success] = 'Comment was successfully destroyed.'
      redirect_to root_path
    else
      flash[:alert] = 'Something gone wrong... try again.'
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def owned_comment
    @comment = @post.comments.find(params[:id])
    return false if current_user == @comment.user
    flash[:alert] = "That doesn't belong to you!"
    redirect_to root_path
  end
end
