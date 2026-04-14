Class {
	#name : 'RAGCosineSimilarityTest',
	#superclass : 'TestCase',
	#category : 'LLM-PharoRAG-Tests',
	#package : 'LLM-PharoRAG-Tests'
}

{ #category : 'tests' }
RAGCosineSimilarityTest >> testIdenticalVectors [

	| score |
	score := RAGCosineSimilarity between: #( 1.0 0.0 0.0 ) and: #( 1.0 0.0 0.0 ).
	self assert: (score closeTo: 1.0)
]

{ #category : 'tests' }
RAGCosineSimilarityTest >> testOrthogonalVectors [

	| score |
	score := RAGCosineSimilarity between: #( 1.0 0.0 ) and: #( 0.0 1.0 ).
	self assert: (score closeTo: 0.0)
]

{ #category : 'tests' }
RAGCosineSimilarityTest >> testOppositeVectors [

	| score |
	score := RAGCosineSimilarity between: #( 1.0 0.0 ) and: #( -1.0 0.0 ).
	self assert: (score closeTo: -1.0)
]

{ #category : 'tests' }
RAGCosineSimilarityTest >> testZeroVector [

	| score |
	score := RAGCosineSimilarity between: #( 0.0 0.0 ) and: #( 1.0 0.0 ).
	self assert: score equals: 0.0
]
