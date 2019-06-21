require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    hashed = key.hash
    bucket = hashed % num_buckets
    linkedList = @store[bucket]
    linkedList.include?(key)
  end

  def set(key, val, resize = false)
    resize! if num_buckets == @count

    hashed = key.hash
    bucket = hashed % num_buckets
    linkedList = @store[bucket]
    if linkedList.include?(key)
      linkedList.update(key, val)
    else
      linkedList.append(key, val)
      @count += 1 unless resize
    end
  end

  def get(key)
    bucket = key.hash % num_buckets
    @store[bucket].get(key)
  end

  def delete(key)
    hashed = key.hash
    bucket = hashed % num_buckets
    linkedList = @store[bucket]
    if linkedList.include?(key)
      linkedList.remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |list|
      node = list.first

      while node.key != :tail
        yield(node.key, node.val)
        node = node.next 
      end
    end
    
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    size = num_buckets
    temp = []
    size *= 2

    @store.each do |list|
      list.each do |node|
        temp << [node.key, node.val]
      end
    end

    @store = Array.new(size) { LinkedList.new }

    temp.each do |key, val|
      set(key, val, true)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end


  # def resize!
  #   size = num_buckets
  #   temp = @store.dup
  #   size *= 2

  #   @store = Array.new(size) { LinkedList.new }

  #   temp.each do |list|
  #     list.each do |key, val|
  #       set(key, val, true)
  #     end
  #   end      


    
  # end