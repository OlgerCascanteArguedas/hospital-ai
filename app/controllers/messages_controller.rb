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
    user_msg = @chat.messages.create!(role: "user", content: params.require(:message)[:content])

    # 2️⃣ Armar el historial de la conversación
    conversation = @chat.messages.order(:created_at).last(20).map do |msg|
      { role: msg.role, content: msg.content }
    end

    # 3️⃣ Llamar a RubyLLM
    client = RubyLLM::Client.new(provider: :openai, model: "gpt-4o-mini")

    ai_response = client.chat(messages: conversation)

    # 4️⃣ Guardar la respuesta de la IA
    @chat.messages.create!(role: "assistant", content: ai_response)

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
end

