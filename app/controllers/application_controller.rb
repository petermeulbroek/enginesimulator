class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  ActionController::Parameters.action_on_unpermitted_parameters = :raise

   rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: { error: { unknown_parameters: pme.params } }, 
           status: :bad_request
  end

end
