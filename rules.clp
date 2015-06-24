; Constantes
(deftemplate pays
	(slot nom)
	(slot temps)
	(multislot radius)
	(slot politic)
)

(deftemplate intent
	(slot person)
	(slot value (type INTEGER))
)

(deffacts contants
	(zone DowntownTokyo 0 0)
	(zone TokyoBeach -10 -20)
	(zone TokyoStadium 30 40)
	(zone TokyoPark 20 10)
	(zone TokyoPort -20 -40)
	(zone TokyoCinema -30 30)
	(zone TokyoBroadcastStation 40 -30)
	(zone ResidentialTokyo 50 0)
	(zone CyberCafe -50 -50)
	(zone GasStation 10 -20)
	(zone Parliament -20 -10)
	(zone Coiffeur 20 30)
	
	;Nom - Radius de bombe - Temps lancement/impact
	(pays (nom Russie) (temps 4) (radius 45 60) (politic communist))
	(pays (nom CoreeNord) (temps 2) (radius 15 30) (politic communist))
	(pays (nom Chine) (temps 1) (radius 40 75) (politic communist))
	(pays (nom Cuba) (temps 7) (radius 10 25) (politic communist))
	(pays (nom USA) (temps 6) (radius 35 55) (politic capitalist))
	(pays (nom UK) (temps 8) (radius 10 40) (politic capitalist))
	(pays (nom France) (temps 6) (radius 20 45) (politic capitalist))
	(pays (nom Allemagne) (temps 7) (radius 10 25) (politic capitalist))
	
	; Personnes - Nom - Job - Cash - Politic
	(personne ArnoldSchwarzenegger pauvre communist)
	(personne JohnnyCash pauvre communist)
	(personne KatyPerry riche communist)
	(personne JackyChan riche communist)
	(personne JennaJameson riche capitalist)
	(personne KimKardashian pauvre capitalist)
	(personne MichaelJackson riche capitalist)
	(personne JustinBieber riche capitalist)
)

(defrule vivants
	(declare (salience 200))
	(personne ?qui ?a ?b)
	=>
	(assert (vivant ?qui))
)

(defrule mari-mutual
	(declare (salience 200))
	(mari ?qui ?autre)
	=>
	(assert (mari ?autre ?qui))
)

(defrule associe-mutual
	(declare (salience 200))
	(associe ?qui ?autre)
	=>
	(assert (associe ?autre ?qui))
)

(defrule cousin-mutual
	(declare (salience 200))
	(cousin ?qui ?autre)
	=>
	(assert (cousin ?autre ?qui))
)

(defrule amant-mutual
	(declare (salience 200))
	(amant ?qui ?autre)
	=>
	(assert (amant ?autre ?qui))
)

(defrule alliance-mutual
	(declare (salience 200))
	(alliance ?p1 ?p2)
	=>
	(assert (alliance ?p2 ?p1))
)

(defrule personne-travaille
	(declare (salience 110))
	(personne-travaille ?qui ?loc)
	=>
	(assert (personne-at ?qui ?loc from-t 8 to-t 16))
)

(defrule quel-pays
	(declare (salience 100))
	(impact ?loc ?radius)
	(pays (nom ?pays) (radius ?min ?max) (temps ?delay))
	(impact-t ?impact-t)
	(test (and (<= ?radius ?max) (>= ?radius ?min)))
	=>
	(printout t ?pays " peut avoir lance la bombe a " (- ?impact-t ?delay) " heure" crlf)
	(assert (lancement ?pays (- ?impact-t ?delay)))
)

(defrule affecte-zone
	(declare (salience 90))
	(impact ?impact-loc ?radius)
	(zone ?impact-loc ?x ?y)
	(zone ?loc ?x2 ?y2)
	(test (<= 
		(sqrt (+ (** (- ?x ?x2) 2) (** (- ?y ?y2) 2)))
		?radius)
	)
	=>
	(printout t ?loc " est touche par l'explosion" crlf)
	(assert (impact-affecte ?loc))
)

(defrule ambassades-nobomb
	(declare (salience 85))
	(ambassade ?pays ?loc)
	(impact-affecte ?loc)
	?lancement <- (lancement ?pays ?t)
	=>
	(printout t ?pays " n'aurait pas lance la bombe. Son ambassade est touche a " ?loc crlf)
	(retract ?lancement)
	(assert (ambassade-detruite ?pays))
)

