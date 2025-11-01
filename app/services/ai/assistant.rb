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
        @chat.messages.order(:created_at).last(8).each do |m|
          history << { role: m.role, content: m.content.to_s }
        end
      end

      client = RubyLLM::Client.new(api_key: ENV["RUBYLLM_API_KEY"])

      response = client.chat(
        model: ENV.fetch("RUBYLLM_MODEL", "gpt-4o-mini"),
        messages: [{ role: "system", content: system_rules }]
                    .concat(history)
                    .concat([{ role: "user", content: prompt }]),
        temperature: 0.2
      )

      response.dig("choices", 0, "message", "content") || "Lo siento, no pude generar una respuesta."
    rescue => e
      Rails.logger.error("[AI] #{e.class}: #{e.message}")
      "Ha ocurrido un problema procesando tu consulta. Intenta nuevamente."
    end
  end
end
