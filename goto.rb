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

catch :out do
  for i in [1,2,3]
    catch :in do
      for j in %w(a b c )
        throw :in if j == 'b'
        p i
        p j
      end
    end
  end
  p :iのループの外
end
