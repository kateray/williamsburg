RailsAdmin.config do |config|
  config.default_items_per_page = 100

  ### Popular gems integration

  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      username == ENV['RAILS_ADMIN_USERNAME'] &&
      password == ENV['RAILS_ADMIN_PASSWORD']
    end
  end
  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.model 'UserPin' do
    list do
      scopes [nil, :missing_neighborhood, :missing_city]
      field :id do
        column_width 50
      end
      field :country_code do
        label "cntry"
        column_width 20
      end
      field :state do
        column_width 80
      end
      field :used_city do
        label "city"
        column_width 110
      end
      field :used_neighborhood do
        label "neighborhood"
        column_width 110
      end
      field :latitude do
        column_width 90
      end
      field :longitude do
        column_width 90
      end
      field :city_name do
        column_width 80
      end
      field :town do
        column_width 70
      end
      field :neighborhood do
        column_width 120
      end
      field :suburb do
        column_width 70
      end
      field :token
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
