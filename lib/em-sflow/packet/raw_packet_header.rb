class EventMachine::SFlow::RawPacketHeader
  attr_accessor :protocol, :frame_length, :strip_count, :header
  
  def initialize data
    data.extend EventMachine::SFlow::BinaryString
    
    @protocol, @frame_length, @strip_count, length = data.unpack("NNNN")
    data.advance(4)
    
    @header = data
  end
end
