class DashboardController < ApplicationController
  before_filter :is_signed_in?

  layout 'application'
  def index
      #render :layout => false
      required_document_types = ["private","sale","listing"]
      uploaded_document_types = current_user.documents.collect{|d| d.document_type.to_s.downcase}.uniq
      #raise uploaded_document_types.inspect
      missing_document_types = required_document_types - uploaded_document_types
      if missing_document_types.present?
      else
        @documents = Document.where("user_id = '#{current_user.id}'")
        @transactions = Transaction.where("user_id = '#{current_user.id}'")
        @passed_transactions = Transaction.where("user_id = '#{current_user.id}' and close_date < '#{Date.today}'")
        @closing_transactions = Transaction.where("user_id = '#{current_user.id}' and '#{Date.today}' < close_date < '#{Date.today+1.month}'")
      end
  end
  
  def show
  end

end
