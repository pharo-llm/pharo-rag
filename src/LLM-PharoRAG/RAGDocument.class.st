Class {
	#name : 'RAGDocument',
	#superclass : 'Object',
	#instVars : [
		'content',
		'metadata',
		'id'
	],
	#category : 'RAG-Model',
	#package : 'RAG',
	#tag : 'Model'
}

{ #category : 'instance creation' }
RAGDocument class >> content: aString [

	^ self new
		  content: aString;
		  yourself
]

{ #category : 'instance creation' }
RAGDocument class >> content: aString metadata: aDictionary [

	^ self new
		  content: aString;
		  metadata: aDictionary;
		  yourself
]

{ #category : 'accessing' }
RAGDocument >> content [

	^ content
]

{ #category : 'accessing' }
RAGDocument >> content: aString [

	content := aString
]

{ #category : 'accessing' }
RAGDocument >> id [

	^ id
]

{ #category : 'accessing' }
RAGDocument >> id: anObject [

	id := anObject
]

{ #category : 'initialization' }
RAGDocument >> initialize [

	super initialize.
	metadata := Dictionary new.
	id := UUID new asString
]

{ #category : 'accessing' }
RAGDocument >> metadata [

	^ metadata
]

{ #category : 'accessing' }
RAGDocument >> metadata: aDictionary [

	metadata := aDictionary
]

{ #category : 'printing' }
RAGDocument >> printOn: aStream [

	aStream
		nextPutAll: 'RAGDocument(';
		nextPutAll: (content
				 ifNil: [ '' ]
				 ifNotNil: [ content truncateTo: 50 ]);
		nextPut: $)
]
