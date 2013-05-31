class SearchController < ApplicationController

  def index
     @transactions = Transaction.search "*#{params[:search]}*"
    @checklists = Checklist.search "*#{params[:search]}*"
   
    #@users = User.search "*#{params[:search]}*"
    @documents = Document.search "*#{params[:search]}*"
    @transactions = Transaction.search "*#{params[:search]}*"
  end

end
