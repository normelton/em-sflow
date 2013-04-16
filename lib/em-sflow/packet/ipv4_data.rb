class EventMachine::SFlow::IPv4Data
  attr_accessor :length, :protocol, :src_ip, :dst_ip, @src_port, @dst_port, @tcp_flags, @tos

  def initialize data
    data.extend EventMachine::SFlow::BinaryString

    @length, @protocol, src, dst, @src_port, @dst_port, @tcp_flags, @tos = data.unpack("NNNNNNNN")
    data.advance(32)

    @src_ip = IPAddr.new(src, Socket::AF_INET)
    @dst_ip = IPAddr.new(dst, Socket::AF_INET)
  end
end
