Rails.application.routes.draw do

  devise_for :customers#,controllers: {
    #sessions: 'public/sessions',
    #registrations: 'public/registrations',
    #passwords: 'public/passwords'}

  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about'
    get 'customers/:id/confirm' => 'customers#confirm' ,as: 'confirm_customer'
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe' ,as: 'unsubscribe_customer'
    resources :customers, only:[:show, :edit, :update]
    resources :items, only:[:show, :index]
  end


  namespace :admin do

    get '/' => 'homes#top'
    resources :items, except:[:destroy]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]

  end

  devise_for :admins,controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
