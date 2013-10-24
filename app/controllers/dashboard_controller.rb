class DashboardController < ApplicationController
  before_filter :is_signed_in?

  layout 'application'
  def index
    @recent_documents_to_assign = Document.last(5).where("reviewed = 'false'")
    @recent_documents_to_review = Document..last(5).where("reviewed = 'false'")
    @recent_documents_to_enter = Document.last(5)
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
    @passed_transactions = Transaction.where("user_id = '#{current_user.id}' and close_date < '#{Date.today}'")
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
    @closing_transactions = Transaction.where("user_id = '#{current_user.id}' and '#{Date.today}' < close_date < '#{Date.today+1.month}'")

  end

end
