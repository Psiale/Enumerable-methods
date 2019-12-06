# frozen_string_literal: false

module Enumerable # :nodoc:
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |element| result << element if yield element }
    result
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_all?(val = nil)
    if block_given?
      my_each { |element| return false unless yield element }
    elsif val.class == Class
      my_each { |element| return false unless element.is_a? val }
    elsif val.class == Regexp
      my_each { |element| return false unless val.match? element }
    elsif val.nil?
      my_each { |element| return false unless element }
    else
      my_each { |element| return false unless element == val }
    end
    true
  end

  def my_any?(val = nil)
    if block_given?
      my_each { |element| return true if yield element }
    elsif val.class == Class
      my_each { |element| return true if element.is_a? val }
    elsif val.class == Regexp
      my_each { |element| return true if val.match? element }
    elsif val.nil?
      my_each { |element| return true if element }
    else
      my_each { |element| return true if element == val }
    end
    false
  end

  def my_none?(val = nil)
    if block_given?
      my_each { |element| return false if yield element }
    elsif val.class == Class
      my_each { |element| return false if element.is_a? val }
    elsif val.class == Regexp
      my_each { |element| return false if val.match? element }
    elsif val.nil?
      my_each { |element| return false if element }
    else
      my_each { |element| return false if element == val }
    end
    true
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_count(val = nil)
    count = 0
    if block_given?
      my_each { |element| count += 1 if yield element }
    elsif val.nil?
      count = length
    else
      my_each { |element| count += 1 if element == val }
    end
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || proc

    result = []
    if proc.nil?
      to_a.my_each { |element| result << yield(element) }
    else
      to_a.my_each { |element| result << proc.call(element) }
    end
    result
  end

  def my_inject(initial = nil)
    if initial.nil?
      acc = self[0]
      self[1..-1].my_each { |element| acc = yield(acc, element) }
    else
      acc = initial
      my_each { |element| acc = yield(acc, element) }
    end
    acc
  end

  def multiply_els(array)
    array.my_inject { |accumulator, current_element| accumulator * current_element }
  end
end
