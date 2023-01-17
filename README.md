# DIY Astigmatic Angle Determination
Experimental tool to determine the axis angle of your astigmatic eye.  
Built using Pharo & Roassal.
                                                                                                    
# Warning:
This tool is made without any professional expertise regarding eye optics!
You should use this out of curiosity only!

# Reason for making this tool:
I ordered new glasses, specially adapted for my computer screen, fixed distance 50cm. Sadly they were useless to me.

I noticed I had to rotate my glasses to improve sight (for my left eye), so I started experimenting.  
I think I managed to determine the angles for both my eyes pretty accurately.  
My prescribed cylinders are around -1,5. The higher this number, the easier it should become to use this tool.

# Control:
Launch by evaluating: `DIYAstigmaticAngleDeterminationTool run`  
Take a look at method: #processKeyDown: to learn about keyboard control keys.  
Use your mouse wheel to zoom.

# Usage:
Occlude one eye and sit at the exact distance you want to work at.  
(The astigmatic angle may vary with the distance between your eye and the screen).  
If you have astigmatism, while looking at the full cirle fan, you should see one line (or two lines) as the sharpest.  
Using left/right keys, rotate until the center hair-line is inline with the sharpest line.  
To get more accuracy, play with rotation, line thicknes, number of lines, zoom, colors, full mode versus few lines mode,
until lines adjacent to the sharpest line are equally sharp (or equally unsharp).
This requires some practice and concentration.  
Using the `T` key, you can reveal the astigmatic angle that should correspond to the angle on your glasses prescription.
