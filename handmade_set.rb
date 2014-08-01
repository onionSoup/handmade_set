class HandmadeSet
require 'timeout'
require "#{File.expand_path(File.dirname(__FILE__))}/array_extension"

attr_accessor :inner_hash

  def initialize(args)
    inner_hash = {}

    args.each do |arg|
      #二分探索するために、ソートしたい。
      #ソートをするために、全要素を文字列にしたい。
      #1と '1'は一緒に集合（Set）の要素になれるので、keys = arg.to_sでは駄目。
      key = "#{arg.to_s}_#{arg.class}"

      inner_hash[key] = arg
    end
      #'10' < '2'になったり、文字コード依存の比較になったりする。
      #ただ、これが直感に反していようが、一貫したソートができれば
      #二分探索するには十分。

      #sortは後で自分で書き直す（できれば、Hash自体使わないように...）

      @inner_hash = inner_hash.sort.to_h
  end

  #Hash#has_value?を使わないために定義。
  #もう少しいい書き方がある気がする。
  #TODO:Hash自体を使わない場合、挿入位置まで求める必要がある。
  def binary_search(target, array)
    timeout(5){
      while(true)
        mid_index = array.length / 2

        case target <=> array[mid_index]
        when -1
          return 'unfound' if array.length <= 1

          array = array.slice!(0.. mid_index-1)
        when 0
          return 'found'
        when 1
          return 'unfound' if array.length <= 2

          array = array.slice!(mid_index+1..array.length)
        else
          raise "bug in #{__method__}"
        end
      end
    }
  end

  def add(target)
    key = "#{target.to_s}_#{target.class}"

    return @inner_hash if binary_search(key, @inner_hash.keys) == 'found'

    @inner_hash[key] = target
    @inner_hash = inner_hash.sort.to_h
  end

  alias << add

  def include?(target)
    key = "#{target.to_s}_#{target.class}"
    binary_search(key, @inner_hash.keys) == 'found' ? true : false
  end

  def delete(target)
    key = "#{target.to_s}_#{target.class}"
    h.delete(key)
  end

  def quicksort(array)
    mid_index = array.length / 2 - 1

    pivot = array[mid_index]

    #pointerだと誤解されそうなので、cursorにした

    left_cursor = 0
    right_cursor = array.size - 1

    if array[left_cursor] >= pivot
      swap_left_item = array[left_cursor]
    end

    if array[right_cursor] <= pivot
      swap_right_item = array[right_cursor]
    end



    while(true || left_cursor < right_cursor) #てきとう
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

  def get_pivot(array)
    pivot_index = array.length / 2 - 1
    array[pivot_index]
  end

  def left_index_for_swap(array, pivot)
    array.each_with_index do |item, index|
      return index if item >= pivot
    end
  end

  def right_index_for_swap(array, pivot)
    array.each_with_index.reverse_each do |item, index|
      return index if item <= pivot
    end
  end

  def can_swap?(left_index, right_index)
    left_index < right_index
  end

  def swap(array, right_index, left_index)
    array[left_index], array[right_index] = array[right_index], array[left_index]
  end

  def can_devide?(array)
    array.size > 1
  end

  def devide(array, left_index)
    left_array = array.slice(0, left_index)
    right_array = array - left_array

    {left_array: left_array, right_array: right_array}
  end

  def can_divide?(array)
    array.size >= 2
  end

  def decided?(array)
    array.size == 1
  end


  def saiki(result)
    array = [8, 4, 3, 7, 6, 5, 2, 1]

    pivot = get_pivot(array)

    #classのメンバにしたほうが良さそう
    left_index = left_index_for_swap(array, pivot)
    right_index = right_index_for_swap(array, pivot)

    while array.can_swap? left_index, right_index
      left_index = left_index_for_swap(array, pivot)
      right_index = right_index_for_swap(array, pivot)

      swap(array, left_index, right_index)
    end

    if can_devide?(array)
      arraies = devide(array, left_index)

      saiki(arraies[:left_array])
      saiki(arraies[:right_array])
    else
      :decided
    end
  end
end
