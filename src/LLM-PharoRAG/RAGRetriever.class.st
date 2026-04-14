Class {
	#name : 'RAGRetriever',
	#superclass : 'Object',
	#instVars : [
		'vectorStore',
		'embedder',
		'topK'
	],
	#category : 'LLM-PharoRAG-Retrieval',
	#package : 'LLM-PharoRAG',
	#tag : 'Retrieval'
}

{ #category : 'instance creation' }
RAGRetriever class >> vectorStore: aVectorStore embedder: anEmbedder [

	^ self new
		  vectorStore: aVectorStore;
		  embedder: anEmbedder;
		  yourself
]

{ #category : 'accessing' }
RAGRetriever >> embedder [

	^ embedder
]

{ #category : 'accessing' }
RAGRetriever >> embedder: anEmbedder [

	embedder := anEmbedder
]

{ #category : 'initialization' }
RAGRetriever >> initialize [

	super initialize.
	topK := 3
]

{ #category : 'retrieving' }
RAGRetriever >> retrieve: aQuery [
	"Retrieve the most relevant chunks for the given query string."

	| queryEmbedding |
	queryEmbedding := embedder embed: aQuery.
	^ vectorStore search: queryEmbedding topK: topK
]

{ #category : 'retrieving' }
RAGRetriever >> retrieveWithScores: aQuery [
	"Retrieve the most relevant chunks with similarity scores."

	| queryEmbedding |
	queryEmbedding := embedder embed: aQuery.
	^ vectorStore searchWithScores: queryEmbedding topK: topK
]

{ #category : 'accessing' }
RAGRetriever >> topK [

	^ topK
]

{ #category : 'accessing' }
RAGRetriever >> topK: anInteger [

	topK := anInteger
]

{ #category : 'accessing' }
RAGRetriever >> vectorStore [

	^ vectorStore
]

{ #category : 'accessing' }
RAGRetriever >> vectorStore: aVectorStore [

	vectorStore := aVectorStore
]
