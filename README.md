# Pharo-RAG

## Overview

Pharo-RAG provides a modular Retrieval Augmented Generation (RAG) pipeline for Pharo. It allows you to ingest documents, split them into chunks, compute embeddings, store them in a vector store, and retrieve relevant context to augment LLM prompts.

## Installation

```smalltalk
Metacello new
  baseline: 'RAG';
  repository: 'github://pharo-llm/pharo-rag:main/src';
  load.
```

## Quick Start

```smalltalk
"Create a pipeline with a hash-based embedder (for testing)"
pipeline := RAGPipeline embedder: RAGHashEmbedder new.

"Add documents"
pipeline addText: 'Pharo is a pure object-oriented programming language focused on simplicity and immediate feedback.'.
pipeline addText: 'Retrieval Augmented Generation combines document retrieval with language model generation.'.

"Query the pipeline"
result := pipeline query: 'What is Pharo?'.
result prompt. "Returns the prompt with injected context, ready to send to an LLM"
result chunks. "Returns the retrieved RAGChunk objects"
```

## Architecture

The package is organized into the following components:

| Class | Role |
|---|---|
| `RAGDocument` | Represents a document with content and metadata |
| `RAGChunk` | A chunk of a document, with optional embedding vector |
| `RAGTextSplitter` | Splits documents into chunks with configurable size and overlap |
| `RAGEmbedder` | Abstract embedder — subclass to integrate any embedding API |
| `RAGHashEmbedder` | Simple hash-based embedder for testing (no external API needed) |
| `RAGCosineSimilarity` | Cosine similarity computation between vectors |
| `RAGVectorStore` | In-memory vector store with similarity search |
| `RAGRetriever` | Retrieves the top-K most relevant chunks for a query |
| `RAGPipeline` | End-to-end pipeline: ingest, embed, store, retrieve, build prompt |
| `RAGResult` | Holds query results: chunks, prompt, and optional answer |

## Custom Embedder

To use a real embedding API, subclass `RAGEmbedder` and override `#embed:`:

```smalltalk
RAGEmbedder >> embed: aString
  "Return an array of floats representing the embedding vector."
  ^ self subclassResponsibility
```