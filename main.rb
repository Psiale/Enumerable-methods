# frozen_string_literal: false

module Enumerable # :nodoc:
  def my_each
    if block_given?
      i = 0
      while self[i]
        yield self[i]
        i += 1
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      while self[i]
        yield(self[i], i)
        i += 1
      end
    else
      to_enum(:my_each_with_index)
    end
  end
end
