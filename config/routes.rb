Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'copy/:key', to: 'copies#index'
      get 'copy', to: 'copies#show'
    end
  end
end
