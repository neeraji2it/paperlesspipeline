class CommentsController < ApplicationController

  def index
    @document = Document.find(params[:document_id])
    @comments = @document.comments
    respond_to do |format|
      format.js
    end
  end

  def new
    @document = Document.find(params[:document_id])
    @comment = @document.comments.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @document = Document.find(params[:document_id])
    @comment = @document.comments.new(params[:comment].merge(:user_id => current_user.id, :document_id => @document.id))
    if @comment.save
      respond_to do |format|
        format.js
      end
    end
  end
end
