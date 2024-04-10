//
//  StatistiqueController.swift
//  Alea
//
//  Created by Loïc DAVID on 24/08/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit

class statistiqueCell: UITableViewCell {
    @IBOutlet weak var tirage: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var comptage: UILabel!
}

class StatistiqueController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // contrôles de l'écran
    @IBOutlet weak var effacer: UIButton!
    @IBOutlet weak var nomTirage: UILabel!
    @IBOutlet weak var nombreTirage: UILabel!
    @IBOutlet weak var nomStatistique: UILabel!
    @IBOutlet weak var tableStatistique: UITableView!

    // identifiant et nombre de tirage pour lequel on affiche l'historique
    var idTirage = -1
    var nbTirage = 0
    var nom: String = ""
    
    // au chragement : personalise l'entête en fonction du tirage sélectionné
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        print("viewDidLoad - Statistique Controller")
        #endif
        
        // abonnement à la notification envoyée par 'resetAll' de l'écran Paramètre
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView(_:)), name: .statistiqueSupprime, object: nil)
    }
    
    // à chaque affichage de la fenêtre on rafraichit la vue
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        print("viewWillAppear - Statistique Controller")
        #endif
        
        preparerAffichage()
        tableStatistique.reloadData()
    }
    
    // affichage du titre et gestion du bouton Effacer
    func preparerAffichage() {
        #if DEBUG
        print("preparerAffichage - Statistique Controller")
        #endif
        
        if idTirage != -1 {
            nom = chercherNomTirage(idTirage: idTirage)
            nomStatistique.text = nom
            nomTirage.text = nom
            nbTirage = statistiqueTirage[idTirage].nombreTirage
            nombreTirage.text = String(nbTirage)
        }
        if nbTirage == 0 {
            tableStatistique.reloadData()
            effacer.isEnabled = false
        } else {
            effacer.isEnabled = true
        }
    }

    // actualisation de l'affichage appelée par notification center (suite au vidage statistique suite au reste dans écran Paramètre)
    @objc func refreshView(_ notification: Notification) {
        actualiserAffichage()
    }
    // actualisation de l'affichage
    func actualiserAffichage() {
        #if DEBUG
        print("actualiserAffichage - Statistique Controller")
        #endif
        
        tableStatistique.reloadData()
        nombreTirage.text = "0"
        effacer.isEnabled = false
    }
    
    // retourne le nombre de ligne de la statistique en cours
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #if DEBUG
        print("numberOfRowsInSection - Statistique Controller")
        #endif
        
        return statistiqueTirage[idTirage].apparition.count
    }
    
    // est appelée à chaque cellule : remplit la cellule en fonction de la statistique
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #if DEBUG
        print("cellForRowAt - Statistique Controller")
        #endif
        
        let cellule = tableView.dequeueReusableCell(withIdentifier: "statistiqueCell", for: indexPath) as! statistiqueCell
        if idTirage == Chiffre {
            remplirChiffre(cell: cellule, row: indexPath.row)
        } else if idTirage == Lettre {
            remplirLettre(cell: cellule, row: indexPath.row)
        } else if idTirage == De {
            remplirDe(cell: cellule, row: indexPath.row)
        } else if idTirage == Carte {
            remplirCarte(cell: cellule, row: indexPath.row)
        } else if idTirage == ToiMoi {
            remplirToiMoi(cell: cellule, row: indexPath.row)
        } else if idTirage == VraiFaux {
            remplirVraiFaux(cell: cellule, row: indexPath.row)
        } else if idTirage == OuiNon {
            remplirOuiNon(cell: cellule, row: indexPath.row)
        } else if idTirage == PileFace {
            remplirPileFace(cell: cellule, row: indexPath.row)
        } else if idTirage == Chifoumi {
            remplirChifoumi(cell: cellule, row: indexPath.row)
        } else if idTirage == Roulette {
            remplirRoulette(cell: cellule, row: indexPath.row)
        } else if idTirage == Direction {
            remplirDirection(cell: cellule, row: indexPath.row)
        } else if idTirage == Azimut {
            remplirAzimut(cell: cellule, row: indexPath.row)
        } else if idTirage == Jour {
            remplirJour(cell: cellule, row: indexPath.row)
        } else if idTirage == Euromillion {
            remplirEuromillion(cell: cellule, row: indexPath.row)
        } else if idTirage == Loto {
            remplirLoto(cell: cellule, row: indexPath.row)
        } else {
            cellule.comptage?.text = String(statistiqueTirage[idTirage].apparition[indexPath.row])
        }
        return cellule
    }
    
    // fixe la hauteur de chaque ligne (plus haute pour les iPad)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        #if DEBUG
        print("heightForRowAt - Statistique Controller")
        #endif

        // pour Euromillion et Loto on affiche pas la première ligne qui est le 0 inutilisé
        if (idTirage == Euromillion) || (idTirage == Loto) {
            if (indexPath.row == 0) {
                return 0
            }
        }
        
        // lignes plus hautes pour les iPad
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            return 50.0
        } else {
            return 36.0
        }
    }
    
    func remplirChiffre(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirChiffre - Statistique Controller")
        #endif
        
        cell.tirage?.text = String(row)
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    func remplirLettre(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirLettre - Statistique Controller")
        #endif
        
        cell.tirage?.text = alphabet[row]
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    func remplirCarte(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirCarte - Statistique Controller")
        #endif
        
        cell.tirage?.text = ""
        cell.image1?.image = UIImage(named: deck[row])
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    func remplirDe(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirDe - Statistique Controller")
        #endif
        
        cell.tirage?.text = ""
        switch row {
        case 0 :
            cell.image1?.image = UIImage(named: "dice-1")
        case 1 :
            cell.image1?.image = UIImage(named: "dice-2")
        case 2 :
            cell.image1?.image = UIImage(named: "dice-3")
        case 3 :
            cell.image1?.image = UIImage(named: "dice-4")
        case 4 :
            cell.image1?.image = UIImage(named: "dice-5")
        case 5 :
            cell.image1?.image = UIImage(named: "dice-6")
        default :
            cell.image1?.image = UIImage(named: "empty")
        }
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }

    func remplirToiMoi(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirToiMoi - Statistique Controller")
        #endif
        
        if row == 0 {
            cell.tirage?.text = texteToi
        } else if row == 1 {
            cell.tirage?.text = texteMoi
        } else {
            cell.tirage?.text = texteNous
        }
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    func remplirVraiFaux(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirVraiFaux - Statistique Controller")
        #endif
        
        if row == 0 {
            cell.tirage?.text = texteFaux
        } else {
            cell.tirage?.text = texteVrai
        }
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }

    func remplirOuiNon(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirOuiNon - Statistique Controller")
        #endif
        
        if row == 0 {
            cell.tirage?.text = texteOui
        } else {
            cell.tirage?.text = texteNon
        }
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }

    func remplirPileFace(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirPileFace - Statistique Controller")
        #endif
        
        if row == 0 {
            cell.tirage?.text = textePile
        } else {
            cell.tirage?.text = texteFace
        }
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    func remplirChifoumi(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("preparerAffichage - Statistique Controller")
        #endif
        
        cell.tirage?.text = texteChifoumi[row]
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }

    func remplirRoulette(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirChifoumi - Statistique Controller")
        #endif
        
        cell.tirage?.text = String(row)
        if rouge.contains(row) {
            cell.tirage.textColor = UIColor.red
        } else if noir.contains(row) {
            cell.tirage.textColor = UIColor.black
        } else {
            cell.tirage.textColor = UIColor.green
        }
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    func remplirDirection(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirDirection - Statistique Controller")
        #endif
        
        cell.tirage?.text = String(texteDirection[row])
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    func remplirAzimut(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirAzimut - Statistique Controller")
        #endif
        
        cell.tirage?.text = String(tableauDegre[row]) + "°  " + tableauCardinal[row]
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    func remplirJour(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirJour - Statistique Controller")
        #endif
        
        cell.tirage?.text = tableauNomJour[row]
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }

    func remplirEuromillion(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirEuromillion - Statistique Controller")
        #endif
        
        cell.tirage?.text = String(row)
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }

    func remplirLoto(cell: statistiqueCell, row: Int) {
        #if DEBUG
        print("remplirLoto - Statistique Controller")
        #endif
        
        cell.tirage?.text = String(row)
        cell.comptage?.text = String(statistiqueTirage[idTirage].apparition[row])
    }
    
    // gestion du bouton Effacer
    @IBAction func effacer(sender: UIButton) {
        #if DEBUG
        print("effacer - Statistique Controller")
        #endif
        
        let effacerStatistique = String(format: NSLocalizedString("effacerStatistique", comment: "effacer statistique"), nom)
        let alert = UIAlertController(title: effacerStatistique, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("validationOui", comment: "oui"), style: .cancel, handler: { action in self.deleteStatistic()}))
        alert.addAction(UIAlertAction(title: NSLocalizedString("validationNon", comment: "non"), style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func deleteStatistic() {
        #if DEBUG
        print("deleteStatistic - Statistique Controller")
        #endif
        
        switch idTirage {
            case Chiffre :
                effacerStatistiqueChiffre()
            case Lettre :
                effacerStatistiqueLettre()
            case ToiMoi :
                effacerStatistiqueToiMoi()
            case OuiNon :
                effacerStatistiqueOuiNon()
            case PileFace :
                effacerStatistiquePileFace()
            case Chifoumi :
                effacerStatistiqueChifoumi()
            case De :
                effacerStatistiqueDe()
            case Carte :
                effacerStatistiqueCarte()
            case Roulette :
                effacerStatistiqueRoulette()
            case Direction :
                effacerStatistiqueDirection()
            case Azimut :
                effacerStatistiqueAzimut()
            case Jour :
                effacerStatistiqueJour()
            case Euromillion :
                effacerStatistiqueEuromillion()
            case Loto :
                effacerStatistiqueLoto()
            default :
                break
        }
        preparerAffichage()
        tableStatistique.reloadData()
    }
}
