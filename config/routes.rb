Rails.application.routes.draw do
   devise_for :users

  get "dashboard", to: "dashboard#show"

  resource :patients_profile, only: %i[show edit update]
  resources :chats, only: %i[index show create] do
    post :ask, on: :member
    resources :messages, only: %i[index create]
  end
  resources :analyses, only: %i[index new create show]
  resources :appointments, only: %i[index new create]

  post "chatbot/ask", to: "chatbot#ask"
end
