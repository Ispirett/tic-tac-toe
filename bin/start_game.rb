require "../lib/game_manager"
require "../lib/board"
require "../lib/gui"

display = Gui.new
app = GameManager.new(display)
player = app.game_init
board = Board.new(player[0], player[1], display, app)
board.game_loop

