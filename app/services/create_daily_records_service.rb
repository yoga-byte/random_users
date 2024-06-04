# frozen_string_literal: true

class CreateDailyRecordsService
  def initialize(record_date = Time.zone.yesterday.to_date)
    @record_date = record_date
  end

  def call
    create_daily_record
  end

  def create_daily_record
    daily_record = DailyRecord.create(
      date: @record_date,
      male_count: RedisHelper.get_count('male'),
      female_count: RedisHelper.get_count('female')
    )
    return unless daily_record

    RedisHelper.reset_count
  end
end
