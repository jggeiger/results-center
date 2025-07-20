Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check


  root "welcome#index"

  # Welcome page for ElectionBuddy coding challenge
  get "welcome" => "welcome#index"
  get "results/:election_id" => "results#show"
end
