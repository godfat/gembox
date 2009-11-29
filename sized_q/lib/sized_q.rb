
class SizedQ
  include Enumerable
  attr_accessor :size

  def initialize size; @size = size      ;end
  def each     &block; data.each(&block) ;end
  def first          ; data.first        ;end
  # should be more efficient than Enumerable's to_a?
  def to_a           ; data.dup          ;end

  def == rhs
    if rhs.kind_of?(self.class)
      data == rhs.__send__(:data)
    else
      false
    end
  end

  # this would drop older data if all data could not fit into the size
  def enqueue *args
    a = args.reverse.take(size)
    self.data = a + data[0, size - a.size]
    self
  end

  private
  # attr_writer :data
  # silence warning
  def data= a; @data = a    ;end
  def data   ; @data ||= [] ;end
end
