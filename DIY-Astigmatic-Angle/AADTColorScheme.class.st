Class {
	#name : #AADTColorScheme,
	#superclass : #Object,
	#instVars : [
		'fanLineColor',
		'guideColor',
		'backgroundColor'
	],
	#category : #'DIY-Astigmatic-Angle'
}

{ #category : #'color schemes' }
AADTColorScheme class >> bw [

	| i |
	i := self new.
	i backgroundColor: Color black.
	i fanLineColor: Color white.
	i guideColor: (Color gray lighter alpha: 0.4).
	^ i
]

{ #category : #'color schemes' }
AADTColorScheme class >> green [

	| i |
	i := self new.
	i backgroundColor: Color green lighter lighter.
	i fanLineColor: Color black.
	i guideColor: (Color gray lighter alpha: 0.4).
	^ i
]

{ #category : #'color schemes' }
AADTColorScheme class >> red [

	| i |
	i := self new.
	i backgroundColor: Color red lighter lighter.
	i fanLineColor: Color black.
	i guideColor: (Color gray lighter alpha: 0.4).
	^ i
]

{ #category : #'color schemes' }
AADTColorScheme class >> wb [ 

	| i |
	i := self new.
	i backgroundColor: Color white.
	i fanLineColor: Color black.
	i guideColor: (Color gray lighter alpha: 0.4).
	^ i
]

{ #category : #accessing }
AADTColorScheme >> backgroundColor [

	^ backgroundColor
]

{ #category : #accessing }
AADTColorScheme >> backgroundColor: anObject [

	backgroundColor := anObject
]

{ #category : #accessing }
AADTColorScheme >> fanLineColor [

	^ fanLineColor
]

{ #category : #accessing }
AADTColorScheme >> fanLineColor: anObject [

	fanLineColor := anObject
]

{ #category : #accessing }
AADTColorScheme >> guideColor [

	^ guideColor
]

{ #category : #accessing }
AADTColorScheme >> guideColor: anObject [

	guideColor := anObject
]
