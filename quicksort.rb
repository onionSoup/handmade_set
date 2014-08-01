def quicksort(array)
  mid_index = array.length / 2

  pivot = array[mid_index]

  #pointerだと誤解されそうなので、cursorにした

  left_cursor = 0
  right_cursor = array.size - 1

  while(left_cursor < right_cursor)
    if array[left_cursor] < pivot
      left_cursor += 1
    else
      left_index_to_swap = left_cursor
    end

    if array[right_cursor] > pivot
      right_cursor -= 1
    else
      right_index_to_swap = right_cursor
    end
  end

  #swap
  ##array[left_cursor], array[right_cursor] = array[right_cursor], array[left_cursor]

  ##separator = left_cursor - 1

end

