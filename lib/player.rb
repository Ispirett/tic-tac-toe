class Player

  attr_accessor :bet_amount
  def initialize(name, bet_amount = 50)
    @name = name
    @icon = "NNN"
    @bet_amount = bet_amount
  end



  def name
    @name
  end


  def name=(string)
    @name
  end


  def icon
    @icon
  end

  def icon=(string)
    @icon = string
  end
end

# icon
