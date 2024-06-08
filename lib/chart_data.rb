require 'date'

class ChartData
    def self.present_datapoints_data
      present_data_points_hash = {}
      today = Date.today
      current_year = today.year
      current_month = today.month
      current_week = today.cweek
      current_day = today.day
      first_day_this_year = Date.new(current_year, 1, 1)
      first_day_this_month = Date.new(current_year, current_month, 1)
      last_day_this_year = Date.new(current_year, 12, 31)
      last_day_this_month = first_day_this_month.next_month - 1

      Conference.all.reduce({}) do |accumulator, current|

        this_year_conferences = :this_year_conferences
        this_month_conferences = :this_month_conferences
        this_week_conferences = :this_week_conferences
        today_conferences = :today_conferences

        this_year_participants = :this_year_participants
        this_month_participants = :this_month_participants
        this_week_participants = :this_week_participants
        today_participants = :today_participants

        accumulator[this_year_conferences] ||= 0
        accumulator[this_month_conferences] ||= 0
        accumulator[this_week_conferences] ||= 0
        accumulator[today_conferences] ||= 0

        accumulator[this_year_participants] ||= 0
        accumulator[this_month_participants] ||= 0
        accumulator[this_week_participants] ||= 0
        accumulator[today_participants] ||= 0

        if current.get_start_date >= first_day_this_year
          accumulator[this_year_conferences] += 1
          accumulator[this_year_participants] += current.participants.count

          if current.get_start_date.cweek >= current_week
            accumulator[this_week_conferences] += 1
            accumulator[this_week_participants] += current.participants.count
          end
        end
      
        if current.get_start_date >= first_day_this_month
          accumulator[this_month_conferences] += 1
          accumulator[this_month_participants] += current.participants.count
        end
      
        if current.get_start_date >= today
  
          accumulator[today_conferences] += 1
          accumulator[today_participants] += current.participants.count
        end
      
        accumulator
      end
    end

    def self.ministry_participation_data
      Ministry.includes(:conferences).all.map { |ministry| {  ministry: ministry.name,  count: ministry.conferences.count } }
    end
  
    def self.state_department_conference_participation_data
      ministry_department_tree = {}
      StateDepartment.includes(:conferences).all.map { |department| { department: department.name, ministry: department.ministry.name,  count: department.conferences.count } }.each do |state_department|
        if ministry_department_tree["#{state_department[:ministry]}"]
          ministry_department_tree["#{state_department[:ministry]}"]["#{state_department[:department]}"] = state_department[:count]
        else
          ministry_department_tree["#{state_department[:ministry]}"] = { "#{state_department[:department]}" => state_department[:count] }
        end
      end
      ministry_department_tree
    end

    def self.state_department_attendance_participation_data
      ministry_department_tree = {}
      StateDepartment.includes(:conferences).all.map { |department| { department: department.name, ministry: department.ministry.name,  count: department.conferences.map { |conference| conference.participants.count }.sum } }.each do |state_department|
        if ministry_department_tree["#{state_department[:ministry]}"]
          ministry_department_tree["#{state_department[:ministry]}"]["#{state_department[:department]}"] = state_department[:count]
        else
          ministry_department_tree["#{state_department[:ministry]}"] = { "#{state_department[:department]}" => state_department[:count] }
        end
      end
      ministry_department_tree
    end
  
    def self.ministry_attendance_participation_data
      Ministry.includes(:conferences).all.map do |ministry| 
        { ministry: ministry.name,  count: ministry.conferences.map { |conference| conference.participants.count }.sum } 
      end
    end

    def self.conferences_per_city_data
      Conference.all.map { |conference| conference.city }.tally
    end

    def self.per_city_conference_participation_data
      city_participations = Conference.all.map { |conference| { "#{conference.city}" => conference.participants.count }}
      summed_hash = {}

      city_participations.each do |participation|
        if summed_hash[participation.keys[0]]
          summed_hash[participation.keys[0]] = summed_hash[participation.keys[0]] + participation[participation.keys[0]]
        else
          summed_hash[participation.keys[0]] = participation[participation.keys[0]]
        end
      end
      summed_hash
    end

    private

    def start_date(year, month, day)
      Date.new(year, month, day)
    end

    def end_date(year, month, day)
      Date.new(year, month, day)
    end
end  