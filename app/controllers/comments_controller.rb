class CommentsController < ApplicationController
  before_action :login_required

  def create
    @comment = Comment.new(:user => current_user, :lesson_id => params[:lesson_id], :content => params[:content])
    @lesson = Lesson.find(params[:lesson_id])

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @lesson }
        format.js {}
      end
    else
      # flash[:alert] = "Comment failed to save..."
      render "lessons/show"
    end
  end 

  def destroy
    @lesson = Lesson.find(params[:lesson_id])
    @comment = Comment.find(params[:id])
    if permitted_to_delete_comment?(@comment) && @comment.destroy
      respond_to do |format|
        format.html { redirect_to :back, :notice => "Commented successfully deleted" }
        format.js {}
      end
    else
      flash[:alert] = "Can't delete someone else's comment!"
      redirect_to :back
    end
  end

end