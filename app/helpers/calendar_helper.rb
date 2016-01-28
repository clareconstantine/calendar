module CalendarHelper

  DAYS = ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat']

  TIMES = ['12:00am', '1:00am', '2:00am', '3:00am', '4:00am', '5:00am','6:00am',
    '7:00am', '8:00am', '9:00am', '10:00am', '11:00am', '12:00pm', '1:00pm']

  # these are offset from TIMES_TO_ABSOLUTE in the Event model because the 12:00am label
  # is in the cell row that corresponds 10 11:30pm (it is labeling its bottom border)
  TIME_LABELS_TO_ABSOLUTE = { '12:00am' => 0,
                              '1:00am' => 2,
                              '2:00am' => 4,
                              '3:00am' => 6,
                              '4:00am' => 8,
                              '5:00am' => 10,
                              '6:00am' => 12,
                              '7:00am' => 14,
                              '8:00am' => 16,
                              '9:00am' => 18,
                              '10:00am' => 20,
                              '11:00am' => 22,
                              '12:00pm' => 24,
                              '1:00pm' => 26
                            }

  def row_absolute_value time_label
    TIME_LABELS_TO_ABSOLUTE[time_label]
  end

  def day_labels
    labels = ""
    DAYS.each do |d|
      labels << content_tag(:th, d, :class => 'day')
    end
    labels.html_safe
  end

  def calendar_body
    rows = ""
    TIMES.each do |t|
      rows << row(row_absolute_value(t), t)
      rows << row(row_absolute_value(t) + 1)
    end
    rows.html_safe
  end

  def row absolute_value, time=nil
    label = time ? time : ""
    row_class = time ? 'halfhour' : 'hour'
    cells = content_tag(:td, label, :class => 'time')
    cells << daily_cells(absolute_value)

    content_tag(:tr, cells, :class => row_class)
  end

  def daily_cells absolute_value
    cells = ""
    DAYS.each do |d|
      # todo: this logic relies on events not overlapping
      event_starting = event_start(absolute_value, d)
      event_continuing = event_continuation(absolute_value, d)

      if event_starting
        cells << content_tag(:td, event_starting.name, { :class => 'event', :rowspan => event_starting.duration.to_s} )
      elsif !event_continuing # if an even is continuing we don't want to make a new cell
        cells << content_tag(:td)        
      end    
    end

    cells.html_safe
  end

  def event_start absolute_value, day
    events = @events.select {|e| e.day == day && e.absolute_start == absolute_value}
    events.first
  end

  def event_continuation absolute_value, day
    events = @events.select {|e| e.day == day && e.absolute_start < absolute_value && e.absolute_end > absolute_value}
    events.first
  end

end
