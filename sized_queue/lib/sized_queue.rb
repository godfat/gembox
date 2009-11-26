
class SizedQueue
  include Enumerable
  attr_accessor :size
  attr_writer :data

  def initialize size; @size = size      ;end
  def each     &block; data.each(&block) ;end
  def first          ; data.first        ;end
  def data           ; @data ||= []      ;end
  def == lhs         ; data == lhs.data  ;end
  # should be more efficient than Enumerable's to_a?
  def to_a           ; data.dup          ;end

  def enqueue *args
    a = args.reverse.take(size)
    self.data = a + (a.size == size ? [] : data[0, size - a.size])
  end
end
