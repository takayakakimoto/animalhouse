class PostsController < ApplicationController
   before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy]
   
  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'ポストを投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.feed_posts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'ポストの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = 'ポストを削除しました。'
    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
