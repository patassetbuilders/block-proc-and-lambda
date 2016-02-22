
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
    
    def test_to_a
      skip
      assert_equal(@todos, @list.to_a)
    end
    
  
    
  end