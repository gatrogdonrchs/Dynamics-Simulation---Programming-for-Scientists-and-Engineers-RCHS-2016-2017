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

getwidgetlist =: verb define
widgetlist
)
NB. Methods common to all widgets
setposition =: verb define
position =: y
)

setwh =: verb define
wh =: y
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

NB. Run a timestep of length y
NB. Update positions & velocities
runstep =: verb define
)


