require 'rails_helper'

RSpec.describe User, type: :model do
  before do #creating data for today and yesterday
    (0..1).each do |t|
      2.times do
        AddUsersDataService.new(Time.zone.now - t.days).call
      end
      CreateDailyRecordsService.new(Time.zone.today.to_date - t.days).call # these are created just after midnight so default date is of yesterday
    end
  end

  it "refactor the male count  when a male user is deleted" do
    todays_male_user = DailyRecord.find_by(date: Time.zone.today.to_date).male_count
    yesterday_male_user = DailyRecord.find_by(date: Time.zone.yesterday.to_date).male_count
    puts "Todays male count #{todays_male_user}"
    puts "Yesterday male count #{yesterday_male_user}"

    described_class.where(gender: 'male').where("created_at > ? ", Time.zone.today.to_date).first.destroy
    expect(DailyRecord.find_by(date: Time.zone.today.to_date).male_count).to be(todays_male_user - 1)
  end

  it "refactor the female count  when a female user is deleted" do
    todays_female_user = DailyRecord.find_by(date: Time.zone.today.to_date).female_count
    yesterday_female_user = DailyRecord.find_by(date: Time.zone.yesterday.to_date).female_count
    puts "Todays female count #{todays_female_user}"
    puts "Yesterday female count #{yesterday_female_user}"

    described_class.where(gender: 'female').where("created_at > ? ", Time.zone.today.to_date).first.destroy
    expect(DailyRecord.find_by(date: Time.zone.today.to_date).female_count).to be(todays_female_user - 1)
  end
end
