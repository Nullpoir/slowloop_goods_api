module ApiRequest
  extend ActiveSupport::Concern

  included do
    before_action :underscore_params!
  end

  private

  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end
end
