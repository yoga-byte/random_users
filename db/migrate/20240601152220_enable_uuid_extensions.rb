# frozen_string_literal: true

class EnableUuidExtensions < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'
  end
end
