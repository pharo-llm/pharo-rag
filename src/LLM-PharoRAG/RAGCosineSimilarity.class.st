Class {
	#name : 'RAGCosineSimilarity',
	#superclass : 'Object',
	#category : 'RAG-Similarity',
	#package : 'RAG',
	#tag : 'Similarity'
}

{ #category : 'computing' }
RAGCosineSimilarity class >> between: vectorA and: vectorB [
	"Compute cosine similarity between two vectors. Returns a value between -1 and 1."

	^ self new between: vectorA and: vectorB
]

{ #category : 'computing' }
RAGCosineSimilarity >> between: vectorA and: vectorB [
	"Compute cosine similarity between two vectors."

	| dotProduct magnitudeA magnitudeB |
	dotProduct := 0.0.
	magnitudeA := 0.0.
	magnitudeB := 0.0.

	1 to: vectorA size do: [ :i |
		| a b |
		a := vectorA at: i.
		b := vectorB at: i.
		dotProduct := dotProduct + (a * b).
		magnitudeA := magnitudeA + (a * a).
		magnitudeB := magnitudeB + (b * b) ].

	magnitudeA := magnitudeA sqrt.
	magnitudeB := magnitudeB sqrt.

	(magnitudeA = 0.0 or: [ magnitudeB = 0.0 ]) ifTrue: [ ^ 0.0 ].

	^ dotProduct / (magnitudeA * magnitudeB)
]
