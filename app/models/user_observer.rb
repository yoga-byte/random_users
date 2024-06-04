# frozen_string_literal: true

class UserObserver < ActiveRecord::Observer
  def after_destroy(user)
    daily_record = DailyRecord.find_by(date: user.created_at.to_date)
    if user.gender == 'male'
      daily_record.update(male_count: daily_record.male_count - 1)
    else
      daily_record.update(female_count: daily_record.female_count - 1)
    end
  end
end
