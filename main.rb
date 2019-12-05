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

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_all?(val = nil)
    if block_given?
      my_each { |element| return false unless yield element }
    elsif val.class == Class
      my_each { |element| return false unless element.is_a? val }
    elsif val.class == Regexp
      my_each { |element| return false unless val.match? element }
    else
      my_each { |element| return false unless element == val }
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |element| return true if yield element }
    elsif val.class == Class
      my_each { |element| return true if element.is_a? val }
    elsif val.class == Regexp
      my_each { |element| return true if val.match? element }
    else
      my_each { |element| return true if element == val }
    end
    false
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_none?
    if block_given?
      my_each { |element| return false if yield element }
      true
    else
      to_enum(:my_none?)
    end
  end

  p([nil, true, 99].my_all? == [nil, true, 99].all?)
end
