class binary_tree_array
  attr_accessor :array, :left_child_id, :right_child_id, :parent_id

  def initialize(array)
    @array = array
  end
end

  #pivot以上とpivot以下にarrayを分割する
  def my_quick_sort(array)
    return if array.size == 1

    pivot_index = array.length.odd? ? array.length / 2 : array.length / 2 - 1
    pivot = array[pivot_index]

    left_index_when_crossed = catch :can_not_swap_because_index_crossed do #すれ違った、ということ
      for i in (0..pivot_index).to_a

        indexes = (i..array.size - 1).to_a
        reverse_indexes = indexes.reverse

        while(true)
          for index in indexes
            if array[index] >= pivot
              left_index = index
              break
            end
          end

          for index in reverse_indexes

            if array[index] <= pivot
              right_index = index
              break
            end
          end

          if left_index < right_index
            array[left_index], array[right_index] = array[right_index], array[left_index]
          else
            #gotoで２つ上のforまで抜けたい
            throw :can_not_swap_because_index_crossed, left_index
          end
        end
      end
    end

    #分割する。
    left_array = array.slice 0, left_index_when_crossed
    right_array = array - left_array unless left_array.empty?

    #再帰的に呼び出す
    binding.pry
    my_quick_sort(left_array) unless left_array.empty?
    my_quick_sort(right_array) if right_array
  end

#main
#timeout(3){
  array = [8, 4, 3, 7, 6, 5, 2, 1]
  my_quick_sort(array)
  p array
