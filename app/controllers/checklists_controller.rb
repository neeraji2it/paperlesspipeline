class ChecklistsController < ApplicationController
  
  # POST /checklists
  # POST /checklists.json
  def create
    Checklist.create(:name => params[:checklist], :transaction_id => params[:transaction_id])
    @transaction = Transaction.find(params[:transaction_id])
    @checklists = @transaction.checklists
    respond_to do |format|
      format.js
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
