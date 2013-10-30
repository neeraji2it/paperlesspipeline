class DashboardController < ApplicationController
  before_filter :is_signed_in?

  layout 'application'
  def index
    @recent_documents_to_assign = Document.where('user_id=? and transaction_id IS NULL ',current_user.id)
    @recent_documents_to_review = Document.where("review = 'false'").last(5)
    @recent_documents_to_enter = Document.where("entered = 'false'").last(5)
    required_document_types = ["private","sale","listing"]
    uploaded_document_types = current_user.documents.collect{|d| d.document_type.to_s.downcase}.uniq
    missing_document_types = required_document_types - uploaded_document_types
    @documents = Document.where("user_id = '#{current_user.id}'")

    # Current month all transaction ======================================================================
    @transactions = Transaction.where("user_id = '#{current_user.id}'")
    @this_month_listing_total_commission = []
    @transactions.each do |i|
      if i.present? and i.close_date.present?
        if i.close_date.strftime("%m") == Date.today.strftime("%m") and i.close_date.strftime("%y") == Date.today.strftime("%y")
          @this_month_listing_total_commission << i.total_commission
        end
      end
    end

    # Previous month transactions ========================================================================
    @passed_transactions = Transaction.where("user_id = '#{current_user.id}' and close_date < '#{Date.today}'")
    @previous_month_closed_transaction_total_commission = []
    @previous_month_listing_transactions_total_commission = []
    #@passed_transactions = Transaction.where("user_id = '#{current_user.id}' and close_date < '#{Date.today}'")
    @passed_transactions.each do |i|
      @previous_month_listing_transactions_total_commission << i.total_commission
    end
    @passed_transactions.each do |i|
      if i.present?
        if i.close_date.strftime("%m") == (Date.today-1.month).strftime("%m") and i.close_date.strftime("%y") == Date.today.strftime("%y")
          @previous_month_closed_transaction_total_commission << i.total_commission
        end
      end
    end

    # All Listing Transactions============================================================================
    @transactions = Transaction.where("user_id = '#{current_user.id}'")
    @total_commission = []
    @transactions.each do |transaction|
      @total_commission << transaction.total_commission
    end
    @closed_total_commission = []
    @transactions.each do  |i|
      @closed_total_commission << i.total_commission
    end
    
    #Incomplete checklists Transations ==========================================
    @incomplete_checklist_transactions = Transaction.includes(:checklists).where(:checklists=>{:id=>nil})
    #passed transaction =========================================================
    @passed_transactins = Transaction.where('user_id =? and close_date <= ?',current_user.id,Date.today)
    # transaction closes in 30 days==============================================
    @closing_transactions = Transaction.where("user_id =? and close_date BETWEEN ? and ?",current_user.id,Date.today,Date.today+1.month)
    #this month transactions=====================================================
    @this_month_transactions = Transaction.where('user_id =? and created_at BETWEEN ? AND ?', current_user.id,Time.now.beginning_of_month, DateTime.now.end_of_month)
  end

end
