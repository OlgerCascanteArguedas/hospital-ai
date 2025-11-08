require "ruby_llm"
module Ai
  class Assistant
    def initialize(chat = nil)
      @chat = chat
    end
    def reply_to(prompt,file = nil)
      system_rules = <<~SYS
        Eres "Hospital IA". Responde en español, tono empático y educativo.
        No des diagnósticos definitivos ni prescripciones. Indica banderas rojas cuando sea pertinente
        y sugiere acudir a una consulta médica si es necesario.
      SYS
      chat = RubyLLM.chat(model: "gemini-2.0-flash").with_temperature(0.2)
      #history = RubyLLM.chat
      if @chat
        @chat.messages.order(:created_at).last(20).each do |message|
          chat.add_message(role: message.role, content: message.content)
        end
      end
      response =
      if file.present?
        chat.ask(prompt,with: file.path)
      else
        chat.ask(prompt)
      end
      response.content
    rescue => e
      Rails.logger.error("[AI] #{e.class}: #{e.message}")
      "Ha ocurrido un problema procesando tu consulta. Intenta nuevamente."
    end
  end
end
