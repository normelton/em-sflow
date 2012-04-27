class EventMachine::SFlow::Datagram
  attr_reader :version, :agent, :sub_agent_id, :datagram_sequence, :uptime, :samples
  
  def initialize data
    data.extend EM::SFlow::BinaryString
    
    @samples = []

    @version, ip_version = data.unpack("NN")
    
    data.advance(8)

    if ip_version == 1
      @agent = IPAddr.new(data.unpack("N").first, Socket::AF_INET)
      data.advance(4)
    else
      ip_elements = data.unpack("NNNN")
      @agent = IPAddr.new((ip_elements[0] << 96) + (ip_elements[1] << 64) + (ip_elements[2] << 32) + ip_elements[3], Socket::AF_INET6)
      data.advance(16)
    end
    
    @sub_agent_id, @datagram_sequence, @uptime, sample_count = data.unpack("NNNN")
    
    data.advance(16)

    sample_count.times do
      enterprise_format, length = data.unpack("NN")
      enterprise = enterprise_format >> 12
      format = enterprise_format & (2 ** 12 - 1)
      
      data.advance(8)

      sample_data = data.advance(length)
      
      if enterprise == 0 && format == 1
        @samples << EM::SFlow::FlowSample.new(sample_data)
      elsif enterprise == 0 && format == 2  
        @samples << EM::SFlow::CounterSample.new(sample_data)
      elsif enterprise == 0 && format == 3
        # @samples << EM::SFlow::ExpandedFlowSample.new(sample_data)
      elsif enterprise == 0 && format == 4
        # @samples << EM::SFlow::ExpandedCounterSample.new(sample_data)
      end
    end
  end
end
