class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  def index
    @messages = @chat.messages.order(:created_at)
  end

  def create
    raise
    user_msg = @chat.messages.create!(role: "user", content: params.require(:message)[:content])
    file = params[:message][:file]
    ai_text = Ai::Assistant.new(@chat).reply_to(user_msg.content, file: file)
    @chat.messages.create!(role: "assistant", content: ai_text)

    @chat.touch
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @chat }
      format.json { render json: { assistant: ai_text } }
    end
  end

  private
  def set_chat
    @chat = current_user.chats.find(params[:chat_id])
  end
end
