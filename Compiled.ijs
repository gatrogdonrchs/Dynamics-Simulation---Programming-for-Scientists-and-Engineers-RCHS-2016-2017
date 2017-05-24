require 'gl2'
coinsert 'jgl2'
NB. Changes these loads according to where ur other info is stored
load 'C:\Users\Agil\j64-805-user\temp\Game\collision_response.ijs'
load 'C:\Users\Agil\j64-805-user\temp\Game\collision_detection.ijs'

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
setname =: verb define
name =: y
)

getname =: verb define
name
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

setsize =: verb define
size =: y
)

getsize =: verb define
size
)

setrotation =: verb define
rotation =: y
)

setavelocity =: verb define
avelocity =: y
)

setid =: verb define
id =: y
)

getid =: verb define
id
)
setmass =: verb define
amass =: y
)

setgraphrep =: verb define
)

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
cc positioon static;
cc destroyallballs button;
cc widgsel combolist;set widgsel wh 140 22;
set widgsel items "Create Disk" "Create Rect";
cc default1 button;
cc default2 button;
cc testbounce button;
cc createrect button;
bin sz;
bin h;
)

CREATEDISK =: 0 : 0
pc disk;
cc Size static;
bin sz;
bin h;
cc "x:" static;
cc newsizex edit;set newsizex wh 40 20;
cc "y:" static;
cc newsizey edit;set newsizey wh 40 20;
bin sz;
bin h;
cc Position static;
cc "x:" static;
cc newposx edit;set newposx wh 40 20;
cc "y:" static;
cc newposy edit;set newposy wh 40 20;
bin sz;
bin h;
cc Velocity static;
cc "x:" static;
cc newvelx edit;set newvelx wh 40 20;
cc "y:" static;
cc newvely edit;set newvely wh 40 20;
bin sz;
bin h;
cc "id:" static;
cc id edit; set id wh 40 20;
bin sz;
bin h;
cc Create button;set Create wh 50 20;
)
CREATERECT =: 0 : 0
pc rect;
cc "x:" static;
cc tlx edit;set tlx wh 40 20;
cc "y:" static;
cc tly edit;set tly wh 40 20;
bin sz;
bin h;
cc "x:" static;
cc trx edit;set trx wh 40 20;
cc "y:" static;
cc try edit;set try wh 40 20;
bin sz;
bin h;
cc "x:" static;
cc blx edit;set blx wh 40 20;
cc "y:" static;
cc bly edit;set bly wh 40 20;
bin sz;
bin h;
cc "x:" static;
cc brx edit;set brx wh 40 20;
cc "y:" static;
cc bry edit;set bry wh 40 20;
bin sz;
bin h;
cc "id:" static;
cc id edit; set id wh 40 20;
bin sz;
bin h;
cc Create button;set Create wh 50 20;
)


canvas_canvasisi_mmove =: monad define

mousex =: 0 { (0 ". sysdata)
mousey =: 1 { (0 ". sysdata)
positioon =: mousex,mousey

wd'set positioon text "(',(":positioon),')";'

)


canvas_widgsel_select =: monad define
if. widgsel -: 'Create Disk' do.
smoutput 'Creating Widget...'
wd CREATEDISK
wd 'pshow'
end.
if. widgsel -: 'Create Rect' do.
smoutput 'Creating Widget...'
wd CREATERECT
wd 'pshow'
end.
)

additems =: monad define
wd 'psel canvas'
items =: wd 'get widgsel allitems'
wd 'set widgsel items ',(items),y
)

widgettable =: 0$a: 

disk_Create_button =: monad define
newball =. '' conew 'disk'
setposition__newball (". newposx),(". newposy)
setvelocity__newball ((". newvelx)),((". newvely))
setid__newball (". id)
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__newball''),((".newposx),(".newposy))
glpaintx''
wd'pclose;'
)

canvas_default1_button =: monad define
newball =. '' conew 'disk'
setposition__newball (100),(300)
setvelocity__newball ((4)),((0))
setid__newball (1)
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__newball''),((300),(300))
glpaintx''
)

canvas_default2_button =: monad define
newball =. '' conew 'disk'
setposition__newball (500),(700)
setvelocity__newball ((0)),((-4))
setid__newball (1)
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__newball''),((300),(300))
glpaintx''
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

disk_close =: monad define
wd 'pclose;'
)

disk_cancel =: disk_close

rect_close =: monad define
wd 'pclose;'
)

rect_cancel =: rect_close
NB. Run a timestep of length y
NB. Update positions & velocities
NB. runstep =: verb define
timerframe =: verb define
glsel canvasisi
glclear''
for_objnum. i. 0{($(getid inlocalesv widgetlist_disk_'')) do.
obj =: objnum { widgetlist_widget_
oidd =: getid__obj''
select. oidd
case. 1 do.
vel =: getvelocity__obj''
setvelocity__obj ((vel) +"1 (0 0.196))
pos =: getposition__obj''
nvel =: getvelocity__obj''
newpos =: pos + nvel
setposition__obj newpos
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse newpos,((".newsizex),(".newsizey))
case. 2 do.
corns =: getcorners__obj''
glbrush glrgb (244 89 66)
glpen 2 0 [  glrgb (244 89 66)
glpolygon corns
end.
end.
glpaintx''
)

sys_timer =: verb define
try.
timerframe''
catch.
smoutput 'timer error'
wd 'timer 0'
end.
NB.ttcoll =: > {. (cd_disk_disk widgetlist_widget_)
NB.if. ttcoll = 0  do.
NB.disk_disk widgetlist_widget_
NB.end.
)

sys_timer_z_ =: sys_timer_base_

NB.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
canvas_createrect_button =: verb define

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
NB.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
canvas_stop_button =: verb define
wd 'timer 0'
)

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

canvas_destroyallballs_button =: verb define
destroy inlocalesv widgetlist_widget_''
glsel canvasisi
glclear''
)
NB.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
canvas_testbounce_button =: monad define
disk_disk widgetlist_widget_
)
NB.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
