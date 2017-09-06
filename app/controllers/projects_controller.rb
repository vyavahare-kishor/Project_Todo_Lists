class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :assign, :edit, :update, :destroy]

  def index
    @projects = Project.all.current_manager(current_user.id)
  end

  def assign
  end

  def show
  end

  def new
    @project = Project.new
    @project.todo_lists.build
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.manager = current_user.id
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.includes(:todo_lists, :users).find(params[:id])
    end

    def update_todo_lists_param
      params["project"]["todo_lists_attributes"].each{|key,value|
        value.merge!({user_id: current_user.id}) if value["id"].blank?
        value.merge!({status: :new}) if value["status"].blank?
      }
    end

    def project_params
      update_todo_lists_param
      params.require(:project).permit(:name, todo_lists_attributes: [:id, :name, :status, :user_id, :_destroy])
    end
end
