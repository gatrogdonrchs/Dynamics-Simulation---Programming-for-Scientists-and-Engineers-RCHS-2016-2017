require 'graphics/bmp/bmp'
require 'graphics/jpeg/jpeg'
require 'gl2'
coinsert 'jgl2'

CANVAS =: 0 : 0
pc canvas;
minwh 1000 900;cc canvasisi isidraw;
bin v;
bin h;
cc ll button;set ll wh 20 20;
cc ► button;set ► wh 20 20;
cc Step button;
cc Widgsel combolist;set Widgsel wh 140 22;
set Widgsel items "" "Create Widget";
bin sz;
bin h;
)

CREATEWIDGET =: 0 : 0
pc "Create Widget";
minwh 20 20;cc canvasisi isidraw;
bin v;
bin h;
)

canvasisi_Widgsel_select =: monad define
wd CREATEWIDGET
wd 'pshow'
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
