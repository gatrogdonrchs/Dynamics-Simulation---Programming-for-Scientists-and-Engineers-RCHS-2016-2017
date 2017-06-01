bsphere =: monad define
c =. $ y
pts =. ((c%2),2) $ y
a =. {. pts
diffa =. a -"1 pts

distsa =. distcalc"1 diff
b =. ((>. dists) i. dists) { pts



)

distcalc =: monad define
%: (*: {. y) + (*: {. y)
)