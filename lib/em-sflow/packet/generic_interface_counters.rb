class EventMachine::SFlow::GenericInterfaceCounters
  attr_accessor :if_index, :if_type, :if_speed, :if_direction, :if_admin_status, :if_oper_status, :if_in_octets, :if_in_ucast_pkts, :if_in_mcast_pkts, :if_in_bcast_pkts, :if_in_discards, :if_in_errors, :if_in_unknown_protocols, :if_out_octets, :if_out_ucast_pkts, :if_out_mcast_pkts, :if_out_bcast_pkts, :if_out_discards, :if_out_errors, :if_promiscuous
  
  def initialize data
    data.extend EventMachine::SFlow::BinaryString
    
    @if_index, @if_type, if_speed_a, if_speed_b, @if_direction, if_status = data.unpack("NNNNNN")
    @if_speed = (if_speed_a << 32) + if_speed_b
    @if_admin_status = (if_status >> 31) && 1
    @if_oper_status = (if_status >> 30) && 1
    
    data.advance(24)
    
    if_in_octets_a, if_in_octets_b, @if_in_ucast_pkts, @if_in_mcast_pkts, @if_in_bcast_pkts, @if_in_discards, @if_in_errors, @if_in_unknown_protocols = data.unpack("NNNNNNNN")
    @if_in_octets = (if_in_octets_a << 32) + if_in_octets_b
    
    data.advance(32)
    
    if_out_octets_a, if_out_octets_b, @if_out_ucast_pkts, @if_out_mcast_pkts, @if_out_bcast_pkts, @if_out_discards, @if_out_errors = data.unpack("NNNNNNN")
    @if_out_octets = (if_out_octets_a << 32) + if_out_octets_b
    
    data.advance(28)
    
    @if_promiscuous = data.unpack("N").first
  end
end
