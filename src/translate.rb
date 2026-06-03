class Translator
  class Words
    def initialize(word, pos, translations)
      @word = word
      @POS = pos
      @translations = translations
    end

    def getWord
      @word
    end

    def getPOS
      @POS
    end

    def getTranslations
      @translations
    end

    def updateTranslations(translation)
      @translations.merge(translation)
    end
  end

  def initialize(words_file, grammar_file)
    @Words = Array.new
    @Grammar = Hash.new
    updateGrammar(grammar_file)
    updateLexicon(words_file)
  end

  # part 1

  def updateLexicon(inputfile)
    file = File.open(inputfile)
    line = file.gets 
    while line  
      if line =~ /^([a-z\-]+), ([A-Z]{3})((, ([A-Z][a-z0-9]+):([a-z\-]+))+)$/
        word = $1
        pos = $2
        arr = line.scan(/, ([A-Z][a-z0-9]*):([a-z\-]+)/)
        translation = arr.to_h
        lexicon = Words.new(word, pos, translation)
       if @Words.include?(lexicon)
        @Words[@Words.index(lexicon)].updateTranslations(translation)
       else
        @Words.push(lexicon)
       end
      end
      line = file.gets
    end
  end

  def updateGrammar(inputfile)
    file = File.open(inputfile)
    line = file.gets
    while line
      if line =~ /^([A-Z][a-z0-9]*): ([A-Z].*)/
        lang = $1
        gram = $2
        arr2 = gram.split(", ")
        grammar = Array.new
        arr2.each do |i|  
          if i =~ /(([A-Z]{3})({(\d)})?)/
            arr = i.scan(/(([A-Z]{3})({(\d)})?)/)
            pos = arr[0][1]
            dup = arr[0][3]
            dup == nil ? dup = 1 : dup = dup
            for j in 0...dup.to_i
              grammar.push(pos)
            end
          end
        end
      end
      @Grammar.store(lang, grammar)
      line = file.gets
    end
  end

  # part 2

  def generateSentence(language, struct)
    sentence = Array.new
    arr = struct.class == String ? @Grammar[struct] : struct
    if arr == nil
      return nil
    end
    arr.each do |i|
      if getWords(language, i) == []
        return nil
      end
      sentence.push(getWords(language, i).sample)
    end
    return sentence.join(" ")
  end

  def checkGrammar(sentence, language)
    sent = sentence.split(" ")
    grammar = @Grammar[language]
    if sent.length != grammar.length
      return false
    end
    for i in 0...sent.length
        word = getWords(language, grammar[i])
       if !word.include?sent[i]
        return false
       end
    end
    return true
  end

  def changeGrammar(sentence, struct1, struct2)
    arr = struct1.class == String ? @Grammar[struct1] : struct1
    arr2 = struct2.class == String ? Array.new(@Grammar[struct2]) : struct2
    if sentence == nil
      return nil
    end
    sent = sentence.split(" ")
    changed = Array.new
    if arr.sort != arr2.sort
      return nil
    else
      for i in 0...arr.length
        for j in 0...arr2.length
          if arr2[j] != nil and arr[i] == arr2[j]
            changed[j] = sent[i]
            arr2[j] = nil
            break
          end
        end
      end
      return changed.length == sent.length ? changed.join(" ") : nil
    end
  end

  # part 3

  def changeLanguage(sentence, language1, language2)
    if sentence == nil
      return nil
    end
    sent = sentence.split(" ")
    changed = Array.new
    sent.each do |i|
      for j in @Words
        if j.getWord == i or j.getTranslations[language1] == i
          if language2 == "English"
            translation = j.getWord
          else
            translation = j.getTranslations[language2]
          end
          translation ? changed.push(translation) : nil
        end
      end
    end
    return changed.size == sent.size ? changed.join(" ") : nil
  end

  def translate(sentence, language1, language2)
    changeLanguage(changeGrammar(sentence,language1, language2), language1, language2)
  end

  def getWords(language, pos)
    word = Array.new
    @Words.each do |i|
      if i.getPOS == pos and (i.getTranslations.keys.include?(language) or language == "English")
        if language == "English"
          word.push(i.getWord)
        else
          word.push(i.getTranslations[language])
        end
      end
    end
      return word 
  end
end

