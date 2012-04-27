module EventMachine
  module SFlow
    module BinaryString
      def advance i
        slice!(0..(i - 1))
      end
    end
  end
end