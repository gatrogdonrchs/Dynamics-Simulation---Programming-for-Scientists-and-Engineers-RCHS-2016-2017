



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




disk_rect =: monad define

NB. disk1 =: [wpw1] { widgetlist_widget_
NB. disk2 =: [wpw2] { widgetlist_widget_
NB. wpw means position of widget in collision with respect to widgetlist_widget_
disk1 =: 0 { widgetlist_widget_
rect1 =: 1 { widgetlist_widget_

velocity2 =: getvelocity__disk1''

posc =: getposition__disk1''

posedge =: getposition__rect1''

rotation =: 0 NB. getrotation__rect1''

velocity =: %:(+/(velocity2)^2)
angle =: | (posedge- posc  )
 
hyp =: %:(+/ (angle^2))
NB. hypotenuse
t =: ((0{angle) % hyp)

angle1 =: _1&o.t

NB. A nice complicated formula that calculates the angle of the ball. 
actangle =: (angle1 + (1p1 + rotation) - (1p1-angle1)) + rotation
velocity1 =:    (velocity * ( 1&o.actangle)) ,( velocity * ( 2&o.actangle) ) 
NB. the x and y components of velocity.
shiftedvelocity =: velocity * (1&o.actangle)
NB. the shifted coordinate system. 
smoutput velocity1
smoutput shiftedvelocity

)

coordinate_rotation =: monad define

disk1 =: 0 { widgetlist_widget_
rect1 =: 1 { widgetlist_widget_

velocity2 =: getvelocity__disk1''

posc =: getposition__disk1''

posedge =: getposition__rect1''

rotation =: 0 NB. getrotation__rect1''

velocity =: %:(+/(velocity2)^2)
angle =: | (posedge- posc  )

hyp =: %:(+/ (angle^2))
NB. hypotenuse
t =: ((0{angle) % hyp)

angle1 =: _1&o.t
NB. A nice complicated formula that calculates the angle of the ball. 
actangle =: (angle1 + (1p1 + rotation) - (1p1-angle1)) + rotation

NB. the x and y components of velocity.
shiftedvelocity =: velocity % (1&o.actangle)
NB. the shifted coordinate system. 
smoutput velocity1
smoutput shiftedvelocity
)


disk_wall =: monad define
NB. input is disk locale, wall locale

NB. duration of collision is going to be the time to compress a film that is 1% of the radius, times two
NB. (2%) * r = deltat
disk =: {. y
wall =: {: y

NB. can be changed later as desired
coF =: 1

R =: getradius__disk ''
Md =: getmass__disk ''
V =: getvelocity__disk ''
Rotd =: getrotation__disk ''
Rotw =: getrotation__wall ''
aVd =: getrotation__disk ''
posc =: getposition__disk ''
posedge =: getposition__wall''


velocity =: %:(+/(V)^2)
angle =: | (posedge- posc  )
 
hyp =: %:(+/ (angle^2))
NB. hypotenuse
t =: ((0{angle) % hyp)

angle1 =: _1&o.t

NB. A nice complicated formula that calculates the angle of the ball. 
actangle =: (angle1 + (1p1 + Rotw) - (1p1-angle1)) + (1p1%4)
NB. actangle is the actual angle.
NB. the x and y components of velocity.
shiftedvelocity =: velocity * (1&o.actangle)
NB. the shifted coordinate system. 





NB. This will be changed with coordinate rotations that Isaac will be doing.
NB. I am currently writing this for a collision with the groud, and will add Isaac's code in later
Vx =: {. shiftedvelocity
Vy =: {: shiftedvelocity

dD =: 0.02 * R
dT =: dD % Vy

NB. average normal force calculation:
NB. delta P divided by delta T, or:
Fn =:  dT %~ (2 * Md * Vy)
NB. this is also the normal force

NB. energy before collision % (1/2 * mass).  The mass cancels out of the before and after energies, so it is not used, as does the 1/2
bEnergy =: %: +/ (Vx,Vy) ^2

NB. Moment of inertia:
I =: 0.5 * Md * (R^2)

NB. torque calculation:
NB. the last part sets the torque to be positive or negative, depending on the velocity of the point in contact with the wall
NB. (velocityx + velocity at edge due to rotation)
Torque =: Fn * coF * R * (* (Vx + R*aVd)) 

NB. final angular velocity calculation
aV2 =: I %~ (Torque * dT) + (I * aVd)

NB. end of class notes: 
NB. now we need to subtract the new rotational energy from the initial kinetic energy, and find the new kinetic energy
NB. I think the energy subtracts only from the x component, because the force of friction is perpendicular to the y component. 
NB. Idk this for sure though

Vxp =: %: ((Vx^2) - ((R^4)*(aV2^4)))
Vyp =: _1 * Vy



velocity =: %:(+/(Vxp,Vyp)^2)
angle =: | (posedge- posc  )

hyp =: %:(+/ (angle^2))
NB. hypotenuse
t =: ((0{angle) % hyp)

angle1 =: _1&o.t
NB. A nice complicated formula that calculates the angle of the ball. 
actangle =: (angle1 + (1p1 + rotation) - (1p1-angle1)) + rotation

NB. the x and y components of velocity.
shiftedvelocity =: velocity % (1&o.actangle)
setvelocity__disk shiftedvelocity
)

NB. https://phet.colorado.edu/en/simulation/collision-lab
NB. http://www.metanetsoftware.com/2016/n-tutorial-a-collision-detection-and-response#section3
NB. http://ericleong.me/research/circle-circle/#dynamic-static-circle-collision-response
