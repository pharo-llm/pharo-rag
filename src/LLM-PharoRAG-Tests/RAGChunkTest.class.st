Class {
	#name : 'RAGChunkTest',
	#superclass : 'TestCase',
	#category : 'RAG-Tests',
	#package : 'RAG-Tests'
}

{ #category : 'tests' }
RAGChunkTest >> testCreation [

	| chunk |
	chunk := RAGChunk content: 'Some text'.
	self assert: chunk content equals: 'Some text'.
	self assert: chunk id isNotNil.
	self deny: chunk hasEmbedding
]

{ #category : 'tests' }
RAGChunkTest >> testCreationWithDocumentId [

	| chunk |
	chunk := RAGChunk content: 'Text' documentId: 'doc-1' index: 1.
	self assert: chunk documentId equals: 'doc-1'.
	self assert: chunk index equals: 1
]

{ #category : 'tests' }
RAGChunkTest >> testHasEmbedding [

	| chunk |
	chunk := RAGChunk content: 'Text'.
	self deny: chunk hasEmbedding.
	chunk embedding: #( 0.1 0.2 0.3 ).
	self assert: chunk hasEmbedding
]
