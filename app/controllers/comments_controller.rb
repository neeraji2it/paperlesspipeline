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
    @comments = @document.comments
    @comment = @document.comments.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @document = Document.find(params[:document_id])
    @comments = @document.comments
    @comment = @document.comments.new(params[:comment].merge(:user_id => current_user.id, :document_id => @document.id))
    if @comment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @document = Document.find(params[:document_id])
    @comment = @document.comments.find(params[:id])
    @comments = @document.comments
    respond_to do |format|
      format.js
    end
  end

  def update
    @document = Document.find(params[:document_id])
    @comment = @document.comments.find(params[:id])
    @comments = @document.comments
    if @comment.update_attributes(params[:comment])
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @document = Document.find(params[:document_id])
    @comment = @document.comments.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.js
      end
    end
  end
end
