require_relative '../array_extension'

using ArrayExtension

describe 'Array#quick_sort' do
  context 'when array includes same item' do
    array = [1,3,2,3,2,1,3].quick_sort
    it { expect(array).to eq [1,1,2,2,3,3,3] }
  end

  context 'when array includes string' do
    array = %w(c d a b).quick_sort
    it { expect(array).to eq %w(a b c d) }
  end

  context 'when array indeludes same string' do
    array = %w(a c c b d).quick_sort
    it { expect(array).to eq %w(a b c c d) }
  end

  #てっとり速く広く探せるけど、ランダムなテストって良くなかったような...
  context 'array has rand rumber' do
    array = (0..INDEX_MAX).map { Random.rand ITEM_MAX }

    rand(array.length).times do
      index_of_original, index_of_clone = (0..(array.length - 1)).to_a.sample(2)
      array[index_of_clone] = array[index_of_original]
    end
    #時々arrayがnilを含んでいたけど、(0..(array.length）を (0..(array.length - 1)にしたらなくなった気がする。
    it { expect(array.quick_sort).to eq array.sort }
  end
end

