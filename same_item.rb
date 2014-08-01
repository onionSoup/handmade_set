array = [7,8,8]
pivot = 8
indexes = [0,1,2]

for index in indexes
  if array[index] >= pivot
    left_index = index
    break
  end
end

p left_index
