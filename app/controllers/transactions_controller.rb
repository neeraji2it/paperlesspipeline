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
    @assigning_users = User.where("location = '#{current_user.location}' and id != '#{current_user.id}' ")
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.user_id = current_user.id
    @transaction.location_id = params[:transaction][:location_id]
    @assigning_users = User.where("location = '#{current_user.location}' and id != '#{current_user.id}' ")
    if @transaction.save
      if !params[:listing].nil?
        params[:listing].each do |list|
          Agent.create(:user_id => list,:transaction_id => @transaction.id,:listing => true,:selling => false)
        end
      end

      if !params[:selling].nil?
        params[:selling].each do |sell|
          @agent = Agent.find_by_transaction_id_and_user_id(@transaction.id,sell)
          if @agent
            @agent.selling = true
            @agent.save
          else
            Agent.create(:user_id => sell,:transaction_id => @transaction.id,:listing => false,:selling => true)
          end
        end
      end
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
    @contacts = @transaction.contacts
    @total_tran_tasks = @transaction.tasks
    @completed_tasks = @transaction.tasks.where("status = ?", true)
    @per_completed_tasks = (@completed_tasks.count.to_f/@total_tran_tasks.count.to_f)*100
    @listing_agents = User.where("location = '#{current_user.location}' and id != '#{current_user.id}' and role = '#{Agent}' ")
    @staff_agents = User.all

    @transaction_documents = Document.where("transaction_id = '#{@transaction.id}'")
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
      @transactions = Transaction.where("close_date = '#{params[:close_date]}' or status = '#{params[:status]}'")
      puts"============================================================"
      puts @transactions.inspect
      puts"============================================================"
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
    @transactions = Transaction.where("user_id = '#{current_user.id}'")
    if request.xhr?
      @transactions = Transaction.where("user_id = '#{current_user.id}' and transaction_name = '#{params[:transaction_name]}'")
      respond_to do |format|
        format.js
      end
    end
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

  def create_contact
    @contact = Contact.new(params[:contact])
    @transaction = Transaction.find(params[:id])
    @contact.transaction_id = params[:id]
    @contact.save
    @contacts = @transaction.contacts
    respond_to do |format|
      format.js
    end
  end

  def add_note
    @note = Note.new(params[:note])
    @transaction = Transaction.find(params[:note][:transaction_id])
    @note.transaction_id = @transaction.id
    @user = current_user.id
    @note.save
    respond_to do |format|
      format.js
    end
  end

  def agents_search
    @assigning_users = User.where("location = '#{current_user.location}' and id != '#{current_user.id}' and first_name LIKE '#{params[:agent_name]}%'")
    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @comment = Comment.new(params[:comment])
    @comment.save
    respond_to do |format|
      @document = Document.find(@comment.document_id)
      format.js
    end
  end

end
