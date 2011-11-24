require 'jabber/bot'
module Chatbot
  class Bot
    def initilize(config)
      @bot = Jabber::Bot.new(config)
    end

    def connect
      @bot.connect
    end

    def add_command(desc)
      @bot.add_command(desc)
    end
    private
  end # Bot
end # Chatbot
# Configure a public bot

__END__


# Create a new bot
bot = Jabber::Bot.new(config)

# Give the bot a private command, 'puts', with a response message
bot.add_command(
  :syntax      => 'puts <string>',
  :description => 'Write something to $stdout',
  :regex       => /^puts\s+(.+)$/
) do |sender, message|
  puts "#{sender} says '#{message}'"
  "'#{message}' written to $stdout"
end

# Give the bot another private command, 'puts!', without a response message
bot.add_command(
  :syntax      => 'puts! <string>',
  :description => 'Write something to $stdout',
  :regex       => /^puts!\s+(.+)$/
) do |sender, message|
  puts "#{sender} says '#{message}'"
  nil
end

# Give the bot a public command, 'rand', with alias 'r'
bot.add_command(
  :syntax      => 'rand',
  :description => 'Produce a random number from 0 to 10',
  :regex       => /^rand$/,
  :alias       => [:syntax => 'r', :regex => /^r$/],
  :is_public   => true
) { rand(10).to_s }

# Unleash the bot
bot.connect
