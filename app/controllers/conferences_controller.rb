require 'base64'
require 'fileutils'
require 'net/smtp'

class ConferencesController < ApplicationController
    skip_before_action :authenticate, only: [:index, :show, :serve_poster, :serve_file_attachment, :findByReferenceNumber, :monthly_tally, :yearly_tally, :foreign_vs_kenyan, :yearly_foreign_vs_kenyan, :monthly_foreign_vs_kenyan, :delete_conference, :update_conference, :monthly_confs, :yearly_confs]
    
    def index
        render json: Conference.all
    end

    def serve_poster
        conference = find_conference
        if conference.poster.attached?
            redirect_to rails_blob_url(conference.poster)
        else
            render json: { message: "File Not Found" }, status: :not_found
        end
    end

    def serve_file_attachment
        conference = find_conference
        if conference.files.attached?
            attachment = conference.files.find_by(id: params[:attachment_id])
            if attachment.present?
                redirect_to rails_blob_url(attachment)
                return
            end
        end
        render json: { message: "File Not Found" }, status: :not_found
    end
    
    def foreign
        data = {}
        Conference.all.map { |c| {"#{c.id}" => c.participants.map { |p| [p.id, p.nationality] } } }.map { |conf| ["#{conf.keys[0]}" => {"Foreigners" => conf.values[0].uniq.select{ |p| p[1] != "Kenyans" }.map{|pt| pt[0]}, "Kenyans" => conf.values[0].uniq.select{ |p| p[1] == "Kenyans" }.map{|pt| pt[0]} }] }.map { |conf| conf[0] }.each do |conf|
            data["#{conf.keys[0]}"] = conf.values[0]
        end
        data
    end

    def foreign_monthly
        data = {}
        Conference.all.filter { |c| Date.parse(c.date.slice(0..9)) >  Date.today.prev_year(1)  }.map { |c| { "#{Date.parse(c.date.split(/\s+-\s+/)[0]).strftime('%B')}" => c.participants.map { |p| [p.id, p.nationality] } } }.map { |conf| {"#{conf.keys[0]}" => {"Foreigners" => conf.values[0].uniq.select{ |p| p[1] != "Kenyans" }.map{|pt| pt[0]}, "Kenyans" => conf.values[0].uniq.select{ |p| p[1] == "Kenyans" }.map{|pt| pt[0]} } } }.each do |conf|
            month = "#{conf.keys[0]}"
            if data[month]
                data[month]["Foreigners"].concat(conf[month]["Foreigners"])
                data[month]["Kenyans"].concat(conf[month]["Kenyans"])
            else
                data[month] = conf[month]
            end
        end

        data
    end
        

    def foreign_vs_kenyan
        data = foreign
        render json: data.keys.map { |k| k.to_i }.sort.map { |k| { id: k, "Foreigners" => data[k.to_s]["Foreigners"].count, "Kenyans" => data[k.to_s]["Kenyans"].count } }
    end

    def yearly_foreign_vs_kenyan
        data = {}
        foreign.each_pair do |key, value|
            year = "#{Conference.find(key.to_i).date.split("-")[0]}"
            if data[year]
                data[year]["Foreigners"].concat(value["Foreigners"])
                data[year]["Kenyans"].concat(value["Kenyans"])
            else
                data[year] = value
            end
        end

        tallys = {}

        data.each_pair do |key, value|
            tallys[key] = {"Foreigners" => value["Foreigners"].size, "Kenyans" => value["Kenyans"].size}
        end

        render json: tallys
    end

    def monthly_foreign_vs_kenyan
        tallys = {}

        foreign_monthly.each_pair do |key, value|
            tallys[key] = {"Foreigners" => value["Foreigners"].size, "Kenyans" => value["Kenyans"].size}
        end

        render json: tallys
    end

    def yearly_confs
        render json: Conference.all.map { |c| Date.parse(c.date.split(/\s+-\s+/)[0]).strftime('%Y') }.tally
    end

    def monthly_confs
        month_tally = Conference.all.map { |c| [Date.parse(c.date.split(/\s+-\s+/)[0]).strftime('%B'), Date.parse(c.date.split(/\s+-\s+/)[0]).strftime('%B')] }.flatten.tally
        months = Date::MONTHNAMES.compact.group_by { |month| month }.transform_values(&:count)
        month_init = months.each_key { |k| months[k]=0 }
        tally = month_init.merge(month_tally)
        render json: tally
    end

    def findByReferenceNumber
        conference = Conference.find_by(reference_number: params[:reference_number])
        attachment_ids = conference.files.attachments.pluck(:id)
        render json: conference, serializer: ConferenceSerializer, attachment_ids: attachment_ids
    end

    def create
        ref_number = SecureRandom.alphanumeric(10).upcase

        conference_create_params = conference_params

        conference_create_params.delete(:poster)
        conference_create_params.delete(:files)

        conference = Conference.create!({
            **conference_create_params,
            reference_number: ref_number
        })

        save_conference_attachments(conference, conference_params)

        render json: conference, status: :created
    end

    def save_conference_attachments(conference_instance, conference_params_hash)
        if conference_params_hash[:poster]
            # Remove the previous one
            conference_instance.poster.purge_later
            save_binary_data_to_active_storage(conference_instance, conference_params_hash[:poster], "poster")
        end
        if conference_params_hash[:files]
            # Attach each file
            conference_params_hash[:files].each do |fileDataUrl|
                save_binary_data_to_active_storage(conference_instance, fileDataUrl, "files")
            end
        end
    end

    def show
        conference = Conference.find(params[:id])
        attachment_ids = conference.files.attachments.pluck(:id)
        render json: conference, serializer: ConferenceSerializer, attachment_ids: attachment_ids
    end

    def update_conference
        conference = Conference.find_by(reference_number: params[:reference_number])
        ref_number = params[:reference_number]

        conference_update_stage_params = conference_update_params

        # Remove attachments from the conference update hash
        conference_update_stage_params.delete(:poster)
        conference_update_stage_params.delete(:participants)
        conference_update_stage_params.delete(:files)
        
        if conference
            if conference_update_params[:participants]
                new_participants = Participant.create!(conference_update_params[:participants])
                new_participants.each do |participant|
                    Participation.create!({
                        participant_id: participant.id,
                        conference_id: conference.id
                    })
                end
            end

            save_conference_attachments(conference, conference_update_params)
          conference.update!(conference_update_stage_params)
          render json: conference
        else
            render json: { error: 'Record not found' }, status: :not_found
        end
    end

    def save_binary_data_to_active_storage(conf, data_url, prop)
        # Separate base64 string from metadata
        data = data_url.split(',')
        base64String = data[-1]
        content_type = data[0].slice((data[0].index(":")+1)...data[0].index(";")) # Content-Type
        extension = data[0].slice((data[0].index("/")+1)...data[0].index(";")) # File extension

        # Extracting the base64 String
        binary_data = Base64.decode64(base64String)

        if prop == "poster"
            conf.poster.attach(io: StringIO.new(binary_data), filename: "#{conf.reference_number}.#{extension}", content_type: content_type)
        else
            conf.files.attach(io: StringIO.new(binary_data), filename: "#{conf.reference_number}.#{extension}", content_type: content_type)
        end
    end

    def delete_conference
            conference = Conference.find_by(reference_number: params[:reference_number])
            if conference
              conference.destroy
              render json: { message: 'Record deleted successfully' }
            else
              render json: { error: 'Record not found' }, status: :not_found
            end
    end

    private

    def find_conference
        Conference.find(params[:id])
    end

    def conference_params
        params.permit(:state_department_id, :number, :email, :location, :city, :time, :date, :poster, :title, :description, :expected, files: [])
    end

    def conference_update_params
        params.permit(:state_department_id, :number, :actual, :expected, :email, :location, :city, :time, :date, :poster, :title, :description, :reference_number, :issues, :resolutions, :recommendations, files: [], participants: [ :email, :phone, :id_number, :address, :city, :nationality ])
    end

    def message_params
        params.permit(:name, :email, :message)
    end
end
