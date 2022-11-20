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

    get 'orders/success',as: 'success_order'
    post 'orders/confirm',as: 'confirm_order'
    resources :orders, only:[:new, :create, :index, :show]

    resources :addresses, except:[:new, :show]
  end

  devise_for :customers, skip: ['sessions','registrations', 'passwords']
  devise_scope :customer do
    get 'customers/sign_up', to: 'public/registrations#new', as: :new_customer_registration
    post 'customers', to: 'public/registrations#create', as: :customer_registration
    get 'customers/sign_in', to: 'public/sessions#new', as: :new_customer_session
    post 'customers/sign_in', to: 'public/sessions#create', as: :customer_session
    delete 'customers/sign_out', to: 'public/sessions#destroy', as: :destroy_customer_session
  end

  namespace :admin do

    get '/' => 'homes#top'
    resources :items, except:[:destroy]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
    resources :genres, only:[:index, :create, :edit, :update]
  end

  devise_for :admin, skip: ['sessions', 'registrations', 'passwords']
  devise_scope :admin do
    get 'admin/sign_in', to: 'admin/sessions#new', as: :new_admin_session
    post 'admin/sign_in', to: 'admin/sessions#create', as: :admin_session
    delete 'admin/sign_out', to: 'admin/sessions#destroy',as: :destroy_admin_session
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
