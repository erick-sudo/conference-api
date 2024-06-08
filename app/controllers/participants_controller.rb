class ParticipantsController < ApplicationController
    skip_before_action :authenticate, only: [:index, :show, :create, :update, :monthly, :daily]

    def index
        render json: Participant.all
    end

    def show
        render json: find_paticipant
    end

    def create
        render json: Participant.create!(participant_params)
    end

    def update
    end

    def delete
        participant = Participant.find(params[:id])
        participant.destroy
    end

    def monthly
    end

    def daily
    end

    private

    def find_paticipant
        Paticipant.find(params[:id])
    end

    def participant_params
        params.permit(:name, :email, :phone, :id_number, :address, :city, :nationality)
    end
end
