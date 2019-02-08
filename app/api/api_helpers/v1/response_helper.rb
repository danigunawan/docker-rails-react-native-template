module ApiHelpers
  module V1
    module ResponseHelper
      def api_get(name, object, entity, message)
        if object.present?
          status 200
          present :message, message
          present name, object, with: entity
        else
          error!({ error_msg: "api_get_error" }, 500)
        end
      end
    end
  end
end
  