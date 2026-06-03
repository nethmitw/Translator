#Translator
# Translator (Ruby Language Processing System)

## Overview

This project is a Ruby-based language processing system that can store, analyze, and transform sentences across multiple languages using custom lexicons and grammar rules.

It supports loading language data from files, validating sentence structure, generating sentences from grammar rules, and translating text between languages while preserving grammatical structure.

## Features

* Load and update multilingual lexicon data from input files
* Parse and store grammar rules for multiple languages
* Generate valid sentences based on grammatical structures
* Check whether a sentence follows a language’s grammar rules
* Convert sentence structure between different grammars
* Translate sentences between supported languages
* Combine translation and grammar transformation logic

## How It Works

The system is built around three core components:

* **Lexicon:** Maps words to parts of speech and translations
* **Grammar Engine:** Defines valid sentence structures per language
* **Translator:** Handles sentence generation, validation, and translation

## Key Concepts

* Parts of Speech (POS) tagging
* Rule-based grammar parsing
* Cross-language word mapping
* Sentence structure transformation
* File-based data ingestion

## Technologies Used

* Ruby
* File I/O and text parsing
* Object-oriented programming (classes and modules)
* Data structure design for language mapping

## Usage

1. Load lexicon data using `updateLexicon(inputfile)`
2. Load grammar rules using `updateGrammar(inputfile)`
3. Use core methods such as:

   * `generateSentence(language, struct)`
   * `checkGrammar(sentence, language)`
   * `changeLanguage(sentence, language1, language2)`
   * `translate(sentence, language1, language2)`

## Notes

* Ignores malformed input lines during file parsing
* Supports multiple words per part of speech
* Designed for educational purposes in language processing and structured data manipulation

## Author

University of Maryland – CMSC 330 Project
