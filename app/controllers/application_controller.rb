class ApplicationController < ActionController::API
    wrap_parameters format: []
    include ActionController::Cookies
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

    before_action :authenticate

    def authenticate
        # Decode and verify JWT token from the 'jwt' cookie
        token = cookies.signed[:user]

        begin
            secret_key = Rails.application.secrets.secret_key_base

            payload = JWT.decode(token, secret_key, true, { algorithm: 'HS512' }).first
            @user = User.find_by('email': payload['email'])
        rescue JWT::DecodeError => e
            # Invalid JWT token
            render json: { error: 'Unauthorized Access' }, status: :unauthorized
            return;
        end

        # If no valid JWT token found, redirect to login page
        unless @user
            render json: { error: 'Unauthorized Access' }, status: :unauthorized
        end
    end

    def encode_token(payload)
        # Set the secret key used for signing the token
        secret_key = Rails.application.secrets.secret_key_base
      
        # Encode the payload using the secret key and return the token
        JWT.encode(payload, secret_key, 'HS512')
      end

    private

    def record_not_found_response
        # Handling record not found error
        render json: { error: "#{controller_name.classify} not found" }, status: :not_found
    end

    def unprocessable_entity_response(invalid)
        render json: { "errors": invalid.record.errors }, status: :unprocessable_entity
    end
end
