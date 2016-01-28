class CalendarController < ApplicationController
  def index
    #start and end times will be assumed to be am unless otherwise specified (ie, '12:30pm')
  	@events = [
  		{ name: 'Yoga', day: 'Sunday', start_time: '9:00', end_time: '10:00' },
  		{ name: 'Running', day: 'Monday', start_time: '11:00', end_time: '12:30pm' },
      { name: 'Ice cream', day: 'Tuesday', start_time: '11:30pm', end_time: '1:00pm' },
      { name: 'Ice cream', day: 'Friday', start_time: '12:00pm', end_time: '1:00pm' },
      { name: 'Ice cream', day: 'Sunday', start_time: '8:30', end_time: '9:00' }

  	]

    @events.map! { |e| Event.new(e) }
  end
end
