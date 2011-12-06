require 'rubygems'
require 'jabber/bot' # jabber-bot
require 'chatbot/config_reader'

module Chatbot
  class Bot
    def initialize(config)
      @bot = Jabber::Bot.new(config)
      read_commands()
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
	  lines = ['Tschuessikowski!', 'Astalavista, Baby!']
	  
	  return lines[rand(lines.length)]
	end
	
	#Methode für die Frage, wie geholfen werden kann (Dummy?)
	def can_i_help
	  #Array mit Dingen, die der Bot sagen kann
	  lines = ['Wie kann ich helfen?', 'Was gibts?', 'Und jetzt?']
	  
	  return lines[rand(lines.length)]
	end
	
	#Methode, die über den Pathfinder den Weg erfragt und ausgibt
	#
	#DUMMY
	def answer_question
	  return "Dein Weg lautet: 42! Nutze dies Wissen wahrlich weise."
	end
  end # Bot
end # Chatbot