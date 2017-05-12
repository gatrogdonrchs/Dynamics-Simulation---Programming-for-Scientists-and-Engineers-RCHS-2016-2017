NB. right now has sams keerthiks code but mohsins code is kinda broken testing it atm
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

setmass =: verb define
amass =: y
)

setgraphrep =: verb define
)

cocurrent 'disk'
coinsert 'widget'

create =: verb define
create_widget_ f. (1{y)
name =: > 6 { (>0{y)
size =: > 0 1 { (>0{y)
position =: > 2 3 { (>0{y)
velocity =: > 4 5 { (>0{y)
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
cc positioon static;
cc destroyallballs button;
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
cc Create button;set Create wh 50 20;
)

canvas_canvasisi_mmove =: monad define
NB. Grabs the current coordinate of the mouse
mousex =: 0 { (0 ". sysdata)
mousey =: 1 { (0 ". sysdata)
positioon =: mousex,mousey
NB. Prevents an error if the user moves off the image

NB.Grabs the coordinates of the mouse
NB. Updates the coordinates and rgb value on the canvas
NB. of the pixel that the mouse is on.
wd'set positioon text "(',(":positioon),')";'

)


canvas_widgsel_select =: monad define
if. widgsel -: 'Create Widget' do.
smoutput 'Creating Widget...'
wd CREATEWIDGET
wd 'pshow'
end.
)

widgettable =: 0$a: 

builder_Create_button =: monad define
vars =: ((". newsizex);(". newsizey);(". newposx);(". newposy);(". newvelx);(". newvely);(newname));''
temp =: vars conew 'disk'
newinfo =: <(getname__temp '');(getsize__temp '');(getposition__temp'');(getvelocity__temp '')
widgettable =: widgettable , newinfo
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__temp''),(getsize__temp'')
glpaintx''
wd'pclose;'
)

canvas_start_button =: verb define
vars2 =: ((". newsizex);(". newsizey);(". newposx);(". newposy);(". newvelx);(". newvely);(newname));''
temp2=: vars2 conew 'disk'
newball =.	 '' conew 'disk'
setposition__newball (". newposx),(". newposy)
setvelocity__newball ((". newvelx)%300),((". newvely)%300)
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__temp2''),(getsize__temp'')
NB.glellipse (getposition__newball''),(newsizex,newsizey)
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

builder_close =: monad define
wd 'pclose;'
)

builder_cancel =: builder_close

NB. Run a timestep of length y
NB. Update positions & velocities
NB. runstep =: verb define
sys_timer =: verb define
cp =: getposition inlocalesv (widgetlist_widget_)''
cv =: getvelocity inlocalesv (widgetlist_widget_)''
setposition inlocalesc widgetlist_widget_ (cp+cv)
try.
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
for_objnum. i. 0{($(getposition inlocalesv widgetlist_widget_'')) do.
pos =: (<:objnum){(getposition inlocalesv widgetlist_widget_'')
sx =. ". newsizex
sy =. ". newsizey
glellipse pos,(sx,sy)
end.
glpaintx''
catch.
smoutput 'gl error'
wd 'timer 0'
end.
)
sys_timer_z_ =: sys_timer_base_

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
filter =: monad define
wlist =: i. $ y
uppertri =: ;@:((,. i.)&.>)@:(i.&.<:)

upperlist =: uppertri wlist
colldet"1 upperlist { widgetlist_widget_
)

colldet =: verb define

NB.vars3 =: ((". newsizex);(". newsizey);(". newposx);(". newposy);(". newvelx);(". newvely);(newname));''
NB.temp3 =: vars3 conew 'disk'

obj0 =: {. y
obj1 =: {: y

vel0 =: getvelocity__obj0
vel1 =: getvelocity__obj1
veldiff =: | vel1 - vel0
speed =. %: (*: {.veldiff) + (*: {:veldiff)


bpos0 =. getposition__obj0''
bpos1 =. getposition__obj1''

xs =: {. bpos0,.bpos1
ys =: {: bpos0,.bpos1

xdist =: -/ xs
ydist =: -/ ys
distsq =:   (*: xdist) + (*: ydist)
dist =: %: distsq

div =: dist % speed

if. (vel0 +. vel1) ~: 0 do. 

else. if. (div < 20) do.

('cd',type__obj0,type__obj1)~ obj0,obj1

end.
end.
)

cd_disk_disk =: monad define
disk0 =. {.y
disk1 =. {:y

v0 =. velocity__disk0
v1 =. velocity__disk1

pos0 =. position__disk0
pos1 =. position__disk1

rad0 =. radius__disk0
rad1 =. radius__disk1

cop =. ((rad0*pos0) + (rad1*pos1)) % (rad0+rad1)

rvec =. pos0 - cop

magv0 =. %: (*: 0{v0) + (*: 1{v0)
veldiv =.(v0 % magv0))

d =. (-veldiv) +/@:* rvec 

avec =. rvec + (d * veldiv)

evec =. -avec
h =. %: (*: rad0) - (*: evec)

dist =. d - h 

time =. dist % v0

)

cd_disk_rectangle =: monad define
object0 =. {.y
object1 =. {:y
v0 =. velocity__disk0
v1 =. velocity__disk1

pos0 =. position__disk0
pos1 =. position__disk1

rad0 =. radius__disk0
rad1 =. radius__disk1


)

cd_rectangle_disk =: cd_disk_rectangle

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
