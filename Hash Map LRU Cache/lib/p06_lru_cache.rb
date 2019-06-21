require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"
class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # debugger
    if @store.include?(key)
      
      node = @store.get_node(key)
      update_node!(node)
      @map.get(key)
    else
      result = calc!(key)
      @map.set(key, result)
      @store.append(key, result)
      eject! if count > @max
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    temp_node = node

    @store.remove(node.key)
    @store.append(temp_node.key, temp_node.val)
  end

  def eject!
    @store.remove(@store.first.key)
  end
end
