NB. This verb should be used to operate on widgetlist, it finds all the pairs of
NB.  widgets and calls the next verb, colldet, to operate on each pair.
filter =: verb define
wlist =: i. $ y
NB. inputs a list, outputs the index of all the pairs,
NB.  not including duplicates (ex. forwards but not 
NB.  backwards).
uppertri =: ;@:((,. i.)&.>)@:(i.&.<:)

upperlist =: uppertri wlist
colldet"1 upperlist { widgetlist_widget_
)

colldet =: verb define

NB. must extract the position and velocity and radius
NB.  of the widgets that have indexes y. then use those to
NB.  find the time until the collision.
obj0 =. 0 { y
obj1 =. 1 { y

vel0 =. getvelocity__obj0''
vel1 =. getvelocity__obj1''
veldiff =. | vel1 - vel0
speed =. %: (*: {.veldiff) + (*: {:veldiff)


bpos0 =. getposition__obj0''
bpos1 =. getposition__obj1''

xs =. {. bpos0,.bpos1
ys =. {: bpos0,.bpos1

xdist =. -/ xs
ydist =. -/ ys
distsq =.   (*: xdist) + (*: ydist)
dist =. %: distsq

div =. dist % speed

NB. If both objects are stationary, don't bother operating on them.
)

NB. Detecting collision between two disks
cd_disk_disk =: monad define
disk0 =. {.y
disk1 =. {:y

NB. Grab widget info needed for calculations
v0 =. getvelocity__disk0''
v1 =. getvelocity__disk1''

pos0 =. getposition__disk0''
pos1 =. getposition__disk1''

rad0 =. radius__disk0
rad1 =. radius__disk1

NB. Find center of psuedomass
NB. Here we say that the pseudomass is the same as  
NB.  the radius to make calculations easier.
cop =. ((rad0*pos0) + (rad1*pos1)) % (rad0+rad1)

NB. Vector from the center of pseudomass to the position
rvec =. pos0 - cop

NB. The magnitude of v0
magv0 =. %: (*: 0{v0) + (*: 1{v0)
NB. A unit vector for the direction of v0
veldiv =.(v0 % magv0))

NB. Distance between the objects current position,
NB.  and the point that is the magnitude of rvec 
NB.  with the direction of v0
d =. (-veldiv) +/@:* rvec 

NB. the vector that goes from the center of pseudomass
NB.  to the end of d that is closer to the center of 
NB.  pseudomass
avec =. rvec + (d * veldiv)

NB. The negative A vector
evec =. -avec
NB. The distance between the end of d near the COP and
NB.  the center of the disk at the time of collision
h =. %: (*: rad0) - (*: evec)

NB. The distance between the center of the disk at
NB.  the time of the calculation and the center of 
NB.  the disk at the time of collision
dist =. d - h 

NB. The time until the collision
time =. dist % v0
)
