require "byebug"
class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.length && num >= 0
  end

  def validate!(num)
  end

end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % num_buckets
    @store[bucket] << num # unless @store.include?(num)
  end

  def remove(num)
    bucket = num % num_buckets
    @store[bucket].delete(num)
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].each { |ele| return true if ele == num }
    false 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def inspect
    puts "store length: #{@store.length}, count: #{@count}"
  end

  def insert(num, resize = false)
    if num_buckets == count
      resize!
    end

    if !include?(num)
      bucket = num % num_buckets
      @store[bucket] << num #if !@store[bucket].include?(num)
      @count += 1 unless resize == true
    end
  end

  def remove(num)
    if include?(num)
      bucket = num % num_buckets
      @store[bucket].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].each {|ele| return true if ele == num}
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    # debugger
    size = num_buckets
    temp = [] 
    @store.each {|bucket| temp += bucket}
    size *= 2
    @store = Array.new(size) { Array.new }

    temp.each do |ele|
      self.insert(ele, true)
    end

  end
end
