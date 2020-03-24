# frozen_string_literal: true

class AddMessageToVisitors < ActiveRecord::Migration[6.0]
  def change
    add_column :visitors, :message, :text
  end
end
