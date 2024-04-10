//
//  TableViewController.swift
//  tableCellule
//
//  Created by Loïc DAVID on 27/07/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit

// cellule spécifique Tirage pour la UITable
class tirageCell: UITableViewCell {
    @IBOutlet weak var nomTirage: UILabel!
    @IBOutlet weak var reste: UILabel!
    @IBOutlet weak var resultatTirage: UILabel!
    @IBOutlet weak var image1Tirage: UIImageView!
    @IBOutlet weak var image2Tirage: UIImageView!
    @IBOutlet weak var image3Tirage: UIImageView!
    @IBOutlet weak var image4Tirage: UIImageView!
    @IBOutlet weak var image5Tirage: UIImageView!
}

class TirageController: UITableViewController, UITabBarControllerDelegate {
    
    // contrôles de l'interface graphique
    @IBOutlet weak var menuJouer: UIButton!
    @IBOutlet weak var boutonTous: UIButton!
    @IBOutlet weak var boutonJouer: UIButton!

    // booléen pour ne pas effectuer 2 fois un tirage au clic sur tab bar item Jeu (1 au clic Jeu et 1 autre au DidAppear)
    var tirageTabBar: Bool = true
    
    // libellés multi-langues dans les fichiers Localizable.string Fr et En
    let texteJouer = NSLocalizedString("texteJouer", comment: "Jouer")
    let texteAucun = NSLocalizedString("texteAucun", comment: "Aucun")
    let texteTous = NSLocalizedString("texteTous", comment: "Tous")

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        print("viewDidLoad - TirageController")
        #endif

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        // rend les tirages sélectionnables
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        // arrondi le bouton
        menuJouer.layer.cornerRadius = 4
        boutonJouer.layer.cornerRadius = 4
        
        // gestion du pool-to-refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshTirage), for: UIControl.Event.valueChanged)
        refreshControl.backgroundColor = UIColor.lightGray
        self.refreshControl = refreshControl

        // pour pouvoir gérer le clic sur les tab bar item (déclencher un tirage au clic sur Jeu)
        self.tabBarController?.delegate = self
        
        // par défaut les tirages sont effectués automatiquement à chaque changement de vue (si tirageAutomatique est positionné à Oui)
        tirageTabBar = true
        
