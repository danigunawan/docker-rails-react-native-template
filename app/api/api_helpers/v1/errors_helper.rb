module ApiHelpers
  module V1
    module ErrorsHelper
      def error_server
        error!({ error_msg: "error_500", error_code: 500 }, 500)
      end

      def error_unauthorized
        error!({ error_msg: "unauthorized" }, 401)
      end
    end
  end
end
