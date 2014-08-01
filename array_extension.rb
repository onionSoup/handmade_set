module ArrayExtension
  refine Array do
    def swap_by_index(a, b)
      unless a.between?(0, self.size) && b.between?(0, self.size)
        raise "#{__method__}で要素外アクセスしてます"
      end

      self[a], self[b] = self[b], self[a]
    end
  end
end
