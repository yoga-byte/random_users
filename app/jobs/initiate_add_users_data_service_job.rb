# frozen_string_literal: true

class InitiateAddUsersDataServiceJob < ApplicationJob
  queue_as :high_priority

  def perform
    AddUsersDataService.new.call
  end
end
