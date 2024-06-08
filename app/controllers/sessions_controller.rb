class SessionsController < ApplicationController

    skip_before_action :authenticate, only: [:create, :google_user, :logout]
    
    def create
        user = find_user
        if user&.authenticate(session_params[:password])
            # Generate a session token
            token = encode_token(user.as_json except: [:password_digest, :id])

            # Set the session token as an HTTP-only cookie
            cookies.signed[:user] = {
                value: token,
                httponly: true,
                secure: Rails.env.production?, # Set secure flag for production environment
                expires: 1.hour.from_now # Set cookie expiration time
            }

            render json: user, status: :accepted
        else
            render json: { error: 'Invalid username, email, or password' }, status: :unauthorized
        end
    end

    def find_user
        User.find_by!("email = :identity OR username = :identity", identity: session_params[:identity])
    end

    def me
        render json: @user
    end

    def logout
        response.set_cookie('user', value: '', expires: 1.day.ago, path: '/')
        head :no_content
    end

    # check and create google user
    def google_user
        user = find_user
        if user
            render json: user
        else
        # Create a new user with the provided email and name
        new_user = User.create(email: params[:email], name: params[:name], password: 'swr23r3r3r334gdvrv', password_confirmation: 'swr23r3r3r334gdvrv')
        token = encode_token({user_id: new_user.id})
        render json: { loggedin: true, user: new_user, jwt:token, status:'registered' }
        end
    end

    private

    def session_params
        params.permit(:identity, :password)
    end 
end