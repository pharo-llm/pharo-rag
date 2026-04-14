Class {
	#name : 'BaselineOfRAG',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfRAG',
	#package : 'BaselineOfRAG'
}

{ #category : 'baselines' }
BaselineOfRAG >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'RAG';
			package: 'RAG-Tests' with: [ spec requires: #( 'RAG' ) ] ].

	spec
		group: 'default' with: #( 'RAG' 'RAG-Tests' );
		group: 'core' with: #( 'RAG' );
		group: 'tests' with: #( 'RAG-Tests' )
]
