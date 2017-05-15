require 'gl2'
coinsert 'jgl2'

	

CANVAS =: 0 : 0
pc canvas;
minwh 1200 600;cc canvasisi isidraw;
cc xcord edit;
cc ycord edit;
cc xvelo edit;
cc yvelo edit;
cc createball button;
cc createbox button;
cc start button;
cc stop button;
cc destroyallballs button;
bin z;
bin z; 
pas 6 6;
)

NB. Execute the form
canvas_run =: monad define
wd CANVAS
wd'pshow'
wd'timer 20'
)

NB. Close the window
canvas_close =: monad define
wd'pclose;'
wd'timer 0'
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
y{(widgetlist_widget_)
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

getrotation =: verb define
rotation =:
)

setavelocity =: verb define
avelocity =: y
)

getavelocity =: verb define
avelocity
)

setmass =: verb define
mass =: y
)

getmass =: verb define
mass
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

setradius =: verb define
radius =: y
)

getradius =: verb define
radius
)

NB. ******************** polygons **********************
cocurrent 'poly'
coinsert 'widget'

create =: verb define
create_widget_ f. y
)
destroy =: verb define
destroy_widget_ f. ''
)

setcorners =: verb define
corners =: y
)

getcorners =: verb define
corners
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

NB. Execute u in locales n, returning list of results
inlocalesv =: 2 : 0
if. 0=#n do. '' return. end.
cocurrent =. 18!:4
i =. 18!:5 ''
cocurrent {. n
res =. ,: u y
for_l. }.n do.
  NB.?lintonly l =. <''
  cocurrent l
  res =. res , u y
end.
cocurrent i
res
:
if. 0=#n do. '' return. end.
cocurrent =. 18!:4
i =. 18!:5 ''
cocurrent {. n
res =. ,: x u y
for_l. }.n do.
  NB.?lintonly l =. <''
  cocurrent l
  res =. res , x u y
end.
cocurrent i
res
)

canvas_createball_button =: verb define
newball =. '' conew 'disk'
setposition__newball (". xcord),(". ycord)
setvelocity__newball ((". xvelo)%50),((". yvelo)%50)
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__newball''),(100 100)
glpaintx''

)

canvas_destroyallballs_button =: verb define
destroy inlocalesv widgetlist_widget_''
glsel canvasisi
glclear''
)


canvas_createbox_button =: verb define

wall1 =: '' conew 'poly'
wall2 =: '' conew 'poly'
wall3 =: '' conew 'poly'
wall4 =: '' conew 'poly'

setcorners__wall1 (0 0),(5 0),(5 600),(0 600)

setcorners__wall2 (0 0),(1200 0),(1200 5),(0 5)

setcorners__wall3 (0 600),(1200 600),(1200 595),(0 595)

setcorners__wall4 (1200 0),(1195 0),(1195 600),(1200 600)

glsel canvasisi
glbrush glrgb (244 89 66)
glpen 2 0 [  glrgb (244 89 66)
glpolygon (getcorners__wall1'')
glpolygon (getcorners__wall2'')
glpolygon (getcorners__wall3'')
glpolygon (getcorners__wall4'')
glpaintx''
)




NB. Run a timestep of length y
NB. Update positions & velocities
NB. runstep =: verb define
NB. set up a try/catch at some point
sys_timer =: verb define
cp =: getposition inlocalesv (widgetlist_disk_)''
cv =: getvelocity inlocalesv (widgetlist_disk_)''
try.
setposition inlocalesc widgetlist_disk_ (cp+cv)
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
for_objnum. i. 0{($(getposition inlocalesv widgetlist_disk_'')) do.
pos =: (<:objnum){(getposition inlocalesv widgetlist_disk_'')
glellipse pos,(100,100)
end.
glpaintx''
catch.
smoutput 'gl error'
wd 'timer 0'
end.
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
