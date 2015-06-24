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
	(impact TokyoBeach 27)
	(impact-t 20)
	
	(ordinateur-disponible GasStation)
	(ordinateur-disponible Coiffeur)
	(ordinateur-disponible Parliament)
	(tour-cellulaire TokyoPark 30)
	(tour-cellulaire ResidentialTokyo 20)
	(tour-cellulaire TokyoBroadcastStation 40)
	
	(ambassade France TokyoBroadcastStation)
	(ambassade CoreeNord Coiffeur)
	(ambassade USA TokyoPark)
	
	(alliance France Russie)
	(alliance UK CoreeNord)
	(alliance USA UK)
	
	(eleve JohnnyCash JackyChan)
	(eleve KimKardashian JennaJameson)
	(eleve KatyPerry JustinBieber)
	(eleve ArnoldSchwarzenegger MichaelJackson)
	(amant JackyChan JustinBieber)
	(amant KatyPerry KimKardashian)
	(amant JohnnyCash ArnoldSchwarzenegger)
	(amant MichaelJackson JustinBieber)
	(mari KatyPerry JennaJameson)
	(mari JustinBieber JennaJameson)
	(mari JohnnyCash KimKardashian)
	(enfant JustinBieber JohnnyCash)
	(enfant KatyPerry KimKardashian)
	(enfant JustinBieber KimKardashian)
	(mari ArnoldSchwarzenegger JustinBieber)
	
	(personne-travaille JustinBieber TokyoBeach)
	(personne-travaille KatyPerry TokyoBeach)
	(personne-travaille MichaelJackson Parliament)
	(personne-travaille JohnnyCash Coiffeur)
	(personne-at MichaelJackson TokyoBeach from-t 19 to-t 22)
	(personne-at ArnoldSchwarzenegger TokyoCinema from-t 18 to-t 21)
	(personne-at ArnoldSchwarzenegger Parliament from-t 6 to-t 11)
	(personne-at ArnoldSchwarzenegger TokyoPark from-t 13 to-t 16)
	(personne-at JustinBieber GasStation from-t 17 to-t 23)
	(personne-at KatyPerry ResidentialTokyo from-t 18 to-t 22)
	(personne-at MichaelJackson TokyoPark from-t 17 to-t 20)
	(personne-at MichaelJackson TokyoPark from-t 21 to-t 23)
	(personne-at JohnnyCash Parliament from-t 19 to-t 22)
	(personne-at JackyChan TokyoBroadcastStation from-t 7 to-t 22)
	(personne-travaille JennaJameson GasStation)
	(personne-at JennaJameson Parliament from-t 17 to-t 24)
	(personne-at KimKardashian DowntownTokyo from-t 14 to-t 20)
	(personne-at KimKardashian Coiffeur from-t 21 to-t 23)
	
)

; Règles --------------------
(printout t "-----------------------------------------------------------------------"
	"-------------------" crlf)
(batch rules.clp)

(reset)
(run)