Rails.application.routes.draw do

  root 'site#index'

  get 'sobre' => 'application#about'

  scope 'cpgf' do
    get 'portadores' => 'people#index'
    get 'portadores/:id' => 'people#view', as: :person_path

    get 'favorecidos' => 'favored#index'
    get 'favorecidos/:id' => 'favored#view', as: :favored_path

    get 'transacoes' => 'transactions#index'
    get 'transacoes/:id' => 'transactions#view', as: :transaction
    post 'transacoes/:id' => 'transactions#report'

    get 'unidades_gestoras' => 'management_units#index'
    get 'unidades_gestoras/:id' => 'management_units#view', as: :management_unit_path
  end

  get "/sitemap.xml" => "sitemap#index", :format => "xml", :as => :sitemap
end
