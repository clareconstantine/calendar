class Event < ActiveRecord::Base

  def day= d     
    write_attribute :day, format_day(d)
  end

  # store times in absolute time so they are standard and easy to work with across the app
  def start_time= start     
    write_attribute :start_time, absolute_time(start)
  end

  def end_time= ending
    write_attribute :end_time, absolute_time(ending)
  end

  # in units of 30 min because each calendar cell is 30 min
  def duration
    end_time - start_time
  end

  # Save it so it is easy to compare with day labels on calendar
  def format_day d
    case d
      when 'Sunday'
        'Sun'
      when 'Monday'
        'Mon'
      when 'Tuesday'
        'Tues'
      when 'Wednesday'
        'Wed'
      when 'Thursday'
        'Thurs'
      when 'Friday'
        'Fri'
      when 'Saturday'
        'Sat'
      end
  end


  # convert the time strings into an absolute value of 30 minute units
  # use format of time strings as they are input
  # the first row on the calendar is 0
  def absolute_time time
    time_to_absolute = {  '11:30pm' =>  0, '12:00' =>  1, '12:30' =>  2, '1:00' =>  3, '1:30' =>  4,
        '2:00' =>  5, '2:30' =>  6, '3:00' =>  7, '3:30' =>  8, '4:00' =>  9, '4:30' => 10, '5:00' => 11,
        '5:30' => 12, '6:00' => 13, '6:30' => 14, '7:00' => 15, '7:30' => 16, '8:00' => 17, '8:30' => 18,
        '9:00' => 19, '9:30' => 20, '10:00' => 21, '10:30' => 22, '11:00' => 23, '11:30' => 24,
        '12:00pm' => 25, '12:30pm' => 26, '1:00pm' => 27, '1:30pm' => 28
    }

    time_to_absolute[time]
  end

end
