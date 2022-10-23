Rails.application.routes.draw do

  devise_for :customers#,controllers: {
    #sessions: 'public/sessions',
    #registrations: 'public/registrations',
    #passwords: 'public/passwords'}

  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about'
    get 'customers/confirm'
    get 'customers/unsubscribe'
    resources :customers, only:[:show, :edit, :update]
  end


  namespace :admin do

    get '/' => 'homes#top'
    resources :items, except:[:new]
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
