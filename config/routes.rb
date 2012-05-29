Computometro::Application.routes.draw do
  match '/movements/balance' => "movements#balance"
  resources :movements
end
