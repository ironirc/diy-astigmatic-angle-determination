"
Warning: 
This tool is by no means made with professional expertise!
You should use this out of curiosity only !!!

Reason for making this tool:
I ordered new glasses (adapted for my computer screen, fixed distance 50cm), sadly it was useless to me.
I noticed I had to rotate my glasses to improve sight (for my left eye)
So I started experimenting.
I think I managed to determine the angles for both my eyes, I think pretty accurate.
My precribed cylinders are around -1,5.

Control:
Launch by evaluating:   AADTAstigmaticAngleDeterminationTool run
Take a look at method: #processKeyDown: to learn about keyboard control keys.
Use your mouse wheel to zoom.

Usage:
Occlude one eye and sit at the exact distance you want to work at.
(The astigmatic angle may vary with the distance between your eye and the screen).
If you have astigmatism, while looking at the full cirle fan, you should see one line (or two lines) as the sharpest.
Using left/right keys, rotate until the center hair-line is inline with the sharpest line.
To get more accuracy, play with rotation, line thicknes, number of lines, zoom, colors, full mode versus few lines mode,
until lines adjacent to the sharpest line are equally sharp (or equally unsharp).
This requires some practice and concentration.
Using the T key, you can reveal the astigmatic angle that should correspond to the angle on your glasses prescription.
"
Class {
	#name : #DIYAstigmaticAngleDeterminationTool,
	#superclass : #RSComposite,
	#instVars : [
		'guideAngle',
		'guide',
		'lineWidth',
		'fanLines',
		'fanAngle',
		'stepSizes',
		'stepSizeIndex',
		'colorSchemes',
		'colorSchemeIndex',
		'onlyUseFewLines',
		'textVisible',
		'text'
	],
	#category : #'DIY-Astigmatic-Angle'
}

