class CalendarController < ApplicationController
  def index
    #start and end times will be assumed to be am unless otherwise specified (ie, '12:30pm')
  	@events = [
  		{ name: 'Yoga', day: 'Sun', start_time: '9:00', end_time: '10:00' },
  		{ name: 'Running', day: 'Mon', start_time: '11:00', end_time: '12:30pm' }
  	]

    @events.map! { |e| Event.new(e) }
  end
end
