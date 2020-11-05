class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(task_params)
      redirect_to root_path # go to the index so we can see the book in the list
      return
    else
      # save failed :(
      render :edit # show the new book form view again
      return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    @task.destroy
    redirect_to root_path
  end

  def mark_complete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    @task.completed_at = Time.now.to_s
    @task.save
    redirect_to root_path
  end

  def mark_incomplete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    @task.completed_at = nil
    @task.save
    redirect_to root_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :started_at, :completed_at)
  end
end

end
