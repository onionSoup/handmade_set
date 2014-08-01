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
          left_index_when_same = catch :same_item do
            indexes = (i..array.length - 1).to_a
            reverse_indexes = (0.. (array.length - (1+i))).to_a.reverse
            #reverse_indexes = ((array.length - (1+i))..0).to_a こうかけないので

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
              #[8,8,7,8]は最初に８と７を交換させないと駄目。
              #[8,8]は無限ループになるので抜け出す。
              #したがって、[8,8,8]
              throw :same_item, left_index if array[left_index] == array[right_index]

              if left_index < right_index
                array[left_index], array[right_index] = array[right_index], array[left_index]
              else
                #gotoで２つ上のforまで抜けたい
                throw :can_not_swap, left_index
              end
            end
            left_index
          end
        end
        left_index_when_same
      end

      #分割する。
      if left_index_when_crossed.class == Array
        left_index_when_last_crossed = left_index_when_crossed.last
      end

      left_array = array.slice 0, (left_index_when_last_crossed || left_index_when_crossed)
#right_array = array - left_array unless left_array.empty? だと同じ要素あったとこにこまる
      right_array = array.slice (left_index_when_last_crossed || left_index_when_crossed), array.length - 1

      binding.pry

      #再帰的に呼び出す
      my_quick_sort(left_array) unless left_array.empty?
      my_quick_sort(right_array) if right_array
    end

    #確定処理 インスタンスに格納する。
    #要素が１個だけの配列は、当然それ以上並び替えられないので格納する
    #要素が２個の場合は、[1,2]や[2,2]は並び替えるないので格納。[2,1]なら並び替えるので格納しない。
    #３つめは[1,2]や[2,2,3,4]のような、既に並べ終わっている場合。
    #再度並び変える必要がないので格納しない。
    if array.length == 1
      self.instance_array << array[0]
    end

    if array.size > 2 && array.uniq.length == 1
      array.each do |item|
        self.instance_array << item
      end
    elsif left_array
      if right_array.nil? && left_array.empty?
        array.each do |item|

          self.instance_array << item
        end
      end
    end
  end
end

#main
#array = [2, 2, 3, 7, 6, 8, 5, 8, 4, 8]
 #array = [8, 8, 7, 8]
  #array = [8,8]
  #array = [2, 2, 3, 4, 5, 6, 7, 8, 8, 8]
  #array = [2, 2, 3, 4, 5, 6, 7, 8, 8, 8]
  #array = [8, 4, 3, 7, 6, 5, 2, 1]
  #array = [8, 4, 3, 7, 6, 5, 2, 8]
  #array = [8, 4, 3, 7, 6, 5, 2, 2, 8, 8]
  #array = [8,8]
  #array = ['a', 'b', 'c', '4']
  array = ["b", "c"]
  q = QuickSort.new
  q.my_quick_sort(array)
  p q.instance_array








