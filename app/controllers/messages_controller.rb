#class MessagesController < ApplicationController
  #before_action :authenticate_user!
  #before_action :set_chat

  #def index
    #@messages = @chat.messages.order(:created_at)
  #end

  #def create
    #user_msg = @chat.messages.create!(role: "user", content: params.require(:message)[:content])

    #ai_text = Ai::Assistant.new(@chat).reply_to(user_msg.content)
    #@chat.messages.create!(role: "assistant", content: ai_text)

    #@chat.touch
    #respond_to do |format|
      #format.turbo_stream
      #format.html { redirect_to @chat }
      #format.json { render json: { assistant: ai_text } }
    #end
  #end

  #private
  #def set_chat
    #@chat = current_user.chats.find(params[:chat_id])
  #end
#end

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  def index
    @messages = @chat.messages.order(:created_at)
  end

  def create
    # 1️⃣ Crear el mensaje del usuario
    user_message = @chat.messages.create!(
      role: "user",
      content: params.require(:message)[:content]
    )

    # 2️⃣ Armar historial completo (contexto)
    conversation = build_conversation

    # 3️⃣ Llamar al modelo RubyLLM
    client = RubyLLM::Client.new(provider: :openai, model: "gpt-4o-mini")

    ai_response = client.chat(messages: conversation)
    ai_text = ai_response.is_a?(String) ? ai_response : ai_response.dig(:message, :content)

    @chat.messages.create!(role: "assistant", content: ai_text)

    @chat.touch

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @chat }
      format.json { render json: { assistant: ai_response } }
    end
  end

  private

  def set_chat
    @chat = current_user.chats.find(params[:chat_id])
  end

  # ✅ Nuevo método para construir el historial
  def build_conversation
    system_prompt = {
      role: "system",
      content: "Eres un asistente útil que recuerda la información del usuario dentro del chat actual."
    }

    # Incluye TODOS los mensajes (o los últimos N si prefieres limitar)
    messages = @chat.messages.order(:created_at).map do |msg|
      { role: msg.role, content: msg.content }
    end

    [system_prompt] + messages
  end
end
