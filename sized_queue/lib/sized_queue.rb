
class SizedQueue
  include Enumerable
  attr_accessor :size

  def initialize size; @size = size      ;end
  def each     &block; data.each(&block) ;end
  def first          ; data.first        ;end
  # should be more efficient than Enumerable's to_a?
  def to_a           ; data.dup          ;end
  def == rhs         ; data == rhs.__send__(:data) ;end

  # this would drop older data if all data could not fit into the size
  def enqueue *args
    a = args.reverse.take(size)
    self.data = a + (a.size == size ? [] : data[0, size - a.size])
    self
  end

  private
  attr_writer :data
  def data           ; @data ||= []      ;end
end
