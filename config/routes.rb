Rails.application.routes.draw do
  root to: ->(env) { [200, {}, ['ok']] }

  get 'estudo-biblico', to: 'bible_study_requests#new'
  post 'estudo-biblico', to: 'bible_study_requests#create'
end
