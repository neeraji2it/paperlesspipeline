class DocumentsController < ApplicationController

  def index
    #    @documents = Document.where("user_id = #{current_user.id}")
    @documents = Document.search "*#{params[:query]}*"
    respond_to do |format|
      format.js
    end
  end

  def new
    @user = current_user
    @document = Document.new
    @locations = Location.all
  end

  def create
    @document = Document.new(params[:document])
    @document.user_id = current_user.id
    @document.location_id = params[:document][:location_id]
    @document.transaction_id = params[:document][:transaction_id]
    @document.doc_type = params[:document][:doc_type]
    if @document.save
      if @document.doc_type == "office"
        redirect_to office_documents_path
      else
        redirect_to office_documents_path
      end
    end
  end

  def destroy
    @documents = Document.where("user_id = #{current_user.id}")
    @document = Document.find(params[:id])
    if @document.destroy
      redirect_to office_documents_path(current_user), :notice => 'Document deleted successfully deleted.'
    end
  end

  def working
    #    @documents = Document.search "*#{params[:query]}*"
    @documents = Document.where("user_id = '#{current_user.id}' or review = 'true' ")
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  def working_filter
    
  end

  def search
    @documents = Document.where("document_file_name = '#{params[:query]}'")
    respond_to do |format|
      format.js
    end
  end

  def location_search
    if params[:location].present?
      @documents = Document.where("location_id = #{params[:location]} and user_id = #{current_user.id}")
      render :action => 'index'
    else
      @documents = Document.where("user_id = #{current_user.id}")
      render :action => 'index'
    end
  end

  def office
    @comment = Comment.new
    @checklists = Checklist.search "*#{params[:search]}*"
    #@users = User.search "*#{params[:search]}*"
    #    @documents = Document.search "*#{params[:search]}*"
    @transactions = Transaction.search "*#{params[:search]}*"
    @docs = Document.where("user_id = '#{current_user.id}' and doc_type = 'office'")
    @documents = Document.search "*#{params[:query]}*"
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  def unreviewed
    @documents = Document.where("user_id = '#{current_user.id}' and review IS NULL ")
    if request.xhr?
      @documents = Document.where("document_file_name = '#{params[:document_file_name]}' ")
      respond_to do |format|
        format.js
      end
    end
  end

  def comment
    @comment = Comment.new(params[:comment])
    @comment.save
    respond_to do |format|
      @document = Document.find(@comment.document_id)
      format.js
    end
  end

  def download_document
    document = Document.find(params[:id])
    send_data document.document.path,
      :filename => document.document_file_name,
      :type => document.document_content_type,
      :disposition => 'attachment'
  end

end
