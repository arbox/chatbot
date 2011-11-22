require 'yaml'
class DialogAgent
	def initialize(filename = "")
		@yfile = YAML::load( File.open( filename ) )
	end
	def process(input)
		@yfile.each do |key, value| 
			if Regexp.new(key).match(input)
				return value
			end
		end
		return "b"
	end
end