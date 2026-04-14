Class {
	#name : 'RAGResult',
	#superclass : 'Object',
	#instVars : [
		'query',
		'chunks',
		'prompt',
		'answer'
	],
	#category : 'RAG-Pipeline',
	#package : 'RAG',
	#tag : 'Pipeline'
}

{ #category : 'accessing' }
RAGResult >> answer [

	^ answer
]

{ #category : 'accessing' }
RAGResult >> answer: aString [

	answer := aString
]

{ #category : 'accessing' }
RAGResult >> chunks [

	^ chunks
]

{ #category : 'accessing' }
RAGResult >> chunks: aCollection [

	chunks := aCollection
]

{ #category : 'accessing' }
RAGResult >> context [
	"Return the context text assembled from the chunks."

	^ String cr join: (chunks collect: [ :c | c content ])
]

{ #category : 'accessing' }
RAGResult >> prompt [

	^ prompt
]

{ #category : 'accessing' }
RAGResult >> prompt: aString [

	prompt := aString
]

{ #category : 'accessing' }
RAGResult >> query [

	^ query
]

{ #category : 'accessing' }
RAGResult >> query: aString [

	query := aString
]

{ #category : 'printing' }
RAGResult >> printOn: aStream [

	aStream
		nextPutAll: 'RAGResult(';
		nextPutAll: (query ifNil: [ '' ] ifNotNil: [ query truncateTo: 40 ]);
		nextPutAll: ', ';
		print: chunks size;
		nextPutAll: ' chunks)'
]
