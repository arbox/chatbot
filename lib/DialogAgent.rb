require 'yaml'
class DialogAgent
	def initialize(filename = "")
		@yfile = YAML::load( File.open( filename ) )
	end
	def process(input)
		@yfile.each do |key, value| 
			if key.match(input)
				return value
			end
		end
		return "b"
	end
end

da = DialogAgent.new("C:\\Users\\Daniel\\test.yml")
puts da.process("hallo")
puts da.process("ciao")
puts da.process("rochen")