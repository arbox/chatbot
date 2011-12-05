module Chatbot
  #Klasse zum Einlesen von Konfigurationsdateien im YAML-Format.
  
  class ConfigReader
    def initialize(bot)
		@bot = bot
		
		@commands = Hash.new
    end #end def initialize
	
	#Iteriert über alle Dateien und erstellt eine Hash-Map
	#mit den aufzurufenden Befehlen.
	#Es werden alle Dateien mit Namen "chat_*.yml" im
	#Verzeichnis chatbot eingelesen
	def read()					
		Dir["chatbot/chat_*.yml"].each do |filename|
			@yfile = YAML.load_file(filename)
			
			@yfile.each do |key, value| 	
				if @bot.respond_to?(value) 
					@commands[key] = @bot.method(value)
				else
					@commands[key] = @bot.method("can_i_help")
				end
			end			
		end
		
		return @commands
	end #end def read
	
	#Wandelt die vorher eingelesenen Befehle in Befehle
	#für den Chatbot um (add_command)
	def teach()
		@commands.each do |key, meth|
			@bot.get_bot.add_command(
				:syntax      => key,
				:description => "reacts on RegExp /#{key}/, invoking the Method: #{meth.name}",
				:regex       => Regexp.new(key),
				:is_public   => true
			) { meth.call }
	    end		
	end #end def teach
	
  end #end class
  
end