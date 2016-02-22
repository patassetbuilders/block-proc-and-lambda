def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
puts "#{chunk_of_code} line seven"

puts '==========='
puts chunk_of_code.call

name = "Griffin III"   
puts chunk_of_code.call     # re-assign name after Proc initialization
