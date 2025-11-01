class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:edit, :update, :destroy]

  def index
    @appointments = current_user.appointments.order(scheduled_at: :asc)
    @next_appointment = @appointments.where("scheduled_at >= ?", Time.current).first
    @other_appointments = @next_appointment ? @appointments.where.not(id: @next_appointment.id) : @appointments
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

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Cita actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Cita eliminada."
  end

  private

  def set_appointment
    # Garantiza que solo edites las tuyas
    @appointment = current_user.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:scheduled_at, :reason)
  end
end
