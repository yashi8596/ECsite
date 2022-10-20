Rails.application.routes.draw do

  devise_for :customers,controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords'}

  namespace :admin do
    resources :items
    resources :customers, only:[:index, :show, :edit, :update]
  end

  devise_for :admins,controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
