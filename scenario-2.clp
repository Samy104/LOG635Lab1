(clear)
(reset)

; Faits
; personne-at => où ils vont
; personne-travaille => travaille dans zone
; impact : Zone et radius
; impact-t : heure d'impact
; mari/enfant/amant/eleve/associe : Relations entres personnes
; tour-cellulaire : Zone et radius, donne l'opportunité
; ordinateur-disponible : Donne l'opportunité
; ambassade : Pays et emplacement.
; alliance : Entre deux pays

; DowntownTokyo TokyoBeach TokyoStadium TokyoPark TokyoPort
; TokyoCinema TokyoBroadcastStation ResidentialTokyo CyberCafe
; GasStation Parliament Coiffeur

; ArnoldSchwarzenegger JohnnyCash KatyPerry JackyChan 
; JennaJameson  KimKardashian  MichaelJackson JustinBieber 

(deffacts faits
	(impact ResidentialTokyo 45)
	(impact-t 22)
	
	(ordinateur-disponible TokyoStadium)
	(ordinateur-disponible ResidentialTokyo)
	(ordinateur-disponible CyberCafe)
	
	(tour-cellulaire TokyoBeach 30)
	(tour-cellulaire GasStation 30)
	
	(ambassade USA TokyoBeach)
	(ambassade UK ResidentialTokyo)
	(ambassade France TokyoBroadcastStation)
	(ambassade Allemagne TokyoPort)
	(ambassade Chine TokyoStadium)
	(ambassade Cuba TokyoPort)
	
	(alliance UK France)
	(alliance USA Cuba)
	(alliance Chine UK)
	(alliance Allemagne Russie)
	
	(personne-at ArnoldSchwarzenegger TokyoPort from-t 4 to-t 12)
	(personne-at ArnoldSchwarzenegger TokyoBeach from-t 13 to-t 18)
	(personne-at ArnoldSchwarzenegger TokyoBroadcastStation from-t 19 to-t 24)
	(personne-travaille JohnnyCash TokyoCinema)
	(personne-at JohnnyCash TokyoCinema from-t 17 to-t 20)
	(personne-at JohnnyCash ResidentialTokyo from-t 21 to-t 24)
	(personne-at KatyPerry ResidentialTokyo from-t 6 to-t 13)
	(personne-at KatyPerry TokyoPark from-t 14 to-t 18)
	(personne-at KatyPerry TokyoBroadcastStation from-t 19 to-t 24)
	(personne-at JackyChan DowntownTokyo from-t 6 to-t 12)
	(personne-at JackyChan TokyoPort from-t 13 to-t 19)
	(personne-at JackyChan TokyoCinema from-t 20 to-t 23)
	(personne-travaille JennaJameson CyberCafe)
	(personne-at JennaJameson ResidentialTokyo from-t 17 to-t 23)
	(personne-at KimKardashian Coiffeur from-t 6 to-t 14)
	(personne-at KimKardashian GasStation from-t 15 to-t 23)
	(personne-at MichaelJackson Coiffeur from-t 6 to-t 11)
	(personne-at MichaelJackson TokyoPark from-t 12 to-t 17)
	(personne-at MichaelJackson TokyoBeach from-t 18 to-t 23)
	(personne-travaille JustinBieber GasStation)
	(personne-at JustinBieber ResidentialTokyo from-t 17 to-t 23)
	
	(enfant JohnnyCash ArnoldSchwarzenegger)
	(enfant KatyPerry JohnnyCash)
	(enfant JackyChan KatyPerry)
	(enfant JennaJameson JackyChan)
	(enfant KimKardashian JennaJameson)
	(enfant MichaelJackson KimKardashian)
	(enfant JustinBieber MichaelJackson)
	(enfant ArnoldSchwarzenegger JustinBieber)
	(mari JohnnyCash JackyChan)
	(mari KatyPerry JennaJameson)
	(mari KimKardashian JustinBieber)
	(mari MichaelJackson ArnoldSchwarzenegger)
	(amant JohnnyCash KimKardashian)
	(amant ArnoldSchwarzenegger KatyPerry)
	(associe ArnoldSchwarzenegger JennaJameson)
	(associe KimKardashian KatyPerry)
	(eleve MichaelJackson JackyChan)
)

; Règles --------------------
(printout t "-----------------------------------------------------------------------"
	"-------------------" crlf)
(batch rules.clp)

(reset)
(run)