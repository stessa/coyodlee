module Envestnet
  module Yodlee
    module Utils
      def uncapitalized_camelize(str)
        str
          .split('_')
          .map { |w| w.capitalize }
          .join
          .tap { |w| w[0] = w[0].downcase }
      end
    end
  end
end
