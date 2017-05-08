filter =: verb define
NB. input widgetlist
wlist =: i. $ widgetlist

NB. inputs a list, outputs the index of all the pairs,
NB.  not including duplicates (ex. forwards but not 
NB.  backwards).
uppertri =: ;@:((,. i.)&.>)@:(i.&.<:)

NB. this inputs the wlist, and spits out a list of the
NB.  times of every collision of the pairs from 
NB.  uppertri. collide is supposed to find the time
NB.(collide@:(<@["1 { ])"1)~ uppertri) wlist
upperlist =: uppertri widgetlist
colldet upperlist { widgetlist
)

colldet =: verb define

NB. must extract the position and velocity and radius
NB.  of the widgets that have indexes y. then use those to
NB.  find the time until the collision.
obj0 =: {. y
obj1 =: {: y

vel0 =: getvelocity__obj0''
vel1 =: getvelocity__obj1''
veldiff =: | vel0 - vel1




bpos0 =: getbpos__obj0''
bpos1 =: getbpos__obj1''

xs =: {. bpos0,.bpos1
ys =: {: bpos0,.bpos1

xdist =: -/ xs
ydist =: -/ ys
distsq =:   (*: xdist) + (*: ydist)
dist =: %: distsq

div =: dist % veldiff

NB.colltime =: | (xdist,ydist) % (vel0 - vel1)


if. (vel0 +. vel1) ~: 0 do. 
else. if. (div > 2) do. else.


('cd',type__obj0,type__obj1)~ obj0,obj1




end.
end.
)


cd_disk_disk =: monad define
NB. Calculates one frame in advance.
disk0 =: {.y
disk1 =: {:y

vel0 =: velocity__disk0
vel1 =: velocity__disk1

pos0 =: position__disk0
pos1 =: position__disk1

rad0 =: radius__disk0
rad1 =: radius__disk1

pmass0 =: pmass__disk0
pmass1 =: pmass__disk1

NB. center of psuedomass
cop =: ((pmass0*pos0) + (pmass1*pos1)) % (pmass0+pmass1)

rvec =: pos0 - cop




)
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