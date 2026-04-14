Class {
	#name : 'RAGPipelineTest',
	#superclass : 'TestCase',
	#category : 'LLM-PharoRAG-Tests',
	#package : 'LLM-PharoRAG-Tests'
}

{ #category : 'tests' }
RAGPipelineTest >> testAddTextAndQuery [

	| pipeline result |
	pipeline := RAGPipeline embedder: RAGHashEmbedder new.
	pipeline addText: 'Pharo is a pure object-oriented programming language and a powerful environment, focused on simplicity and immediate feedback.'.
	pipeline addText: 'Python is a high-level general-purpose programming language with dynamic typing and garbage collection.'.
	pipeline addText: 'Retrieval Augmented Generation combines retrieval with language model generation.'.
	result := pipeline query: 'Tell me about Pharo'.
	self assert: (result isKindOf: RAGResult).
	self assert: result chunks isNotEmpty.
	self assert: (result prompt includesSubstring: 'Tell me about Pharo')
]

{ #category : 'tests' }
RAGPipelineTest >> testAddDocument [

	| pipeline doc |
	pipeline := RAGPipeline embedder: RAGHashEmbedder new.
	doc := RAGDocument content: 'Some document content here.'.
	pipeline addDocument: doc.
	self assert: pipeline vectorStore size > 0
]

{ #category : 'tests' }
RAGPipelineTest >> testPromptContainsContext [

	| pipeline result |
	pipeline := RAGPipeline embedder: RAGHashEmbedder new.
	pipeline addText: 'Pharo Smalltalk is amazing for live programming.'.
	result := pipeline query: 'What is Pharo?'.
	self assert: (result prompt includesSubstring: 'Context:').
	self assert: (result prompt includesSubstring: 'Question:')
]

{ #category : 'tests' }
RAGPipelineTest >> testCustomPromptTemplate [

	| pipeline result |
	pipeline := RAGPipeline embedder: RAGHashEmbedder new.
	pipeline promptTemplate: 'Context: {context} | Query: {query}'.
	pipeline addText: 'Hello world test content.'.
	result := pipeline query: 'Hello'.
	self assert: (result prompt includesSubstring: 'Context:').
	self assert: (result prompt includesSubstring: '| Query: Hello')
]
