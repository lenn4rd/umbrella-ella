Rails.application.routes.draw do
  get 'weather' => 'weather#index'
  
  root to: 'weather#intro'
end
