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
