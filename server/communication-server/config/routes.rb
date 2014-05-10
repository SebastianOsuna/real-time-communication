CommunicationServer::Application.routes.draw do
  post "users/" => "users#identify"
  post "messages/" => "messages#create"
  get "messages/" => "messages#query"
end
