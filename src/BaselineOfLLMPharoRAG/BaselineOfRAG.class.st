Class {
	#name : 'BaselineOfLLMPharoRAG',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfLLMPharoRAG',
	#package : 'BaselineOfLLMPharoRAG'
}

{ #category : 'baselines' }
BaselineOfLLMPharoRAG >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'LLM-PharoRAG';
			package: 'LLM-PharoRAG-Tests' with: [ spec requires: #( 'LLM-PharoRAG' ) ] ].

]
