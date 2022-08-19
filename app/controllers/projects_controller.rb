# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy add remove add_developer_qa]
  before_action :set_user, only: %i[add remove]
  before_action :authorize_action, only: %i[new edit create destroy add_developer_qa add remove]
  before_action :user_data, only: %i[add remove add_developer_qa]

  def index
    case current_user.user_type
    when 'manager', 'developer'
      @projects = current_user.projects
    when 'qa'
      @projects = Project.all
    end
  end

  def show
    @users = @project.users

    if (current_user.user_type != 'qa') && (!@project.users.include? current_user)
      redirect_to projects_path, notice: 'You are not authorized to view this Project'
    else
      render 'show'
    end
  end

  def new
    @add_user = User.all
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    @user_in_project = params[:project][:u_id].reject(&:blank?)

    if @project.save
      current_user.projects << @project

      @user_in_project.each do |user_id|
        User.find(user_id.to_i).projects << @project
      end
      redirect_to project_url(@project), notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity, notice: 'Project was successfully created.'
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
    if @project.destroy
      redirect_to projects_url, notice: 'Project was successfully destroyed.'
    else
      render :index, notice: 'Project not destroyed.'
    end
  end

  def add_developer_qa; end

  def add
    @project.users << @user unless @project.users.include? @user

    respond_to do |format|
      format.html { redirect_to project_add_developer_qa_path(@project) }
      format.js
    end
  end

  def remove
    @project.users.delete(@user)

    respond_to do |format|
      format.html { redirect_to project_add_developer_qa_path(@project) }
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_project
    @project = Project.find(params[:id] || params[:project_id])
  end

  def project_params
    params.require(:project).permit(:name, :user_id, :u_id)
  end

  def authorize_action
    authorize Project
  end

  def user_data
    @developer_in_project = @project.users.reload.where(user_type: :developer)
    @developer_not_in_project = User.where(user_type: :developer) - @developer_in_project
    @qa_in_project = @project.users.reload.where(user_type: :qa)
    @qa_not_in_project = User.where(user_type: :qa) - @qa_in_project
  end
end
