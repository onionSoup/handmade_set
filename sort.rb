require 'pry'
=begin
#これだと[1,9,8,1]がおかしい結果を返す。
class Array
  def quicksort
    return self if self.length <= 1
    pivot = (self[0] < self[1])? self[1] : self[0]
    left = []
    right = []

    (1..self.length - 1).each do |i|
      if self[i] <= pivot
        left << self[i]
      else
        right << self[i]
      end
    end

    sorted_left = left.quicksort
    sorted_right = right.quicksort
    return sorted_left + [pivot] + sorted_right
  end
=end

#=begin
class Array
  def quick_sort
    return self if length <= 1
    base = pop
    smaller, bigger = partition { |e| e < base }
    push base
    smaller.quick_sort + [base] + bigger.quick_sort
  end
end
#=end
