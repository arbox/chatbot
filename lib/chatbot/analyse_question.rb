module Chatbot
	
  class AnalyseQuestion
  
	def initialize(str)

    end
# die Methode liesFrageSteuerung schaut, ob die angegebenen Satz eine Frage zur Wegbeschreibungentspricht
# wenn ja dann ruft er die Methode analysiere_Frage auf
  	def liesFrageSteuerung (satz)
    
    	muster = /(wie|zu[mr])?(?>der |dem |den )?(Parkplatz|Mensa|[a-z -Gebaeude]|Raum XYZ|Raum \w|Toiletten)/i

			if satz.match(muster)

    			analysiere_Frage(satz)

    		else
       			'unbekannt'
    		end
	
  	end	

# die Methode analysiere_Frage  filtert das Ziel aus dem eingegebenen Satz heraus und fragt, wo man sich momentan befindet
# Sie liefert dann einen Standpunkt und ein Ziel
# Schien einfacher noch einmal nach dem Standpunkt zu fragen, anstatt das Format: von...nach... zu verlangen! Es wird also 
#Standpunkt und Zeil zurückgegeben oder nichts
#der Satz wird hier zerlegt und wörter jeweils mit den Schlüssel verglichen

  	def analysiere_Frage(satz)

      	schluessel = ["Mensa", "Gebaeude", "A-Gebaeude","B-Gebaeude", "C-Gebaeude","D-Gebaeude","F-Gebaeude","N-Gebaeude","Bibliothek", "Raum", "AB-
	    Foyer", "Parkplatz Ost", "Parkplatz West", "Campus 2"]

        standpunkt =''
        ziel = ''
	   	count = 0   	 	   
        zeichen = satz.split 
           	      	      
 	   	schluessel.each do |value|

  	      	zeichen.each do |kette|
               
				if value == kette
      		    	ziel = kette
		    		count +=1

		    		if ziel == "Gebaeude" 
		       			ziel = value+ " "+zeichen.last
                        ziel = ziel.chomp("?")
		       		    ziel = ziel.chomp(".")
			          
	            	elsif ziel == "Raum" 
				   		ziel = zeichen.last
			           	ziel = ziel.chomp("?")
				   		ziel = ziel.chomp(".")
			
                    end		                              	
				end			
	    	end
          	  
    	end

# Analyse vom Standpunkt
# Am Ende wird den Standpunkt und das Ziel zurückgegeben, also entweder beide oder gar nichts.
          	
	  	if count != 0

	    	puts "Wo befinden Sie sich gerade?"
 	    	print '>'
            count = 0	  
            linie = gets
            zeichen1 = linie.split
	  
            schluessel.each do |value|

  	       		zeichen1.each do |kette|
   
		 	    	if value == kette
		    			standpunkt = kette
	            
		    			if standpunkt == "Gebaeude" 
							standpunkt = value+ " "+zeichen1.last
                        	standpunkt = standpunkt.chomp("?")
                        	standpunkt = standpunkt.chomp(".")

		    			elsif standpunkt == "Raum" 
							standpunkt = zeichen1.last
                        	standpunkt = standpunkt.chomp("?")
							standpunkt = standpunkt.chomp(".")
                    	end
                    	            
      		    	puts "Die Wegbeschreibung folgt in kuerze"
		    		puts "Ihr Standpunkt: "+ standpunkt
                    puts "Ihr Ziel: "+ ziel
		    		count +=1
                	return [standpunkt, ziel]  
                	#end                 
		 			end
	      		end
        	end
	  	end
	                         
#arg = path_finder.new(standpunkt, ziel)
           	                    
	 	if count == 0
		#puts "der angegebene Ort gibt es hier nicht"
		#puts "Bitte achten Sie auf Schreibfehler"
                return[nil, nil]
	 	end       	 
   	end
 end

#ivy = AnalyseQuestion.new('str')
#ivy.liesFrageSteuerung("ich muss in C-Gebaeude")

end

