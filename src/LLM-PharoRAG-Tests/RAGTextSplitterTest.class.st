Class {
	#name : 'RAGTextSplitterTest',
	#superclass : 'TestCase',
	#category : 'LLM-PharoRAG-Tests',
	#package : 'LLM-PharoRAG-Tests'
}

{ #category : 'tests' }
RAGTextSplitterTest >> testDefaultValues [

	| splitter |
	splitter := RAGTextSplitter new.
	self assert: splitter chunkSize equals: 500.
	self assert: splitter chunkOverlap equals: 50
]

{ #category : 'tests' }
RAGTextSplitterTest >> testSplitShortText [

	| splitter result |
	splitter := RAGTextSplitter chunkSize: 100.
	result := splitter split: 'Hello world'.
	self assert: result size equals: 1.
	self assert: result first equals: 'Hello world'
]

{ #category : 'tests' }
RAGTextSplitterTest >> testSplitLongText [

	| splitter text result |
	splitter := RAGTextSplitter chunkSize: 50 overlap: 0.
	text := String cr join:
		        ((1 to: 10) collect: [ :i |
			         'This is line number ' , i printString
			         , ' of the document.' ]).
	result := splitter split: text.
	self assert: result size > 1
]

{ #category : 'tests' }
RAGTextSplitterTest >> testSplitDocument [

	| splitter doc chunks |
	splitter := RAGTextSplitter chunkSize: 20 overlap: 0.
	doc := RAGDocument content: 'First line.
Second line.
Third line.'.
	chunks := splitter splitDocument: doc.
	self assert: chunks isNotEmpty.
	self assert: (chunks allSatisfy: [ :c | c isKindOf: RAGChunk ]).
	self assert: (chunks allSatisfy: [ :c | c documentId = doc id ])
]
