



disk_disk1 =: dyad define
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
NB. none of this is working, just keeping it to show I was working on stuff
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

disk_disk =: monad define
disk1 =: 0 { y
disk2 =: 1 { y

xy1 =: getposition__disk1 ''
x1 =: 0 { xy1
y1 =: 1 { xy1
xy2 =: getposition__disk2 ''
x2 =: 0 { xy2
y2 =: 1 { xy2
v1 =: getvelocity__disk1 ''
v1 =: (1 , _1) * v1 
v2 =: getvelocity__disk2 ''
v2 =: (1 , _1) * v2
m1 =: getmass__disk1 ''
m2 =: getmass__disk2 ''

dy12 =: y1 - y2
dx12 =: x2 - x1
angle12 =: arctanpos dx12, dy12
anglev1 =: arctanvel v1

v1r =: (anglev1 -angle12) shift_forward v1
v1x =: 0 { ,v1r
v1y =: 1 { ,v1r

dy21 =: y2 - y1
dx21 =: x1 - x2
angle21 =: arctanpos dx21,  dy21
anglev2 =: anglev1

v2r =: (anglev2 - angle21) shift_forward v2 
v2x =: 0 { ,v2r
v2y =: 1 { ,v2r


v1xf =: (((m1 - m2) % (m1 + m2)) * v1x ) + (((2 * m2) % (m1 + m2)) * v2x)
v2xf =: (((2 * m1) % (m1 + m2)) * v1x ) - (((m1 - m2) % (m1 + m2)) * v2x)

anglev1f =: arctanvel v1xf, v1y
anglev2f =: arctanvel v2xf, v2y
theta =: 1p1 - angle21
rotmtrx =: ((2 o. theta) , (_1 * 1 o. theta)) ,. ((1 o. theta) , ( 2 o. theta))

v1f =: rotmtrx +/ . * ,. v1xf , v1y
v2f =: rotmtrx +/ . * ,. v2xf , v2y
NB.v1f =:  (anglev1f - theta) shift_forward v1xf , v1y
NB.v2f =:  (anglev2f - theta) shift_forward v2xf , v2y

NB.v1f =:  (_1 * anglev1 - angle12) shift_forward v1xf , v1y
NB.v2f =:  (_1 * anglev2 - angle21) shift_forward v2xf , v2y

NB.v1f =:  (_1 * anglev1 - angle12) shift_forward v1xf , v1y
NB.v2f =: (_1 * anglev2 - angle21) shift_forward v2xf , v2y

setvelocity__disk1 (1 , _1) * ,v1f
setvelocity__disk2 (1 , _1) * ,v2f
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

arctanpos =: monad define
exe =: 0 { y

arc =: _3 o. %~/ * y
if. (exe < 0) do.
arc =: arc + 1p1
end.
) 

arctanvel =: monad define
exe =: 0 { y

arc =: _3 o. %~/ (1 1)* y
if. (exe < 0) do.
arc =: arc + 1p1
end.
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


NB. setvelocity inlocalesc widgetlist_disk_ (cv +"1 (0 0.196))
NB. http://farside.ph.utexas.edu/teaching/301/lectures/node76.html
NB. this literally has the equations we need.  Just rotate the frame, then rotate back



shift_forward1 =: monad define

NB. disk1 =: [wpw1] { widgetlist_widget_
NB. disk2 =: [wpw2] { widgetlist_widget_
NB. wpw means position of widget in collision with respect to widgetlist_widget_
disk1 =:0 NB.0 { widgetlist_widget_
rect1 =: 0 NB. 1 { widgetlist_widget_

velocity2 =: 0 5 NB.getvelocity__disk1''

posc =: 0 _10 NB.getposition__disk1''

posedge =:0 0 NB.getposition__rect1''

rotation =: 1p1%2 NB. getrotation__rect1''

hyp =: %:(+/ (velocity2^2))

angle12 =: (1p1%2) - rotation

shiftedvelocity =: (hyp * (1&o.angle12)),(hyp * (2&o.angle12))
NB. the shifted coordinate system. 

smoutput shiftedvelocity

)

shift_back1 =: monad define

disk1 =: 10
rect1 =: 0
rotation =: 1p1%4
velocity2 =:0 5

angle2 =: (1p1%2) - (rotation+ 1p1%4)

veloc =: %:(+/(velocity2^2))
shiftback =: (veloc * (1&o.angle2)),(veloc * (2&o.angle2))
NB. the shifted coordinate system. 
smoutput shiftback
)

