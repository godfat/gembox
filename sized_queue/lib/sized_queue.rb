
class SizedQueue
  include Enumerable
  attr_accessor :size
  attr_writer :data

  def initialize size; @size = size      ;end
  def each     &block; data.each(&block) ;end
  def first          ; data.first        ;end
  def data           ; @data ||= []      ;end
  def == rhs         ; data == rhs.data  ;end
  # should be more efficient than Enumerable's to_a?
  def to_a           ; data.dup          ;end

  # this would drop older data if all data could not fit into the size
  def enqueue *args
    a = args.reverse.take(size)
    self.data = a + (a.size == size ? [] : data[0, size - a.size])
    self
  end
end
