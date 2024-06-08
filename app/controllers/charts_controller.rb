class ChartsController < ApplicationController
    skip_before_action :authenticate, only: [:ministry_participation,  :state_department_conference_participation, :state_department_attendance_participation, :conference_locations_participation, :ministry_attendance_participation, :conferences_per_city, :per_city_conference_participation, :present_datapoints]

    def present_datapoints
        render json: ChartData.present_datapoints_data
    end
    
    def ministry_participation
        render json: ChartData.ministry_participation_data
    end
    
    def state_department_conference_participation
        render json: ChartData.state_department_conference_participation_data
    end

    def state_department_attendance_participation
      render json: ChartData.state_department_attendance_participation_data
    end

    def ministry_attendance_participation
        render json: ChartData.ministry_attendance_participation_data
    end
    
    def conference_locations_participation
        render json: ChartData.conference_locations_participation_data
    end

    def conferences_per_city
        render json: ChartData.conferences_per_city_data
    end

    def per_city_conference_participation
        render json: ChartData.per_city_conference_participation_data
    end
end
