Computometro::Application.routes.draw do
  match '/movements/balance' => "movements#balance"
  match '/deals/total' => "deals#total"
  match '/invoices/total' => "invoices#total"
  resources :movements
  resources :deals
  resources :invoices
end
