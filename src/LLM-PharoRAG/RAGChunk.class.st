Class {
	#name : 'RAGChunk',
	#superclass : 'Object',
	#instVars : [
		'content',
		'metadata',
		'embedding',
		'id',
		'documentId',
		'index'
	],
	#category : 'LLM-PharoRAG-Model',
	#package : 'LLM-PharoRAG',
	#tag : 'Model'
}

{ #category : 'instance creation' }
RAGChunk class >> content: aString [

	^ self new
		  content: aString;
		  yourself
]

{ #category : 'instance creation' }
RAGChunk class >> content: aString documentId: aDocumentId index: anInteger [

	^ self new
		  content: aString;
		  documentId: aDocumentId;
		  index: anInteger;
		  yourself
]

{ #category : 'accessing' }
RAGChunk >> content [

	^ content
]

{ #category : 'accessing' }
RAGChunk >> content: aString [

	content := aString
]

{ #category : 'accessing' }
RAGChunk >> documentId [

	^ documentId
]

{ #category : 'accessing' }
RAGChunk >> documentId: anObject [

	documentId := anObject
]

{ #category : 'accessing' }
RAGChunk >> embedding [

	^ embedding
]

{ #category : 'accessing' }
RAGChunk >> embedding: anArray [

	embedding := anArray
]

{ #category : 'testing' }
RAGChunk >> hasEmbedding [

	^ embedding isNotNil and: [ embedding isNotEmpty ]
]

{ #category : 'accessing' }
RAGChunk >> id [

	^ id
]

{ #category : 'accessing' }
RAGChunk >> id: anObject [

	id := anObject
]

{ #category : 'accessing' }
RAGChunk >> index [

	^ index
]

{ #category : 'accessing' }
RAGChunk >> index: anInteger [

	index := anInteger
]

{ #category : 'initialization' }
RAGChunk >> initialize [

	super initialize.
	metadata := Dictionary new.
	id := UUID new asString
]

{ #category : 'accessing' }
RAGChunk >> metadata [

	^ metadata
]

{ #category : 'accessing' }
RAGChunk >> metadata: aDictionary [

	metadata := aDictionary
]

{ #category : 'printing' }
RAGChunk >> printOn: aStream [

	aStream
		nextPutAll: 'RAGChunk(';
		nextPutAll: (content
				 ifNil: [ '' ]
				 ifNotNil: [ content truncateTo: 50 ]);
		nextPut: $)
]
