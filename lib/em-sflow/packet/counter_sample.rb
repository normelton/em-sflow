class EventMachine::SFlow::CounterSample
  attr_accessor :sequence_number, :source_class, :source_value, :records
  def initialize data
    @records = []
    
    data.extend EM::SFlow::BinaryString
    
    @sequence_number, source_id_class_value, record_count = data.unpack("NNN")
    
    @source_class = source_id_class_value >> 24
    @source_value = source_id_class_value & (2 ** 24 - 1)
    
    data.advance(12)
    
    record_count.times do
      enterprise_format, length = data.unpack("NN")
      
      enterprise = enterprise_format >> 12
      format = enterprise_format & (2 ** 12 - 1)
      
      data.advance(8)
      
      record_data = data.advance(length)

      if enterprise == 0 && format == 1
        @records << EM::SFlow::GenericInterfaceCounters.new(record_data)
      elsif enterprise == 0 && format == 2
        @records << EM::SFlow::EthernetInterfaceCounters.new(record_data)
      elsif enterprise == 0 && format == 3
        # @records << EM::SFlow::TokenRingCounters.new(record_data)
      elsif enterprise == 0 && format == 4
        # @records << EM::SFlow::HundredBaseVgCounters.new(record_data)
      elsif enterprise == 0 && format == 5
        # @records << EM::SFlow::VlanCounters.new(record_data)
      elsif enterprise == 0 && format == 1001
        # @records << EM::SFlow::ProcessorInformation.new(record_data)
      end
    end
  end
end
