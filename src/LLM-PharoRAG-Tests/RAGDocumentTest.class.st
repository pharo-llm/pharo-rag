Class {
	#name : 'RAGDocumentTest',
	#superclass : 'TestCase',
	#category : 'LLM-PharoRAG-Tests',
	#package : 'LLM-PharoRAG-Tests'
}

{ #category : 'tests' }
RAGDocumentTest >> testCreation [

	| doc |
	doc := RAGDocument content: 'Hello world'.
	self assert: doc content equals: 'Hello world'.
	self assert: doc metadata isEmpty.
	self assert: doc id isNotNil
]

{ #category : 'tests' }
RAGDocumentTest >> testCreationWithMetadata [

	| doc meta |
	meta := Dictionary new
		        at: 'source' put: 'test';
		        yourself.
	doc := RAGDocument content: 'Hello' metadata: meta.
	self assert: doc content equals: 'Hello'.
	self assert: (doc metadata at: 'source') equals: 'test'
]

{ #category : 'tests' }
RAGDocumentTest >> testPrintOn [

	| doc |
	doc := RAGDocument content: 'Short text'.
	self assert: (doc printString includesSubstring: 'RAGDocument(')
]
