class TodoListsController < ApplicationController
  before_action :set_todo, only: [:edit, :update]

  def index
    @todos = TodoList.all.by_current_user(current_user.id).order(status: :desc)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @todos.update(todos_params)
        format.html { redirect_to todo_lists_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @todos }
      else
        format.html { render :edit }
        format.json { render json: @todos.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_todo
    @todos = TodoList.includes(:project).find(params[:id])
  end

  def todos_params
    params.require(:todo_list).permit(:name, :status)
  end
end
