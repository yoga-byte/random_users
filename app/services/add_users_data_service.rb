# frozen_string_literal: true

class AddUsersDataService
  def call
    if api_response.code == '200'
      before_count = gender_count
      add_users
      store_in_redis(before_count)
    else
      handle_failure
    end
  end

  def api_response
    @api_response ||= UsersDataApiResponseService.new.call
  end

  def gender_count
    User
      .select('count(uuid), gender')
      .group('gender')
      .each_with_object(Hash.new(0)) do |x, h|
      h[x['gender']] = x['count']
    end
  end

  def add_users
    result = JSON.parse(api_response.body)['results']
    uuids = result.map { |item| item['login']['uuid'] }
    users_by_uuid = User.where(uuid: uuids).index_by(&:uuid)

    users = result.map do |user_data|
      uuid = user_data['login']['uuid']
      attributes = {
        uuid:,
        name: user_data['name'],
        location: user_data['location'],
        age: user_data['dob']['age'],
        gender: user_data['gender']
      }
      user = users_by_uuid[uuid] || User.new
      user.attributes = attributes
      user
    end

    User.import(
      users,
      on_duplicate_key_update: {
        conflict_target: [:uuid],
        columns: %i[name location age gender]
      }
    )
  end

  def handle_failure
    Rails.logger.fatal 'API is not responding'
  end

  def store_in_redis(before_count)
    after_count = gender_count
    male_count = after_count['male'] - before_count['male']
    female_count = after_count['female'] - before_count['female']
    RedisHelper.add_male_count(male_count) if male_count.positive?
    RedisHelper.add_female_count(female_count) if female_count.positive?
  end
end
