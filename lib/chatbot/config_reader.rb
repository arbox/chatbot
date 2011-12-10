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
		Dir["etc/chatbot/chat_*.yml"].each do |filename|
			@yfile = YAML.load_file(filename)
			
			@yfile.each do |key, value|
				@commands[key] = value
			end			
		end
		
		return @commands
	end #end def read
	
	#Wandelt die vorher eingelesenen Befehle in Befehle
	#für den Chatbot um (add_command)
	#Ist die angegebene Funktion im Bot bekannt, so wird diese Aufgerufen.
	#Ansonsten wird der String als Antwort geliefert.
	def teach()
		@commands.each do |key, meth|
			if meth == "answer_question"
				@bot.get_bot.add_command(
					:syntax      => key,
					:description => "reacts on RegExp /#{key}/, invoking the Method: #{meth}",
					:regex       => Regexp.new(key, Regexp::IGNORECASE),
					:is_public   => true
				) do |sender, params, msg|
					@bot.answer_question(sender, msg)
				  end
			elsif @bot.respond_to?(meth)
				@bot.get_bot.add_command(
					:syntax      => key,
					:description => "reacts on RegExp /#{key}/, invoking the Method: #{meth}",
					:regex       => Regexp.new(key, Regexp::IGNORECASE),
					:is_public   => true
				) { @bot.method(meth).call() }
			else
				@bot.get_bot.add_command(
					:syntax      => key,
					:description => "reacts on RegExp /#{key}/, returing the String: #{meth}",
					:regex       => Regexp.new(key, Regexp::IGNORECASE),
					:is_public   => true
				) { meth }			
			end
	    end		
	end #end def teach
	
  end #end class
  
end