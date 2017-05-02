



disk_disk =: dyad define
NB. Dummy code
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

disk_disk1 =: dyad define
posx =: 0 { x
posy =: 1 { x
disk1 =: 0 { y
disk2 =: 1 { y
NB.r1 =: getradius__disk1 ''
NB.r2 =: getradius__disk2 ''

v1 =: getvelocity__disk1 ''
v2 =: getvelocity__disk2 ''
p1 =: getposition__disk1 ''
p2 =: getposition__disk2 ''
m1 =: getmass__disk1 ''
m2 =: getmass__disk2 ''

v1x =: {. v1
v1y =: {: v1
v2x =: {. v2
v2y =: {: v2
p1x =: {. p1
p1y =: {: p1
p2x =: {. p2
p2y =: {: p2
NB. http://ericleong.me/research/circle-circle/#dynamic-static-circle-collision-response
NB. I am a bit worried about the calculation, because it does not take into account the point of impact
NB. distance between centers
d =: %: +/ *:( p1x -p2x) , (p1y - p2y)
NB. "norm of the vector from the point of collision for the first circle and the point of collision of the second circle"
n =: d %~ (p1 - p2)
NB. x and y components
nx =: {. n
ny =: {: n
NB. delta p for disks
p =: (m1 + m2) %~ +: ( ((v1x*nx) + (v1y * ny)) + ((v2x * nx) + (v2y * ny)) )
NB. Final velocity calculations
v1p =: v1 - n * p * m1 
v2p =: v2 - n * p * m2

setvelocity__disk1 v1p
setvelocity__disk2 v2p
)


disk_rect =: dyad define
NB. Input: 
NB. x is point of collision, 
NB. y is the two colliding locales


)
NB. https://phet.colorado.edu/en/simulation/collision-lab
NB. http://www.metanetsoftware.com/2016/n-tutorial-a-collision-detection-and-response#section3
NB. http://ericleong.me/research/circle-circle/#dynamic-static-circle-collision-response
