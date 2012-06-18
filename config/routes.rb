Computometro::Application.routes.draw do
  match '/movements/balance' => "movements#balance"
  match '/movements/total' => "movements#total"
  match '/deals/total' => "deals#total"
  match '/deals/graph' => "deals#graph"
  match '/invoices/total' => "invoices#total"
  resources :movements
  resources :deals
  resources :invoices
  root :to => 'high_voltage/pages#show', :id => 'dashboard'
end
