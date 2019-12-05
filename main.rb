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

  def my_select
    result = []
    if block_given?
      my_each { |element| result << element if yield element }
      result
    else
      to_enum(:my_select)
    end
  end

  def my_all?
    if block_given?
      my_each { |element| return false unless yield element }
      true
    else
      to_enum(:my_all)
    end
  end

  def my_any?
    if block_given?
      my_each { |element| return true if yield element }
      false
    else
      to_enum(:my_any)
    end
  end
end
