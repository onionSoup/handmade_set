#文字列比較は'10' < '2'になったり、文字コード依存の比較になったりする。
#ただ、これが直感に反していようが、一貫したソートができれば
#二分探索するには十分。

module ArrayExtension
  refine Array do
    def quick_sort
      return self if length <= 1
      base = pop
      smaller, bigger = partition { |e| e < base }
      push base
      smaller.quick_sort + [base] + bigger.quick_sort
    end
  end
end
