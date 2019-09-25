class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :admin

  attribute :token, if: Proc.new { |record, params|
    params && params[:token]
  }
end
