require 'gl2'
coinsert 'jgl2'

	

CANVAS =: 0 : 0
pc canvas;
minwh 1200 600;cc canvasisi isidraw;
cc xcord edit;
cc ycord edit;
cc xvelo edit;
cc yvelo edit;
cc objr edit;
cc objg edit;
cc objb edit;
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

setid =: verb define
id =: y
)

getid =: verb define
id
)

setbcparams =: verb define
bcparams =: y
)

getbcparams =: verb define
bcparams
)

setcolor =: verb define
color =: y
)

getcolor =: verb define
color
)

NB. ******************** disks ******************
NB. disks are id =: 1
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
NB. polys are id =: 2
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
setposition__newball (". xcord),(". ycord),100,100
setvelocity__newball ((". xvelo)%50),((". yvelo)%50),0,0
setid__newball 1 
setbcparams__newball (getposition__newball'')
setcolor__newball (".objr, ".objg, ".objb)
glsel canvasisi
glbrush glrgb (getcolor__newball'')
glpen 2 0 [  glrgb (getcolor__newball'')
glellipse (getposition__newball'')
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

setid__wall1 2
setid__wall2 2
setid__wall3 2
setid__wall4 2

setmass__wall1 _
setmass__wall2 _
setmass__wall3 _
setmass__wall4 _

NB. glrgba for bounding circle set a to be 255
NB. bounding circle calculations
NB. 4 billion away


setbcparams__wall1 =: ((_1*(2^32)),300,(2^32),(2^32))
setbcparams__wall2 =: (600,(2^32),(2^32),(2^32))
setbcparams__wall3 =: ((2^32),300,(2^32),(2^32))
setbcparams__wall4 =: (600,(_1*(2^32)),(2^32),(2^32))

glsel canvasisi
glbrush glrgb (244 89 66)
glpen 2 0 [  glrgb (244 89 66)
glpolygon (getcorners__wall1'')
glpolygon (getcorners__wall2'')
glpolygon (getcorners__wall3'')
glpolygon (getcorners__wall4'')
glbrush glrgba (150 244 89 66)
glpen 2 0 [ glrgba (150 244 89 66)
glpaintx''
)




timerframe =: verb define
glsel canvasisi
glclear''
for_objnum. i. 0{($(getid inlocalesv widgetlist_disk_'')) do.
obj =: objnum { widgetlist_widget_
oidd =: getid__obj''
select. oidd
case. 1 do.
pos =: getposition__obj''
vel =: getvelocity__obj''
setvelocity__obj ((vel) +"1 (0 0.196 0 0))
newpos =: pos + vel
setposition__obj newpos
col =: getcolor__obj''
glbrush glrgb col
glpen 2 0 [  glrgb col
glellipse newpos
case. 2 do.
corns =: getcorners__obj''
glbrush glrgb (244 89 66)
glpen 2 0 [  glrgb (244 89 66)
glpolygon corns
end.
end.
glpaintx''
)


NB. Run a timestep of length y
NB. Update positions & velocities
sys_timer =: verb define
try.
timerframe''
catch.
smoutput 'timer error'
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
