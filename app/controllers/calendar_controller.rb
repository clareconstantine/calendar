class CalendarController < ApplicationController
  def index
  	# todo: eventually get events somewhere else?
  	@events = [
		{ name: 'Yoga', day: 'Sunday', start_time: '9:00', end_time: '10:00' },
		{ name: 'Running', day: 'Monday', start_time: '11:00', end_time: '12:30' }
	]
  end
end
