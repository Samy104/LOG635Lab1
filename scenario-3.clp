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
	(impact CyberCafe 40)
	(impact-t 18)
	
	(ordinateur-disponible ResidentialTokyo)
	(ordinateur-disponible CyberCafe)
	(tour-cellulaire TokyoStadium 50)
	
	(ambassade USA CyberCafe)
	(ambassade Russie DowntownTokyo)
	
	(alliance USA Russie)
	(alliance France CoreeNord)
	
	(eleve KatyPerry JennaJameson)
	(eleve KimKardashian JennaJameson)
	(eleve JustinBieber JennaJameson)
	(amant KatyPerry ArnoldSchwarzenegger)
	(amant JennaJameson ArnoldSchwarzenegger)
	(amant KimKardashian ArnoldSchwarzenegger)
	(mari JustinBieber ArnoldSchwarzenegger)
	(enfant JustinBieber JohnnyCash)
	(enfant KimKardashian ArnoldSchwarzenegger)
	(enfant JackyChan JennaJameson)
	(mari JackyChan JohnnyCash)
	
	(personne-at JustinBieber TokyoStadium from-t 8 to-t 13)
	(personne-at JustinBieber CyberCafe from-t 14 to-t 19)
	(personne-at KatyPerry TokyoStadium from-t 6 to-t 8)
	(personne-travaille CyberCafe)
	(personne-at KatyPerry ResidentialTokyo from-t 17 to-t 24)
	(personne-at ArnoldSchwarzenegger TokyoPort from-t 8 to-t 11)
	(personne-at ArnoldSchwarzenegger TokyoBeach from-t 12 to-t 15)
	(personne-at ArnoldSchwarzenegger TokyoBroadcastStation from-t 16 to-t 20)
	(personne-at JohnnyCash Coiffeur from-t 12 to-t 15)
	(personne-at JohnnyCash Parliament from-t 16 to-t 19)
	(personne-at JackyChan GasStation from-t 12 to-t 15)
	(personne-at JackyChan TokyoPort from-t 16 to-t 20)
	(personne-at JennaJameson DowntownTokyo from-t 11 to-t 15)
	(personne-at JennaJameson ResidentialTokyo from-t 16 to-t 19)
	(personne-at KimKardashian TokyoCinema from-t 14 to-t 16)
	(personne-at KimKardashian CyberCafe from-t 17 to-t 20)
	(personne-at MichaelJackson Parliament from-t 11 to-t 14)
	(personne-at MichaelJackson ResidentialTokyo from-t 15 to-t 17)
	(personne-at MichaelJackson TokyoPark from-t 18 to-t 21)
)

; Règles --------------------
(printout t "-----------------------------------------------------------------------"
	"-------------------" crlf)
(batch rules.clp)

(reset)
(run)