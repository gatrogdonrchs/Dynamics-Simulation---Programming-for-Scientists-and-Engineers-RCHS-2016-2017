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

widgetlist =: 0$a:

cocurrent 'widget'
create =: verb define
widgetlist =: widgetlist , coname''
)
destroy =: verb define
widgetlist =: widgetlist -. coname''
codestroy''
)

NB. Methods common to all widgets
setposition =: verb define
position =: y
)

setvelocity =: verb define
velocity =: y
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

setwh =: verb define
wh =: y
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

NB. Run a timestep of length y
NB. Update positions & velocities
runstep =: verb define
)


