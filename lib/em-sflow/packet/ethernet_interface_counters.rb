class EventMachine::SFlow::EthernetInterfaceCounters
  attr_accessor :alignment_errors, :fcs_errors, :single_collision_frames, :multiple_collision_frames, :sqe_test_errors, :deferred_transmissions, :late_collisions, :excessive_collisions, :internal_mac_transmit_errors, :carrier_sense_errors, :frames_too_long, :internal_mac_receive_errors, :symbol_errors
  
  def initialize data
    data.extend EventMachine::SFlow::BinaryString
    
    @alignment_errors, @fcs_errors, @single_collision_frames, @multiple_collision_frames, @sqe_test_errors, @deferred_transmissions, @late_collisions, @excessive_collisions, @internal_mac_transmit_errors, @carrier_sense_errors, @frames_too_long, @internal_mac_receive_errors, @symbol_errors = data.unpack("NNNNNNNNNNNNN")
  end
end
