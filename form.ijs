require 'gl2'
coinsert 'jgl2'

NB. Dynamics simulation

NB. Calculate length of next time step
NB. For each pair of objects, find out how long till they collide
NB. Result is time to next collision
calctimestep =: verb define
)

NB. Widgets
NB. A widget represents a physical object
NB. It has a graphical representation and a mathematical representation

NB. Subclasses of widgets are disks, rectangles, etc.


cocurrent 'widget'
widgetlist =: 0$a:

create =: verb define
widgetlist =: widgetlist , coname''
)

destroy =: verb define
widgetlist =: widgetlist -. coname''
codestroy''
)

NB. Methods common to all widgets

setvelocity =: verb define
velocity =: y
)

getvelocity =: verb define
velocity
)

setposition =: verb define
position =: y
)

getposition =: verb define
position
)

setrotation =: verb define
rotation =: y
)

setavelocity =: verb define
avelocity =: y
)

setmass =: verb define
amass =: y
)

setgraphrep =: verb define
)

cocurrent 'disk'
coinsert 'widget'

create =: verb define
create_widget_ y
)

destroy =: verb define
destroy_widget_ f. ''
)

cocurrent 'base'

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
pc build;
cc Widget static;
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
cc Create button;set Create wh 40 20;
)

canvas_widgsel_select =: monad define
if. widgsel -: 'Create Widget' do.
smoutput 'Creating Widget...'
wd CREATEWIDGET
wd 'pshow'
end.
)

build_Create_button =: monad define
newname =: '' conew 'disk'
setposition__newname (". newposx),(". newposy)
setvelocity__newname (". newvelx),(". newvely)
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__newname''),(100 100)
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

timerframe =: verb define
cp =: getposition__newname''
cv =: getvelocity__newname''
setposition__newname (cp + cv)
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__newname''),(100,100)
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
wd 'timer 200'
)

canvas_ll_button =: verb define
wd 'timer 0'
)

canvas_Step_button =: verb define
timerframe ''
)

NB. When we load this file, create the form if it doesn't exist
wd :: canvas_run 'psel canvas'
