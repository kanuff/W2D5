class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key, resize = false)
    hashed = key.hash
    if num_buckets == count
      resize!
    end

    if !include?(hashed)
      bucket = hashed % num_buckets
      @store[bucket] << hashed #if !@store[bucket].include?(num)
      @count += 1 unless resize == true
    end
  end

  def include?(key)
    hashed = key.hash
    bucket = hashed % num_buckets
    @store[bucket].each {|ele| return true if ele == hashed}
    false
  end

  def remove(key)
    hashed = key.hash
    bucket = hashed % num_buckets

    if include?(key)
      @store[bucket].delete(hashed)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
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


# class ResizingIntSet
#   attr_reader :count

#   def initialize(num_buckets = 20)
#     @store = Array.new(num_buckets) { Array.new }
#     @count = 0
#   end

#   def inspect
#     puts "store length: #{@store.length}, count: #{@count}"
#   end

#   def insert(num, resize = false)
#     if num_buckets == count
#       resize!
#     end

#     if !include?(num)
#       bucket = num % num_buckets
#       @store[bucket] << num #if !@store[bucket].include?(num)
#       @count += 1 unless resize == true
#     end
#   end

#   def remove(num)
#     if include?(num)
#       bucket = num % num_buckets
#       @store[bucket].delete(num)
#       @count -= 1
#     end
#   end

#   def include?(num)
#     bucket = num % num_buckets
#     @store[bucket].each {|ele| return true if ele == num}
#     false
#   end

#   private

#   def [](num)
#     # optional but useful; return the bucket corresponding to `num`
#   end

#   def num_buckets
#     @store.length
#   end

#   def resize!
#     # debugger
#     size = num_buckets
#     temp = [] 
#     @store.each {|bucket| temp += bucket}
#     size *= 2
#     @store = Array.new(size) { Array.new }

#     temp.each do |ele|
#       self.insert(ele, true)
#     end

#   end
# end
