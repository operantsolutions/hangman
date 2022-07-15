class Secret_Word
  attr_accessor :word, :chars  

  def initialize(word="new", chars="new")
    if word == "new" || chars == "new"
      dictionary = File.open("dictionary.txt", "r")
      all_words = dictionary.readlines
      five_to_twelve_words = []

      all_words.each do |word|
        if word.length > 4 && word.length < 13
          five_to_twelve_words.push(word)
        end
      end
      selection = five_to_twelve_words[(Random.rand(0..five_to_twelve_words.length))]
      self.word = selection[0...(selection.length - 1)]
      self.chars = []
      self.word.split("").each do |char|
        if self.chars.include?(char)
        else
          self.chars.push(char)
        end
      end
    else
      self.word = word
      self.chars = chars
    end
  end

  def to_yaml
    YAML.dump({
      :word => self.word,
      :chars => self.chars
    })
  end

end