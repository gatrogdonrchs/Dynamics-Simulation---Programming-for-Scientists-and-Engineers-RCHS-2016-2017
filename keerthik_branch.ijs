NB. The verb "require" loads a script, and in this case it loads the 'gl2' script that contains useful graphics verbs
NB. To view the gl2 script, one can execute (open 'gl2') in the ijx window
require 'gl2'
NB. The current locale, which can be viewed by executing (coname''), is the 'base' locale
NB. Each locale has a path, which can be viewed by executing (copath'localename')
NB. The coinsert verb inserts a new locale, the jgl2 locale shared among all branche, and places it right before the z locale 
NB.    along the copath of base
coinsert 'jgl2'

NB. (0 : 0) Will define a name, in this case CANVAS, as a noun (0), and in placing the second 0, will state than any code below
NB.   is part of the definition of that noun until a ) appears.  Similarly 3 : 0 does the same but for a verb.
CANVAS =: 0 : 0
NB. The verb (pc), short for "parent create," creates a standard parent window, in this case with the name 'canvas'
pc canvas;
NB. "minwh" is a wd command that sets the minimum width and height of the standard parent window
minwh 1200 900;
NB. A cc, or child class, creates a specific entity in the parental window, of which there are many types
NB. (wd 'cc id isidraw') Creates a widget window which can be acted upon by gl2 commands (graphics commands)
NB. In this case, the widget is named 'canvasisi'
cc canvasisi isidraw;
NB. Creates edit windows (a type of child class) with the names of xcord, ycord, xvelo, and yvelo
cc xcord edit;
cc ycord edit;
cc xvelo edit;
cc yvelo edit;
NB. Creates buttons (a type of child class) with the names of createball, start, and stop
cc createball button;
cc start button;
cc stop button;
NB. bins are "invisible two-dimensional containers" which can contain child controls or other pins
NB. Widgets are automatically stacked vertically in a bin unless commands such as 'binh" or "binv" are used
NB.  bin z ends a specific bin
bin z;
bin z; 
NB. The wd 'pas' command adjusts the parental size to create margins
NB.   in this case, the left and top margins are both 6, and the right/bottom margins will automatically be
NB.   the same as the left and top margins
pas 6 6;
)

NB. Execute the form
canvas_run =: monad define
NB. The (wd) command sends commands to the windows driver
NB. It's arguments must be separated by semicolons
NB. By running (wd CANVAS), the entire CANVAS noun is run as many arguments to send to the window driver 
wd CANVAS
NB. Displays the current graphics window on the screen
wd'pshow'
)

NB. Close the window
canvas_close =: monad define
NB. Closes the parent window.  'pclose' is essentially the opposite command of 'pshow'
wd'pclose;'
)

canvas_cancel =: canvas_close






NB. Dynamics simulation

NB. Calculate length of next time step
NB. For each pair of objects, find out how long till they collide
NB. Result is time to next collision
calctimestep =: verb define
)

NB. Widgets
NB. A widget represents a physical object
NB. It has a graphical representation and a mathematical representation

NB. Subclasses of widgets are disks, rectangles, etc.


cocurrent 'widget'

widgetlist =: 0$a:

create =: verb define
widgetlist_widget_ =: widgetlist_widget_ , coname''
)

destroy =: verb define
widgetlist_widget_ =: widgetlist_widget_ -. coname''
codestroy''
)

NB. Methods common to all widgets
getwidget =: verb define
y{(widgetlist_widget)
)

setvelocity =: verb define
velocity =: y
)

getvelocity =: verb define
velocity
)

setposition =: verb define
position =: y
)

getposition =: verb define
position
)

setrotation =: verb define
rotation =: y
)

setavelocity =: verb define
avelocity =: y
)

setmass =: verb define
amass =: y
)

setgraphrep =: verb define
)

NB. ******************** disks ******************
cocurrent 'disk'
coinsert 'widget'



create =: verb define
create_widget_ f. y
)
destroy =: verb define
destroy_widget_ f. ''
)

cocurrent 'base'
require 'gl2'
coinsert 'jgl2'

inlocalesc =: 2 : 0
cocurrent =. 18!:4
i =. 18!:5 ''
for_l. n do.
  NB.?lintonly l =. <''
  cocurrent l
  u l_index{y
end.
cocurrent i
''
:
cocurrent =. 18!:4
i =. 18!:5 ''
for_l. n do.
  NB.?lintonly l =. <''
  cocurrent l
  x u l_index{y
end.
cocurrent i
''
)
canvas_createball_button =: verb define
newball =: '' conew 'disk'
setposition__newball (". xcord),(". ycord)
setvelocity__newball ((". xvelo)%50),((". yvelo)%50)
glsel canvasisi
NB. glbrush glrgb 3#196
NB. glpen 2 0 [  glrgb 3#128
glellipse (getposition__newball''),(100 100)
glpaintx''
)

canvas_destroyball_button =: verb define
destroy_widget_ inlocales widgetlist_widget_
)

timerframe =: verb define
(setposition_widget_ inlocalesc widgetlist_widget_) ((getposition_widget_ inlocalesc (widgetlist_widget_)) + (getvelocity_widget_ inlocalesc (widgetlist_widget_)))
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse ((getposition_widget_ inlocalesc widgetlist_widget_),(100,100))
glpaintx''
)

NB. Run a timestep of length y
NB. Update positions & velocities
NB. runstep =: verb define
sys_timer =: verb define
cp =: getposition_widget_ inlocalesc (widgetlist_widget_)
cv =: getvelocity_widget_ inlocalesc (widgetlist_widget_)
(setposition inlocalesc widgetlist_widget_) (cp+cv)
glsel canvasisi
glclear''
glbrush glrgb 3#196
glpen 2 0 [  glrgb 3#128
glellipse ((getposition_widget_ inlocalesc widgetlist_widget_),(100,100))
glpaintx''
)

sys_timer_z_ =: sys_timer_base_
canvas_start_button =: verb define
wd 'timer 20'
)

canvas_stop_button =: verb define
wd 'timer 0'
)

NB. When we load this file, create the form if it doesn't exist
wd :: canvas_run 'psel canvas'
