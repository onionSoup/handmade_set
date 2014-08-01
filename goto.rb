catch :label do
  puts "This will print"
  throw :label
  puts "This will not print"
end

=begin
catch :label do
  p 'hi'
  for i in (0..Float::INFINITY).to_a
    p i
    throw :label if i > 10
  end
  p 'end'
  exit
 end
=end

sym = catch :label do
  throw :label, :hihi
end

binding.pry


