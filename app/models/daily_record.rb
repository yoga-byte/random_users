# frozen_string_literal: true

class DailyRecord < ApplicationRecord
  before_save :add_avg_age

  def add_avg_age
    return unless changed?

    average_counts = User
                     .select('sum(age),count(uuid), gender')
                     .group('gender')
                     .each_with_object(Hash.new(0)) do |data, hash|
      hash[data['gender']] = data['sum'].to_f / data['count']
    end
    self.male_avg_age = average_counts['male']
    self.female_avg_age = average_counts['female']
  end
end
