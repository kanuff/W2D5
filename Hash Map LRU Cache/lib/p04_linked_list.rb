require "byebug"
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail && @tail.prev == @head
    false
  end

  def get_node(key)
    node = @head

    until node.key == key
      node = node.next
      break if node.nil?
    end

    node
  end

  def get(key)
    node = get_node(key)
    return nil if node.nil?
    node.val
  end

  def include?(key)
    includes = false
    node = @head
    until includes 
      includes = true if node.key == key
      node = node.next
      break if node.nil?
    end
    return true if includes == true
    false
  end

  def append(key, val)
    node = Node.new(key, val)

    node.prev = @tail.prev
    node.next = @tail

    @tail.prev.next = node
    @tail.prev = node
    
  end

  def update(key, val)
      node = @head

      until node.key == key
        node = node.next
        break if node.nil?
        node.val = val if node.key == key
      end

  end

  def remove(key)
    node = get_node(key)
    node.prev.next, node.next.prev = node.next, node.prev
    node.next = nil
    node.prev = nil
  end

  def each
    node = first

    while node != @tail
      yield(node)
      node = node.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  def inspect
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
