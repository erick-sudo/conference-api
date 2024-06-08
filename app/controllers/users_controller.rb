require 'securerandom'
require 'net/smtp'

class UsersController < ApplicationController

    skip_before_action :authenticate, only: [:create, :new_admin]

    def index
        render json: User.all
    end

    def create
        render json: User.create!(user_params), status: :created
    end

    def send_email(sender_email, sender_password, recipient_email, subject, body)
        smtp_server = 'smtp.gmail.com'
        smtp_port = 587
        domain = 'gmail.com'
        enable_ssl = true

        message = <<~MESSAGE
            From: #{sender_email}
            To: #{recipient_email}
            Subject: #{subject}

            #{body}
        MESSAGE

        Net::SMTP.start(smtp_server, smtp_port, domain, sender_email, sender_password, :login) do |smtp|
            smtp.enable_starttls if enable_ssl
            smtp.send_message(message, sender_email, recipient_email)
        end
    end

    def new_admin
        sender_email = 'ram.bharathbrands@gmail.com'
        sender_password = 'eccfutcatpsykoho'
        
        recipient_email = admin_params[:email]
        subject = admin_params[:name]

        pass = SecureRandom.hex(12).upcase

        body = "Password: #{pass}"

        user = User.create!({**user_params, password: pass, is_admin: true})

        send_email(sender_email, sender_password, recipient_email, subject, body)

        render json: user, status: :accepted
    end

    def show
        render json: find_user
    end

    def destroy
        find_user.destroy
        head :no_content
    end

    def update
        user = find_user
        user.update!(user_params)
        render json: user, status: :accepted
    end

    private

    def find_user
        User.find(params[:id])
    end

    def user_params
        params.permit(:id, :name, :email, :username, :password, :password_confirmation)
    end

    def admin_params
        params.permit(:username, :email, :name)
    end
end
