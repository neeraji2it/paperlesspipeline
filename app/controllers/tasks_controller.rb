class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @transaction = Transaction.find(params[:transaction_id])
    respond_to do |format|
      format.js
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(:checklist_id => params[:checklist_id], :transaction_id => params[:transaction_id], :name => params[:task][:name])
    @task.save
    @checklist = Checklist.find(params[:checklist_id])
    @tasks = @checklist.tasks
    @transaction = Transaction.find(params[:transaction_id])
    @total_tran_tasks = @transaction.tasks
    @completed_tasks = @transaction.tasks.where("status = ?", true)
    if @completed_tasks.count.to_f > 0 && @total_tran_tasks.count.to_f > 0
      @per_completed_tasks = (@completed_tasks.count.to_f/@total_tran_tasks.count.to_f)*100
    else
      @per_completed_tasks = 0
    end
    respond_to do |format|
      format.js
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    @checklist = Checklist.find(@task.checklist_id)
    @tasks = @checklist.tasks
    @transaction = Transaction.find(params[:transaction_id])
    respond_to do |format|
      format.js
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    render :update do |page|
      page.reload
    end
  end

  def update_status
    @task = Task.find(params[:id])
    @task.update_attribute(:status, params[:status])
    @transaction = Transaction.find(params[:transaction_id])
    @total_tran_tasks = @transaction.tasks
    @completed_tasks = @transaction.tasks.where("status = ?", true)
    if @completed_tasks.count.to_f > 0 && @total_tran_tasks.count.to_f > 0
      @per_completed_tasks = (@completed_tasks.count.to_f/@total_tran_tasks.count.to_f)*100
    else
      @per_completed_tasks = 0
    end
    respond_to do |format|
      format.js
    end
  end
end
