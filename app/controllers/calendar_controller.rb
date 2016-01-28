class CalendarController < ApplicationController
  def index
    #start and end times will be assumed to be am unless otherwise specified (ie, '12:30pm')
  	@events = [
  		{ name: 'Yoga', day: 'Sunday', start_time: '9:00', end_time: '10:00' },
      { name: 'Climbing', day: 'Sunday', start_time: '9:00', end_time: '10:00' },
      { name: 'Ice cream', day: 'Sunday', start_time: '8:30', end_time: '9:00' },
  		{ name: 'Running', day: 'Monday', start_time: '11:00', end_time: '12:30pm' },
      { name: 'Lunch', day: 'Monday', start_time: '12:00pm', end_time: '1:00pm' },
      { name: 'Birthday!', day: 'Tuesday', start_time: '11:30pm', end_time: '1:30pm' },
      { name: 'Lunch', day: 'Friday', start_time: '11:00', end_time: '1:00pm' },
      { name: 'Parade', day: 'Friday', start_time: '11:30', end_time: '12:30pm' }


  	]

    @events.map! { |e| Event.new(e) }
  end
end
