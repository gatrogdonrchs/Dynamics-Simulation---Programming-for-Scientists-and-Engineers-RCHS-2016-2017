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

setavelocity =: verb define
avelocity =: y
)

getavelocity =: verb define
avelocity
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
name =: > 7 { (>0{y)
size =: > 0 1 { (>0{y)
position =: > 2 3 { (>0{y)
velocity =: > 4 5 { (>0{y)
avelocity =: > 6 { (>0{y)
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
cc wsize static;set wsize text Size:  x: y: ;
cc wpos static;set wpos text Position:  x: y: ;
cc wvel static;set wvel text Velocity:  x: y: ;
cc wavel static;set wavel text Angular Velocity: ;
bin sz;
bin h;
)

CREATEWIDGET =: 0 : 0
pc select;
cc Disk button;set Disk wh 80 20;
cc Rectangle button;set Rectangle wh 80 20;
)

select_Disk_button =: monad define
wd'pclose;'
wd CREATEDISK
wd 'pshow'
)

select_Rectangle_button =: monad define
wd'pclose;'
wd CREATERECT
wd 'pshow'
)

CREATEDISK =: 0 : 0
pc disk;
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
cc "AngularVelocity:" static;
cc newavel edit;set newavel wh 40 20;
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
cc Create button;set Create wh 50 20;
)

canvas_widgsel_select =: monad define
if. widgsel -: 'Create Widget' do.
wd CREATEWIDGET
wd 'pshow'
end.
)

NB. Include in timerframe verb to display the info for selected widgets
widginfo =: monad define
wd 'psel canvas'
goods =: > (I. widgsel -:"1 > 0{"1 >widgettable) { widgettable
ssize =: > 1 { ,goods
spos =: > 2 { ,goods
svel =: > 3 { ,goods
savel =: > 4 { ,goods
wd 'set wsize text Size: x: ',(0 { ssize),'y: '(1 { ssize)';'
wd 'set wpos text Position:  x: ',(0 { spos)'y: ',(1 { spos)';'
wd 'set wvel text Velocity:  x: ',(0 { svel)'y: ',(1 { svel)';'
wd 'set wavel text Angular Velocity:  ',savel';'
)

additems =: monad define
wd 'psel canvas'
items =: wd 'get widgsel allitems'
wd 'set widgsel items ',(items),y
wd 'set widgsel select ',(": $ (<;._2 items) -. <'')
)

widgettable =: 0$a: 

disk_Create_button =: monad define
vars =: ((". newsizex);(". newsizey);(". newposx);(". newposy);(". newvelx);(". newvely);(". newavel);(newname));''
temp =: vars conew 'disk'
newinfo =: <(getname__temp '');(getsize__temp '');(getposition__temp'');(getvelocity__temp '');(getavelocity__temp '')
widgettable =: widgettable , newinfo
wd 'pclose;'
additems newname
glsel canvasisi
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse (getposition__temp''),(getsize__temp'')
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

select_close =: monad define
wd 'pclose;'
)

select_cancel =: select_close

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
