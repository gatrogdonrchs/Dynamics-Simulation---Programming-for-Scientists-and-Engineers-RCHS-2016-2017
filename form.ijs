require 'graphics/bmp/bmp'
require 'graphics/jpeg/jpeg'
require 'gl2'
coinsert 'jgl2'

CANVAS =: 0 : 0
pc canvas;
minwh 1000 900;cc canvasisi isidraw;
bin v;
bin h;
cc Start/Stop button;
cc Pause button;
cc Step button;
cc Create_Widget button;
bin sz;
bin h;
)



NB. Execute the form
canvas_run =: monad define
wd CANVAS
wd'pshow'
)

NB. Close the window
canvas_close =: monad define
wd'pclose;'
)

canvas_cancel =: canvas_close

NB. When we load this file, create the form if it doesn't exist
wd :: canvas_run 'psel canvas'
