Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
scope '/api' do
    get '/messages', to: 'messages#index'
    post '/messages', to: 'messages#create'
    get '/messages/:id', to: 'messages#show'
    put 'messages/:id', to: 'messages#update'
    delete 'messages/:id', to: 'messages#destroy'
scope '/auth' do 
  post '/sign_up', to: 'users#create'
  post '/sign_in', to: 'users#sign_in'
end
end
end
