require 'csv'
class TransactionsController < ApplicationController
  respond_to :html, :json

  before_filter :is_valid_account?, :except => ['index']

  def index
    #@transactions = Transaction.where("user_id = #{current_user.id}")
    @transactions = Transaction.where("user_id = '#{current_user.id}'")
    #raise @transactions.inspect
  end

  def transaction_search
    @transactions = Transaction.search "*#{params[:search]}*"
       
    respond_to do |format|
      format.js
    end
  end

  def export_transactions
    @transactions = Transaction.where("user_id = #{current_user.id}")
    csv_string = CSV.generate do |csv|
      csv << ["Address", "MLS Number", "Status","Close Date","More Info","Buyer","Seller","List price","Sale price","Commission Amount","Commission Summary"]
      @transactions.each do |transaction|
        csv << [transaction.transaction_name, transaction.transaction_number, transaction.status, transaction.close_date,transaction.more_info,transaction.buyer_name,transaction.seller_name,transaction.list_price,transaction.sale_price,transaction.total_commission,transaction.commission_summary]
      end
    end

    send_data csv_string,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=trasactions.csv"
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.user_id = current_user.id
    @transaction.location_id = params[:transaction][:location_id]
    if @transaction.save
      csv_string = CSV.generate do |csv|
        csv << ["Address", "MLS Number", "Status","Close Date","More Info","Buyer","Seller","List price","Sale price","Commission Amount","Commission Summary"]
        csv << [@transaction.transaction_name, @transaction.transaction_number, @transaction.status, @transaction.close_date,@transaction.more_info,@transaction.buyer_name,@transaction.seller_name,@transaction.list_price,@transaction.sale_price,@transaction.total_commission,@transaction.commission_summary]
      end

      send_data csv_string,
        :type => 'text/csv; charset=iso-8859-1; header=present',
        :disposition => "attachment; filename=trasactions.csv"
    else
      render :action => 'new'
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    @transaction.update_attributes(params[:transaction])
    if @transaction.save
      redirect_to dashboard_index_path
    else
      render :action => 'edit'
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def search
    @transactions = Transaction.where("transaction_name = '#{params[:search]}'")
    respond_to do |format|
      format.js
    end
  end

  def advance_search
    @transactions = Transaction.where("user_id = '#{current_user.id}'")
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  def transaction_advance_search
    @transactions = Transaction.where("close_date = '#{params[:close_date]}'")
    respond_to do |format|
      format.js
    end
  end

  def filter
    
  end

  def location_search
    if params[:location].present?
      @transactions = Transaction.where("(location_id = #{params[:location]} or status = #{params[:status]}) and user_id = #{current_user.id}")
      render :action => 'index'
    else
      @transactions = Transaction.where("user_id = #{current_user.id}")
      render :action => 'index'
    end
  end
end
