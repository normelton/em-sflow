class EventMachine::SFlow::ExpandedFlowSample
  attr_accessor :sequence_number, :source_class, :source_value, :sampling_rate, :sample_pool, :drop_count, :input_type, :input_value, :output_type, :output_value, :records

  def initialize data
    data.extend EM::SFlow::BinaryString
    data.extend EM::SFlow::FlowRecord

    @sequence_number, @source_class, @source_value, @sampling_rate, @sample_pool, @drop_count, @input_type, @input_value, @output_type, @output_value, record_count = data.unpack("NNNNNNNNNNN")

    data.advance(44)

    @records = data.to_flow_records!(record_count)
  end
end
