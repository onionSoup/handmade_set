require 'timeout'
require_relative 'array_extension'

using ArrayExtension

class HandmadeSet
  include Enumerable

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
    @inner_hash = hash_quick_sort inner_hash
  end

  #Hash#has_value?を使わないために定義。
  #もう少しいい書き方がある気がする。
  #TODO:Hash自体を使わない場合、挿入位置まで求める必要がある。
  def binary_search(target, array)
    timeout(5) {
      while(true)
        mid_index = array.length / 2

        case target <=> array[mid_index]
        when -1
          return 'unfound' if array.length <= 1

          array = array.slice(0.. mid_index-1)
        when 0
          return 'found'
        when 1
          return 'unfound' if array.length <= 2

          array = array.slice(mid_index+1..array.length)
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
    @inner_hash = hash_quick_sort inner_hash
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

  def to_a
    @inner_hash.values
  end

  def each()
    @inner_hash.values.each do |item|
      yield item
    end
  end

  private
  #refineしたArray#quick_sortを使ってHashをrefineできないため、これで。
  def hash_quick_sort(hash)
    hash.keys.quick_sort.map {|key| [key, hash[key]] }.to_h
  end
end
