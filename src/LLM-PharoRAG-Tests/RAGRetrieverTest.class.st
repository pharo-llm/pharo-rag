Class {
	#name : 'RAGRetrieverTest',
	#superclass : 'TestCase',
	#category : 'RAG-Tests',
	#package : 'RAG-Tests'
}

{ #category : 'tests' }
RAGRetrieverTest >> testRetrieve [

	| embedder store retriever c1 c2 results |
	embedder := RAGHashEmbedder new.
	store := RAGVectorStore new.
	c1 := RAGChunk content: 'Pharo is a Smalltalk dialect'.
	embedder embedChunk: c1.
	c2 := RAGChunk content: 'Python is a programming language'.
	embedder embedChunk: c2.
	store addChunks: {
			c1.
			c2 }.
	retriever := RAGRetriever vectorStore: store embedder: embedder.
	retriever topK: 1.
	results := retriever retrieve: 'What is Pharo Smalltalk?'.
	self assert: results size equals: 1
]

{ #category : 'tests' }
RAGRetrieverTest >> testRetrieveWithScores [

	| embedder store retriever c1 results |
	embedder := RAGHashEmbedder new.
	store := RAGVectorStore new.
	c1 := RAGChunk content: 'Pharo is great'.
	embedder embedChunk: c1.
	store addChunk: c1.
	retriever := RAGRetriever vectorStore: store embedder: embedder.
	results := retriever retrieveWithScores: 'Pharo'.
	self assert: results isNotEmpty.
	self assert: results first value isFloat
]

{ #category : 'tests' }
RAGRetrieverTest >> testDefaultTopK [

	| retriever |
	retriever := RAGRetriever new.
	self assert: retriever topK equals: 3
]
