
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!


require_relative 'todolist'

class ToDoListTest < Minitest::Test
  
  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

    # Your tests go here. Remember they must start with "test_"
    
    def test_size
      assert_equal(3, @list.size)
    end
    
    def test_first
      assert_equal(@todo1, @list.first)
    end
    
    def test_last
      assert_equal(@todo3, @list.last
    end
    
    def test_shift
      assert_equal(3, @list.size)
      assert_equal(@todo1, @list.shift)
      assert_equal(2, @list.size)
      assert_equal([@todo2,@todo3], @list.to_a)
    end
    
    def test_pop
       assert_equal(3, @list.size)
       assert_equal(@todo3, @list.pop)
       assert_equal([@todo1,@todo2], @list.to_a)
       assert_equal(2, @list.size)
     end
      
     def test_new_items_must_be_todo_object_raise_error
       assert_raises(TypeError) { @list.add(1) }
       assert_raises(TypeError) { @list.add ('hi') }
     end
     
     def test_add_alias
       new_todo = Todo.new("Walk the dog")
       @list << new_todo
       todos = @todos << new_todo

       assert_equal(todos, @list.to_a)
     end
     
     def test_item_at
       assert_equal(@todo1, @list.item_at(0))
       assert_equal(@todo2, @list.item_at(1))
       assert_raises(IndexError) { @list.item_at(100) }
     end
     
     def test_todo_done?
       assert_equal(false, @todo1.done?)
     end
     
     def test_item_done
       assert_equal(false, @todo1.done?)
       @todo1.done!
       assert_equal(true, @todo1.done?)
     end
     
     def test_list_done?
       assert_equal(false, @list.done?)
       @todo1.done!
       assert_equal(false, @list.done?)
       @todo2.done!
       @todo3.done!
       assert_equal(true, @list.done?)
     end
     
     def test_mark_done_at?
       assert_equal(false,@todo2.done?)
       @list.mark_done_at(1)
       assert_equal(true,@todo2.done?)
       assert_raises(IndexError) {@list.mark_done_at(100)}
     end
       
     def test_mark_undone_at?
       @list.mark_done_at(1)
       assert_equal(true,@todo2.done?)
       @list.mark_undone_at(1)
       assert_equal(false,@todo2.done?)
       assert_raises(IndexError) {@list.mark_undone_at(100)}
     end
     
     def test_list_done!
       assert_equal(false, @list.done?)
       @list.done!
       assert_equal(true,@list.done?)  
     end
     
     def test_remove_at
       assert_equal(3, @list.size)
       @list.remove_at(1)
       assert_equal(2, @list.size)
     end
     
     def test_to_s
       skip
       output = <<-OUTPUT.chomp.gsub /^\s+/, ""
       ---- Today's Todos ----
       [ ] Buy milk
       [ ] Clean room
       [ ] Go to gym
       OUTPUT

       assert_equal(output, @list.to_s)
     end
     
     def test_each_returns_original_ist
       assert_equal(@list, @list.each {|todo| nil })
     end
     
     def test_select
       @todo1.done!
       list = TodoList.new(@list.title)
       list.add(@todo1)

       assert_equal(list.title, @list.title)
       assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
     end
    
  end
  