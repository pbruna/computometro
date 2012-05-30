Computometro::Application.routes.draw do
  match '/movements/balance' => "movements#balance"
  match '/deals/total' => "deals#total"
  resources :movements
  resources :deals
end
