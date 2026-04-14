Class {
	#name : 'RAGVectorStoreTest',
	#superclass : 'TestCase',
	#category : 'RAG-Tests',
	#package : 'RAG-Tests'
}

{ #category : 'tests' }
RAGVectorStoreTest >> testAddAndSize [

	| store chunk |
	store := RAGVectorStore new.
	chunk := RAGChunk content: 'Hello'.
	chunk embedding: #( 1.0 0.0 0.0 ).
	store addChunk: chunk.
	self assert: store size equals: 1
]

{ #category : 'tests' }
RAGVectorStoreTest >> testSearch [

	| store c1 c2 c3 results |
	store := RAGVectorStore new.
	c1 := RAGChunk content: 'First'.
	c1 embedding: #( 1.0 0.0 0.0 ).
	c2 := RAGChunk content: 'Second'.
	c2 embedding: #( 0.0 1.0 0.0 ).
	c3 := RAGChunk content: 'Third'.
	c3 embedding: #( 0.9 0.1 0.0 ).
	store addChunks: {
			c1.
			c2.
			c3 }.
	results := store search: #( 1.0 0.0 0.0 ) topK: 2.
	self assert: results size equals: 2.
	self assert: results first content equals: 'First'.
	self assert: results second content equals: 'Third'
]

{ #category : 'tests' }
RAGVectorStoreTest >> testRemoveChunksForDocumentId [

	| store c1 c2 |
	store := RAGVectorStore new.
	c1 := RAGChunk content: 'A' documentId: 'doc1' index: 1.
	c1 embedding: #( 1.0 0.0 ).
	c2 := RAGChunk content: 'B' documentId: 'doc2' index: 1.
	c2 embedding: #( 0.0 1.0 ).
	store addChunks: {
			c1.
			c2 }.
	store removeChunksForDocumentId: 'doc1'.
	self assert: store size equals: 1.
	self assert: store chunks first content equals: 'B'
]

{ #category : 'tests' }
RAGVectorStoreTest >> testSearchWithScores [

	| store c1 results |
	store := RAGVectorStore new.
	c1 := RAGChunk content: 'Match'.
	c1 embedding: #( 1.0 0.0 ).
	store addChunk: c1.
	results := store searchWithScores: #( 1.0 0.0 ) topK: 1.
	self assert: results size equals: 1.
	self assert: results first key content equals: 'Match'.
	self assert: (results first value closeTo: 1.0)
]
