module Resources
  module V1
    class Users < Grape::API
      helpers ApiHelpers::V1::ErrorsHelper
      resource :users do
        # http://localhost:3000/api/v1/users
        desc '/api/v1/users'
        get do
          users = User.all
          api_get( :users, users, Entities::V1::UserEntity, 'success_message' )
        end
      end 
    end
  end
end