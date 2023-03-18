class CommentsController < ApplicationController
    def create
      @prototype = Prototype.find(params[:prototype_id])
      @comment = @prototype.comments.new(comment_params.merge(user_id: current_user.id))
      if @comment.content.blank?
        redirect_to prototype_path(@prototype)    
      elsif @comment.save
        redirect_to prototype_path(@prototype)
      else
        render "prototypes/show"
      end
    end

    def show
      @comment = Comment.new
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    end
  end
