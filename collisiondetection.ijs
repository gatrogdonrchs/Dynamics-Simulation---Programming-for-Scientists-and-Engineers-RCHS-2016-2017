NB. This verb should be used to operate on widgetlist, it finds all the pairs of
NB.  widgets and calls the next verb, colldet, to operate on each pair.
filter =: verb define
wlist =: i. $ y
NB. inputs a list, outputs the index of all the pairs,
NB.  not including duplicates (ex. forwards but not 
NB.  backwards).
uppertri =: ;@:((,. i.)&.>)@:(i.&.<:)

upperlist =: uppertri wlist
colldet"1 upperlist { widgetlist
)

colldet =: verb define

NB. must extract the position and velocity and radius
NB.  of the widgets that have indexes y. then use those to
NB.  find the time until the collision.
obj0 =: {. y
obj1 =: {: y

vel0 =. getvelocity__obj0''
vel1 =. getvelocity__obj1''
veldiff =. | vel1 - vel0
speed =. %: (*: {.veldiff) + (*: {:veldiff)


bpos0 =. getbpos__obj0''
bpos1 =. getbpos__obj1''

xs =. {. bpos0,.bpos1
ys =. {: bpos0,.bpos1

xdist =. -/ xs
ydist =. -/ ys
distsq =.   (*: xdist) + (*: ydist)
dist =. %: distsq

div =. dist % speed

NB. If both objects are stationary, don't bother operating on them.
if. (vel0 +. vel1) ~: 0 do. 

NB. The 20 is the frame time, change if needed.
else. if. (div < 20) do.

NB. Calls the correct cd verb based on the widget types
('cd',type__obj0,type__obj1)~ obj0,obj1

end.
end.
)

NB. Detecting collision between two disks
cd_disk_disk =: monad define
disk0 =. {.y
disk1 =. {:y

NB. Grab widget info needed for calculations
v0 =. velocity__disk0
v1 =. velocity__disk1

pos0 =. position__disk0
pos1 =. position__disk1

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

cd_disk_rectangle =: monad define
object0 =. {.y
object1 =. {:y

NB. Grab widget info needed for calculations
v0 =. velocity__disk0
v1 =. velocity__disk1

pos0 =. position__disk0
pos1 =. position__disk1

rad0 =. radius__disk0
rad1 =. radius__disk1


)

cd_rectangle_disk =: cd_disk_rectangle


NB. Rough filtering
NB.  take sums of velocity vectors and distance between


NB. Finding center of pseudomass
NB.  the pseudomass of each object is just the radius
NB.  (m1c1 + m2c2) / (m1 + m2)


NB. locale changes when:
NB.   -cocurrent 'locname' is executed
NB.   -a locative is executed >>> a_base_ (direct) or b__obj (indirect)
NB.	ball =: '' conew 'disk' >>> velocity__ball
NB.	velocity__ball =: 2 does not change locale, DO NOT USE
NB.	 use a verb instead to EXECUTE the locale with a locative
NB.	 ex. get_vel__ball'' >>> executes get_vel in the locale of ball
NB.	two underscores indicate a locative: b__obj
NB.   -an exp. def completes

NB. every locale has a search path, you can define it when making the locale
NB. copath <'name' tells you the path of that name
NB. locale: base  widget  disk
NB. path:    z     z     widget z

NB. every widget needs a bounding disk/sphere,
NB. filter out widget list based on time til collision
NB. use bounding spheres for that^^^
NB. do not need to check stationary objects against each
NB.  other, but have to check with widgets in motion
NB. one verb filters, another calls each other verb based
NB.  on type of collision, they calculate time of collision
NB.  more accurately. next verb takes further info of the
NB.  soonest collision.
NB. we also need to find a way to specify point of contact
NB.  may be different depending on type of collision
NB. ask other departments for standard of time, they have to
NB.  define bounding sphere for each widget at creation
NB. the bounding disk of a disk is just the widget itself
NB. special cases: -simultaneous collisions > offset a lil bit
NB.   -multi-point collisions > change angle a bit
