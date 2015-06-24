(clear)
(reset)

; Faits
; personne-at => où ils vont
; personne-travaille => travaille dans zone

(deffacts faits
	(impact DowntownTokyo 40)
	(impact-t 18)

	(personne-travaille ArnoldSchwarzenegger TokyoBeach)
	(personne-at ArnoldSchwarzenegger DowntownTokyo from-t 5 to-t 7)
	(personne-at JohnnyCash TokyoCinema from-t 4 to-t 14)
	(personne-at JohnnyCash TokyoPort from-t 15 to-t 18)
	(personne-at KimKardashian CyberCafe from-t 8 to-t 12)
	(personne-at KimKardashian TokyoCinema from-t 13 to-t 15)
	(personne-at KimKardashian TokyoBroadcastStation from-t 16 to-t 19)
	(personne-at JustinBieber TokyoBeach from-t 3 to-t 6)
	(personne-travaille JustinBieber TokyoBroadcastStation)
	(personne-at JustinBieber TokyoPark from-t 17 to-t 20)
	(personne-at JackyChan TokyoBroadcastStation from-t 3 to-t 12)
	(personne-at JackyChan TokyoStadium from-t 13 to-t 16)
	(personne-at JackyChan TokyoPark from-t 17 to-t 20)
	(personne-at JennaJameson DowntownTokyo from-t 6 to-t 14)
	(personne-at JennaJameson TokyoBeach from-t 15 to-t 18)
	(personne-at MichaelJackson CyberCafe from-t 6 to-t 10)
	(personne-at MichaelJackson TokyoPark from-t 11 to-t 14)
	(personne-at MichaelJackson TokyoBeach from-t 15 to-t 18)
	(personne-travaille KatyPerry ResidentialTokyo)
	(personne-at KatyPerry ResidentialTokyo from-t 5 to-t 7)
	(personne-at KatyPerry TokyoBroadcastStation from-t 18 to-t 21)
	
	(mari JohnnyCash JennaJameson)
	(mari ArnoldSchwarzenegger KimKardashian)
	(enfant KimKardashian JohnnyCash)
	(enfant KimKardashian JennaJameson)
	(amant JennaJameson ArnoldSchwarzenegger)
	(enfant JennaJameson MichaelJackson)
	(enfant KatyPerry JennaJameson)
	(enfant KatyPerry ArnoldSchwarzenegger)
	(eleve KatyPerry MichaelJackson)
	(enfant ArnoldSchwarzenegger MichaelJackson)
	(associe ArnoldSchwarzenegger JackyChan)
	(associe JackyChan JustinBieber)
	
	(ordinateur-disponible CyberCafe)
	(ordinateur-disponible TokyoBroadcastStation)
	(ordinateur-disponible ResidentialTokyo)
	(ordinateur-disponible TokyoCinema)
	
	(tour-cellulaire TokyoBroadcastStation 20)
	(tour-cellulaire TokyoBeach 30)
	
	(ambassade Russie ResidentialTokyo)
	(ambassade CoreeNord TokyoPort)
	(ambassade Chine TokyoBeach)
	(ambassade USA TokyoStadium)
	(ambassade UK DowntownTokyo)
	(ambassade France TokyoBroadcastStation)
	(ambassade Allemagne TokyoBeach)
	
	(alliance USA Chine)
	(alliance Allemagne CoreeNord)
	(alliance France Russie)
	(alliance UK Cuba)
)

; Règles --------------------
(printout t "-----------------------------------------------------------------------"
	"-------------------" crlf)
(batch rules.clp)

(reset)
(run)