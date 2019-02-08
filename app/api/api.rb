class API < Grape::API
  helpers ApiHelpers::V1::ResponseHelper
  helpers ApiHelpers::V1::ErrorsHelper
  # urlの第１セグメント名 ex) http://localhost/api/
  prefix 'api'
  # app/api/resources/v1/root.rbをマウント
  mount Resources::V1::Root
end