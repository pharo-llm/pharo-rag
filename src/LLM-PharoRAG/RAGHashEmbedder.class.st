Class {
	#name : 'RAGHashEmbedder',
	#superclass : 'RAGEmbedder',
	#instVars : [
		'dimensions'
	],
	#category : 'LLM-PharoRAG-Embedding',
	#package : 'LLM-PharoRAG',
	#tag : 'Embedding'
}

{ #category : 'instance creation' }
RAGHashEmbedder class >> dimensions: anInteger [

	^ self new
		  dimensions: anInteger;
		  yourself
]

{ #category : 'accessing' }
RAGHashEmbedder >> dimensions [

	^ dimensions
]

{ #category : 'accessing' }
RAGHashEmbedder >> dimensions: anInteger [

	dimensions := anInteger
]

{ #category : 'embedding' }
RAGHashEmbedder >> embed: aString [
	"Generate a simple hash-based embedding for testing and offline use.
	This uses word hashing to create a bag-of-words style vector.
	Not suitable for production - use an API-based embedder instead."

	| vector words |
	vector := Array new: dimensions withAll: 0.0.
	words := aString asLowercase substrings.
	words do: [ :word |
		| idx |
		idx := word hash \\ dimensions + 1.
		vector at: idx put: (vector at: idx) + 1.0 ].
	^ self normalize: vector
]

{ #category : 'initialization' }
RAGHashEmbedder >> initialize [

	super initialize.
	dimensions := 128
]

{ #category : 'private' }
RAGHashEmbedder >> normalize: aVector [
	"L2-normalize the vector."

	| magnitude |
	magnitude := (aVector inject: 0.0 into: [ :sum :each |
		              sum + (each * each) ]) sqrt.
	magnitude = 0.0 ifTrue: [ ^ aVector ].
	^ aVector collect: [ :each | each / magnitude ]
]
