# frozen_string_literal: true

class InitiateAddUserDataServiceJob < ApplicationJob
  queue_as :default

  def perform
    AddUsersDataService.new.call
  end
end
