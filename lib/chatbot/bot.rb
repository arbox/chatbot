require 'rubygems'
require 'chatbot/my_jabber_bot' # jabber-bot
require 'chatbot/config_reader'
require 'chatbot/analyze_question'
require 'chatbot/path_finder'

module Chatbot
  class Bot
    def initialize(config)
      @bot = Jabber::Bot.new(config)
      read_commands()
	  
	  #Initialisieren des PathFinder mit Graphen
	  @this_path_finder = Chatbot::PathFinder.new("lib/chatbot/campusgraph.xml")
	  
	  #Initialisieren des QuestionAnalyzers
	  @aq = QuestionAnalyzer.new(@this_path_finder.get_nodelist())
	  	  	  
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
	  res = @aq.analyze_question(msg)
	  
	  if (res == nil)
	    return "Das wird so wohl nichts. (res nil) Versuch es mit 'und wie von <start> zu <ziel>'. Uebrigens: Kaese ist heute im Angebot."
	  end
	  
	  if (res.length < 2)
		puts res.inspect
		return "Das wird so wohl nichts. Versuch es mit 'und wie von <start> zu <ziel>'. Uebrigens: Kaese ist heute im Angebot."
	  else  
		if (res[2] == 0)
		  return "Du bist bei '#{res[0]}'? Von da aus kann ich dir leider auch nicht helfen."
		end 
		if (res[3] == 0)
		  return "#{res[1]}? Noch nie von gehört, sorry"
		end
		
		path = @this_path_finder.find_path(res[0], res[1])
		if (path == nil) 
		  return "Ich habe verstanden: Weg von #{res[0]} nach #{res[1]}. Computer sagt 'Nein'."
		end
		
		sa = @this_path_finder.verbalize_path(path)	  
	    return sa
	  end
	end
  end # Bot
end # Chatbot