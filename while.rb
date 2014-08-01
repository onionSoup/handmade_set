class QuickSort
  attr_accessor :quick_sort_call_counter, :instance_array

  def initialize
    @quick_sort_call_counter = 0
    @instance_array = []
  end

 #pivot以上とpivot以下にarrayを分割する

  def my_quick_sort(array)
    @quick_sort_call_counter += 1

    unless array.size == 1 #[2,2]も並び替え不要だがleft_indexはほしい #array.uniq.length == 1 #[1]や[2,2]の場合並び替えは不要
      pivot_index = array.length.odd? ? array.length / 2 : array.length / 2 - 1
      pivot = array[pivot_index]

      left_index_when_crossed = catch :can_not_swap do #すれ違った、ということ
        for i in (0..pivot_index).to_a
          indexes = (i..array.length - 1).to_a
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

            #同じ要素を交換させると、無限ループになるので抜け出す。
            throw :can_not_swap, left_index if array[left_index] == array[right_index]

            if left_index < right_index
              array[left_index], array[right_index] = array[right_index], array[left_index]
            else
              #gotoで２つ上のforまで抜けたい
              throw :can_not_swap, left_index
            end
          end
        end
      end

      #分割する。
      left_array = array.slice 0, left_index_when_crossed
      right_array = array - left_array unless left_array.empty?

      #再帰的に呼び出す
      my_quick_sort(left_array) unless left_array.empty?
      my_quick_sort(right_array) if right_array
    end

    #確定処理 インスタンスに格納する。
    #要素が１個だけの配列は、当然それ以上並び替えられないので格納する
    #要素が２個の場合は、[1,2]や[2,2]は並び替えるないので格納。[2,1]なら並び替えるので格納しない。
    #要素が２個以上の配列は、[2,2]なら並びかえられないので格納。一方[2,1,2]は並び替えるので格納しない。
    if array.length == 1
      self.instance_array << array[0]
    end
    if array.size > 2 && array.uniq.length == 1
      array.each do |item|
        self.instance_array << item
      end
    end
    if array.length == 2 && array[0] <= array[1]
      self.instance_array << array[0] << array[1]
    end
  end
end

#main
  array = [8, 4, 3, 7, 6, 5, 2, 1]
  #array = [8, 4, 3, 7, 6, 5, 2, 8]
  #array = [8,8]
  q = QuickSort.new
  q.my_quick_sort(array)
  p q.quick_sort_call_counter
  p q.instance_array








