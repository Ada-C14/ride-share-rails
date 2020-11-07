class ApplicationController < ActionController::Base

  private

  def action_success_check(action, redirect_path, destination_view: :new)
    if action
      redirect_to redirect_path
    else
      render destination_view, status: :bad_request
    end
  end

end
