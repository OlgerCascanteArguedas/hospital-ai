class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: %i[edit update destroy]

  def index
    @appointments = current_user.appointments.upcoming
  end

  def new
    @appointment  = current_user.appointments.new
    @appointments = current_user.appointments.upcoming
  end

  def create
    date = params[:appointment].delete(:date)
    time = params[:appointment].delete(:time)
    scheduled_at = if date.present? && time.present?
                      Time.zone.parse("#{date} #{time}")
                    end

    @appointment = current_user.appointments.new(appointment_params.merge(scheduled_at: scheduled_at))

    if @appointment.save
      redirect_to appointments_path, notice: "Cita agendada"
    else
      @appointments = current_user.appointments.upcoming
      flash.now[:alert] = "Revisa los campos"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    date = params[:appointment].delete(:date)
    time = params[:appointment].delete(:time)
    if date.present? && time.present?
      params[:appointment][:scheduled_at] = Time.zone.parse("#{date} #{time}")
    end

    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Cita actualizada"
    else
      flash.now[:alert] = "Revisa los campos"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Cita eliminada"
  end

  private

  def set_appointment
    @appointment = current_user.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment)
          .permit(:specialty, :reason, :notes, :scheduled_at)
  end
end
