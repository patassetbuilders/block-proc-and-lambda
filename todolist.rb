# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.
require 'pry'

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(to_do)
    if to_do.class.to_s == 'Todo'  
      @todos  << to_do
    else
      raise TypeError, 'You can only add Todo objects'
    end
  end
  
  def <<(to_do) #aliased to add
    add(to_do)
  end
  
  def size
    @todos.size
  end
  
  def first
    @todos.first
  end

  def last
    @todos.last
  end
  
  def item_at(position)
    if position > @todos.size
      raise IndexError
    else
      @todos[position]
    end
  end
  
  def mark_done_at(position)
    if position > @todos.size
      raise IndexError
    else
      @todos[position].done!
    end
  end

  def mark_undone_at(position)
    if position > @todos.size
      raise IndexError
    else
      @todos[position].undone!
    end
  end
  
  def shift
      @todos.shift
  end
  
  def pop
      @todos.pop
  end
  
  def remove_at(position)
    if position > @todos.size
      raise IndexError
    else
      @todos.delete_at(position)
    end
  end
  
  def to_s
    puts "---- #{@title} ----"
    @todos.each do |todo|
      puts todo
    end
  end
  
  def each
    @todos
    counter = 0 
    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end
    self
  end
  
  def select #returning a todolistobject
    completed_items = TodoList.new('Completed Items')
    @todos.each do |todo|
      completed_items.add(todo) if yield(todo)
    end
    completed_items
  end
  
  def find_by_title(todo_title)
    @todos.each do |todo|
      if  todo.title.downcase == todo_title.downcase
         return todo 
       end
    end
    nil
  end
  
  def done? 
    @todos.each do |todo|
      return false if todo.done == false
    end
    true
  end
  
  def all_done # returns a lsit of completed items
    all_completed_items = TodoList.new('All Completed Items')
    @todos.each do |todo|
      all_completed_items.add(todo) if todo.done?
    end
    all_completed_items
  end
  
  def all_not_done # returns a list of open items
    all_open_items = TodoList.new('All Open Items')
    @todos.each do |todo|
      all_open_items.add(todo) if !todo.done?
    end
    all_open_items
  end
  
  def mark_done!(todo_title) # given a title it marks the item done
    item = self.find_by_title(todo_title)
    if item
      item.done!
    else
      raise "error item not found"
    end
    self
  end
  
  def done!
    @todos.each do |todo|
      todo.done!
    end
    self
  end
  
  def mark_all_undone!
    @todos.each do |todo|
      todo.undone!
    end
    self
  end
  
  def to_a
    @todos
  end
  
end


class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end


#  todo1 = Todo.new("Buy milk","make sure it is full cream milk")
#  todo2 = Todo.new("Clean room")
#  todo3 = Todo.new("Go to gym")
#  
#  puts todo1
#  puts todo2
#  puts todo3
#  
#  list = TodoList.new("Todays todo")
#  list.add(todo1)
#  list.add(todo2)
#  list.add(todo3)
#  
#  puts list.size
#  
#  puts list.first.inspect
#  puts list.last.inspect
#  
#  list.to_s
#  
#  puts "=========each==========="
#  
#  list.each do |todo|
#    puts todo
#  end
#  
#  puts ''
#  puts "============select==========="
#  
#  todo1.done!
#  
#  results = list.select { |todo| todo.done? }    # you need to implement this method
#  puts results.inspect
#  puts ''
#  puts results.to_s
#  
#  puts ''
#  # =========all completed items ========
#  finished_items = list.all_done
#  puts finished_items
#  
#  puts ''
#  # =========all not_done ========
#  open_items = list.all_not_done
#  puts open_items
#  
#  puts ''
#  puts  '============ find by title ========='
#  searching = list.find_by_title('buy milk')
#  puts searching
#  
#  
#  puts ''
#  puts  '============ mark done  ========='
#  todo1.undone!
#  searching = list.mark_done!('buy milk')
#  puts searching.inspect
#  
#  #list.mark_done!('this item is not in the list')
#  
#  puts '=========mark all done ====='
#  list.mark_all_done!
#  
#  puts list
#  
#  puts '=========mark all undone ========='
#  list.mark_all_undone!
#  
#  puts list