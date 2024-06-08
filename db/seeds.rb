# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'date'
require 'faker'
require 'thread'

ministries = [
  {
    name: "The Presidency",
    description:
      "The Presidency includes the Executive Office of the President, Office of the Deputy President, and Cabinet Affairs Office.",
  },
  {
    name: "Office of the Prime Cabinet Secretary",
    description:
      "The Office of the Prime Cabinet Secretary is headed by Musalia Mudavadi and consists of State Department For Performance and Management and State Department For Parliamentary Affairs.",
  },
  {
    name: "Ministry of Interior and National Administration",
    description:
      "The Ministry of Interior and National Administration is led by Kithure Kindiki and comprises State Department For Correctional Services, State Department For Internal Security And National Administration, and State Department For Citizen Services. It also includes Kenya Police, Administration Police, Kenya Prisons Service, and Probation and Aftercare Services agencies.",
  },
  {
    name: "The National Treasury And Economic Planning",
    description:
      "The National Treasury And Economic Planning, headed by Njuguna Ndung'u, includes State Department of Finance and State Department for Economic Planning. It is associated with Kenya Revenue Authority and Central Bank of Kenya.",
  },
  {
    name: "Ministry of Foreign and Diaspora Affairs",
    description:
      "The Ministry of Foreign and Diaspora Affairs, led by Alfred Mutua, includes State Department for Foreign Affairs and State Department for Diaspora Affairs. It is associated with Kenya Foreign Service Institute.",
  },
  {
    name: "Ministry of Defence",
    description:
      "The Ministry of Defence is led by Aden Duale and consists of the State Department of Defence. It also includes Kenya Defence Forces, The Kenya Space Agency, and National Defence University of Kenya.",
  },
  {
    name: "Ministry of Health",
    description:
      "The Ministry of Health, headed by Susan Wafula, includes State Department For Medical Services and State Department For Public Health Services. It is associated with various healthcare-related institutions.",
  },
  {
    name: "Ministry of Education",
    description:
      "The Ministry of Education, led by Ezekiel Machogu Ombaki, includes State Department For Basic Education, State Department For Technical, Vocational Education And Training, and State Department For Higher Education And Research. It is associated with various educational institutions and councils.",
  },
  {
    name: "Ministry Of Roads, Transport And Public Works",
    description:
      "The Ministry Of Roads, Transport And Public Works is headed by Onesmus Kipchumba Murkomen and consists of State Department Of Roads, State Department For Transport, and State Department For Public Works. It is associated with various transportation and infrastructure agencies.",
  },
  {
    name: "Ministry of Devolution and Arid and Semi-Arid Lands (ASALs)",
    description:
      "The Ministry of Devolution and Arid and Semi-Arid Lands (ASALs) includes the State Department of Devolution and State Department of Arid and Semi-Arid Lands (ASALs).",
  },
  {
    name: "Ministry Of Lands, Housing And Urban Development",
    description:
      "The Ministry Of Lands, Housing And Urban Development, led by Zacharia Mwangi Njeru, includes State Department For Lands And Physical Planning, State Department For Housing, and State Department For Urban Development. It is associated with the National Land Commission.",
  },
  {
    name: "Ministry of Environment and Forestry",
    description:
      "The Ministry of Environment and Forestry, headed by Roselinda Soipan Tuiya, includes the State Department of Environment and Forestry. It is associated with the National Environment Management Authority.",
  },
  {
    name: "Ministry of Mining and Petroleum",
    description:
      "The Ministry of Mining and Petroleum, led by Davis Chirchir, includes the State Department of Mining and State Department of Petroleum.",
  },
  {
    name: "Ministry of Agriculture And Livestock Development",
    description:
      "The Ministry of Agriculture And Livestock Development is led by Mithika Linturi and includes the State Department For Crop Development and State Department For Livestock Development. It is associated with various agricultural institutions.",
  },
  {
    name: "Ministry of East African Community and Northern Corridor Development",
    description:
      "The Ministry of East African Community and Northern Corridor Development includes the State Department of East African Community and Northern Corridor Development.",
  },
  {
    name: "Ministry of Labour and Social Protection",
    description:
      "The Ministry of Labour and Social Protection, led by Florence Bore, includes the State Department of Labour and State Department of Social Protection, Pensions, and Senior Citizens Affairs. It is associated with the National Social Security Fund.",
  },
  {
    name: "Ministry of Tourism and Wildlife",
    description:
      "The Ministry of Tourism and Wildlife, headed by Peninah Malonza, includes the State Department of Tourism, State Department of Culture, and State Department of Heritage. It also includes the State Department for Wildlife.",
  },
  {
    name: "Ministry of Water and Sanitation",
    description:
      "The Ministry of Water and Sanitation, led by Alice Wahome, includes the State Department of Water and Sanitation.",
  },
  {
    name: "Ministry Of Public Service, Gender And Affirmative Action",
    description:
      "The Ministry Of Public Service, Gender And Affirmative Action is led by Aisha Jumwa and includes the State Department For Public Service and State Department For Gender And Affirmative Action. It is associated with various gender-related institutions and funds.",
  },
  {
    name: "Ministry of Energy",
    description:
      "The Ministry of Energy, headed by Charles Cheruiyot Keter, includes the State Department of Energy and State Department of Renewable Energy.",
  },
  {
    name: "Ministry of Trade, Investments And Industry",
    description:
      "The Ministry of Trade, Investments And Industry, led by Moses Kuria, includes the State Department For Industry and State Department of Trade. It is associated with various trade-related agencies and institutions.",
  },
  {
    name: "Ministry of Information Communications And The Digital Economy",
    description:
      "The Ministry of Information Communications And The Digital Economy, headed by Eliud Owalo, includes the State Department For Broadcasting And Telecommunications and State Department For Information Communication Technology (ICT) And Digital Economy. It is associated with various communication and digital-related agencies.",
  },
  {
    name: "Ministry of Youth Affairs, Sports And The Arts",
    description:
      "The Ministry of Youth Affairs, Sports And The Arts, led by Ababu Namwamba, includes the State Department of Sports and is associated with various sports and arts-related institutions.",
  },
];

