require 'pry'

def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end
  
  number
end

times(5) do |num|
  puts num
end

# Build an each method

def each(array)
  counter = 0

  while counter < array.size
    yield(array[counter])                           # yield to the block, passing in the current element to the block
    counter += 1
  end

  array                                             # returns the `array` parameter, similar in spirit to how `Array#each` returns the caller
end

each([1, 2, 3, 4, 5]) do |num|
  puts num
end


puts " select method"

def select(array)
  counter = 0
  result = []

  while counter < array.size
    current_element = array[counter]
    result << current_element if yield(current_element)
    counter += 1
  end
  puts result
  result
end

array = [1, 2, 3, 4, 5]

puts select(array) { |num| num.odd? }      # => [1, 3, 5]
puts select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
puts select(array) { |num| num + 1 }  

# =============reduce ================
puts 'reduce'

def reduce(array, default=0)
  counter = 0
  accumulator = default
  
  while counter < array.size
    accumulator = yield(accumulator,array[counter])
    counter += 1
  end
  
  accumulator
end

array = [1, 2, 3, 4, 5]

puts reduce(array) { |acc, num| acc + num }                
puts reduce(array, 10) { |acc, num| acc + num }            
puts reduce(array) { |acc, num| acc + num if num.odd? }  