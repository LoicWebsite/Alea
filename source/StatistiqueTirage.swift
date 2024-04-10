//
//  StatistiqueTirage.swift
//  Alea
//
//  Created by Loïc DAVID on 14/08/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit

class StatistiqueTirage: NSObject, NSCoding {
    var id : Int
    var nombreTirage : Int
    var apparition : [Int]
    
    init(id: Int, nombreTirage: Int, apparition: [Int]) {
        #if DEBUG
        print("init - Statistique")
        #endif
        
        self.id = id
        self.nombreTirage = nombreTirage
        self.apparition = apparition
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        #if DEBUG
        print("decode - Statistique")
        #endif
        
        let id = aDecoder.decodeInteger(forKey: "id")
        let nombreTirage = aDecoder.decodeInteger(forKey: "nombreTirage")
        let apparition = aDecoder.decodeObject(forKey: "apparition") as! [Int]
        self.init(id: id, nombreTirage: nombreTirage, apparition: apparition)
    }
    
    func encode(with aCoder: NSCoder) {
        #if DEBUG
        print("encode - Statistique")
        #endif
        
        aCoder.encode(id, forKey: "id")
        aCoder.encode(nombreTirage, forKey: "nombreTirage")
        aCoder.encode(apparition, forKey: "apparition")
    }

}

// statistiques des tirages
var statistiqueTirage = [StatistiqueTirage]()

// constante pour remplir les tableaux de 0
let apparitionChiffre = [Int] (repeating: 0, count: 101)
let apparitionLettre = [Int] (repeating: 0, count: 26)
let apparitionCarte = [Int] (repeating: 0, count: 52)
let apparitionRoulette = [Int] (repeating: 0, count: 37)
let apparitionEuromillion = [Int] (repeating: 0, count: 51)
let apparitionLoto = [Int] (repeating: 0, count: 50)

// initialisation du tableau des statistiques de tirages
func initialiserStatistiqueTirage() {
    #if DEBUG
    print("initialiserStatistiqueTirage - Statistique")
    #endif
    
    statistiqueTirage = [
        StatistiqueTirage(id: Chiffre, nombreTirage: 0, apparition: apparitionChiffre),         // 101 (avec le 0)
        StatistiqueTirage(id: Lettre, nombreTirage: 0, apparition: apparitionLettre),           // 26
        StatistiqueTirage(id: ToiMoi, nombreTirage: 0, apparition: [0,0,0]),                    // 3
        StatistiqueTirage(id: VraiFaux, nombreTirage: 0, apparition: [0,0]),                    // 2
        StatistiqueTirage(id: OuiNon, nombreTirage: 0, apparition: [0,0]),                      // 2
        StatistiqueTirage(id: PileFace, nombreTirage: 0, apparition: [0,0]),                    // 2
        StatistiqueTirage(id: Chifoumi, nombreTirage: 0, apparition: [0,0,0]),                  // 3
        StatistiqueTirage(id: De, nombreTirage: 0, apparition: [0,0,0,0,0,0]),                  // 6
        StatistiqueTirage(id: Carte, nombreTirage: 0, apparition: apparitionCarte),             // 52
        StatistiqueTirage(id: Roulette, nombreTirage: 0, apparition: apparitionRoulette),       // 37 (avec le 0)
        StatistiqueTirage(id: Direction, nombreTirage: 0, apparition: [0,0,0,0]),               // 4
        StatistiqueTirage(id: Azimut, nombreTirage: 0, apparition: [0,0,0,0,0,0,0,0]),          // 8
        StatistiqueTirage(id: Jour, nombreTirage: 0, apparition: [0,0,0,0,0,0,0]),              // 7
        StatistiqueTirage(id: Euromillion, nombreTirage: 0, apparition: apparitionEuromillion), // 51 avec le 0 inutile dans le tableau
        StatistiqueTirage(id: Loto, nombreTirage: 0, apparition: apparitionLoto)                // 50 avec le 0 inutile dans le tableau
    ]
}

