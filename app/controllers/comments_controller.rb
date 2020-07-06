class CommentsController < ApplicationController
  def create
    @item=Item.find(params[:item_id])
    comment=Comment.new(comment_params)
    if comment.save
      flash[:notice]="コメントを投稿しました"
      redirect_to item_path(@item)
    else
      flash[:alert]="コメントの投稿に失敗しました"
      redirect_to item_path(@item)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
