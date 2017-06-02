NB. Rotation verb for widget use. Credits to Mac
sin=: 1&o.
cos=: 2&o.
ang=: 0
rotate =: verb define
C =: getposition inlocalesv (widgetlist_disk_)''
R=: (((cos(ang)),(-sin(ang)))),:((sin(ang)),(cos(ang)))
MP =: +/ .*
rotation =: C MP |R
ang =: ang + o.(0.1)
)