// fonctions EffacerStatistiqueXXXX remplace dans le tableau Statistique le row de la statistique concernée par un row vide
func effacerStatistiqueChiffre() {
    statistiqueTirage.remove(at: Chiffre)
    statistiqueTirage.insert(StatistiqueTirage(id: Chiffre, nombreTirage: 0, apparition: apparitionChiffre),at: Chiffre)
}
func effacerStatistiqueLettre() {
    statistiqueTirage.remove(at: Lettre)
    statistiqueTirage.insert(StatistiqueTirage(id: Lettre, nombreTirage: 0, apparition: apparitionLettre),at: Lettre)
}
func effacerStatistiqueToiMoi() {
    statistiqueTirage.remove(at: ToiMoi)
    statistiqueTirage.insert(StatistiqueTirage(id: ToiMoi, nombreTirage: 0, apparition: [0,0,0]),at: ToiMoi)
}
func effacerStatistiqueVraiFaux() {
    statistiqueTirage.remove(at: VraiFaux)
    statistiqueTirage.insert(StatistiqueTirage(id: VraiFaux, nombreTirage: 0, apparition: [0,0]),at: VraiFaux)
}
func effacerStatistiqueOuiNon() {
    statistiqueTirage.remove(at: OuiNon)
    statistiqueTirage.insert(StatistiqueTirage(id: OuiNon, nombreTirage: 0, apparition: [0,0]),at: OuiNon)
}
func effacerStatistiquePileFace() {
    statistiqueTirage.remove(at: PileFace)
    statistiqueTirage.insert(StatistiqueTirage(id: PileFace, nombreTirage: 0, apparition: [0,0]),at: PileFace)
}
func effacerStatistiqueChifoumi() {
    statistiqueTirage.remove(at: Chifoumi)
    statistiqueTirage.insert(StatistiqueTirage(id: Chifoumi, nombreTirage: 0, apparition: [0,0,0]),at: Chifoumi)
}
func effacerStatistiqueDe() {
    statistiqueTirage.remove(at: De)
    statistiqueTirage.insert(StatistiqueTirage(id: De, nombreTirage: 0, apparition: [0,0,0,0,0,0]),at: De)
}
func effacerStatistiqueCarte() {
    statistiqueTirage.remove(at: Carte)
    statistiqueTirage.insert(StatistiqueTirage(id: Carte, nombreTirage: 0, apparition: apparitionCarte),at: Carte)
}
func effacerStatistiqueRoulette() {
    statistiqueTirage.remove(at: Roulette)
    statistiqueTirage.insert(StatistiqueTirage(id: Roulette, nombreTirage: 0, apparition: apparitionRoulette),at: Roulette)
}
func effacerStatistiqueDirection() {
    statistiqueTirage.remove(at: Direction)
    statistiqueTirage.insert(StatistiqueTirage(id: Direction, nombreTirage: 0, apparition: [0,0,0,0]),at: Direction)
}
func effacerStatistiqueAzimut() {
    statistiqueTirage.remove(at: Azimut)
    statistiqueTirage.insert(StatistiqueTirage(id: Azimut, nombreTirage: 0, apparition: [0,0,0,0,0,0,0,0]),at: Azimut)
}
func effacerStatistiqueJour() {
    statistiqueTirage.remove(at: Jour)
    statistiqueTirage.insert(StatistiqueTirage(id: Jour, nombreTirage: 0, apparition: [0,0,0,0,0,0,0]),at: Jour)
}
func effacerStatistiqueEuromillion() {
    statistiqueTirage.remove(at: Euromillion)
    statistiqueTirage.insert(StatistiqueTirage(id: Euromillion, nombreTirage: 0, apparition: apparitionEuromillion),at: Euromillion)
}
func effacerStatistiqueLoto() {
    statistiqueTirage.remove(at: Loto)
    statistiqueTirage.insert(StatistiqueTirage(id: Loto, nombreTirage: 0, apparition: apparitionLoto),at: Loto)
}

// sauvegarde des statistiques des tirages dans le contexte utilisateur
func sauvegarderStatistique() {
    #if DEBUG
    print("sauvegarderStatistique - Statistique")
    #endif
    
    let encodedStatistique: Data = NSKeyedArchiver.archivedData(withRootObject: statistiqueTirage)
    choixUtilisateur.set(encodedStatistique, forKey: "savedStatistiqueTirage")

    #if DEBUG
    dump(statistiqueTirage)
    #endif
}

// récupération des statistiques des tirages sauvgardés si elles existent, sinon initialisation des statistiques
func recupererStatistique() {
    #if DEBUG
    print("recupererStatistique - Statistique")
    #endif
    
    if (choixUtilisateur.object(forKey: "savedStatistiqueTirage") != nil) {
        let decodedStatistique  = choixUtilisateur.object(forKey: "savedStatistiqueTirage") as! Data
        statistiqueTirage = NSKeyedUnarchiver.unarchiveObject(with: decodedStatistique) as! [StatistiqueTirage]

        // ajout d'Euromillion et Loto s'ils n'xistaient pas (cas de mise à jour de l'appli de 1.2 vers 1.3)
        if statistiqueTirage[statistiqueTirage.endIndex - 1].id == Jour {
            statistiqueTirage.append(StatistiqueTirage(id: Euromillion, nombreTirage: 0, apparition: apparitionEuromillion))
            statistiqueTirage.append(StatistiqueTirage(id: Loto, nombreTirage: 0, apparition: apparitionLoto))
        }
    } else {
        initialiserStatistiqueTirage()
    }
    
    #if DEBUG
    dump(statistiqueTirage)
    #endif
}

// mise à jour des statistiques de Chiffre sorti
func compterTirageChiffre(chiffreApparu: Int) {
    #if DEBUG
    print("compterTirageChiffre - Statistique")
    #endif
    
    statistiqueTirage[Chiffre].nombreTirage += 1
    statistiqueTirage[Chiffre].apparition[chiffreApparu] += 1
}