state_departments = [
  {
    ministry_name: "The Presidency",
    name: "Executive Office of the President",
    description:
      "The Executive Office of the President is part of The Presidency.",
  },
  {
    ministry_name: "The Presidency",
    name: "Office of the Deputy President",
    description:
      "The Office of the Deputy President is part of The Presidency.",
  },
  {
    ministry_name: "The Presidency",
    name: "Cabinet Affairs Office",
    description: "The Cabinet Affairs Office is part of The Presidency.",
  },
  {
    ministry_name: "Office of the Prime Cabinet Secretary",
    name: "State Department For Performance and Management",
    description:
      "This department is part of the Office of the Prime Cabinet Secretary.",
  },
  {
    ministry_name: "Office of the Prime Cabinet Secretary",
    name: "State Department For Parliamentary Affairs",
    description:
      "This department is part of the Office of the Prime Cabinet Secretary.",
  },
  {
    ministry_name: "Ministry of Interior and National Administration",
    name: "State Department For Correctional Services",
    description:
      "This department is part of the Ministry of Interior and National Administration.",
  },
  {
    ministry_name: "Ministry of Interior and National Administration",
    name: "State Department For Internal Security And National Administration",
    description:
      "This department is part of the Ministry of Interior and National Administration.",
  },
  {
    ministry_name: "Ministry of Interior and National Administration",
    name: "State Department For Citizen Services",
    description:
      "This department is part of the Ministry of Interior and National Administration.",
  },
  {
    ministry_name: "The National Treasury And Economic Planning",
    name: "State Department of Finance",
    description:
      "This department is part of The National Treasury And Economic Planning.",
  },
  {
    ministry_name: "The National Treasury And Economic Planning",
    name: "State Department for Economic Planning",
    description:
      "This department is part of The National Treasury And Economic Planning.",
  },
  {
    ministry_name: "Ministry of Foreign and Diaspora Affairs",
    name: "State Department for Foreign Affairs",
    description:
      "This department is part of the Ministry of Foreign and Diaspora Affairs.",
  },
  {
    ministry_name: "Ministry of Foreign and Diaspora Affairs",
    name: "State Department for Diaspora Affairs",
    description:
      "This department is part of the Ministry of Foreign and Diaspora Affairs.",
  },
  {
    ministry_name: "Ministry of Defence",
    name: "State Department of Defence",
    description: "This department is part of the Ministry of Defence.",
  },
  {
    ministry_name: "Ministry of Health",
    name: "State Department For Medical Services",
    description: "This department is part of the Ministry of Health.",
  },
  {
    ministry_name: "Ministry of Health",
    name: "State Department For Public Health Services",
    description: "This department is part of the Ministry of Health.",
  },
  {
    ministry_name: "Ministry of Education",
    name: "State Department For Basic Education",
    description: "This department is part of the Ministry of Education.",
  },
  {
    ministry_name: "Ministry of Education",
    name: "State Department For Technical, Vocational Education And Training",
    description: "This department is part of the Ministry of Education.",
  },
  {
    ministry_name: "Ministry of Education",
    name: "State Department For Higher Education And Research",
    description: "This department is part of the Ministry of Education.",
  },
  {
    ministry_name: "Ministry Of Roads, Transport And Public Works",
    name: "State Department Of Roads",
    description:
      "This department is part of the Ministry Of Roads, Transport And Public Works.",
  },
  {
    ministry_name: "Ministry Of Roads, Transport And Public Works",
    name: "State Department For Transport",
    description:
      "This department is part of the Ministry Of Roads, Transport And Public Works.",
  },
  {
    ministry_name: "Ministry Of Roads, Transport And Public Works",
    name: "State Department For Public Works",
    description:
      "This department is part of the Ministry Of Roads, Transport And Public Works.",
  },
  {
    ministry_name:
      "Ministry of Devolution and Arid and Semi-Arid Lands (ASALs)",
    name: "State Department of Devolution",
    description:
      "This department is part of the Ministry of Devolution and Arid and Semi-Arid Lands (ASALs).",
  },
  {
    ministry_name:
      "Ministry of Devolution and Arid and Semi-Arid Lands (ASALs)",
    name: "State Department of Arid and Semi-Arid Lands (ASALs)",
    description:
      "This department is part of the Ministry of Devolution and Arid and Semi-Arid Lands (ASALs).",
  },
  {
    ministry_name: "Ministry Of Lands, Housing And Urban Development",
    name: "State Department For Lands And Physical Planning",
    description:
      "This department is part of the Ministry Of Lands, Housing And Urban Development.",
  },
  {
    ministry_name: "Ministry Of Lands, Housing And Urban Development",
    name: "State Department For Housing",
    description:
      "This department is part of the Ministry Of Lands, Housing And Urban Development.",
  },
  {
    ministry_name: "Ministry Of Lands, Housing And Urban Development",
    name: "State Department For Urban Development",
    description:
      "This department is part of the Ministry Of Lands, Housing And Urban Development.",
  },
  {
    ministry_name: "Ministry of Environment and Forestry",
    name: "State Department of Environment and Forestry",
    description:
      "This department is part of the Ministry of Environment and Forestry.",
  },
  {
    ministry_name: "Ministry of Mining and Petroleum",
    name: "State Department of Mining",
    description:
      "This department is part of the Ministry of Mining and Petroleum.",
  },
  {
    ministry_name: "Ministry of Mining and Petroleum",
    name: "State Department of Petroleum",
    description:
      "This department is part of the Ministry of Mining and Petroleum.",
  },
  {
    ministry_name: "Ministry of Agriculture And Livestock Development",
    name: "State Department For Crop Development",
    description:
      "This department is part of the Ministry of Agriculture And Livestock Development.",
  },
  {
    ministry_name: "Ministry of Agriculture And Livestock Development",
    name: "State Department For Livestock Development",
    description:
      "This department is part of the Ministry of Agriculture And Livestock Development.",
  },
  {
    ministry_name:
      "Ministry of East African Community and Northern Corridor Development",
    name: "State Department of East African Community and Northern Corridor Development",
    description:
      "This department is part of the Ministry of East African Community and Northern Corridor Development.",
  },
  {
    ministry_name: "Ministry of Labour and Social Protection",
    name: "State Department of Labour",
    description:
      "This department is part of the Ministry of Labour and Social Protection.",
  },
  {
    ministry_name: "Ministry of Labour and Social Protection",
    name: "State Department of Social Protection, Pensions, and Senior Citizens Affairs",
    description:
      "This department is part of the Ministry of Labour and Social Protection.",
  },
  {
    ministry_name: "Ministry of Tourism and Wildlife",
    name: "State Department of Tourism",
    description:
      "This department is part of the Ministry of Tourism and Wildlife.",
  },
  {
    ministry_name: "Ministry of Tourism and Wildlife",
    name: "State Department of Culture",
    description:
      "This department is part of the Ministry of Tourism and Wildlife.",
  },
  {
    ministry_name: "Ministry of Tourism and Wildlife",
    name: "State Department of Heritage",
    description:
      "This department is part of the Ministry of Tourism and Wildlife.",
  },
  {
    ministry_name: "Ministry of Tourism and Wildlife",
    name: "State Department for Wildlife",
    description:
      "This department is part of the Ministry of Tourism and Wildlife.",
  },
  {
    ministry_name: "Ministry of Water and Sanitation",
    name: "State Department of Water and Sanitation",
    description:
      "This department is part of the Ministry of Water and Sanitation.",
  },
  {
    ministry_name: "Ministry Of Public Service, Gender And Affirmative Action",
    name: "State Department For Public Service",
    description:
      "This department is part of the Ministry Of Public Service, Gender And Affirmative Action.",
  },
  {
    ministry_name: "Ministry Of Public Service, Gender And Affirmative Action",
    name: "State Department For Gender And Affirmative Action",
    description:
      "This department is part of the Ministry Of Public Service, Gender And Affirmative Action.",
  },
  {
    ministry_name: "Ministry of Energy",
    name: "State Department of Energy",
    description: "This department is part of the Ministry of Energy.",
  },
  {
    ministry_name: "Ministry of Energy",
    name: "State Department of Renewable Energy",
    description: "This department is part of the Ministry of Energy.",
  },
  {
    ministry_name: "Ministry of Trade, Investments And Industry",
    name: "State Department For Industry",
    description:
      "This department is part of the Ministry of Trade, Investments And Industry.",
  },
  {
    ministry_name: "Ministry of Trade, Investments And Industry",
    name: "State Department of Trade",
    description:
      "This department is part of the Ministry of Trade, Investments And Industry.",
  },
  {
    ministry_name:
      "Ministry of Information Communications And The Digital Economy",
    name: "State Department For Broadcasting And Telecommunications",
    description:
      "This department is part of the Ministry of Information Communications And The Digital Economy.",
  },
  {
    ministry_name:
      "Ministry of Information Communications And The Digital Economy",
    name: "State Department For Information Communication Technology (ICT) And Digital Economy",
    description:
      "This department is part of the Ministry of Information Communications And The Digital Economy.",
  },
  {
    ministry_name: "Ministry of Youth Affairs, Sports And The Arts",
    name: "State Department of Sports",
    description:
      "This department is part of the Ministry of Youth Affairs, Sports And The Arts.",
  },
]

