# frozen_string_literal: true

class CallCreateDailyRecordServiceJob < ApplicationJob
  queue_as :default

  def perform
    CreateDailyRecordsService.new.call
  end
end
