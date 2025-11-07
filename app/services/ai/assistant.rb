require "ruby_llm"
module Ai
  class Assistant
    def initialize(chat = nil)
      @chat = chat
    end
    def reply_to(prompt)
      system_rules = <<~SYS
        Eres "Hospital IA". Responde en español, tono empático y educativo.
        No des diagnósticos definitivos ni prescripciones. Indica banderas rojas cuando sea pertinente
        y sugiere acudir a una consulta médica si es necesario.
      SYS

      history = []
      if @chat
        @chat.messages.order(:created_at).last(20).each do |m|
          history << { role: m.role, content: m.content.to_s }
        end
      end
      conversation = [{ role: "system", content: system_rules }]
      conversation += history
      conversation << { role: "user", content: prompt }
      puts conversation

      response = RubyLLM.chat
                        .with_temperature(0.2)
                        .with_messages(conversation)
                        .ask("Responde al último mensaje del usuario en contexto.")

      #response = RubyLLM.chat.with_temperature(0.2).ask(prompt)
      response.content
      puts response
    rescue => e
      Rails.logger.error("[AI] #{e.class}: #{e.message}")
      "Ha ocurrido un problema procesando tu consulta. Intenta nuevamente."
    end
  end
end
