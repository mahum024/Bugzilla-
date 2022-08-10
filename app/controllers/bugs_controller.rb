# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update destroy]

  def index
    @project = Project.find(params[:project_id])
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
      redirect_to bug_url(@bug), notice: 'Bug was successfully updated.'

    else
      render :edit, status: :unprocessable_entity

    end
  end

  def destroy
    @bug.destroy
    redirect_to project_bugs_url(@bug.project_id), notice: 'Bug was successfully destroyed.'
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :type_of_bug, :status, :creator_id, :developer_id,
                                :project_id, :screenshot)
  end
end
