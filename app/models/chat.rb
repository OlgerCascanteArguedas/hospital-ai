class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :patients_profile
  has_many :messages, dependent: :destroy
  validates :title, presence: true

  def ask(prompt:, system_prompt:)
    client = RubyLLM.chat.with_temperature(0.2)
    full_prompt = [
      { role: "system", content: system_prompt }
    ] + messages.map { |m| { role: m.role, content: m.content } } +
      [{ role: "user", content: prompt }]

    response = client.ask(full_prompt)
    messages.create(role: "user", content: prompt)
    messages.create(role: "assistant", content: response.content)
    response.content
  end
end
