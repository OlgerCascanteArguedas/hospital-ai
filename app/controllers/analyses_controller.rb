class AnalysesController < ApplicationController
  before_action :authenticate_user!

  def index
    @analyses = current_user.analyses.order(created_at: :desc)
  end

  def new
    @analysis = current_user.analyses.new
  end

  def create
    @analysis = current_user.analyses.new(analysis_params)
    if @analysis.save
      prompt = <<~TXT
        Eres un asistente médico. Resume en lenguaje claro los hallazgos de este análisis.
        No brindes diagnóstico definitivo. Incluye banderas rojas y sugiere consultar con profesional.
        Datos del paciente (si aplica): #{current_user.patients_profile.attributes.except("id","user_id","created_at","updated_at")}
      TXT
      ai = Ai::Assistant.new
      @analysis.update(ai_result: ai.reply_to(prompt))

      redirect_to @analysis, notice: "Análisis subido correctamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @analysis = current_user.analyses.find(params[:id])
  end

  private
  def analysis_params
    params.require(:analysis).permit(:description, :file)
  end
end
