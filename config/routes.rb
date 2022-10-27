Rails.application.routes.draw do

  devise_for :customers, skip: ['registrations', 'passwords']
  devise_scope :customer do
    get 'customers/sign_up', to: 'devise/registrations#new', as: :new_customer_registration
    post 'customers', to: 'devise/registrations#create', as: :customer_registration
  end

  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about'
    get 'customers/confirm',as: 'confirm_customer'
    get 'customers/unsubscribe',as: 'unsubscribe_customer'
    delete 'cart_items' => 'cart_items#destroy_all',as: 'destroy_all_cart_items'
    resource :customers, only:[:show, :edit, :update]
    resources :items, only:[:show, :index]
    resources :cart_items, except:[:new, :show, :edit]
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
