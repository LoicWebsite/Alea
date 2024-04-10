//
//  HistoriqueTirage.swift
//  Alea
//
//  Created by Loïc DAVID on 18/08/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit

class HistoriqueTirage: NSObject, NSCoding {
    var id : Int
    var dateTirage : Date
    var resultat : String
    var image1 : String
    var image2 : String
    var image3 : String
    var image4 : String
    var image5 : String
    
    init(id: Int, dateTirage: Date, resultat: String, image1: String, image2: String, image3: String, image4: String, image5: String) {
        #if DEBUG
        print("init - Historique")
        #endif
        
        self.id = id
        self.dateTirage = dateTirage
        self.resultat = resultat
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.image4 = image4
        self.image5 = image5
    }

    required convenience init(coder aDecoder: NSCoder) {
        #if DEBUG
        print("decode - Historique")
        #endif
        
        let id = aDecoder.decodeInteger(forKey: "id")
        let dateTirage = aDecoder.decodeObject(forKey: "dateTirage") as! Date
        let resultat = aDecoder.decodeObject(forKey: "resultat") as! String
        let image1 = aDecoder.decodeObject(forKey: "image1") as! String
        let image2 = aDecoder.decodeObject(forKey: "image2") as! String
        let image3 = aDecoder.decodeObject(forKey: "image3") as! String
        let image4 = aDecoder.decodeObject(forKey: "image4") as! String
        let image5 = aDecoder.decodeObject(forKey: "image5") as! String
        self.init(id: id, dateTirage: dateTirage, resultat: resultat, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5)
    }
    
    func encode(with aCoder: NSCoder) {
        #if DEBUG
        print("encode - Historique")
        #endif
        
        aCoder.encode(id, forKey: "id")
        aCoder.encode(dateTirage, forKey: "dateTirage")
        aCoder.encode(resultat, forKey: "resultat")
        aCoder.encode(image1, forKey: "image1")
        aCoder.encode(image2, forKey: "image2")
        aCoder.encode(image3, forKey: "image3")
        aCoder.encode(image4, forKey: "image4")
        aCoder.encode(image5, forKey: "image5")
    }
}

// historique des tirages
var historiqueChiffre = [HistoriqueTirage]()
var historiqueLettre = [HistoriqueTirage]()
var historiqueToiMoi = [HistoriqueTirage]()
var historiqueVraiFaux = [HistoriqueTirage]()
var historiqueOuiNon = [HistoriqueTirage]()
var historiquePileFace = [HistoriqueTirage]()
var historiqueChifoumi = [HistoriqueTirage]()
var historiqueDe = [HistoriqueTirage]()
var historiqueCarte = [HistoriqueTirage]()
var historiqueRoulette = [HistoriqueTirage]()
var historiqueDirection = [HistoriqueTirage]()
var historiqueAzimut = [HistoriqueTirage]()
var historiqueJour = [HistoriqueTirage]()
var historiqueEuromillion = [HistoriqueTirage]()
var historiqueLoto = [HistoriqueTirage]()

// nombre maximum de tirages historisés
let maximumHistorique = 1000

// insert un tirage en début de l'historique Chiffre (et supprime le dernier si besoin)
func insererHistoriqueChiffre (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueChiffre - Historique")
    #endif

    if historiqueChiffre.count >= maximumHistorique {
        historiqueChiffre.removeLast()
    }
    historiqueChiffre.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Lettre (et supprime le dernier si besoin)
func insererHistoriqueLettre (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueLettre - Historique")
    #endif

    if historiqueLettre.count >= maximumHistorique {
        historiqueLettre.removeLast()
    }
    historiqueLettre.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique ToiMoi (et supprime le dernier si besoin)
func insererHistoriqueToiMoi (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueToiMoi - Historique")
    #endif

    if historiqueToiMoi.count >= maximumHistorique {
        historiqueToiMoi.removeLast()
    }
    historiqueToiMoi.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique VraiFaux (et supprime le dernier si besoin)
func insererHistoriqueVraiFaux (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueVraiFaux - Historique")
    #endif
    
    if historiqueVraiFaux.count >= maximumHistorique {
        historiqueVraiFaux.removeLast()
    }
    historiqueVraiFaux.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique OuiNon (et supprime le dernier si besoin)
func insererHistoriqueOuiNon (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueOuiNon - Historique")
    #endif
    
    if historiqueOuiNon.count >= maximumHistorique {
        historiqueOuiNon.removeLast()
    }
    historiqueOuiNon.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique PileFace (et supprime le dernier si besoin)
func insererHistoriquePileFace (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriquePileFace - Historique")
    #endif
    
    if historiquePileFace.count >= maximumHistorique {
        historiquePileFace.removeLast()
    }
    historiquePileFace.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Chifoumi (et supprime le dernier si besoin)
func insererHistoriqueChifoumi (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueChifoumi - Historique")
    #endif
    
    if historiqueChifoumi.count >= maximumHistorique {
        historiqueChifoumi.removeLast()
    }
    historiqueChifoumi.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Dé (et supprime le dernier si besoin)
func insererHistoriqueDe (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueDe - Historique")
    #endif
    
    if historiqueDe.count >= maximumHistorique {
        historiqueDe.removeLast()
    }
    historiqueDe.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Carte (et supprime le dernier si besoin)
func insererHistoriqueCarte (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueCarte - Historique")
    #endif
    
   if historiqueCarte.count >= maximumHistorique {
        historiqueCarte.removeLast()
    }
    historiqueCarte.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Roulette (et supprime le dernier si besoin)
func insererHistoriqueRoulette (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueRoulette - Historique")
    #endif
    
    if historiqueRoulette.count >= maximumHistorique {
        historiqueRoulette.removeLast()
    }
    historiqueRoulette.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Direction (et supprime le dernier si besoin)
func insererHistoriqueDirection (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueDirection - Historique")
    #endif
    
    if historiqueDirection.count >= maximumHistorique {
        historiqueDirection.removeLast()
    }
    historiqueDirection.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Azimut (et supprime le dernier si besoin)
func insererHistoriqueAzimut (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueAzimut - Historique")
    #endif
    
    if historiqueAzimut.count >= maximumHistorique {
        historiqueAzimut.removeLast()
    }
    historiqueAzimut.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Jour (et supprime le dernier si besoin)
func insererHistoriqueJour (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueJour - Historique")
    #endif
    
    if historiqueJour.count >= maximumHistorique {
        historiqueJour.removeLast()
    }
    historiqueJour.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Euromillion (et supprime le dernier si besoin)
func insererHistoriqueEuromillion (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueEuromillion - Historique")
    #endif
    
    if historiqueEuromillion.count >= maximumHistorique {
        historiqueEuromillion.removeLast()
    }
    historiqueEuromillion.insert(historiqueAInserer, at: 0)
}
// insert un tirage en début de l'historique Loto (et supprime le dernier si besoin)
func insererHistoriqueLoto (historiqueAInserer: HistoriqueTirage ) {
    #if DEBUG
    print("insererHistoriqueLoto - Historique")
    #endif
    
   if historiqueLoto.count >= maximumHistorique {
        historiqueLoto.removeLast()
    }
    historiqueLoto.insert(historiqueAInserer, at: 0)
}
// sauvegarde des historiques des tirages dans le contexte utilisateur
func sauvegarderHistorique() {
    var encodedHistorique: Data
    #if DEBUG
    print("sauvegarderHistorique - Historique")
    #endif
    
    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueChiffre)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueChiffre")
    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueLettre)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueLettre")
    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueToiMoi)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueToiMoi")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueVraiFaux)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueVraiFaux")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueOuiNon)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueOuiNon")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiquePileFace)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriquePileFace")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueChifoumi)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueChifoumi")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueDe)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueDe")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueCarte)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueCarte")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueRoulette)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueRoulette")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueDirection)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueDirection")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueAzimut)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueAzimut")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueJour)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueJour")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueEuromillion)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueEuromillion")

    encodedHistorique = NSKeyedArchiver.archivedData(withRootObject: historiqueLoto)
    choixUtilisateur.set(encodedHistorique, forKey: "savedHistoriqueLoto")
}

