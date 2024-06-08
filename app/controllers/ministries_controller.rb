class MinistriesController < ApplicationController

    skip_before_action :authenticate, only: [:index, :show]

    def index
        render json: Ministry.all
    end

    def show
        render json: find_ministry
    end

    private

    def find_ministry
        Ministry.find(params[:id])
    end
end
