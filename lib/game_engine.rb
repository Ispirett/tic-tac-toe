module GameEngine
  public

  FILE_NAME = "score.txt".freeze

  def open_file
    puts File.open(FILE_NAME, "r", &:read)
  end

  def create_or_append_file(data)
    File.open(FILE_NAME, "a+") do |file|
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

  def bg_black
    colorize(40)
  end

  def bg_red
    colorize(41)
  end

  def bg_green
    colorize(42)
  end

  def bg_brown
    colorize(43)
  end

  def bg_blue
    colorize(44)
  end

  def bg_magenta
    colorize(45)
  end

  def bg_cyan
    colorize(46)
  end

  def bg_gray
    colorize(47)
  end

  def bold
    colorize(22)
  end

  def italic
    colorize(23)
  end

  def underline
    colorize(24)
  end

  def blink
    colorize(25)
  end

  def reverse_color
    colorize(27)
  end
end
