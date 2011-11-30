require 'yaml'
module Chatbot
	#Grundlegende Funktionen zum Initialisieren eines 
	#DialogAgenten mit einer Sammlung (YAML) von Regulären Ausdrücken
	#als Nutzereingaben und zugehörigen Reaktionen
	class DialogAgent
		#Init mit Pfad zur YAML-Datei
		def initialize(filename)
			@yfile = YAML.load_file(filename)
		end
		
		#Prüfen der Regulären Ausdrücke, bis ein Matching gefunden wurde.
		#Rückgabewert entsprechend dem Eintrag in der YAML-Datei.
		#Wird kein Matching gefunden, wird "b" als Default-Wert zurückgegeben.
		def process(input)
			@yfile.each do |key, value| 
				if Regexp.new(key).match(input)
					return value
				end
			end
			return "b"
		end
	end
end

