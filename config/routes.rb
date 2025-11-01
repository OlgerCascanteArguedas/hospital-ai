Rails.application.routes.draw do
  get 'patients_profiles/show'
  get 'patients_profiles/edit'
  get 'patients_profiles/update'
  root "dashboard#show"

  devise_for :users

  get "dashboard", to: "dashboard#show"

  resource :patients_profile, only: %i[show edit update destroy]
  resources :chats, only: %i[index show create] do
    resources :messages, only: %i[index create]
  end
  resources :analyses, only: %i[index new create show]
resources :appointments, only: [:index, :new, :create, :edit, :update, :destroy]

  post "chatbot/ask", to: "chatbot#ask"
end
