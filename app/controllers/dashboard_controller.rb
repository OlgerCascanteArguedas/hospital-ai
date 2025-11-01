class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @appointments  = current_user.appointments.order(:scheduled_at).limit(5)
    @last_analysis = current_user.analyses.order(created_at: :desc).first
    @chats         = current_user.chats.order(updated_at: :desc).limit(5)

    @profile = current_user.patients_profile
    @profile&.reload
    response.set_header("Turbo-Cache-Control", "no-cache")
  end
end
