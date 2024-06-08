Rails.application.routes.draw do
  resources :state_departments
  resources :ministries

  resources :participations
  resources :participant_ids
  resources :participants
  resources :users
  resources :conferences

  get '/media/poster/:id/download', to: 'conferences#serve_poster', as: 'conference_poster'
  get '/media/files/:id/:attachment_id', to: 'conferences#serve_file_attachment', as: 'conference_file_attachment'

  get "/statistics", to: "conferences#stats"
  post "/new/admin", to: "users#new_admin"

  get "/monthly/tally", to: "conferences#monthly_confs"
  get "/yearly/tally", to: "conferences#yearly_confs"
  get "/trend/foreign/vs/kenyan", to: "conferences#foreign_vs_kenyan"
  get "/yearly/foreign/vs/kenyan", to: "conferences#yearly_foreign_vs_kenyan"
  get "/monthly/foreign/vs/kenyan", to: "conferences#monthly_foreign_vs_kenyan"

  get "/conference/:reference_number", to: "conferences#findByReferenceNumber"
  post "/login", to: "sessions#create"
  get "/me", to: "sessions#me"
  get "/logout", to: "sessions#logout"

  delete "/conference/:reference_number", to: "conferences#delete_conference"
  patch "/conference/:reference_number", to: "conferences#update_conference"

  post "/message", to: "conferences#receive_message"


  get "/state_departments/conferences/participation", to: "charts#state_department_conference_participation"
  get "/ministries/conferences/participation", to: "charts#ministry_participation"
  get "/state_departments/attendance/participation", to: "charts#state_department_attendance_participation"
  get "/ministry/attendance/participation", to: "charts#ministry_attendance_participation"
  get "/conferences/per/city", to: "charts#conferences_per_city"
  get "/attendance/per/city", to: "charts#per_city_conference_participation"

  get "/conferences/present/datapoints", to: "charts#present_datapoints"
end
