class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :ask]

  def index
    @chats = Chat.all.order(created_at: :desc)
  end

  def show
    @messages = @chat.messages.order(:created_at)
  end

  def create
    @chat = Chat.create!(title: params[:title] || "Nuevo Chat Médico", model: "gpt-4o-mini")
    redirect_to @chat
  end

  def ask
    prompt = params[:prompt]
    @response = @chat.ask(prompt: prompt, system_prompt: MEDICAL_SYSTEM_PROMPT)
    redirect_to @chat, notice: "Respuesta generada correctamente."
  rescue => e
    redirect_to @chat, alert: "Error: #{e.message}"
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end
end
