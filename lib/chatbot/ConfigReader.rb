module Chatbot
  #Klasse zum Einlesen von Konfigurationsdateien im YAML-Format.
  
  class ConfigReader
    def initialize(bot)
		@bot = bot
		
		#Liste der einzulesenden Dateien
		@configfiles = ["abschied.yml"]
    end #end def initialize
	
	#Iteriert über alle Dateien und erstellt Befehle für den Bot.
	#Die Befehle selbst reagieren auf den RegExp-Teil der aus den YAML-Dateien
	#ausgelesenen Zeilen. Der Rückgabewert ist jeweils der definierte Wert als 
	#einfacher String innerhalb der YAML-Datei.
	def read()		
		@configfiles.each do |filename|
			@yfile = YAML.load_file(filename)
			
			@yfile.each do |key, value| 
				@bot.add_command(
					:syntax      => key,
					:description => "reacts on RegExp /#{key}/, returning the String: #{value}",
					:regex       => Regexp.new(key),
					:is_public   => true
				) { value }
			end			
		end
	end #end def read
  end #end class
  
end