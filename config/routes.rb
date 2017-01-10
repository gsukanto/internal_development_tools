Rails.application.routes.draw do
  resources :card_infos
  get 'card_infos' => 'card_infos#index'
  get 'show' => 'card_infos#show'
  get 'cvv' => 'card_infos#cvv'
  root 'card_infos#index'
end
