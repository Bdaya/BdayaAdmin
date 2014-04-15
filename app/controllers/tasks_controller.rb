class TasksController < ApplicationController

	authorize_actions_for Task

	def new
		@task = Task.new
	end

	def create
		#@user = User.find(params[:task][:responsible_user_id])
		@task = Task.new params[:task]
		@task.status = "pending"
		@task.creator = current_user
		if @task.save
			redirect_to sent_tasks_path
		else
			redirect_to :back, alert: @task.errors.full_messages.join("\n")
		end
    #@task = current_user.assign_task(@user, params[:task][:deadline], params[:task][:title], params[:task][:details])
    #@task.responsible_user = User.find(params[:task][:user_id])
    #@task.save
    #redirect_to sent_tasks_path
	end

	def update
		@task = Task.find(params[:id])
		@task.status = "pending"
		if @task.update_attributes!(params[:task])
			redirect_to sent_tasks_path
		else
			redirect_to :back, alert: @task.errors.full_messages.join("\n")
		end
	end

	def show
		@task = Task.find(params[:id])

		# Show Page is rendered in details partial
		render :partial => 'details'
	end

	def done
		@task = Task.find(params[:task_id])
		current_user.mark_task_done(@task)
		redirect_to action: "index"
	end

	def reopen
		@task = Task.find(params[:task_id])
		current_user.reopen_task(@task)
		redirect_to action: "sent_tasks"
	end

	def accept
		@task = Task.find(params[:task_id])
		current_user.accept_task(@task)
		redirect_to action: "sent_tasks"
	end

	def request_extension
		@task = Task.find(params[:task_id])
	end

	def index
		@today_tasks = current_user.get_today_tasks
		@tomorrow_tasks = current_user.get_tomorrow_tasks
		@week_tasks = current_user.get_week_tasks
		@later_tasks = current_user.get_later_tasks
		@past_tasks = current_user.get_past_tasks
		# @done_tasks = current_user.get_done_tasks
		# @pending_tasks = current_user.get_pending_tasks
		# @sent_tasks = current_user.get_sent_tasks
		# @tasks = current_user.tasks_responsible_for
		@task = Task.new
	end

	def sent_tasks
		@today_tasks = current_user.get_today_sent_tasks
		@tomorrow_tasks = current_user.get_tomorrow_sent_tasks
		@week_tasks = current_user.get_week_sent_tasks
		@later_tasks = current_user.get_later_sent_tasks
		@past_tasks = current_user.get_past_sent_tasks
		# @sent_tasks = current_user.get_sent_tasks
		@task = Task.new
	end

	def send_message
	    @task = Task.find(params[:id])
	    @user = current_user.name
	    @message = params[:message]
	    @task.post_message(@user,@message)
	    redirect_to tasks_path
	end

end
