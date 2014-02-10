class TasksController < ApplicationController

	def new
		@task = Task.new
	end

	def show
		@task = Task.first
	end

	def done
		@task = Task.find(params[:task_id])
		current_user.mark_task_done(@task)
		redirect_to action: "index"
	end

	def reopen
		@task = Task.find(params[:task_id])
		current_user.reopen_task(@task)
		redirect_to action: "index"
	end

	def accept
		@task = Task.find(params[:task_id])
		current_user.accept_task(@task)
		redirect_to action: "index"
	end

	def request_extension
		@task = Task.find(params[:task_id])
	end

	def index
		@done_tasks = current_user.get_done_tasks
		@pending_tasks = current_user.get_pending_tasks
		@sent_tasks = current_user.get_sent_tasks
		@tasks = current_user.tasks_responsible_for
	end

	def sent_tasks
		@sent_tasks = current_user.get_sent_tasks
	end
end
