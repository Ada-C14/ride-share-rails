class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id] #we'll be able to access our route parameter via a special hash provided by Rails called params. The ID sent by the browser will be stored under the key :id (remember that this is the name we gave the parameter in the routefile).
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def edit
    task_id = params[:id]
    @driver = Driver.find_by(id: task_id)

    if @driver.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      redirect_to root_path
      return
    elsif @driver.update(driver_params)
      redirect_to root_path # go to the index so we can see the book in the list
      return
    else
      # save failed :(
      render :edit # show the new book form view again
      return
    end
  end
end