(defrule cellular-zone
	(declare (salience 80))
	(tour-cellulaire ?loc ?radius)
	(zone ?loc ?x ?y)
	(zone ?coverage ?x2 ?y2)
	(test (<= 
		(sqrt (+ (** (- ?x ?x2) 2) (** (- ?y ?y2) 2)))
		?radius)
	)
	=>
	(printout t ?coverage " a/avait la couverture cellulaire" crlf)
	(assert (cellular-coverage ?coverage))
)

(defrule decede
	(declare (salience 50))
	?vivant <- (vivant ?qui)
	(personne-at ?qui ?loc from-t ?t1 to-t ?t2)
	(impact-affecte ?loc)
	(impact-t ?t)
	(test (and (<= ?t1 ?t) (>= ?t2 ?t)))
	=>
	(printout t ?qui " est mort dans l'explosion (Loc:" ?loc ")." crlf)
	(assert (decede ?qui))
	(retract ?vivant)
)

(defrule base-intent
	(declare (salience 45))
	(vivant ?qui)
	=>
	(assert (intent (person ?qui) (value 0)))
)

(defrule jalousie
	(declare (salience 44))
	(decede ?src)
	(amant ?dst ?src)
	(mari ?qui ?dst)
	(vivant ?qui)
	(not (jalousie ?qui ?src))
	?intent <- (intent (person ?qui) (value ?value))
	=>
	(printout t ?qui " a un motif de meurtre (Amant+20) pour " ?src crlf)
	(assert (jalousie ?qui ?src))
	(modify ?intent (value (+ ?value 20)))
)

(defrule adultere
	(declare (salience 44))
	(decede ?dst)
	(amant ?dst ?amant)
	(mari ?qui ?dst)
	(vivant ?qui)
	(not (adultere ?qui ?dst))
	?intent <- (intent (person ?qui) (value ?value))
	=>
	(printout t ?qui " a un motif de meurtre (Adultere+30) pour " ?dst crlf)
	(assert (adultere ?qui ?dst))
	(modify ?intent (value (+ ?value 30)))
)

(defrule parente
	(declare (salience 44))
	(enfant ?enf ?parent)
	(decede ?enf)
	(not (intent-enfant ?parent ?enf))
	?intent <- (intent (person ?parent) (value ?value))
	=>
	(printout t ?parent " ne tuera probablement pas son enfant (-20) " ?enf crlf)
	(assert (intent-enfant ?parent ?enf))
	(modify ?intent (value (- ?value 20)))
)

(defrule eleve-maitre
	(declare (salience 44))
	(eleve ?qui ?dst)
	(decede ?dst)
	(vivant ?qui)
	(not (eleve-intent ?qui ?dst))
	?intent <- (intent (person ?qui) (value ?value))
	=>
	(printout t ?qui " a un motif de meurtre (Maitre+30) pour " ?dst crlf)
	(assert (eleve-intent ?qui ?dst))
	(modify ?intent (value (+ ?value 30)))
)

(defrule pauvre-riche
	(declare (salience 44))
	(personne ?qui pauvre ?politic)
	(vivant ?qui)
	(personne ?dst riche ?p)
	(decede ?dst)
	(not (intent-pauvre-riche ?qui ?dst))
	?intent <- (intent (person ?qui) (value ?value))
	=>
	(printout t ?qui " a un motif de meurtre (Pauvre-Riche+15) pour " ?dst crlf)
	(assert (intent-pauvre-riche ?qui ?dst))
	(modify ?intent (value (+ ?value 15)))
)

(defrule communist-riche
	(declare (salience 44))
	(vivant ?qui)
	(personne ?qui ?cash communist)
	(personne ?dst riche ?p)
	(decede ?dst)
	(not (intent-communist-riche ?qui ?dst))
	?intent <- (intent (person ?qui) (value ?value))
	=>
	(printout t ?qui " a un motif de meurtre (Communiste-Riche+10) pour " ?dst crlf)
	(assert (intent-communist-riche ?qui ?dst))
	(modify ?intent (value (+ ?value 10)))
)

(defrule justin-bieber
	(declare (salience 43))
	(decede JustinBieber)
	(vivant ?qui)
	(not (intent-jb ?qui))
	?intent <- (intent (person ?qui) (value ?value))
	=>
	(printout t "JustinBieber is down. You get points. And you get points. EVERYBODY GET POINTS!!!!111one!!" crlf)
	(assert (intent-jb ?qui))
	(modify ?intent (value (+ ?value 50)))
)

