class DocumentsController < ApplicationController
  before_filter :parse_raw_upload, :only => :drag_drop
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
    @doc = DragDrop.new
    @locations = Location.all
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(:document_type => params[:document_type] )
      respond_to do |format|
        format.js
      end
    end
  end

  def update_reviewed
    @document = Document.find(params[:id])
    if @document.update_attributes(:reviewed => params[:reviewed])
      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @locations = Location.all
    @doc = DragDrop.new
    if params[:document][:document].blank? and session[:doc_ids] != nil
      session[:doc_ids].each do |doc_id|
        @drag_drop = DragDrop.find(doc_id)
        @document = Document.new(:document => @drag_drop.document)
        @document.user_id = current_user.id
        @document.location_id = params[:document][:location_id]
        @document.transaction_id = params[:document][:transaction_id]
        @document.doc_type = params[:document][:doc_type]
        @document.reviewed="false"
        @document.save
        flash[:notice] = "Document Successfully uploaded."
        @drag_drop.destroy
      end
      session[:doc_ids] = nil
      if params[:document][:doc_type] == "office"
        redirect_to office_documents_path
      else
        redirect_to params[:document][:transaction_id].present? ? transaction_path(params[:document][:transaction_id]) : dashboards_path
      end
    else
      @document = Document.new(params[:document])
      @document.user_id = current_user.id
      @document.location_id = params[:document][:location_id]
      @document.transaction_id = params[:document][:transaction_id]
      @document.doc_type = params[:document][:doc_type]
      if @document.save
        flash[:notice] = "Document Successfully uploaded."
        if session[:doc_ids] != nil
          session[:doc_ids].each do |doc_id|
            @drag_drop = DragDrop.find(doc_id)
            @document = Document.new(:document => @drag_drop.document)
            @document.user_id = current_user.id
            @document.location_id = params[:document][:location_id]
            @document.transaction_id = params[:document][:transaction_id]
            @document.doc_type = params[:document][:doc_type]
            @document.save
            flash[:notice] = "Document Successfully uploaded."
            @drag_drop.destroy
          end
        end
        session[:doc_ids] = nil
        if @document.doc_type == "office"
          redirect_to office_documents_path
        else
          redirect_to params[:document][:transaction_id].present? ? transaction_path(params[:document][:transaction_id]) : dashboards_path
        end
      else
        render :action => :new
      end
    end
  end
  
  def drag_drop
    @document = DragDrop.new(:document => @raw_file)
    @document.save
    flash[:notice] = "Document Successfully uploaded."
    (session[:doc_ids] ||= []) << @document.id
    respond_to do |format|
      format.html
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
    @documents = Document.where("user_id = '#{current_user.id}' and reviewed = false ")
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

  private
  def parse_raw_upload
    if env['HTTP_X_FILE_UPLOAD'] == 'true'
      @raw_file = env['rack.input']
      @raw_file.class.class_eval { attr_accessor :original_filename, :content_type }
      @raw_file.original_filename = env['HTTP_X_FILE_NAME']
      @raw_file.content_type = env['HTTP_X_MIME_TYPE']
    end
  end
end
