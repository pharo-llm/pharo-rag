Class {
	#name : 'RAGVectorStore',
	#superclass : 'Object',
	#instVars : [
		'chunks',
		'similarity'
	],
	#category : 'RAG-Store',
	#package : 'RAG',
	#tag : 'Store'
}

{ #category : 'adding' }
RAGVectorStore >> addChunk: aRAGChunk [
	"Add a chunk to the vector store."

	chunks add: aRAGChunk
]

{ #category : 'adding' }
RAGVectorStore >> addChunks: aCollection [
	"Add multiple chunks to the vector store."

	aCollection do: [ :each | self addChunk: each ]
]

{ #category : 'accessing' }
RAGVectorStore >> chunks [

	^ chunks
]

{ #category : 'initialization' }
RAGVectorStore >> initialize [

	super initialize.
	chunks := OrderedCollection new.
	similarity := RAGCosineSimilarity new
]

{ #category : 'removing' }
RAGVectorStore >> removeChunksForDocumentId: aDocumentId [
	"Remove all chunks associated with the given document ID."

	chunks removeAllSuchThat: [ :chunk |
		chunk documentId = aDocumentId ]
]

{ #category : 'searching' }
RAGVectorStore >> search: queryEmbedding topK: anInteger [
	"Search for the top-K most similar chunks to the query embedding."

	| scored |
	scored := chunks
		          select: [ :chunk | chunk hasEmbedding ]
		          thenCollect: [ :chunk |
			          {
				          chunk.
				          (similarity between: queryEmbedding and: chunk embedding) } ].
	scored sort: [ :a :b | a second > b second ].
	^ (scored first: (anInteger min: scored size)) collect: [ :each |
		  each first ]
]

{ #category : 'searching' }
RAGVectorStore >> searchWithScores: queryEmbedding topK: anInteger [
	"Search and return chunks paired with their similarity scores."

	| scored |
	scored := chunks
		          select: [ :chunk | chunk hasEmbedding ]
		          thenCollect: [ :chunk |
			          {
				          chunk.
				          (similarity between: queryEmbedding and: chunk embedding) } ].
	scored sort: [ :a :b | a second > b second ].
	^ (scored first: (anInteger min: scored size)) collect: [ :each |
		  each first -> each second ]
]

{ #category : 'accessing' }
RAGVectorStore >> size [

	^ chunks size
]
