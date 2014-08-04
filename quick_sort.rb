class Array
  def quick_sort
    return self if length <= 1
    base = pop

    begin
    smaller, bigger = partition { |e| e < base }
    rescue
      binding.pry
    end
    push base
    smaller.quick_sort + [base] + bigger.quick_sort
  end
end

class Hash
  def quick_sort
    self.keys.quick_sort.map {|key| [key, self[key]] }.to_h
  end
end
