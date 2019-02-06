class CommentsController < ApplicationController
 def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to root_url
    else
      @post = @comment.post
      @comments = @post.comments.reload
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render 'posts/show'
    end
 end
 
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
     redirect_to root_url
  end


  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end