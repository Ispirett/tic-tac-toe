class Gui

  def display_board(slots)
    row_one = "\t\t\t\t\t\t#{slots[:one]}|#{slots[:two]}|#{slots[:three]}"
    row_two = "\t\t\t\t\t\t#{slots[:four]}|#{slots[:five]}|#{slots[:six]}"
    row_three = "\t\t\t\t\t\t#{slots[:seven]}|#{slots[:eight]}|#{slots[:nine]}"
    [row_one, row_two, row_three]
  end

  def msg
    return msg.each { |m| puts m } if msg.is_a? Array
    puts "\t\t\t\t\t#{msg}"
  end


end

