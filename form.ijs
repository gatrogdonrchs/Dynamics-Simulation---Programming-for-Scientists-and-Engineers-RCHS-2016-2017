require 'gl2'
coinsert 'jgl2'

NB._____________FORM_GOODIEs______________
CANVAS =: 0 : 0
pc canvas;
minwh 1000 900;cc canvasisi isidraw;
bin v;
bin h;
cc ll button;set ll wh 20 20;
cc start button;set start wh 20 20;cn "►";
cc Step button;
cc widgsel combolist;set widgsel wh 140 22;
set widgsel items "" "Create Widget";
bin sz;
bin h;
)

CREATEWIDGET =: 0 : 0
pc builder;
cc Name static;
cc newname edit;set newname wh 80 20;
bin sz;
bin h;
cc Size static;
cc newsizex edit;set newsizex wh 20 20;
cc newsizey edit;set newsizey wh 20 20;
bin sz;
bin h;
cc Position static;
cc newposx edit;set newposx wh 20 20;
cc newposy edit;set newposy wh 20 20;
bin sz;
bin h;
cc Velocity static;
cc newvelx edit;set newvelx wh 20 20;
cc newvely edit;set newvely wh 20 20;
bin sz;
bin h;
cc Create button;set Create wh 50 20;
)

canvas_widgsel_select =: monad define
if. widgsel -: 'Create Widget' do.
smoutput 'Creating Widget...'
wd CREATEWIDGET
wd 'pshow'
end.
)

builder_Create_button =: monad define
vars =: ((". newsizex),(". newsizey),(". newposx),(". newposy),(". newvelx),(". newvely));(newname)
w =: vars conew 'disk'
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__w''),(getsize__w'')
glpaintx''
wd'pclose;'
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

builder_close =: monad define
wd 'pclose;'
)

builder_cancel =: builder_close

timerframe =: verb define
cp =. getposition__w''
cv =. getvelocity__w''
cs =. getsize__w''
setposition__w (cp + cv)
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__w''),cs
glpaintx''
)

NB. Run a timestep of length y
NB. Update positions & velocities
NB. runstep =: verb define
sys_timer =: verb define
try.
timerframe''
catch.
smoutput 'error in systimer'
wd 'timer 0'
end.
)

sys_timer_z_ =: sys_timer_base_

canvas_start_button =: verb define
wd 'timer 60'
)

canvas_ll_button =: verb define
wd 'timer 0'
)

canvas_Step_button =: verb define
timerframe ''
)

NB. When we load this file, create the form if it doesn't exist
wd :: canvas_run 'psel canvas'
