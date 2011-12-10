module Chatbot
	class SynteseAnswer
		def initialize(arr)
			@arr = arr
		end

		def result()
			return @arr.inspect
		end
	end
end