// mise à jour des statistiques de Lettre sortie
func compterTirageLettre(lettreApparue: String) {
    #if DEBUG
    print("compterTirageLettre - Statistique")
    #endif
    
    let rangLettre = alphabet.index{$0 == lettreApparue}
    statistiqueTirage[Lettre].nombreTirage += 1
    statistiqueTirage[Lettre].apparition[rangLettre!] += 1
}

// mise à jour des statistiques de Toi ou moi sorti
func compterTirageToiMoi(toiMoiApparu: Int) {
    #if DEBUG
    print("compterTirageToiMoi - Statistique")
    #endif
    
    statistiqueTirage[ToiMoi].nombreTirage += 1
    statistiqueTirage[ToiMoi].apparition[toiMoiApparu] += 1
}

// mise à jour des statistiques de Vrai ou faux sorti
func compterTirageVraiFaux(vraiFauxApparu: Int) {
    #if DEBUG
    print("compterTirageVraiFaux - Statistique")
    #endif
    
    statistiqueTirage[VraiFaux].nombreTirage += 1
    statistiqueTirage[VraiFaux].apparition[vraiFauxApparu] += 1
}

// mise à jour des statistiques de Oui ou non sorti
func compterTirageOuiNon(ouiNonApparu: Int) {
    #if DEBUG
    print("compterTirageOuiNon - Statistique")
    #endif
    
    statistiqueTirage[OuiNon].nombreTirage += 1
    statistiqueTirage[OuiNon].apparition[ouiNonApparu] += 1
}

// mise à jour des statistiques de Pile ou face sorti
func compterTiragePileFace(pileFaceApparu: Int) {
    #if DEBUG
    print("compterTiragePileFace - Statistique")
    #endif
    
    statistiqueTirage[PileFace].nombreTirage += 1
    statistiqueTirage[PileFace].apparition[pileFaceApparu] += 1
}

// mise à jour des statistiques de Chifoumi sorti
func compterTirageChifoumi(chifoumiApparu: Int) {
    #if DEBUG
    print("compterTirageChifoumi - Statistique")
    #endif
    
    statistiqueTirage[Chifoumi].nombreTirage += 1
    statistiqueTirage[Chifoumi].apparition[chifoumiApparu] += 1
}

// mise à jour des statistiques de Dé sorti
func compterTirageDe(deApparu: Int) {
    #if DEBUG
    print("compterTirageDe - Statistique")
    #endif
    
    statistiqueTirage[De].nombreTirage += 1
    statistiqueTirage[De].apparition[deApparu] += 1
}

// mise à jour des statistiques de Carte sortie
func compterTirageCarte(carteApparue: String) {
    #if DEBUG
    print("compterTirageCarte - Statistique")
    #endif
    
    let rangCarte = deck.index{$0 == carteApparue}
    statistiqueTirage[Carte].nombreTirage += 1
    statistiqueTirage[Carte].apparition[rangCarte!] += 1
}

// mise à jour des statistiques de Roulette sortie
func compterTirageRoulette(rouletteApparue: Int) {
    #if DEBUG
    print("compterTirageRoulette - Statistique")
    #endif
    
    statistiqueTirage[Roulette].nombreTirage += 1
    statistiqueTirage[Roulette].apparition[rouletteApparue] += 1
}

// mise à jour des statistiques de Direction sortie
func compterTirageDirection(directionApparue: Int) {
    #if DEBUG
    print("compterTirageDirection - Statistique")
    #endif
    
    statistiqueTirage[Direction].nombreTirage += 1
    statistiqueTirage[Direction].apparition[directionApparue] += 1
}

// mise à jour des statistiques de l'Azimut sorti
func compterTirageAzimut(azimutApparu: Int) {
    #if DEBUG
    print("compterTirageAzimut - Statistique")
    #endif
    
    statistiqueTirage[Azimut].nombreTirage += 1
    statistiqueTirage[Azimut].apparition[azimutApparu] += 1
}

// mise à jour des statistiques du Jour sorti
func compterTirageJour(jourApparu: Int) {
    #if DEBUG
    print("compterTirageJour - Statistique")
    #endif
    
    statistiqueTirage[Jour].nombreTirage += 1
    statistiqueTirage[Jour].apparition[jourApparu] += 1
}

// mise à jour des statistiques de Euromillion sorti
func compterTirageEuromillion(euromillionApparu: Int) {
    #if DEBUG
    print("compterTirageEuromillion - Statistique")
    #endif
    
    statistiqueTirage[Euromillion].nombreTirage += 1
    statistiqueTirage[Euromillion].apparition[euromillionApparu] += 1
}

// mise à jour des statistiques de Loto sorti
func compterTirageLoto(lotoApparu: Int) {
    #if DEBUG
    print("compterTirageLoto - Statistique")
    #endif
    
    statistiqueTirage[Loto].nombreTirage += 1
    statistiqueTirage[Loto].apparition[lotoApparu] += 1
}