(defrule politic-same
	(declare (salience 44))
	(vivant ?qui)
	(personne ?qui ?cash ?politic)
	(personne ?dst ?cash2 ?politic)
	(decede ?dst)
	(not (intent-politic-same ?qui ?dst))
	?intent <- (intent (person ?qui) (value ?value))
	=>
	(printout t ?qui " aurait prefere epargner " ?dst " (Politic " ?politic " -10)" crlf)
	(assert (intent-politic-same ?qui ?dst))
	(modify ?intent (value (- ?value 10)))
)

(defrule cash-same
	(declare (salience 44))
	(vivant ?qui)
	(personne ?qui ?cash ?politic)
	(personne ?dst ?cash ?politic2)
	(decede ?dst)
	(not (intent-cash-same ?qui ?dst))
	?intent <- (intent (person ?qui) (value ?value))
	=>
	(printout t ?qui " aurait prefere epargner " ?dst " (Cash " ?cash " -10)" crlf)
	(assert (intent-cash-same ?qui ?dst))
	(modify ?intent (value (- ?value 10)))
)

(defrule suspect-lancement
	(declare (salience 40))
	(personne ?qui ?cash ?politic)
	(vivant ?qui)
	(lancement ?pays ?t)
	(pays (nom ?pays) (politic ?politic))
	=>
	(printout t ?qui " est associe a " ?pays " qui pourrait avoir lance la bombe" crlf)
	(assert (suspect-lancement ?qui))
)

(defrule opportunity-cellular
	(declare (salience 25))
	(vivant ?qui)
	(not (opportunity ?qui))
	(lancement ?pays ?t)
	(cellular-coverage ?loc)
	(personne-at ?qui ?loc from-t ?t1 to-t ?t2)
	(suspect-lancement ?qui)
	(test (and (<= ?t ?t2) (>= ?t ?t1)))
	=>
	(printout t ?qui " avait l'opportunite de lancer la bombe avec un cellulaire" crlf)
	(assert (opportunity ?qui))
)

(defrule opportunity-computer
	(declare (salience 25))
	(vivant ?qui)
	(not (opportunity ?qui))
	(lancement ?pays ?t)
	(ordinateur-disponible ?loc)
	(personne-at ?qui ?loc from-t ?t1 to-t ?t2)
	(suspect-lancement ?qui)
	(test (and (<= ?t ?t2) (>= ?t ?t1)))
	=>
	(printout t ?qui " avait l'opportunite de lancer la bombe avec un ordinateur" crlf)
	(assert (opportunity ?qui))
)

(defrule no-intent-opportunity
	(declare (salience 5))
	(vivant ?qui)
	(not (opportunity ?qui))
	?intent <- (intent (person ?qui) (value ?val))
	(test (> ?val 0))
	=>
	(printout t ?qui " n'a pas l'opportunite -> intent = 0" crlf)
	(modify ?intent (value 0))
)

(defrule ranking
	(declare (salience 6))
	(opportunity ?qui)
	(intent (person ?qui) (value ?val))
	=>
	(printout t ?qui " a " ?val " intent" crlf)
)

(defrule coupable
	(declare (salience 3))
	(opportunity ?qui)
	(intent (person ?qui) (value ?val))
	(not (intent (value ?val2&:(> ?val2 ?val))))
	=>
	(printout t ?qui " est coupable avec " ?val crlf)
	(assert (coupable ?qui))
)

(defrule pays-alliance
	(declare (salience 3))
	(ambassade-detruite ?pays)
	(alliance ?pays ?dst)
	?lancement <- (lancement ?dst ?t)
	=>
	(printout t ?dst " n'aurait pas detruit l'ambassade de son allie " ?pays crlf)
	(retract ?lancement)
)

(defrule pays-coupable
	(declare (salience 2))
	(coupable ?qui)
	(personne ?qui ?cash ?politic)
	(personne-at ?qui ?loc from-t ?t1 to-t ?t2)
	(lancement ?pays ?t)
	(pays (nom ?pays) (politic ?politic))
	(test (and (<= ?t ?t2) (>= ?t ?t1)))
	=>
	(printout t ?pays " a lance le missile " crlf)
	(assert (pays-coupable ?pays))
)