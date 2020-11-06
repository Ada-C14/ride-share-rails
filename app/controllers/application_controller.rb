class ApplicationController < ActionController::Base

  private

  def action_success_check(action, redirect_path)
    if action
      redirect_to redirect_path
    else
      render :new, bad_request
    end
  end

end
