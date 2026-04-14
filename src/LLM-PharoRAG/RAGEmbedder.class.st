Class {
	#name : 'RAGEmbedder',
	#superclass : 'Object',
	#category : 'LLM-PharoRAG-Embedding',
	#package : 'LLM-PharoRAG',
	#tag : 'Embedding'
}

{ #category : 'embedding' }
RAGEmbedder >> embed: aString [
	"Return an embedding vector (array of floats) for the given text.
	Subclasses must override this method."

	^ self subclassResponsibility
]

{ #category : 'embedding' }
RAGEmbedder >> embedAll: aCollectionOfStrings [
	"Return a collection of embedding vectors for the given texts."

	^ aCollectionOfStrings collect: [ :each | self embed: each ]
]

{ #category : 'embedding' }
RAGEmbedder >> embedChunk: aRAGChunk [
	"Compute and set the embedding on the given chunk."

	aRAGChunk embedding: (self embed: aRAGChunk content).
	^ aRAGChunk
]

{ #category : 'embedding' }
RAGEmbedder >> embedChunks: aCollectionOfChunks [
	"Compute and set the embeddings on all given chunks."

	^ aCollectionOfChunks collect: [ :chunk | self embedChunk: chunk ]
]
