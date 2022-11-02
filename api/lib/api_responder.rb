class ApiResponder < ActionController::Responder
  def display_errors
    controller.render error: :record_invalid, model: resource, status: :unprocessable_entity
  end
end
