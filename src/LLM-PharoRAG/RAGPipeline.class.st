Class {
	#name : 'RAGPipeline',
	#superclass : 'Object',
	#instVars : [
		'splitter',
		'embedder',
		'vectorStore',
		'retriever',
		'promptTemplate'
	],
	#category : 'LLM-PharoRAG-Pipeline',
	#package : 'LLM-PharoRAG',
	#tag : 'Pipeline'
}

{ #category : 'instance creation' }
RAGPipeline class >> embedder: anEmbedder [
	"Create a pipeline with an embedder and default settings."

	^ self new
		  embedder: anEmbedder;
		  yourself
]

{ #category : 'adding' }
RAGPipeline >> addDocument: aRAGDocument [
	"Process a document: split into chunks, compute embeddings, and store."

	| chunks |
	chunks := splitter splitDocument: aRAGDocument.
	embedder embedChunks: chunks.
	vectorStore addChunks: chunks.
	^ chunks
]

{ #category : 'adding' }
RAGPipeline >> addDocuments: aCollection [
	"Add multiple documents to the pipeline."

	^ aCollection flatCollect: [ :doc | self addDocument: doc ]
]

{ #category : 'adding' }
RAGPipeline >> addText: aString [
	"Convenience method: create a document from text, process and store it."

	^ self addDocument: (RAGDocument content: aString)
]

{ #category : 'prompting' }
RAGPipeline >> buildPromptFor: aQuery withContext: contextChunks [
	"Build a prompt using the template, injecting context and query."

	| context |
	context := String cr join:
		           (contextChunks collect: [ :chunk | chunk content ]).
	^ (promptTemplate
		   copyReplaceAll: '{context}'
		   with: context)
		  copyReplaceAll: '{query}'
		  with: aQuery
]

{ #category : 'accessing' }
RAGPipeline >> embedder [

	^ embedder
]

{ #category : 'accessing' }
RAGPipeline >> embedder: anEmbedder [

	embedder := anEmbedder.
	retriever embedder: anEmbedder
]

{ #category : 'initialization' }
RAGPipeline >> initialize [

	super initialize.
	splitter := RAGTextSplitter new.
	vectorStore := RAGVectorStore new.
	retriever := RAGRetriever
		             vectorStore: vectorStore
		             embedder: nil.
	promptTemplate := 'Use the following context to answer the question.

Context:
{context}

Question: {query}

Answer:'
]

{ #category : 'accessing' }
RAGPipeline >> promptTemplate [

	^ promptTemplate
]

{ #category : 'accessing' }
RAGPipeline >> promptTemplate: aString [

	promptTemplate := aString
]

{ #category : 'querying' }
RAGPipeline >> query: aQueryString [
	"Retrieve relevant context for the query. Returns an association:
	 #context -> collection of chunks, #prompt -> the built prompt string."

	| contextChunks prompt |
	contextChunks := retriever retrieve: aQueryString.
	prompt := self buildPromptFor: aQueryString withContext: contextChunks.
	^ RAGResult new
		  query: aQueryString;
		  chunks: contextChunks;
		  prompt: prompt;
		  yourself
]

{ #category : 'removing' }
RAGPipeline >> removeDocumentId: aDocumentId [
	"Remove all chunks for the given document from the store."

	vectorStore removeChunksForDocumentId: aDocumentId
]

{ #category : 'accessing' }
RAGPipeline >> retriever [

	^ retriever
]

{ #category : 'accessing' }
RAGPipeline >> splitter [

	^ splitter
]

{ #category : 'accessing' }
RAGPipeline >> splitter: aTextSplitter [

	splitter := aTextSplitter
]

{ #category : 'accessing' }
RAGPipeline >> vectorStore [

	^ vectorStore
]
