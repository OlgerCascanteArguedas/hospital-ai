class PatientsProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show; end
  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to patients_profile_path, notice: "Perfil actualizado"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_profile
    @profile = current_user.patients_profile
  end

  def profile_params
    params.require(:patients_profile).permit(
      :allergies, :weight, :age, :conditions, :height,
      :gender, :medication, :medical_history
    )
  end
end


#creo el controllador para el perfil de los pacientes
