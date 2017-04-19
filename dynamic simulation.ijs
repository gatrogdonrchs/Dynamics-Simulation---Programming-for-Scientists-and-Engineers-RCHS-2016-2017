NB. calculate length of next time step
NB. for each pair of objects. find out how long until they collide
NB. result is time to next collision
calctimestep =: verb define
NB. WIIIDDDGEETTS represent a physical object; it has two representations (graphical and  mathematical) 
NB.subclasses of widgets are disks, rektantgles, and etc.
widgetlist =: 0$a:
concurrent 'widget'
create =: verb define
widgetlist =: widgetlist -. coname ''
)
destroy =: verb define

)