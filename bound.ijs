
NB. Verb to find the center and radius of a bounding sphere given
NB.  the corners of the rectangle. 
NB. Inputs: corners of rectangle
NB. Outputs: center and radius, each boxed then comma'ed together

bound =: monad define
NB. The points put into a better format, a 2 column table
pts =. ((c%2),2) $ y

NB. splits x's and y's of points
xs =. {."1 pts
ys =. {:"1 pts

NB. averages the points to find the center
xavg =. (+/ xs) % $ xs
yavg =. (+/ ys) % $ ys
center =. xavg,yavg

NB. finds the furthest point in the rectangle from the 
NB.  center, and make the radius as big as the distance
NB.  between the two
diffs =. center -"1 pts
dists =. distcalc"1 diffs
radius =. >./ dists

NB. Outputs center and radius, boxed
(<center),<radius

)

NB. Small verb to find distance using pythagorean
distcalc =: monad define
%: (*: {. y) + (*: {. y)
)
