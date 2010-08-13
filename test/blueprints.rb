require 'machinist/active_record'
require 'sham'


Sham.define do
  role_name { Faker::Lorem.words(1) }
  username { Faker::Name.name }
  email { Faker::Internet.email }
  salt = Authlogic::Random.hex_token
  password_salt { salt }
  crypted_password { Authlogic::CryptoProviders::Sha512.encrypt("password_#{salt}") }
  persistence_token { Authlogic::Random.hex_token }
  person_name { Faker::Name.name }
  job_title { Faker::Lorem.words(2) }
  phone { Faker::PhoneNumber.phone_number }
  mobile { Faker::PhoneNumber.phone_number }
  profile { Faker::Lorem.paragraphs(1) }
  photo { File.open("#{RAILS_ROOT}/test/fixtures/photo.jpg") }
  company_name { Faker::Company.name }
  company_role { Faker::Company.bs }
  business_type { Faker::Company.catch_phrase }
  skill_name { Faker::Lorem.words(1) }
  skill_level { Faker::Lorem.words(1) }
  skill_desc { Faker::Lorem.sentences(5) }
  school_name { Faker::Lorem.words(3) }
  school_course { Faker::Lorem.words(5) }
  school_result { Faker::Lorem.sentence(1) }
  date_from { Date.civil((1970..2010).to_a.rand, (1..12).to_a.rand, (1..28).to_a.rand)}
  responsibility_desc { Faker::Lorem.paragraph }
  project_name { Faker::Lorem.words(1) }
  project_desc { Faker::Lorem.paragraph }
  task_desc { Faker::Lorem.sentence }
end

Role.blueprint do
  name { Sham.role_name}
end

Role.blueprint :admin do
  name { 'Admin' }
end

Role.blueprint :author do
  name { 'Author' }
end

User.blueprint do
  username
  email
  password_salt
  crypted_password
  persistence_token
end

Person.blueprint do
  name { Sham.person_name }
  job_title
  email
  phone
  mobile
  profile
  photo
end

Company.blueprint do
  person
  name { Sham.company_name }
  role { Sham.company_role }
  business_type
  start_date
end

Responsibility.blueprint do
  company
  description { Sham.responsibility_desc }
end

Project.blueprint do
  company
  name { Sham.project_name }
  description { Sham.project_desc }
end

Task.blueprint do
  project
  description { Sham.task_desc }
end

Skill.blueprint do
  person
  name { Sham.skill_name }
  level { Sham.skill_level }
  description { Sham.skill_desc }
end

School.blueprint do
  person
  name { Sham.school_name }
  course { Sham.school_course }
  result { Sham.school_result }
  date_from
  date_to { date_from + 1.year }
end