        // pour test mémoire en phase de debug
        #if DEBUG
//            for _ in 1...1000 {
//                displayRandom(sender: boutonJouer)
//            }
        #endif
    }
    
    // UITabBarControllerDelegate : pour déclencher un tirage sur le clic du tab bar item Jeu uniquement quand la vue Tirage est affichée et que TirageAutomatique est paramétré à vrai
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        #if DEBUG
        print("tabBarController - TirageController")
        #endif
        
        let nc = tabBarController.viewControllers![0] as! UINavigationController
        if tabBarController.selectedIndex == 0 && !isEditing && tirageAutomatique && nc.visibleViewController?.restorationIdentifier == "vueTirage" {
            trouverPlaceTirage()
            displayRandom(sender: boutonJouer)
            tirageTabBar = false
        }
    }
    
    // à chaque affichage de la fenêtre on effectue les tirages aléatoires
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #if DEBUG
        print("viewDidAppear - TirageController")
        #endif
        
        if tirageTabBar && tirageAutomatique {
            trouverPlaceTirage()
            displayRandom(sender: boutonJouer)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        #if DEBUG
        print("viewWillDisappear - TirageController")
        #endif
        
        tirageTabBar = true
    }
    
    // Enable detection of shake motion
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        #if DEBUG
        print("motionBegan")
        #endif
        
        if motion == .motionShake {
            effacerTirage()
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        #if DEBUG
        print("motionEnded - TirageController")
        #endif
        
        if motion == .motionShake {
            displayRandom(sender: boutonJouer)
        }
    }
    
    // traitement à faire lors du refresh pull-to-refresh
    @objc func refreshTirage() {
        #if DEBUG
        print("refreshTirage - TirageController")
        #endif
        
        if !self.isEditing {
           displayRandom(sender: boutonJouer)
        }
        refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        #if DEBUG
        print("didReceiveMemoryWarning - TirageController")
        #endif

        // le traitement est fait dans AppDelegate
    }

    // pour pouvoir ré-ordonner les cellules
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        #if DEBUG
        print("canMoveRowAt - TirageController")
        #endif
        
        return true
    }
    
    // mémorise l'ordre des tirages
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        #if DEBUG
        print("moveRowAt - TirageController")
        #endif
        
        let tirageDeplace = listeTirage.remove(at: sourceIndexPath.row)
        listeTirage.insert(tirageDeplace, at: destinationIndexPath.row)
    }
    
    // masque les icones delete
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        #if DEBUG
        print("editingStyleForRowAt - TirageController")
        #endif
        
        return UITableViewCell.EditingStyle.none
    }
    
    // retourne le nombre de sections de la table
    override func numberOfSections(in tableView: UITableView) -> Int {
        #if DEBUG
        print("numberOfSections - TirageController")
        #endif
        
        return 1
    }
    
    // retourne le nombre de ligne de la table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #if DEBUG
        print("numberOfRowsInSection - TirageController")
        #endif
        
        return listeTirage.count
    }

    // remplit la table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #if DEBUG
        print("cellForRowAt - TirageController")
        #endif
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tirage", for: indexPath) as! tirageCell
        let tirageItem = listeTirage[indexPath.row]
        
        // en mode Edit on affiche tous les tirages et on sélectionne ceux non "cachés"
        if self.isEditing {
            cell.nomTirage?.text = tirageItem.nom
            cell.reste?.text = ""
            cell.resultatTirage?.text = ""
            cell.image1Tirage?.image = nil
            cell.image2Tirage?.image = nil
            cell.image3Tirage?.image = nil
            cell.image4Tirage?.image = nil
            cell.image5Tirage?.image = nil
            if (tirageItem.actif)  {
                self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
            }
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.white
            cell.selectedBackgroundView = bgColorView
        // en mode normal on affiche que les tirages "non cachés"
        } else {
            if tirageItem.actif {
                cell.nomTirage?.text = tirageItem.nom
                if afficherTirageRestant {
                    if tirageItem.id == Chiffre {
                        cell.reste?.text = "(" + String(tableauChiffre.count) + ")"
                    } else if tirageItem.id == Lettre {
                        cell.reste?.text = "(" + String(tableauLettre.count) + ")"
                    } else if tirageItem.id == Carte {
                        cell.reste?.text = "(" + String(jeuCarte.count) + ")"
                    } else if tirageItem.id == Jour {
                        cell.reste?.text = "(" + String(tableauJour.count) + ")"
                    } else {
                        cell.reste?.text = ""
                    }
                } else {
                    cell.reste?.text = ""
                }
                cell.resultatTirage?.text = tirageItem.resultat
                cell.resultatTirage.textColor = UIColor.black
                if (tirageItem.id == Euromillion) {                               // line wrap et coloration pour l'Euromillion
                    cell.resultatTirage.numberOfLines = 0
                    cell.resultatTirage.attributedText = formaterEuromillion(resultatEuromillion: tirageItem.resultat)
                } else if (tirageItem.id == Loto) {                               // line wrap et coloration pour le Loto
                        cell.resultatTirage.numberOfLines = 0
                        cell.resultatTirage.attributedText = formaterLoto(resultatLoto: tirageItem.resultat)
                }
                if tirageItem.id == Roulette && tirageItem.resultat.contains(texteRouge) {
                    cell.resultatTirage.textColor = UIColor.red
                } else if tirageItem.id == Roulette && tirageItem.resultat.contains(texteVert) {
                    cell.resultatTirage.textColor = UIColor.green
                }
                if tirageItem.image1 != "" {
                    cell.image1Tirage?.image = UIImage(named: tirageItem.image1)
                } else {
                    cell.image1Tirage?.image = UIImage(named: "empty")
                }
                if tirageItem.image2 != "" {
                    cell.image2Tirage?.image = UIImage(named: tirageItem.image2)
                } else {
                    cell.image2Tirage?.image = UIImage(named: "empty")
                }
                if tirageItem.image3 != "" {
                    cell.image3Tirage?.image = UIImage(named: tirageItem.image3)
                } else {
                    cell.image3Tirage?.image = UIImage(named: "empty")
                }
                if tirageItem.image4 != "" {
                    cell.image4Tirage?.image = UIImage(named: tirageItem.image4)
                } else {
                    cell.image4Tirage?.image = UIImage(named: "empty")
                }
                if tirageItem.image5 != "" {
                    cell.image5Tirage?.image = UIImage(named: tirageItem.image5)
                } else {
                    cell.image5Tirage?.image = UIImage(named: "empty")
                }
            } else {
                cell.isHidden = true
            }
        }
        return cell
    }

    // met la hauteur de la ligne cachée à zéro sauf en mode édition
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        #if DEBUG
        print("heightForRowAt - TirageController")
        #endif
        
        var rowHeight:CGFloat = UITableView.automaticDimension
        let tirageItem = listeTirage[indexPath.row]
        
        if !self.isEditing {
            if !tirageItem.actif {
                rowHeight = 0.0
            } else {
                // lignes plus hautes pour les iPad et encore plus haute quand c'est l'Euromillion ou le Loto
                if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
                    if (tirageItem.id == Euromillion) || (tirageItem.id == Loto) {
                        rowHeight =  70.0
                    } else {
                        rowHeight =  50.0
                    }
                } else {
                    rowHeight =  36.0
                }
            }
        } else {
            rowHeight = UITableView.automaticDimension
        }
        return rowHeight
    }
    
    // gère le mode edit (avec sélections et déselections des tirages)
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        #if DEBUG
        print("setEditing - TirageController")
        #endif
        
        tableView.setEditing(editing, animated: true)
        if editing {
            menuJouer.isHidden = true
            menuJouer.setTitle(nil, for: UIControl.State.normal)
            menuJouer.frame.size.width = 1  // on reduit sa largeur et son texte pour que le bouton Tous soit plus à gauche
            boutonTous.isHidden = false
            afficherAucunTous()
            boutonJouer.isHidden = true
            // ajouter code pour désactiver le segue vers l'historique
        } else {
            menuJouer.isHidden = false
            menuJouer.setTitle(texteJouer, for: UIControl.State.normal)
            menuJouer.frame.size.width = 71
            boutonTous.isHidden = true
            boutonJouer.isHidden = false
            if tirageAutomatique {
                displayRandom(sender: boutonJouer)
            }
        }
        self.tableView.reloadData()
    }

    // sélection ou désélection de tous les tirages
    @IBAction func selectionnerTous(_ sender: Any) {
        #if DEBUG
        print("selectionnerTous - TirageController")
        #endif
        
        var nbActif : Int = 0
        var activer : Bool = true
        for item in 0..<listeTirage.count {
            if (listeTirage[item].actif == true) {
                nbActif += 1
            }
        }
        if (nbActif == listeTirage.count) {
            activer = false
        }
        for item in 0..<listeTirage.count {
            if activer {
                activerTirage(item: item, actif: true)
            } else {
                activerTirage(item: item, actif: false)
            }
        }
        afficherAucunTous()
        self.tableView.reloadData()
    }

    // afficher Aucun ou Tous
    func afficherAucunTous() {
        #if DEBUG
        print("afficherAucunTous - TirageController")
        #endif
        
        var nbActif = 0
        for item in 0..<listeTirage.count {
            if listeTirage[item].actif {
                nbActif += 1
            }
        }
        if nbActif == listeTirage.count {
            boutonTous.setTitle(texteAucun, for: UIControl.State.normal)
        } else {
            boutonTous.setTitle(texteTous, for: UIControl.State.normal)
        }
    }
    
    // mémorise les tirages sélectionnés ou déselectionnés
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #if DEBUG
        print("didSelectRowAt - TirageController")
        #endif
        
        activerTirage(item: indexPath.row, actif: true)
        afficherAucunTous()
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        #if DEBUG
        print("didDeselectRowAt - TirageController")
        #endif
        
        activerTirage(item: indexPath.row, actif: false)
        afficherAucunTous()
    }
    
    func activerTirage(item: Int, actif: Bool) {
        #if DEBUG
        print("activerTirage - TirageController")
        #endif
        
        listeTirage[item].actif = actif
    }

    // affiche les tirages au sort (pour ceux sélectionnés)
    @IBAction func displayRandom(sender: UIButton) {
        #if DEBUG
        print("displayRandom - TirageController")
        #endif
        
        effacerTirage()
        tirageAuSort()

        // actualisation de l'affichage
        self.tableView.reloadData()
    }

    // passe le nom du tirage (de la cellule sélectionnée) à l'écran Historique
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        #if DEBUG
        print("prepare for segue - TirageController")
        #endif
        
        if segue.identifier == "affichageHistorique" {
            let cell = sender as! tirageCell
            let viewController = segue.destination as! HistoriqueController
            viewController.nom = cell.nomTirage.text!
        }
    }
    
    // empeche la navigation vers l'Historique en mode Edit
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        #if DEBUG
        print("shouldPerformSegue - TirageController")
        #endif
        
        if identifier == "affichageHistorique" && isEditing {
            return false
        }
        return true
    }

}
