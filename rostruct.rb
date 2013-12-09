
require 'ostruct'

class RecOpenStruct < OpenStruct
  def initialize hash
    super(hash.inject({}){ |r, (k, v)|
      r[k] = self.class.convert(v)
      r
    })
  end

  def self.convert obj
    case obj
    when Hash
      RecOpenStruct.new(obj)
    when Array
      obj.map{ |v| convert(v) }
    else
      obj
    end
  end
end

if $PROGRAM_NAME == __FILE__
  require 'bacon'
  Bacon.summary_on_exit
  describe RecOpenStruct do
    should 'initialize' do
      ros = RecOpenStruct.new(:a => :b, :c => {:d => :e},
                              :f => [:g, {:h => :i}, {:j => {:k => :h}}])
      ros.a       .should.eql     :b
      ros.c       .should.kind_of RecOpenStruct
      ros.c.d     .should.eql     :e
      ros.f       .should.kind_of Array
      ros.f[0]    .should.eql     :g
      ros.f[1]    .should.kind_of RecOpenStruct
      ros.f[1].h  .should.eql     :i
      ros.f[2]    .should.kind_of RecOpenStruct
      ros.f[2].j  .should.kind_of RecOpenStruct
      ros.f[2].j.k.should.eql     :h
    end
  end
end
