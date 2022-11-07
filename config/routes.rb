Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'

    resources :items, only:[:show, :index]

    resource :customers, only:[:show, :edit, :update]
    get 'customers/confirm',as: 'confirm_customer'
    patch 'customers/unsubscribe',as: 'unsubscribe_customer'

    resources :cart_items, except:[:new, :show, :edit]
    delete 'cart_items' => 'cart_items#destroy_all',as: 'destroy_all_cart_items'

    resources :orders, only:[:new, :create, :index, :show]
    post 'orders/confirm',as: 'confirm_order'
    get 'orders/success',as: 'success_order'

  end

  devise_for :customers, skip: ['registrations', 'passwords']
  devise_scope :customer do
    get 'customers/sign_up', to: 'devise/registrations#new', as: :new_customer_registration
    post 'customers', to: 'devise/registrations#create', as: :customer_registration
  end

  namespace :admin do

    get '/' => 'homes#top'
    resources :items, except:[:destroy]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
    resources :genres, only:[:index, :create, :edit, :update]

  end

  devise_for :admins, skip: ['sessions', 'registrations', 'passwords']
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    post 'admins/sign_in', to: 'admins/sessions#create', as: :admin_session
    delete 'admins/sign_out', to: 'admins/sessions#destroy',as: :destroy_admin_session
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
