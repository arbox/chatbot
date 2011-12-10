module Chatbot
	class SynteseAnswer
		def initialize(arr)
			@arr = arr
		end

		def result()
			return "von: " + @arr[0] + ", nach: " + @arr[1]
		end
	end
end

