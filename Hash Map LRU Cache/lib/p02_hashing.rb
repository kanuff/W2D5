class Integer
  # Integer#hash already implemented for you
end

class Array

  def hash
    base = []
    base << 1
    base << count
    base << self.first
    base << self.last


    self.each do |ele|
      if ele > 0
        base << ele 
      else
        base << ele * -1
      end
    end
    
    base = base.join("").to_i
    base.hash
  end
end

class String
  def hash
    number = 3
    self.each_char.with_index do |char, idx|
      number += char.to_i(base = 16) * idx
    end

    number.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    number = 3
    keys = self.keys.join("")
    keys.each_char.with_index do |char, idx|
      number += char.to_i(base = 16)
    end
    number.hash
  end
end
