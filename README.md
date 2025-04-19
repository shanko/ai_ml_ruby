# AI/ML with Ruby

A collection of Ruby examples and utilities for working with various AI and Machine Learning tools and APIs.

## Overview

This repository contains a series of Ruby scripts demonstrating integration with different AI providers and tools. It serves as both a reference and a practical guide for developers looking to incorporate AI capabilities into their Ruby applications.

## Contents

This repository includes examples for working with:

- **OpenAI** - Examples of using GPT models via the OpenAI API
- **Ollama** - Local LLM integration with Ollama
- **Perplexity** - Using Perplexity AI in Ruby
- **Groq** - High-performance AI with Groq's API
- **Mistral AI** - Examples with Mistral models
- **LangChain** - Ruby implementation of LangChain concepts
- **Combined approaches** - Examples showing how to integrate multiple AI providers

## Requirements

- Ruby 3.0+
- Required gems (specific to each example)
- API keys for various services (OpenAI, Perplexity, Groq, Mistral, etc.)

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/shanko/ai_ml_ruby.git
   cd ai_ml_ruby
   ```

2. Install required gems:
   ```
   # Install specific gems needed for the examples you wish to run
   # gem install openai
   # gem install langchain
   # etc.
   ```

3. Set up your API keys as environment variables (recommended) or within the scripts for testing purposes.

## Usage

Each Ruby file in this repository demonstrates a specific AI integration or concept:

- `01_perplexity.rb` - Working with Perplexity AI
- `02_gpt_4o.rb` - Using OpenAI's GPT-4o model
- `03_ollama_ai.rb` - Local LLM integration with Ollama
- `04_openai.rb` - Basic OpenAI API integration
- `05_openai_ollama.rb` - Combining OpenAI and Ollama
- `06_granite_guardian.rb` - Granite Guardian example
- `07_ruby_llm.rb` - Ruby LLM utilities
- `08_groq_ai.rb` - Groq API integration
- `09_mistral_ai.rb` - Mistral AI examples
- `10_groq_response.rb` - Working with Groq responses
- `11_langchain.rb` - LangChain in Ruby
- `12_lc_image.rb` - LangChain with image processing

To run any example:

```
ruby 01_perplexity.rb
```

## Additional Resources

The repository includes supporting material:
- `reading_material.md` - Additional resources and documentation
- `intro_to_ai_ml_tools.pdf` - Introduction to AI/ML tools

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
