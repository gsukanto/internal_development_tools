Rails.application.routes.draw do
  resources :card_infos
  get 'show' => 'card_infos#show'
  get 'cvv' => 'card_infos#cvv'
  root 'card_infos#index'
end
