class StateDepartmentsController < ApplicationController
    skip_before_action :authenticate, only: [:index, :show]

    def index
        render json: StateDepartment.all
    end

    def show
        render json: find_state_department
    end

    private

    def find_state_department
        StateDepartment.find(params[:id])
    end
end
