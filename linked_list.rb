class LinkedList
  include Enumerable
  
  attr_accessor :head, :tail
  
  def initialize
    @head = nil
    @tail = nil
  end
  
  def append(node)
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
  end
  
  def prepend(node)
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
  end
  
  def each
    return nil if @head.nil?
    
    data = @head
    until data.nil?
      yield data
      data = data.next_node
    end
  end
  
  def size
    self.count
  end
  
  def at(index)
    index = size - index.abs if index < 0
    self.each_with_index do |obj, idx|
      return obj if idx == index
    end
  end
  
  def pop
    return nil if @head.nil?
    value = at(-1)
    at(-2).next_node = nil
    value
  end
  
  def contains?(value)
    self.any? { |obj| obj.value == value }
  end
  
  def find(data)
    res = nil
    self.each_with_index { |obj, idx| return idx if obj.value == data }
    res
  end
  
  def insert_at(index, node)
    index = size - index.abs if index < 0
    
    if @head.nil?
      append(node)
    elsif index == 0
      node.next_node = @head
      @head = node
    elsif index == size
      @tail.next_node = node
      @tail = node
    else
      prev = at(index - 1)
      node.next_node = prev.next_node
      prev.next_node = node
    end
  rescue NoMethodError
    puts "Index is out of range!"
  end
    
  def remove_at(index)
    return nil if @head.nil?
    
    index = size - index.abs if index < 0
    
    if index == 0
      @head = @head.next_node
      @tail = nil if size == 0
    elsif index == size - 1
      @tail = at(index - 1)
      @tail.next_node = nil
    else
      at(index - 1).next_node = at(index).next_node
    end 
  rescue NoMethodError
    puts "Index is out of range!"
  end
  
  def to_s
    self.map { |obj| "( #{obj.value} )" }.join(' -> ') + ' -> nil'
  end
end


class Node
  attr_accessor :value, :next_node
  
  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end



capitals = LinkedList.new
kiev = Node.new("Kiev, Ukraine")
madrid = Node.new("Madrid, Spain")
london = Node.new("London, England")
paris = Node.new("Paris, France")
berlin = Node.new("Berlin, Germany")
stockholm = Node.new("Stockholm, Sweden")

capitals.append(kiev)
capitals.prepend(madrid)
capitals.append(london)
capitals.append(paris)

capitals.insert_at(2, berlin)
capitals.insert_at(5, stockholm)

#p capitals.size
#p capitals.at(-2)
#p capitals.pop
#capitals.each { |obj| p obj }
#p capitals.contains?("Berlin, Germany")
#p capitals.find("Paris, France")
#p capitals.to_s
#p capitals
#p capitals.head
#p capitals.tail
#capitals.remove_at(4)
#capitals.remove_at(3)
#capitals.remove_at(2)
#capitals.remove_at(1)
#capitals.remove_at(5)
