module GameEngine

public

FILE_NAME = 'score.txt'.freeze

def open_file
  puts File.open(FILE_NAME, 'r', &:read)
end

def create_or_append_file(data)
  File.open(FILE_NAME, 'a+') do |file|
    file.puts(data)
  end
end
end

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end

  def white
    colorize(15)
  end

end