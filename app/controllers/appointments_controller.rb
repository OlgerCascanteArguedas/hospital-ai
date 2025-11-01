class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = current_user.appointments.order(scheduled_at: :asc)
  end

  def new
    @appointment = current_user.appointments.new
  end

  def create
    @appointment = current_user.appointments.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, notice: "Solicitud enviada. Te notificaremos la confirmación."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:scheduled_at, :reason)
  end
end
