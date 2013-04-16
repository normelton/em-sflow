class EventMachine::SFlow::IPv6Data
  attr_accessor :length, :protocol, :src_ip, :dst_ip, @src_port, @dst_port, @tcp_flags, @priority

  def initialize data
    data.extend EventMachine::SFlow::BinaryString

    @length, @protocol = data.unpack("NN")
    data.advance(8)

    src = data.unpack("NNNN")
    @src_ip = IPAddr.new((src[0] << 96) + (src[1] << 64) + (src[2] << 32) + src[3], Socket::AF_INET6)
    data.advance(16)

    dst = data.unpack("NNNN")
    @dst_ip = IPAddr.new((dst[0] << 96) + (dst[1] << 64) + (dst[2] << 32) + dst[3], Socket::AF_INET6)
    data.advance(16)

    @src_port, @dst_port, @tcp_flags, @priority = data.unpack("NNNN")
    data.advance(16)
  end
end
