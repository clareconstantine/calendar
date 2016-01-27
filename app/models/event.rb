class Event < ActiveRecord::Base
  # convert the time strings into an absolute value of 30 minute units
  TIME_TO_ABSOLUTE = {  '12:00' =>  0,
                        '12:30' =>  1,
                         '1:00' =>  2,
                         '1:30' =>  3,
                         '2:00' =>  4,
                         '2:30' =>  5,
                         '3:00' =>  6,
                         '3:30' =>  7,
                         '4:00' =>  8,
                         '4:30' =>  9,
                         '5:00' => 10,
                         '5:30' => 11,
                         '6:00' => 12,
                         '6:30' => 13,
                         '7:00' => 14,
                         '7:30' => 15,
                         '8:00' => 16,
                         '8:30' => 17,
                         '9:00' => 18,
                         '9:30' => 19,
                        '10:00' => 20,
                        '10:30' => 21,
                        '11:00' => 22,
                        '11:30' => 23,
                        '12:00pm' => 24,
                        '12:30pm' => 25,
                         '1:00pm' => 26
  }

  # in units of 30 min because each calendar cell is 30 min
  def duration
    TIME_TO_ABSOLUTE[end_time] - TIME_TO_ABSOLUTE[start_time]
  end

end
