module RequestErrorable
  extend ActiveSupport::Concern

  included do
    private

    def respond_with_record_not_found(exception)
      message = I18n.t("errors.not_found", entity: exception.model.constantize.model_name.human)

      respond_with_error(:not_found, errors: [ message ])
    end

    def respond_with_params_missing(exception)
      message = I18n.t("errors.missing_params", param: exception.param)

      respond_with_error(:bad_request, errors: [ message ])
    end

    def respond_with_error(code, errors: nil)
      render json: { errors: errors }, status: code
    end
  end
end
