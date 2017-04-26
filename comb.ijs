NB. Graphics+timing combined .ijs
NB. this has a skeleton of a ui just so that we can work with it, will update as ui gets updated

require 'gl2'
coinsert 'jgl2'

	

CANVAS =: 0 : 0
pc canvas;
minwh 1200 900;cc canvasisi isidraw;
cc xcord edit;
cc ycord edit;
cc xvelo edit;
cc yvelo edit;
cc createball button;
cc start button;
cc stop button;
bin z;
bin z; 
pas 6 6;
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

NB. ******************** disks ******************
cocurrent 'disk'
coinsert 'widget'

create =: verb define
create_widget_ y
)
destroy =: verb define
destroy_widget_ f. ''
)

cocurrent 'base'
require 'gl2'
coinsert 'jgl2'

canvas_createball_button =: verb define
ball1 =: '' conew 'disk'
setposition__ball1 (". xcord),(". ycord)
setvelocity__ball1 (". xvelo),(". yvelo)
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__ball1''),(100 100)
glpaintx''
)

timerframe =: verb define
cp =: getposition__ball1''
cv =: getvelocity__ball1''
setposition__ball1 (cp + cv)
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__ball1''),(100,100)
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

canvas_stop_button =: verb define
wd 'timer 0'
)

NB. When we load this file, create the form if it doesn't exist
wd :: canvas_run 'psel canvas'


