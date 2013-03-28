class ChecklistsController < ApplicationController
  # GET /checklists
  # GET /checklists.json
  def index
    @checklists = Checklist.search "*#{params[:search]}*"

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /checklists/1
  # GET /checklists/1.json
  def show
    @checklist = Checklist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /checklists/new
  # GET /checklists/new.json
  def new
    @checklist = Checklist.new
    @locations = Location.all
    1.times { @checklist.tasks.build }

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /checklists/1/edit
  def edit
    @checklist = Checklist.find(params[:id])
  end

  # POST /checklists
  # POST /checklists.json
  def create
    @checklist = Checklist.new(params[:checklist])
    if @checklist.tasks.blank?
      1.times { @checklist.tasks.build }
    end
    respond_to do |format|
      if @checklist.save
        format.html { redirect_to @checklist, :notice => 'Checklist was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /checklists/1
  # PUT /checklists/1.json
  def update
    @checklist = Checklist.find(params[:id])

    respond_to do |format|
      if @checklist.update_attributes(params[:checklist])
        format.html { redirect_to @checklist, :notice => 'Checklist was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /checklists/1
  # DELETE /checklists/1.json
  def destroy
    @checklist = Checklist.find(params[:id])
    @checklist.destroy

    respond_to do |format|
      format.html { redirect_to checklists_url }
    end
  end
end
