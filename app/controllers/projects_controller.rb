# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    case current_user.user_type
    when 'manager'
      @projects = current_user.projects
    when 'developer'
      @projects = current_user.projects
    when 'qa'
      @projects = Project.all
    end
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)

    if @project.save
      current_user.projects << @project
      redirect_to project_url(@project), notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_url(@project), notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  def add_developer_qa
    @project = Project.find(params[:project_id])
    @developer_in_project = @project.users.reload.where(user_type: :developer)
    @developer_not_in_project = User.where(user_type: :developer) - @developer_in_project
    @qa_in_project = @project.users.reload.where(user_type: :qa)
    @qa_not_in_project = User.where(user_type: :qa) - @qa_in_project
  end

  
  def add
    @project = Project.find(params[:project_id])
    @user = User.find(params[:id])
    @project.users << @user
    redirect_to project_add_developer_qa_path(@project)
  end

  def remove
    @project = Project.find(params[:project_id])
    @user = User.find(params[:id])
    @project.users.delete(@user)
    redirect_to project_add_developer_qa_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