images = [
  "https://cdn.pixabay.com/photo/2017/03/28/12/17/chairs-2181994_640.jpg",
  "https://cdn.pixabay.com/photo/2017/03/28/12/11/chairs-2181960_640.jpg",
  "https://cdn.pixabay.com/photo/2017/03/28/12/10/chairs-2181951_640.jpg",
  "https://cdn.pixabay.com/photo/2016/08/16/09/53/international-conference-1597531_640.jpg",
  "https://cdn.pixabay.com/photo/2017/03/28/12/06/chairs-2181919_640.jpg",
  "https://cdn.pixabay.com/photo/2023/05/08/13/24/laptop-7978588_640.jpg",
  "https://cdn.pixabay.com/photo/2023/04/01/13/26/lake-7892215_640.jpg",
  "https://cdn.pixabay.com/photo/2016/02/03/17/38/coffee-break-1177540_640.jpg",
  "https://cdn.pixabay.com/photo/2016/01/18/09/21/conference-room-1146244_640.jpg",
  "https://cdn.pixabay.com/photo/2017/08/06/11/09/interior-2591368_640.jpg",
  "https://cdn.pixabay.com/photo/2019/10/21/10/34/meeting-4565702_640.jpg",
  "https://cdn.pixabay.com/photo/2015/01/08/18/12/meeting-593301_640.jpg"
]

