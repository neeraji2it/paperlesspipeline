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
    @comment = Comment.new(params[:comment].merge(:document_id => params[:document_id], :user_id => current_user.id))
    @comment.save
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
    @comment = Comment.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.js
      end
    end
  end
end
