module CalendarHelper

  DAYS = ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat']
  TIMES = ['12:00am', '1:00am', '2:00am', '3:00am', '4:00am', '5:00am','6:00am',
    '7:00am', '8:00am', '9:00am', '10:00am', '11:00am', '12:00pm', '1:00pm']

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
      rows << row(t)
      rows << row
    end
    rows.html_safe
  end

  def row time=nil
    label = time ? time : ""
    row_class = time ? 'halfhour' : 'hour'
    cells = content_tag(:td, label, :class => 'time')
    cells << empty_row

    content_tag(:tr, cells, :class => row_class)
  end

  def empty_row
    cells = ""
    DAYS.each do |d|
      cells << content_tag(:td)
    end
    cells.html_safe
  end

end
