
require 'ostruct'

class RecOpenStruct < OpenStruct
  def initialize hash
    super(hash.inject({}){ |r, (k, v)|
      r[k] = case v
             when Hash
               RecOpenStruct.new(v)
             else
               v
             end
      r
    })
  end
end

if $PROGRAM_NAME == __FILE__
  require 'bacon'
  Bacon.summary_on_exit
  describe RecOpenStruct do
    should 'initialize' do
      ros = RecOpenStruct.new(:a => :b, :c => {:d => :e})
      ros.a  .should.eql     :b
      ros.c  .should.kind_of RecOpenStruct
      ros.c.d.should.eql     :e
    end
  end
end
