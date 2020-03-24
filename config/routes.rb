Rails.application.routes.draw do
  root to: ->(env) { [200, {}, ['ok']] }
end
