Class {
	#name : 'RAGTextSplitter',
	#superclass : 'Object',
	#instVars : [
		'chunkSize',
		'chunkOverlap',
		'separator'
	],
	#category : 'LLM-PharoRAG-Chunking',
	#package : 'LLM-PharoRAG',
	#tag : 'Chunking'
}

{ #category : 'instance creation' }
RAGTextSplitter class >> chunkSize: anInteger [

	^ self new
		  chunkSize: anInteger;
		  yourself
]

{ #category : 'instance creation' }
RAGTextSplitter class >> chunkSize: anInteger overlap: overlapInteger [

	^ self new
		  chunkSize: anInteger;
		  chunkOverlap: overlapInteger;
		  yourself
]

{ #category : 'accessing' }
RAGTextSplitter >> chunkOverlap [

	^ chunkOverlap
]

{ #category : 'accessing' }
RAGTextSplitter >> chunkOverlap: anInteger [

	chunkOverlap := anInteger
]

{ #category : 'accessing' }
RAGTextSplitter >> chunkSize [

	^ chunkSize
]

{ #category : 'accessing' }
RAGTextSplitter >> chunkSize: anInteger [

	chunkSize := anInteger
]

{ #category : 'initialization' }
RAGTextSplitter >> initialize [

	super initialize.
	chunkSize := 500.
	chunkOverlap := 50.
	separator := String cr
]

{ #category : 'accessing' }
RAGTextSplitter >> separator [

	^ separator
]

{ #category : 'accessing' }
RAGTextSplitter >> separator: aString [

	separator := aString
]

{ #category : 'splitting' }
RAGTextSplitter >> split: aString [
	"Split a string into chunks respecting the chunk size and overlap."

	| paragraphs chunks currentChunk |
	paragraphs := self splitBySeparator: aString.
	chunks := OrderedCollection new.
	currentChunk := ''.

	paragraphs do: [ :paragraph |
		| trimmed |
		trimmed := paragraph trimBoth.
		trimmed ifNotEmpty: [
			(currentChunk size + trimmed size + 1 > chunkSize and: [
				 currentChunk isNotEmpty ])
				ifTrue: [
					chunks add: currentChunk trimBoth.
					currentChunk := self overlapFrom: currentChunk.
					currentChunk := currentChunk , trimmed ]
				ifFalse: [
					currentChunk := currentChunk isEmpty
						                ifTrue: [ trimmed ]
						                ifFalse: [
						                currentChunk , String cr , trimmed ] ] ] ].

	currentChunk trimBoth ifNotEmpty: [ :c | chunks add: c ].
	^ chunks asArray
]

{ #category : 'splitting' }
RAGTextSplitter >> splitBySeparator: aString [
	"Split the string by the configured separator."

	^ separator = String cr
		  ifTrue: [ aString lines ]
		  ifFalse: [ aString substrings: separator ]
]

{ #category : 'splitting' }
RAGTextSplitter >> splitDocument: aRAGDocument [
	"Split a RAGDocument into an array of RAGChunks."

	| textChunks |
	textChunks := self split: aRAGDocument content.
	^ textChunks withIndexCollect: [ :text :idx |
		  RAGChunk
			  content: text
			  documentId: aRAGDocument id
			  index: idx ]
]

{ #category : 'private' }
RAGTextSplitter >> overlapFrom: aString [
	"Return the overlap portion from the end of the given string."

	chunkOverlap = 0 ifTrue: [ ^ '' ].
	^ aString size <= chunkOverlap
		  ifTrue: [ aString ]
		  ifFalse: [
			  (aString last: chunkOverlap) trimBoth
				  ifNotEmpty: [ :s | s , String cr ]
				  ifEmpty: [ '' ] ]
]
