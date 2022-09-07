require 'telegram/bot'
require 'dotenv/load'
require_relative 'parser'

TOKEN = ENV['MY_TOKEN']

signs = %w[Овен Телец Близнецы Рак Лев Дева Весы Скорпион Стрелец Козерог Водолей Рыбы]

Telegram::Bot::Client.run(TOKEN) do |bot|
	bot.listen do |message|
		case message 
    when Telegram::Bot::Types::Message
			bot.api.send_message(chat_id: message.from.id, text: "Вас приветствует Весёлый Гороскоп!")		
				
			kb = signs.map {|sign|			  
						Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{sign}", callback_data: "#{sign}")
			}		

			markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
			bot.api.send_message(chat_id: message.chat.id, text: "#{message.from.first_name} выберите знак задиака", reply_markup: markup)			
		
		when Telegram::Bot::Types::CallbackQuery			
			if signs.include?(message.data)
				bot.api.send_message(chat_id: message.from.id, text: "#{found_sign(message.data)}")										
			end		
		end
	end    
end