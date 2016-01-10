module AnimalsHelper
  def format_notes(notes, html)
    descr = ""
    eol = html ? "<br/>" : "\n"
    small = html ? "<small>" : ""
    em = html ? "<em>" : ""
    small_end = html ? "</em>" : ""
    em_end = html ? "</small>" : ""

    unless notes.nil?
      if html
        descr += notes.gsub("\r\n", "<br/>")
      else
        descr += notes
      end
    end

    return raw(descr)
  end
end
