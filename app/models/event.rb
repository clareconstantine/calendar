class Event < ActiveRecord::Base
  # convert the time strings into an absolute value of 30 minute units
  # use format of time strings as they are input, not the same as the label in the view
  TIME_TO_ABSOLUTE = {  '11:30pm' =>  0,
                        '12:00' =>  1,
                        '12:30' =>  2,
                         '1:00' =>  3,
                         '1:30' =>  4,
                         '2:00' =>  5,
                         '2:30' =>  6,
                         '3:00' =>  7,
                         '3:30' =>  8,
                         '4:00' =>  9,
                         '4:30' => 10,
                         '5:00' => 11,
                         '5:30' => 12,
                         '6:00' => 13,
                         '6:30' => 14,
                         '7:00' => 15,
                         '7:30' => 16,
                         '8:00' => 17,
                         '8:30' => 18,
                         '9:00' => 19,
                         '9:30' => 20,
                        '10:00' => 21,
                        '10:30' => 22,
                        '11:00' => 23,
                        '11:30' => 24,
                        '12:00pm' => 25,
                        '12:30pm' => 26,
                         '1:00pm' => 27
  }

  def absolute_start
    TIME_TO_ABSOLUTE[start_time]
  end

  def absolute_end
    TIME_TO_ABSOLUTE[end_time]
  end

  # in units of 30 min because each calendar cell is 30 min
  def duration
    absolute_end - absolute_start
  end

end
