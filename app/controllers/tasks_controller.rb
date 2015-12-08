class TasksController < ApplicationController
	before_filter :get_category
	before_filter :get_task, only: [:edit, :update, :destroy]
	def new
		@task = Task.new
	end

	def edit
	end

	def create
		@task = @category.tasks.create(task_params)
		redirect_to category_path(@category)
	end

	def update
		if @task.update(task_params)
			redirect_to category_path(@category)
		else
			render 'edit'
		end
	end

	def destroy
		@task.destroy
		redirect_to category_path(@category)
	end

	private
		def task_params
			params.require(:task).permit(:title, :description)
		end

		def get_category
			@category = Category.find(params[:category_id])
		end

		def get_task
			@task = @category.tasks.find(params[:id])
		end
end
