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
widgetlist_widget_ =: widgetlist_widget_ , coname''
)

destroy =: verb define
widgetlist_widget_ =: widgetlist_widget_ -. coname''
codestroy''
)

NB. Methods common to all widgets
getwidget =: verb define
y{(widgetlist_widget)
)

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
create_widget_ f. y
)
destroy =: verb define
destroy_widget_ f. ''
)

cocurrent 'base'
require 'gl2'
coinsert 'jgl2'

inlocalesc =: 2 : 0
cocurrent =. 18!:4
i =. 18!:5 ''
for_l. n do.
  NB.?lintonly l =. <''
  cocurrent l
  u l_index{y
end.
cocurrent i
''
:
cocurrent =. 18!:4
i =. 18!:5 ''
for_l. n do.
  NB.?lintonly l =. <''
  cocurrent l
  x u l_index{y
end.
cocurrent i
''
)
canvas_createball_button =: verb define
newball =: '' conew 'disk'
setposition__newball (". xcord),(". ycord)
setvelocity__newball ((". xvelo)%50),((". yvelo)%50)
glsel canvasisi
NB. glbrush glrgb 3#196
NB. glpen 2 0 [  glrgb 3#128
glellipse (getposition__newball''),(100 100)
glpaintx''
)

canvas_destroyball_button =: verb define
destroy_widget_ inlocales widgetlist_widget_
)

timerframe =: verb define
(setposition_widget_ inlocalesc widgetlist_widget_) ((getposition_widget_ inlocalesc (widgetlist_widget_)) + (getvelocity_widget_ inlocalesc (widgetlist_widget_)))
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse ((getposition_widget_ inlocalesc widgetlist_widget_),(100,100))
glpaintx''
)

NB. Run a timestep of length y
NB. Update positions & velocities
NB. runstep =: verb define
sys_timer =: verb define
cp =: getposition_widget_ inlocalesc (widgetlist_widget_)
cv =: getvelocity_widget_ inlocalesc (widgetlist_widget_)
(setposition inlocalesc widgetlist_widget_) (cp+cv)
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse ((getposition_widget_ inlocalesc widgetlist_widget_),(100,100))
glpaintx''
)

sys_timer_z_ =: sys_timer_base_
canvas_start_button =: verb define
wd 'timer 20'
)

canvas_stop_button =: verb define
wd 'timer 0'
)

NB. When we load this file, create the form if it doesn't exist
wd :: canvas_run 'psel canvas'
