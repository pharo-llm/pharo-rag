Class {
	#name : 'RAGHashEmbedderTest',
	#superclass : 'TestCase',
	#category : 'RAG-Tests',
	#package : 'RAG-Tests'
}

{ #category : 'tests' }
RAGHashEmbedderTest >> testEmbedReturnsCorrectDimensions [

	| embedder result |
	embedder := RAGHashEmbedder dimensions: 64.
	result := embedder embed: 'Hello world'.
	self assert: result size equals: 64
]

{ #category : 'tests' }
RAGHashEmbedderTest >> testEmbedIsNormalized [

	| embedder result magnitude |
	embedder := RAGHashEmbedder new.
	result := embedder embed: 'Some text to embed'.
	magnitude := (result inject: 0.0 into: [ :sum :each |
		              sum + (each * each) ]) sqrt.
	self assert: (magnitude closeTo: 1.0)
]

{ #category : 'tests' }
RAGHashEmbedderTest >> testSameTextSameEmbedding [

	| embedder a b |
	embedder := RAGHashEmbedder new.
	a := embedder embed: 'Hello world'.
	b := embedder embed: 'Hello world'.
	self assert: a equals: b
]

{ #category : 'tests' }
RAGHashEmbedderTest >> testDifferentTextDifferentEmbedding [

	| embedder a b |
	embedder := RAGHashEmbedder new.
	a := embedder embed: 'Hello world'.
	b := embedder embed: 'Goodbye universe'.
	self deny: a = b
]

{ #category : 'tests' }
RAGHashEmbedderTest >> testEmbedChunk [

	| embedder chunk |
	embedder := RAGHashEmbedder new.
	chunk := RAGChunk content: 'Test content'.
	self deny: chunk hasEmbedding.
	embedder embedChunk: chunk.
	self assert: chunk hasEmbedding.
	self assert: chunk embedding size equals: 128
]
