module EventMachine
  module SFlow
    module FlowRecord
      def to_flow_records!(record_count)
        records = []
        record_count.times do
          enterprise_format, length = unpack("NN")

          enterprise = enterprise_format >> 12
          format = enterprise_format & (2 ** 12 - 1)

          self.advance(8)

          record_data = self.advance(length)

          if enterprise == 0 && format == 1
            records << EM::SFlow::RawPacketHeader.new(record_data)
          elsif enterprise == 0 && format == 2
            # records << EM::SFlow::EthernetFrameData.new(record_data)
          elsif enterprise == 0 && format == 3
            # records << EM::SFlow::IPv4Data.new(record_data)
          elsif enterprise == 0 && format == 4
            # records << EM::SFlow::IPv6Data.new(record_data)
          elsif enterprise == 0 && format == 1001
            # records << EM::SFlow::ExtendedSwitchData.new(record_data)
          elsif enterprise == 0 && format == 1002
            # records << EM::SFlow::ExtendedRouterData.new(record_data)
          elsif enterprise == 0 && format == 1003
            # records << EM::SFlow::ExtendedGatewayData.new(record_data)
          elsif enterprise == 0 && format == 1004
            # records << EM::SFlow::ExtendedUserData.new(record_data)
          elsif enterprise == 0 && format == 1005
            # records << EM::SFlow::ExtendedUrlData.new(record_data)
          elsif enterprise == 0 && format == 1006
            # records << EM::SFlow::ExtendedMplsData.new(record_data)
          elsif enterprise == 0 && format == 1007
            # records << EM::SFlow::ExtendedNatData.new(record_data)
          elsif enterprise == 0 && format == 1008
            # records << EM::SFlow::ExtendedMplsTunnel.new(record_data)
          elsif enterprise == 0 && format == 1009
            # records << EM::SFlow::ExtendedMplsVc.new(record_data)
          elsif enterprise == 0 && format == 1010
            # records << EM::SFlow::ExtendedMplsFec.new(record_data)
          elsif enterprise == 0 && format == 1011
            # records << EM::SFlow::ExtendedMplsLvpFec.new(record_data)
          elsif enterprise == 0 && format == 1012
            # records << EM::SFlow::ExtendedVlanTunnel.new(record_data)
          end
        end
        
        records
      end
    end
  end
end