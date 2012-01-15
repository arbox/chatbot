require 'rubygems'
require 'chatbot/my_jabber_bot' # jabber-bot
require 'chatbot/config_reader'
require 'chatbot/analyse_question'
require 'chatbot/syntese_answer'
require 'chatbot/path_finder'

module Chatbot
  class Bot
    def initialize(config)
      @bot = Jabber::Bot.new(config)
      read_commands()
	  
	  #Initialisieren des PathFinder mit Graphen
	  @this_path_finder = Chatbot::PathFinder.new("lib/chatbot/campusgraph.xml")
	  
	  #Laden der Antworten 
	  @lines_say_tschuess = YAML.load_file("etc/chatbot/answers_say_tschuess.yml")
	  @lines_can_i_help = YAML.load_file("etc/chatbot/answers_can_i_help.yml")  
    end

    def connect
      @bot.connect
    end
	
	#Diese Methode scheint nicht zu funktionieren (weil der Command zwar erstellt wird, aber 
	#ohne Methodenrumpf)
	def add_command(desc)
      @bot.add_command(desc)
    end
	
	#Über den Bot kann die obige add_command umgangen werden (mag unsauber sein, läuft aber)
	def get_bot
	  return @bot
	end
    
	def read_commands
      reader = Chatbot::ConfigReader.new(self)
      reader.read()
	  
	  reader.teach()
    end
	
	#Methode zum Verabschieden (Dummy?)
	def say_tschuess 
	  return @lines_say_tschuess[rand(@lines_say_tschuess.length)]
	end
	
	#Methode für die Frage, wie geholfen werden kann (Dummy?)
	def can_i_help
	  return @lines_can_i_help[rand(@lines_can_i_help.length)]
	end
	
	#Methode, die über den Pathfinder den Weg erfragt und ausgibt
	def answer_question(sender, msg)
	  aq = AnalyseQuestion.new(msg)
	  	  
	  if aq.result[0] == "unbekannt" && aq.result[1] == "unbekannt"
	    return "Leider konnte ich deiner Anfrage weder einen Start noch einen Zielort entnehmen. Am besten verstehe ich Anfragen im Format: von ... nach ..."
	  end
	  if aq.result[0] == "unbekannt"
        return "Leider konnte ich nur deinen Zielort erkennen: #{aq.result[1]}. Bitte formuliere die Anfrage nochmal in folgendem Format: von ... nach ..."
	  end
	  if aq.result[1] == "unbekannt"
        return "Leider konnte ich nur deinen Startort erkennen: #{aq.result[0]}. Bitte formuliere die Anfrage nochmal in folgendem Format: von ... nach ..."
	  end
	  	  
	  sa = SynteseAnswer.new(@this_path_finder.find_path(aq.result[0], aq.result[1]))	  
	  return sa.result
	end
  end # Bot
end # Chatbot