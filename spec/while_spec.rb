def same_as_buildin_when(input)
  array = Marshal.load(Marshal.dump(input))
  QuickSort.new.my_quick_sort(array)
  it {expect(array).to eq input.sort }
end

describe 'nanika' do
  describe '#quick_sort' do
    context 'input has same item' do
      input = [2, 2, 3, 7, 6, 8, 5, 8, 4, 8]
      same_as_buildin_when(input)
    end
  end
end
