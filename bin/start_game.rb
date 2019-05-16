require "../lib/game_manager"
require "../lib/board"
require "../lib/gui"

def run
  display = Gui.new
  app = GameManager.new(display)
  player = app.game_init
  board = Board.new(player[0], player[1], display, app)
  board.game_loop
  board.is_game_over
end
run

while run == true
 run
end