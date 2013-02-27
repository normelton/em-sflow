class EventMachine::SFlow::FlowSample
  attr_accessor :sequence_number, :source_class, :source_value, :sampling_rate, :sample_pool, :drop_count, :input_count, :output_count, :records
  
  def initialize data
    data.extend EM::SFlow::BinaryString
    data.extend EM::SFlow::FlowRecord
    
    @records = []
    
    @sequence_number, source_id_class_value, @sampling_rate, @sample_pool, @drop_count, @input_count, @output_count, record_count = data.unpack("NNNNNNNN")
    
    @source_class = source_id_class_value >> 24
    @source_value = source_id_class_value & (2 ** 24 - 1)
    
    data.advance(32)
    
    @records = data.to_flow_records!(record_count)
  end
end
