module Chatbot
# liefert Array aus Start und Endpunkt
class QuestionAnalyzer
	def initialize(nl_hash)
		@nl_hash = nl_hash
	end
	
	def analyze_question(str)
		startEnd_re = /vo[mn] (?>der |dem |den )?(.+?) zu[mr]? (?>der |dem |den )?(.+?)[.?]?\z/i
		
		start_end = str.scan(startEnd_re)
		
		if (start_end.length != 1)
			return nil
		end
		if (start_end[0].length != 2)
			return nil
		end
		
		start_copy = start_end[0][0]
		end_copy = start_end[0][1]
		
		start_match_found = 0
		end_match_found = 0
					
		@nl_hash.each do |k, v|
			if (start_copy.downcase.include? v.downcase) or (v.downcase.include? start_copy.downcase)			
				start_end[0][0] = k	
				start_match_found = start_match_found + 1
			end
			if (end_copy.downcase.include? v.downcase) or (v.downcase.include? end_copy.downcase)
				start_end[0][1] = k				
				end_match_found = end_match_found + 1
			end	
			
			if (start_copy.downcase.include? k.downcase) or (k.downcase.include? start_copy.downcase)
				start_end[0][0] = k
				start_match_found = start_match_found + 1
			end
			if (end_copy.downcase.include? k.downcase) or (k.downcase.include? end_copy.downcase)
				start_end[0][1] = k
				end_match_found = end_match_found + 1
			end
		end

		#Kontrollausgabe
		start_end[2] = start_match_found
		start_end[3] = end_match_found
		puts "Es wurden #{start_match_found} Ergebnisse für den Start und #{end_match_found} für das Ziel gefunden. Gewählt wurden: Start #{start_end[0][0]} - Ziel #{start_end[0][1]}"
		
		start_end[0]
				
	end

end
end
