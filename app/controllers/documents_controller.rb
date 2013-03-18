class DocumentsController < ApplicationController

  def new
    @user = current_user
    @document = Document.new
  end

  def create
    @document = Document.new(:document => params[:uploadfile])
    @document.user_id = params[:user_id]
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
end
