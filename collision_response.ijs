



disk_disk =: dyad define
NB. Input: 
NB. x is point of collision, 
NB. y is the two colliding locales

posx =: 0 { x
posy =: 1 { x
disk1 =: 0 { y
disk2 =: 1 { y
NB.r1 =: getradius__disk1 ''
NB.r2 =: getradius__disk2 ''

v1 =: getvelocity__disk1 ''
v2 =: getvelocity__disk2 ''

v1p =: (_1, _1) * v1
v2p =: (_1, _1) * v2

setvelocity__disk1 v1p
setvelocity__disk2 v2p
 

)


disk_rect =: verb define
NB. Input: 
NB. x is point of collision, 
NB. y is the two colliding locales


)


Notes =: noun define
locale changes when:
     current 'locname' is executed
     a locative is executed (a verb is executed)
          (some name)_base_ - this is direct, base is not a name
          (name)__obj   - this is indirect - obj is a name

http://www.real-world-physics-problems.com/physics-of-billiards.html

)