require 'yaml'
module Chatbot
	#Grundlegende Funktionen zum Initialisieren eines 
	#DialogAgenten mit einer Sammlung (YAML) von Regul�ren Ausdr�cken
	#als Nutzereingaben und zugeh�rigen Reaktionen
	class DialogAgent
		#Init mit Pfad zur YAML-Datei
		def initialize(filename)
			@yfile = YAML.load_file(filename)
		end
		
		#Pr�fen der Regul�ren Ausdr�cke, bis ein Matching gefunden wurde.
		#R�ckgabewert entsprechend dem Eintrag in der YAML-Datei.
		#Wird kein Matching gefunden, wird "b" als Default-Wert zur�ckgegeben.
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

