//
//  HistoriqueControllerViewController.swift
//  Alea
//
//  Created by Loïc DAVID on 19/08/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit

// cellule spécifique Historique Tirage pour la Table
class historiqueCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var resultat: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!

}

class HistoriqueController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // contrôles de l'écran
    @IBOutlet weak var statistique: UIButton!
    @IBOutlet weak var effacer: UIButton!
    @IBOutlet weak var nombreTirage: UILabel!
    @IBOutlet weak var nomHistorique: UILabel!
    @IBOutlet weak var tableHistorique: UITableView!

    // variable renseigné par l'appelant (TirageController.swift)
    var nom: String = ""

    // identifiant et nombre de tirage pour lequel on affiche l'historique
    var idTirage = -1
    var nbTirage = 0
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        print("viewDidLoad - HistoriqueController")
        #endif

        // bordure de la table
        tableHistorique.layer.borderColor = UIColor.lightGray.cgColor
        tableHistorique.layer.borderWidth = 0.5

        // abonnement à la notification envoyée par 'effacerTousHistorique' suite au memory warning
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView(_:)), name: .historiqueSupprime, object: nil)
    }

    // à chaque affichage de la fenêtre on ...
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        print("viewWillAppear - HistoriqueController")
        #endif

        preparerAffichage()
        tableHistorique.reloadData()
    }

    // affichage du titre et gestion du bouton Effacer
    func preparerAffichage() {
        #if DEBUG
        print("preparerAffichage - HistoriqueController")
        #endif
        
        nomHistorique.text = nom
        idTirage = chercherIdTirage(nomTirage: nom)
        switch idTirage {
        case Chiffre :
            nbTirage = historiqueChiffre.count
        case Lettre :
            nbTirage = historiqueLettre.count
        case ToiMoi :
            nbTirage = historiqueToiMoi.count
        case VraiFaux :
            nbTirage = historiqueVraiFaux.count
        case OuiNon :
            nbTirage = historiqueOuiNon.count
        case PileFace :
            nbTirage = historiquePileFace.count
        case Chifoumi :
            nbTirage = historiqueChifoumi.count
        case De :
            nbTirage = historiqueDe.count
        case Carte :
            nbTirage = historiqueCarte.count
        case Roulette :
            nbTirage = historiqueRoulette.count
        case Direction :
            nbTirage = historiqueDirection.count
        case Azimut :
            nbTirage = historiqueAzimut.count
        case Jour :
            nbTirage = historiqueJour.count
        case Euromillion :
            nbTirage = historiqueEuromillion.count
        case Loto :
            nbTirage = historiqueLoto.count
        default :
            nbTirage = 0
        }
        
        nombreTirage.text = String(nbTirage)
        if nbTirage == 0 {
            tableHistorique.reloadData()
            effacer.isEnabled = false
        } else {
            effacer.isEnabled = true
        }
        
        let labelBouton: String = NSLocalizedString("statistique", comment: "statistique") + "  " + nom + "  >"
        statistique.setTitle(labelBouton, for: .normal )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        #if DEBUG
        print("didReceiveMemoryWarning - HistoriqueController")
        #endif
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        #if DEBUG
        print("viewWillDisappear - HistoriqueController")
        #endif
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        #if DEBUG
        print("numberOfSectionsInTableView - HistoriqueController")
        #endif
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #if DEBUG
        print("numberOfRowsInSection - HistoriqueController")
        #endif
        
        return nbTirage
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #if DEBUG
        print("cellForRowAt - HistoriqueController")
        #endif
        
        let cellule = tableView.dequeueReusableCell(withIdentifier: "historiqueCell", for: indexPath) as! historiqueCell
        cellule.date.text = ""
        cellule.resultat.text = ""
        cellule.image1?.image = nil
        cellule.image2?.image = nil
        cellule.image3?.image = nil
        cellule.image4?.image = nil
        cellule.image5?.image = nil
        switch idTirage {
            case Chiffre :
                if !historiqueChiffre.isEmpty {
                    let historiqueItem = historiqueChiffre[indexPath.row]
                    remplirCellule(cell: cellule, historiqueItem: historiqueItem)
                }
        case Lettre :
            if !historiqueLettre.isEmpty {
                let historiqueItem = historiqueLettre[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case ToiMoi :
            if !historiqueToiMoi.isEmpty {
                let historiqueItem = historiqueToiMoi[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case VraiFaux :
            if !historiqueVraiFaux.isEmpty {
                let historiqueItem = historiqueVraiFaux[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case OuiNon :
            if !historiqueOuiNon.isEmpty {
                let historiqueItem = historiqueOuiNon[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case PileFace :
            if !historiquePileFace.isEmpty {
                let historiqueItem = historiquePileFace[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case Chifoumi :
            if !historiqueChifoumi.isEmpty {
                let historiqueItem = historiqueChifoumi[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case De :
            if !historiqueDe.isEmpty {
                let historiqueItem = historiqueDe[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case Carte :
            if !historiqueCarte.isEmpty {
                let historiqueItem = historiqueCarte[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case Roulette :
            if !historiqueRoulette.isEmpty {
                let historiqueItem = historiqueRoulette[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
                if historiqueItem.resultat.contains(texteRouge) {
                    cellule.resultat.textColor = UIColor.red
                } else if historiqueItem.resultat.contains(texteVert) {
                    cellule.resultat.textColor = UIColor.green
                } else {
                    cellule.resultat.textColor = UIColor.black
                }
            }
        case Direction :
            if !historiqueDirection.isEmpty {
                let historiqueItem = historiqueDirection[indexPath.row]
                cellule.image3?.image = UIImage(named: "empty")
                cellule.image4?.image = UIImage(named: "empty")
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case Azimut :
            if !historiqueAzimut.isEmpty {
                let historiqueItem = historiqueAzimut[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case Jour :
            if !historiqueJour.isEmpty {
                let historiqueItem = historiqueJour[indexPath.row]
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
            }
        case Euromillion :
            if !historiqueEuromillion.isEmpty {
                let historiqueItem = historiqueEuromillion[indexPath.row]
                cellule.resultat.numberOfLines = 0
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
                cellule.resultat.attributedText = formaterEuromillion(resultatEuromillion: historiqueItem.resultat)
            }
        case Loto :
            if !historiqueLoto.isEmpty {
                let historiqueItem = historiqueLoto[indexPath.row]
                cellule.resultat.numberOfLines = 0
                remplirCellule(cell: cellule, historiqueItem: historiqueItem)
                cellule.resultat.attributedText = formaterLoto(resultatLoto: historiqueItem.resultat)
            }
        default :
            break
        }
        return cellule
    }
    
    func remplirCellule(cell: historiqueCell, historiqueItem: HistoriqueTirage) {
        #if DEBUG
        print("remplirCellule - HistoriqueController")
        #endif

        cell.date.text = DateFormatter.localizedString(from: historiqueItem.dateTirage, dateStyle: .short, timeStyle: .medium)
        cell.date?.numberOfLines=0                                  // line wrap pour la date
        cell.date.lineBreakMode = .byWordWrapping                   // line wrap sur le premier blanc de la date
        cell.resultat.text = historiqueItem.resultat
        if historiqueItem.image1 != "" {
            cell.image1?.image = UIImage(named: historiqueItem.image1)
        }
        if historiqueItem.image2 != "" {
            cell.image2?.image = UIImage(named: historiqueItem.image2)
        }
        if historiqueItem.image3 != "" {
            cell.image3?.image = UIImage(named: historiqueItem.image3)
        }
        if historiqueItem.image4 != "" {
            cell.image4?.image = UIImage(named: historiqueItem.image4)
        }
        if historiqueItem.image5 != "" {
            cell.image5?.image = UIImage(named: historiqueItem.image5)
        }
    }
    
    // fixe la hauteur de chaque ligne (plus haute pour les iPad)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        #if DEBUG
        print("heightForRowAt - HistoriqueController")
        #endif
        
        // lignes plus hautes pour les iPad et encore plus haute quand c'est l'Euromillion ou le Loto
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            if (idTirage == Euromillion) || (idTirage == Loto) {
                return 70.0
            } else {
                return 50.0
            }
        } else {
            return 36.0
        }
    }
    
    // efface l'historique des tirages pour le tirage affiché
    func deleteHistoric() {
        #if DEBUG
        print("deleteHistoric - HistoriqueController")
        #endif
        
        switch idTirage {
        case Chiffre :
            historiqueChiffre.removeAll()
        case Lettre :
            historiqueLettre.removeAll()
        case ToiMoi :
            historiqueToiMoi.removeAll()
        case VraiFaux :
            historiqueVraiFaux.removeAll()
        case OuiNon :
            historiqueOuiNon.removeAll()
        case PileFace :
            historiquePileFace.removeAll()
        case Chifoumi :
            historiqueChifoumi.removeAll()
        case De :
            historiqueDe.removeAll()
        case Carte :
            historiqueCarte.removeAll()
        case Roulette :
            historiqueRoulette.removeAll()
        case Direction :
            historiqueDirection.removeAll()
        case Azimut :
            historiqueAzimut.removeAll()
        case Jour :
            historiqueJour.removeAll()
        case Euromillion :
            historiqueEuromillion.removeAll()
        case Loto :
            historiqueLoto.removeAll()
        default :
            break
        }
        actualiserAffichage()
    }
    
    // actualisation de l'affichage appelée par notification center (suite au vidage historique suite au memory warning)
    @objc func refreshView(_ notification: Notification) {
        actualiserAffichage()
    }
    // actualisation de l'affichage
    func actualiserAffichage() {
        #if DEBUG
        print("actualiserAffichage - Historique Controller")
        #endif
        
        tableHistorique.reloadData()
        nombreTirage.text = "0"
        effacer.isEnabled = false
    }
    
    // gestion du bouton Effacer
    @IBAction func effacer(sender: UIButton) {
        #if DEBUG
        print("effacer - HistoriqueController")
        #endif
        
        let effacerHistorique = String(format: NSLocalizedString("effacerHistorique", comment: "effacer historique"), nom)
        let alert = UIAlertController(title: effacerHistorique, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("validationOui", comment: "oui"), style: .cancel, handler: { action in self.deleteHistoric()}))
        alert.addAction(UIAlertAction(title: NSLocalizedString("validationNon", comment: "non"), style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // passe l'id du tirage à l'écran Statistique
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        #if DEBUG
        print("prepare for segue - HistoriqueController")
        #endif
        
        if segue.identifier == "HistoriqueVersStatistique" {
            let viewController = segue.destination as! StatistiqueController
            viewController.idTirage = idTirage
        }
    }
}