cities = ["Nairobi", "Mombasa", "Kisumu", "Nakuru", "Eldoret", "Naivasha"]

def attach_file_to_conference(model_instance, remote_url, file_name)
  io = URI.open(remote_url)
  puts "Succesfully attached [ ------- #{model_instance.id} - #{model_instance.reference_number} -------> ] #{model_instance.poster.attach(io: io, filename: "#{file_name}")}"
end

puts "Seeding"

start_date = Date.new(2019, 1, 1)
end_date = Date.new(Date.today.year, 12, 31)

puts "Creating Ministries"

ministries.each do |ministry_hash|
  ministry = Ministry.create!(ministry_hash)
  state_departments.select { |state_department| state_department[:ministry_name] == ministry.name}.each do |state_department|
    StateDepartment.create!({
      **state_department,
      ministry_id: ministry.id
    })
  end
end

state_department_count = StateDepartment.count

threads = []

puts "Creating Conferences"
27.times do
    start = (start_date..end_date).to_a.sample.strftime('%Y-%m-%d')
    last = (Date.parse(start) + rand(1..10)).strftime('%Y-%m-%d')
    ref_num = SecureRandom.alphanumeric(10).upcase
    hash = {
      "reference_number": ref_num,
      "number": Faker::PhoneNumber.phone_number_with_country_code,
      "email": Faker::Internet.email,
      "location": "#{Faker::Address.street_address}, #{Faker::Address.secondary_address}" ,
      "date": "#{start} - #{last}",
      "time": "09:30 - 16:30",
      "city": cities.sample,
      "title": Faker::Lorem.sentence.slice(0..-2),
      "description": Faker::Lorem.paragraph(sentence_count: rand(1..4)),
      "issues": (1..rand(1..7)).to_a.map { Faker::Lorem.paragraph sentence_count: rand(1..4) }.join("|"),
      "resolutions": (1..rand(1..7)).to_a.map { Faker::Lorem.paragraph sentence_count: rand(1..4) }.join("|"),
      "recommendations": (1..rand(1..7)).to_a.map { Faker::Lorem.paragraph sentence_count: rand(1..4) }.join("|"),
      "state_department_id": rand(1..state_department_count)
    }

    conf = Conference.create(hash)
    puts "Attaching remote poster to [#{ref_num} #{conf.id}] using an active job..."
    threads << Thread.new do
      attach_file_to_conference(conf, images.sample, "#{ref_num}.jpg")
    end
end

nationalities = ["Turkish Cypriots", "Kenyans", "Kenyans", "Chadians", "Kenyans", "Kenyans", "Norwegians", "Kenyans", "Norwegians", "Kenyans", "Croatians", "Zambians", "Kenyans", "Saudis", "Kenyans", "Finnish Swedish", "Kenyans", "Malagasy", "Kenyans", "Finnish Swedish"]

puts "Creating Participants"
350.times do
  Participant.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    id_number: Faker::IdNumber.valid,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    nationality: nationalities.sample
  )
end

puts "Creating Superuser"
User.create({
  name: "Admin Conference",
  email: "admin@gmail.com",
  password: "password",
  username: "erick",
  is_admin: true
})

cn = Conference.count
pn = Participant.count


puts "Creating Participations"
400.times do
  Participation.create!(
    participant_id: rand(1..pn),
    conference_id: rand(1..cn)
  )
end

puts "Waiting for all file attachment threads to complete"

threads.each(&:join)

puts "All active jobs complete!"

puts "Done seeding"