{ #category : #building }
DIYAstigmaticAngleDeterminationTool class >> run [

	<script>
	| comp c window |
	c := RSCanvas new.
	c aaBest.
	c @ RSZoomableCanvasInteraction.
	c @ RSDraggableCanvasInteraction.
	comp := self new.
	c add: comp.
	comp build.
	window := c openWithTitle: self name asString.
	window extent: comp encompassingRectangle extent.
	window maximize.
	c when: RSKeyDown send: #processKeyDown: to: comp.
	comp zoomToFit
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> addToLineWidth: diff [

	lineWidth := lineWidth + diff.
	self build
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> applyColorScheme [

	self perform: (colorSchemes at: colorSchemeIndex)
]

{ #category : #'accessing derived' }
DIYAstigmaticAngleDeterminationTool >> astigmaticAngle [

	^ self guideAngle + 90 \\ 180
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> build [
	self canvas color: self currentColorScheme backgroundColor.
	self buildFan.
	self buildGuide.
	self adjustToChildren.
	self signalUpdate
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> buildFan [

	| line |
	fanLines ifNotNil: [ self removeAll: fanLines ].
	fanLines := RSGroup new.
	self fanStepsDo: [ :degrees | 
		| x y |
		x := (degrees + guideAngle) degreesToRadians cos.
		y := (degrees + guideAngle) degreesToRadians sin.
		line := RSLine new
			        startPoint: x * self innerRadius @ (y * self innerRadius);
			        endPoint: x * self radius @ (y * self radius);
			        width: self lineWidth;
			        color: self currentColorScheme fanLineColor;
			        yourself.
		fanLines add: line ].
	self addAll: fanLines
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> buildGuide [

	guide ifNotNil: [ self removeShape: guide ].
	guide := RSLine new
		         width: 2;
		         startPoint: self guideStart;
		         endPoint: self guideEnd;
		         color: self currentColorScheme guideColor;
		         yourself.
	guide color: (Color blue alpha: 0.5).
	guide
		startPoint: self guideStart;
		endPoint: self guideEnd.
	text ifNotNil: [ 
		self removeShape: text.
		text := nil ].

	self textVisible ifTrue: [ 
		text := RSLabel new
			        fontName: 'Source Sans Pro';
			        fontSize: 50;
			        color: self currentColorScheme guideColor;
			        text: (self astigmaticAngle roundTo: 0.1) displayString.
		self add: text.
		RSLocation new
			middle;
			center;
			stick: text on: guide ].
	self add: guide
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> currentColorScheme [

	^colorSchemes at: colorSchemeIndex
]

{ #category : #actions }
DIYAstigmaticAngleDeterminationTool >> decreaseStep [
	stepSizeIndex := (stepSizeIndex - 1) max: 1.
	self build
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> fanStepsDo: aBlock [

	| step |
	step := self stepSize.
	self onlyUseFewLines
		ifTrue: [ (step negated * 2 to: step * 2 by: step) do: aBlock ]
		ifFalse: [ (-180 to: 180 - step by: step) do: aBlock ]
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> guideAngle [

	^ guideAngle
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> guideAngle: anObject [

	guideAngle := anObject
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> guideEnd [

	| x y |
	x := self guideAngle degreesToRadians cos * self innerRadius.
	y := self guideAngle degreesToRadians sin * self innerRadius.
	^ x negated @ y negated
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> guideStart [

	| x y |
	x := self guideAngle degreesToRadians cos * self innerRadius.
	y := self guideAngle degreesToRadians sin * self innerRadius.
	^ x @ y
]

{ #category : #actions }
DIYAstigmaticAngleDeterminationTool >> increaseStep [

	stepSizeIndex := stepSizeIndex + 1 min: stepSizes size.
	self build
]

{ #category : #'initialize-release' }
DIYAstigmaticAngleDeterminationTool >> initialize [

	super initialize.
	lineWidth := 10.
	guideAngle := 0.
	onlyUseFewLines := true.
	stepSizes := #( 5 6 9 10 12 15 18 20 ). "1 2 3 4"
	stepSizeIndex := 6.
	colorSchemes := { 
		                AADTColorScheme red.
		                AADTColorScheme wb.
		                AADTColorScheme green }.
	" AADTColorScheme bw."
	colorSchemeIndex := 1.
	textVisible := true
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> innerRadius [
	^250
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> lineWidth [

	^ lineWidth
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> lineWidth: anObject [

	lineWidth := anObject
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> onlyUseFewLines [

	^ onlyUseFewLines == true
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> onlyUseFewLines: anObject [

	onlyUseFewLines := anObject
]

{ #category : #'keyboard events' }
DIYAstigmaticAngleDeterminationTool >> processKeyDown: ev [

	ev keyName = 'LEFT' ifTrue: [ 
		self rotateGuide: (ev shiftKeyPressed
				 ifTrue: [ -5 ]
				 ifFalse: [ -0.5 ]) ].
	ev keyName = 'RIGHT' ifTrue: [ 
		self rotateGuide: (ev shiftKeyPressed
				 ifTrue: [ 5 ]
				 ifFalse: [ 0.5 ]) ].
	ev keyName = 'RIGHT' ifTrue: [ self rotateGuide: 0.5 ].
	ev keyName = 'UP' ifTrue: [ self increaseStep ].
	ev keyName = 'DOWN' ifTrue: [ self decreaseStep ].
	ev keyName = 'KP_SUBTRACT' ifTrue: [ self addToLineWidth: -0.25 ].
	ev keyName = 'KP_ADD' ifTrue: [ self addToLineWidth: 0.25 ].
	ev keyName = 'M' ifTrue: [ self toggleModeFullOrPartial ].
	ev keyName = 'C' ifTrue: [ self selectNextColorScheme ].
	ev keyName = 'T' ifTrue: [ self toggleTextVisibility ].
	ev keyName = 'F' ifTrue: [ self rotateGuide: 180 ].
	ev keyName = 'Z' ifTrue: [ self zoomToFit ]
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> radius [
	^1000
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> removeAll: aColl [

	aColl do: [ :e | self removeShape: e ]
]

{ #category : #building }
DIYAstigmaticAngleDeterminationTool >> rotateGuide: degrees [

	guideAngle := guideAngle + degrees.
self build.
]

{ #category : #actions }
DIYAstigmaticAngleDeterminationTool >> selectNextColorScheme [

	colorSchemeIndex := colorSchemeIndex + 1.
	colorSchemeIndex > colorSchemes size ifTrue: [ colorSchemeIndex := 1 ].
	self build
]

{ #category : #'accessing derived' }
DIYAstigmaticAngleDeterminationTool >> stepSize [ 


	^stepSizes at: stepSizeIndex 
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> textVisible [

	^ textVisible == true
]

{ #category : #accessing }
DIYAstigmaticAngleDeterminationTool >> textVisible: anObject [

	textVisible := anObject
]

{ #category : #actions }
DIYAstigmaticAngleDeterminationTool >> toggleModeFullOrPartial [

	self onlyUseFewLines: self onlyUseFewLines not.
	self build.
	self zoomToFit
]

{ #category : #actions }
DIYAstigmaticAngleDeterminationTool >> toggleTextVisibility [

	self textVisible: self textVisible not.
	self build
]

{ #category : #'keyboard events' }
DIYAstigmaticAngleDeterminationTool >> zoomToFit [

	self canvas zoomToFit.
	self signalUpdate
]
