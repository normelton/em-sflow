
module EventMachine
  module SFlow
    class Collector
      def initialize args = {}
        args[:host] ||= "127.0.0.1"
        args[:port] ||= 6343
        
        @callbacks = []
        @proxy_targets = []
        
        EventMachine.open_datagram_socket(args[:host], args[:port], DatagramHandler, {:host => args[:host], :callbacks => @callbacks, :proxy_targets => @proxy_targets})
      end
      
      def proxy_to target
        @proxy_targets << target
      end
      
      def on_sflow &proc
        @callbacks << proc
      end
    end
  end
end