class ChangeDataTypeForStartAndEndTime < ActiveRecord::Migration
  def change
    change_column :events, :start_time, :int
    change_column :events, :end_time, :int
  end
end
