Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :forms do
    post 'add_field', on: :collection
    get '/:field_id/delete_field', to: 'forms#delete_field', on: :collection, as: 'delete_field'
  end

  get 'forms/:form_id/answers', controller: :form_answer, to: 'form_answer#answers', as: 'form_answers'
  get 'forms/:form_id/answers/:form_answer_id', controller: :form_answer, to: 'form_answer#detailed_answer', as: 'form_answer'
  get 'forms/:form_id/answer', controller: :form_answer, to: 'form_answer#new_answer', as: 'answer_form'
  post 'forms/:form_id/answer', controller: :form_answer, to: 'form_answer#answer'

  # Defines the root path route ("/")
  root "forms#index"
end
