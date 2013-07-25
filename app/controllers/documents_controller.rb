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
    if @document.save
      redirect_to dashboard_index_path
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
    @documents = Document.where("user_id = '#{current_user.id}'")
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
    @checklists = Checklist.search "*#{params[:search]}*"
    #@users = User.search "*#{params[:search]}*"
    #    @documents = Document.search "*#{params[:search]}*"
    @transactions = Transaction.search "*#{params[:search]}*"
    @docs = Document.where("user_id = '#{current_user.id}'")
    @documents = Document.search "*#{params[:query]}*"
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  def unreviewed
    @documents = Document.where("user_id = '#{current_user.id}'")
    if request.xhr?
      @document = Document.where("document_file_name = '#{params[:document_file_name]}'").first
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

end
