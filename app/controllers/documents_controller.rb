class DocumentsController < ApplicationController

  def index
    @documents = Document.where("user_id = #{current_user.id}")
  end

  def new
    @user = current_user
    @document = Document.new
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
      respond_to do |format|
        format.js
      end
    end
  end

  def working
    #raise params.inspect
    @documents = Document.all
  end

  def working_filter
    @documents = Document.where("location_id = '#{params[:locations]}'")
    render :action => 'index'
  end

  def search
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
    @documents = Document.search "*#{params[:search]}*"
    @transactions = Transaction.search "*#{params[:search]}*"
  end

end
