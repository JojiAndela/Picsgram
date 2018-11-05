class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable


  def new
    @comment = Comment.new
  end

  def create
    #instance the variables
    @comment = @commentable.comments.new comment_param
    @comment.user = current_user
    @comment.save
    if @comment.save
      if @commentable.user != current_user
        Notification.create(recipient: @commentable.user, actor: current_user, action: "commented on your", notifiable:  @commentable)
      end
      #want to be able to capture prevoius rquest page
      url = Rails.application.routes.recognize_path(request.referrer)

      if url[:controller] == 'pics' && url[:action] == 'index'
        redirect_to root_path + "#comment_#{@commentable.id}"
      else
        redirect_back(fallback_location: root_path)

      end

    else
      redirect_back(fallback_location: root_path)


    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end
  end


  private
  def find_commentable
    #find the commentable according to its proportion
    @commentable = Pic.find_by_id(params[:pic_id]) if params[:pic_id]
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
  end

  def comment_param
    params.require(:comment).permit(:body)
  end

end
