# frozen_string_literal: false

module Enumerable # :nodoc:
  def my_each
    if block_given?
      i = 0
      while self[i]
        yield self[i]
        i += 1
      end
    end
    to_enum
  end

  def my_each_with_index
    if block_given?
      i = 0
      while self[i]
        yield(self[i], i)
        i += 1
      end
    end
    to_enum
  end
end
