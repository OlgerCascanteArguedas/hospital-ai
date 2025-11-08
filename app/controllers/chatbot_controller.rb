class ChatbotController < ApplicationController
  before_action :authenticate_user!

  def ask
    chat = current_user.chats.where(title: "Chat rápido").first_or_create!(patients_profile: current_user.patients_profile)
    chat.messages.create!(role: "user", content: params[:prompt])

    answer = Ai::Assistant.new(chat).reply_to(params[:prompt],params[:file])
    chat.messages.create!(role: "assistant", content: answer)
    chat.touch

    render json: { answer: answer }
  end
end