// récupération de l'historique des tirages sauvgardés si ils existent
func recupererHistorique() {
    #if DEBUG
    print("recupereHistorique - Historique")
    #endif
    
    if (choixUtilisateur.object(forKey: "savedHistoriqueChiffre") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueChiffre") as! Data
        historiqueChiffre = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueLettre") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueLettre") as! Data
        historiqueLettre = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueToiMoi") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueToiMoi") as! Data
        historiqueToiMoi = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueVraiFaux") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueVraiFaux") as! Data
        historiqueVraiFaux = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueOuiNon") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueOuiNon") as! Data
        historiqueOuiNon = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriquePileFace") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriquePileFace") as! Data
        historiquePileFace = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueChifoumi") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueChifoumi") as! Data
        historiqueChifoumi = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueDe") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueDe") as! Data
        historiqueDe = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueCarte") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueCarte") as! Data
        historiqueCarte = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueRoulette") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueRoulette") as! Data
        historiqueRoulette = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueDirection") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueDirection") as! Data
        historiqueDirection = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueAzimut") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueAzimut") as! Data
        historiqueAzimut = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueJour") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueJour") as! Data
        historiqueJour = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueEuromillion") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueEuromillion") as! Data
        historiqueEuromillion = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    if (choixUtilisateur.object(forKey: "savedHistoriqueLoto") != nil) {
        let decodedHistorique  = choixUtilisateur.object(forKey: "savedHistoriqueLoto") as! Data
        historiqueLoto = NSKeyedUnarchiver.unarchiveObject(with: decodedHistorique) as! [HistoriqueTirage]
    }
    
    #if DEBUG
        dump(historiqueChiffre)
        dump(historiqueLettre)
        dump(historiqueToiMoi)
        dump(historiqueVraiFaux)
        dump(historiqueOuiNon)
        dump(historiquePileFace)
        dump(historiqueChifoumi)
        dump(historiqueDe)
        dump(historiqueCarte)
        dump(historiqueRoulette)
        dump(historiqueDirection)
        dump(historiqueAzimut)
        dump(historiqueJour)
        dump(historiqueEuromillion)
        dump(historiqueLoto)
    #endif
}

// Effacer tous les historique des tirages
func effacerTousHistorique() {
    #if DEBUG
    print("effacerTousHistorique - Historique")
    #endif
    
    historiqueChiffre.removeAll()
    historiqueLettre.removeAll()
    historiqueToiMoi.removeAll()
    historiqueVraiFaux.removeAll()
    historiqueOuiNon.removeAll()
    historiquePileFace.removeAll()
    historiqueChifoumi.removeAll()
    historiqueDe.removeAll()
    historiqueCarte.removeAll()
    historiqueRoulette.removeAll()
    historiqueDirection.removeAll()
    historiqueAzimut.removeAll()
    historiqueJour.removeAll()
    historiqueEuromillion.removeAll()
    historiqueLoto.removeAll()

    // envoi notification à l'écran historique pour qu'il soit rafraichi
    NotificationCenter.default.post(name: .historiqueSupprime, object: nil)
}
