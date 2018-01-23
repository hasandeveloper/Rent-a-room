Rails.application.routes.draw do

  devise_for :users
  resources :cities

  get 'rooms/myrooms'
  get 'rooms/authorize'
  resources :rooms

  resources :amenities
  resources :permissions

  get 'bookings/confirmation'
  resources :bookings

  root 'cities#index'

end
