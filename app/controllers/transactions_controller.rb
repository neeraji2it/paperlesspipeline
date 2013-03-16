class TransactionsController < ApplicationController

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.user_id = current_user.id
    if @transaction.save
      redirect_to dashboard_index_path
    else
      render :action => 'new'
    end
  end
end
