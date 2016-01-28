module CalendarHelper

  DAYS = ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat']

  TIMES = ['12:00am', '1:00am', '2:00am', '3:00am', '4:00am', '5:00am','6:00am',
    '7:00am', '8:00am', '9:00am', '10:00am', '11:00am', '12:00pm', '1:00pm']

  # these are offset from times_to_absolute in the Event model because the 12:00am label
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
      labels << content_tag(:th, d, { :class => 'day', :colspan => '2' })
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
    cells = content_tag(:td, label, { :class => 'time', :colspan => '2' })
    cells << daily_cells(absolute_value)

    content_tag(:tr, cells, :class => row_class)
  end

  def daily_cells absolute_value
    cells = ""
    DAYS.each do |d|
      events_starting = event_start(absolute_value, d)
      events_continuing = event_continuation(absolute_value, d)

      # two events start simultaneously
      if events_starting.size == 2
        events_starting.each do |e|
          cells << content_tag(:td, e.name, { :class => 'event', :rowspan => e.duration.to_s, :colspan => '1' })
        end
      # one event starts, one is continuing
      elsif events_starting.size == 1 && events_continuing.size == 1
        e = events_starting.first
        cells << content_tag(:td, e.name, { :class => 'event', :rowspan => e.duration.to_s, :colspan => '1' })
      # one event starts, none continuing
      elsif events_starting.size == 1
        e = events_starting.first
        events_overlapping = event_overlap e

        # if no overlapping events
        if events_overlapping.size == 0
          cells << content_tag(:td, e.name, { :class => 'event', :rowspan => e.duration.to_s, :colspan => '2' })
        # overlapping event starting later
        else
          cells << content_tag(:td, "", :colspan => '1')
          cells << content_tag(:td, e.name, { :class => 'event', :rowspan => e.duration.to_s, :colspan => '1' })
        end
      # one continuing event
      elsif events_continuing.size == 1
        e = events_continuing.first
        events_overlapping = event_overlap e

        # do nothing if the event is continuing and does not overlap anything
        # but if it overlaps an event...
        if events_overlapping.size == 1
          cells << content_tag(:td, "", :colspan => '1')
        end
      # no events starting or continuing
      elsif events_continuing.size == 0
        cells << content_tag(:td, "", :colspan => '2')
      end    
    end

    cells.html_safe
  end

  def event_start absolute_value, day
    @events.select {|e| e.day == day && e.start_time == absolute_value}
  end

  def event_continuation absolute_value, day
    @events.select {|e| e.day == day && e.start_time < absolute_value && e.end_time > absolute_value}
  end

  def event_overlap cur_event
    events = @events.select {|e| overlap?(e, cur_event)}
  end

  def overlap? e1, e2
    overlap = false
    if e1.day == e2.day
      if (e1.start_time > e2.start_time) && (e1.start_time < e2.end_time)
        overlap = true
      elsif (e1.end_time > e2.start_time) && (e1.end_time < e2.end_time)
        overlap = true
      end
    end
    overlap
  end

end
