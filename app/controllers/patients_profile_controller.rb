class PatientsProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!

def show
  @profile = current_user.patient_profile
end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to patients_profile_path, notice: "Perfil actualizado"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def ensure_profile!
    @profile = current_user.patients_profile || current_user.create_patients_profile!
  end

  def profile_params
    params.require(:patients_profile).permit(
      :allergies, :weight, :age, :conditions, :height,
      :gender, :medication, :medical_history
    )
  end
end
