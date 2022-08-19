# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new create]
  before_action :authorize_action, only: %i[new edit create destroy mark_resolved assign_developer]
  
  def index
    @bugs = @project.bugs
  end

  def show; end

  def new
    @bug = Bug.new
  end

  def edit; end

  def create
    @bug = Bug.new(bug_params)

    if @bug.save
      redirect_to bug_url(@bug), notice: 'Bug was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update

    if @bug.update(bug_params)
      redirect_to bug_url(@bug), notice: 'Bug successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

    if @bug.destroy
      redirect_to project_bugs_url(@bug.project_id), notice: 'Bug successfully destroyed.'
    else
      render :index, notice: 'Bug not destroyed.'
    end
  end

  def mark_resolved
    @bug = Bug.find(params[:bug_id])
    @bug.update(status: params[:status])

    respond_to do |format|
      format.html { redirect_to project_bugs_path(@bug.project_id), notice: 'Bug successfully updated.' }
      format.js
    end
  end

  def assign_developer
    @bug = Bug.find(params[:bug_id])
    @bug.update(developer_id: current_user.id)
    
    respond_to do |format|
      format.html { redirect_to project_bugs_path(@bug.project_id), notice: 'Bug assigned to you successfully' }
      format.js
    end
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def authorize_action
    authorize Bug
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :type_of_bug, :status, :creator_id, :developer_id,
                                :project_id, :screenshot)
  end
end
