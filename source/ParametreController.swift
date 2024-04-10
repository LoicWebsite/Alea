//
//  ParameterViewController.swift
//  Alea
//
//  Created by Loïc DAVID on 23/06/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit

class ParametreController: UITableViewController {
    
    // objets de l'écran
    @IBOutlet weak var demandeChiffreMinimum: UIStepper!
    @IBOutlet weak var resultatChiffreMinimum: UILabel!
    @IBOutlet weak var demandeChiffreMaximum: UIStepper!
    @IBOutlet weak var resultatChiffreMaximum: UILabel!
    @IBOutlet weak var demandeChiffreIndependant: UISwitch!
    @IBOutlet weak var demandeNombreChiffre: UIStepper!
    @IBOutlet weak var resultatNombreChiffre: UILabel!
    
    @IBOutlet weak var demandeLettreIndependant: UISwitch!
    @IBOutlet weak var demandeNombreLettre: UIStepper!
    @IBOutlet weak var resultatNombreLettre: UILabel!

    @IBOutlet weak var demandeNombreDe: UIStepper!
    @IBOutlet weak var resultatNombreDe: UILabel!
 
    @IBOutlet weak var demandeJourIndependant: UISwitch!
    
    @IBOutlet weak var demandeNombreCarte: UIStepper!
    @IBOutlet weak var resultatNombreCarte: UILabel!
    
    @IBOutlet weak var demandeTirageRestant: UISwitch!
    @IBOutlet weak var demandeTirageAutomatique: UISwitch!
    
    // libellés d'erreur multi-langue dans les fichiers Localizable.string
    let erreurMinimumMaximum = NSLocalizedString("minimumMaximum", comment: "erreur minimum maximum")
    let erreurChiffreMinimum = NSLocalizedString("chiffreMinimum", comment: "erreur minimum")
    let erreurChiffreMaximum = NSLocalizedString("chiffreMaximum", comment: "erreur maximum")
    let erreurIncoherence = NSLocalizedString("chiffreIncoherent", comment: "parametre chiffre incoherent")
    let validationReset = NSLocalizedString("validationReset", comment: "validation reset")
    let validationOui = NSLocalizedString("validationOui", comment: "oui")
    let validationNon = NSLocalizedString("validationNon", comment: "non")
    
    // chargement de l'écran (initialisation)
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        print("viewDidLoad - ParametreController")
        #endif
    }

    // à chaque affichage de la fenêtre on récupère les paramètres du contexte
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        print("viewWillAppear - ParametreController")
        #endif
        
        trouverPlaceTirage()
        demandeChiffreMinimum.value = Double(listeTirage[placeChiffre].minimum)
        resultatChiffreMinimum.text = String(listeTirage[placeChiffre].minimum)
        demandeChiffreMaximum.value = Double(listeTirage[placeChiffre].maximum)
        resultatChiffreMaximum.text = String(listeTirage[placeChiffre].maximum)
        demandeChiffreIndependant.setOn(listeTirage[placeChiffre].repetition, animated:false)
        resultatNombreChiffre.text = String(listeTirage[placeChiffre].occurence)
        demandeNombreChiffre.value = Double(listeTirage[placeChiffre].occurence)
        
        demandeLettreIndependant.setOn(listeTirage[placeLettre].repetition, animated:false)
        resultatNombreLettre.text = String(listeTirage[placeLettre].occurence)
        demandeNombreLettre.value = Double(listeTirage[placeLettre].occurence)
        
        resultatNombreDe.text = String(listeTirage[placeDe].occurence)
        demandeNombreDe.value = Double(listeTirage[placeDe].occurence)

        resultatNombreCarte.text = String(listeTirage[placeCarte].occurence)
        demandeNombreCarte.value = Double(listeTirage[placeCarte].occurence)
 
        demandeJourIndependant.setOn(listeTirage[placeJour].repetition, animated:false)
        
        demandeTirageRestant.setOn(afficherTirageRestant, animated:false)
        demandeTirageAutomatique.setOn(tirageAutomatique, animated:false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        #if DEBUG
        print("didReceiveMemoryWarning - ParametreController")
        #endif

        // le traitement est fait dans AppDelegate
    }
  
    // demande de confirmation du reset
    @IBAction func boutonReset(_ sender: Any) {
        #if DEBUG
        print("boutonReset - ParametreController")
        #endif
        
        let alert = UIAlertController(title: validationReset, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: validationOui, style: .cancel, handler: { action in self.resetAll()}))
        alert.addAction(UIAlertAction(title: validationNon, style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    // réintialisation des contrôles, des paramètres par défaut et remise à zéro des tableaux Chiffre, Lettre, Carte et Historique
    func resetAll() {
        #if DEBUG
        print("resetAll  - ParametreController")
        #endif
        
        initialiserListeTirage()
        initialiserTableaux()
        initialiserStatistiqueTirage()
        effacerTousHistorique()
        resultatChiffreMinimum.text = "1"
        demandeChiffreMinimum.value = 1
        resultatChiffreMaximum.text = "10"
        demandeChiffreMaximum.value = 10
        resultatNombreChiffre.text = "1"
        demandeNombreChiffre.value = 1
        resultatNombreLettre.text = "1"
        demandeNombreLettre.value = 1
        resultatNombreDe.text = "1"
        demandeNombreDe.value = 1
        resultatNombreCarte.text = "1"
        demandeNombreCarte.value = 1
        demandeChiffreIndependant.setOn(false, animated:true)
        demandeLettreIndependant.setOn(false, animated:true)
        demandeJourIndependant.setOn(false, animated:true)
        demandeTirageRestant.setOn(false, animated:true)
        afficherTirageRestant = false
        demandeTirageAutomatique.setOn(true, animated:true)
        tirageAutomatique = true
        
        // envoi notifications aux écrans Historique et Statistique pour qu'ils soient rafraichis
//        NotificationCenter.default.post(name: .historiqueSupprime, object: nil)
//        NotificationCenter.default.post(name: .statistiqueSupprime, object: nil)
    }

    // gestion du stepper pour afficher le nombre de chiffres et le stocker dans le contexte
    @IBAction func boutonDemandeChiffre(_ sender: Any) {
        #if DEBUG
        print("boutonDemandeChiffre - ParametreController")
        #endif
        
        let plageChiffre = Int(demandeChiffreMaximum.value) - Int(demandeChiffreMinimum.value) + 1      // la plage de chiffre entre le minimum et le maximum doit être supérieur à l'occurence si non répétition de chiffre
        if ((Int(demandeNombreChiffre.value) > plageChiffre) && (!listeTirage[placeChiffre].repetition)) {
            let alert = UIAlertController(title: erreurMinimumMaximum, message: erreurIncoherence, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            resultatNombreChiffre.text = "\(Int(demandeNombreChiffre.value))"
            listeTirage[placeChiffre].occurence = Int(demandeNombreChiffre.value)
        }
    }
   
    // gestion du stepper pour afficher le nombre de lettres et le stocker dans le contexte
    @IBAction func boutonDemandeLettre(_ sender: Any) {
        #if DEBUG
        print("boutonDemandeLettre - ParametreController")
        #endif
        
        resultatNombreLettre.text = "\(Int(demandeNombreLettre.value))"
        listeTirage[placeLettre].occurence = Int(demandeNombreLettre.value)
    }
    
    // gestion des stepper pour afficher et stocker le chiffre minimum dans le contexte
    @IBAction func boutonMinimum(_ sender: Any) {
        #if DEBUG
        print("boutonMinimum - ParametreController")
        #endif

        if (demandeChiffreMinimum.value >= demandeChiffreMaximum.value) {                       // le chiffre minimum doit être inférieur au chiffre maximum
            let alert = UIAlertController(title: erreurMinimumMaximum, message: erreurChiffreMinimum, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            demandeChiffreMinimum.value -= 1
        } else {
            let plageChiffre = Int(demandeChiffreMaximum.value) - Int(demandeChiffreMinimum.value) + 1      // la plage de chiffre entre le minimum et le maximum doit être supérieur à l'occurence si non répétition de chiffre
            if ((listeTirage[placeChiffre].occurence > plageChiffre) && (!listeTirage[placeChiffre].repetition)) {
                let alert = UIAlertController(title: erreurMinimumMaximum, message: erreurIncoherence, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                demandeChiffreMinimum.value -= 1
            } else {
                resultatChiffreMinimum.text = "\(Int(demandeChiffreMinimum.value))"
                listeTirage[placeChiffre].minimum = Int(resultatChiffreMinimum.text!)!
                initialiserTableauChiffre(item: placeChiffre)
            }
        }
    }
    
    // gestion des stepper pour afficher et stocker le chiffre maximum dans le contexte
    @IBAction func boutonMaximum(_ sender: Any) {
        #if DEBUG
        print("boutonMaximum - ParametreController")
        #endif
        
        if (demandeChiffreMaximum.value <= demandeChiffreMinimum.value) {
            let alert = UIAlertController(title: erreurMinimumMaximum, message: erreurChiffreMaximum, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            demandeChiffreMaximum.value += 1
        } else {
            let plageChiffre = Int(demandeChiffreMaximum.value) - Int(demandeChiffreMinimum.value) + 1      // la plage de chiffre entre le minimum et le maximum doit être supérieur à l'occurence si non répétition de chiffre
            if ((listeTirage[placeChiffre].occurence > plageChiffre) && (!listeTirage[placeChiffre].repetition)) {
                let alert = UIAlertController(title: erreurMinimumMaximum, message: erreurIncoherence, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                demandeChiffreMaximum.value += 1
            } else {
                resultatChiffreMaximum.text = "\(Int(demandeChiffreMaximum.value))"
                listeTirage[placeChiffre].maximum = Int(resultatChiffreMaximum.text!)!
                initialiserTableauChiffre(item: placeChiffre)
            }
        }
    }
    
    // mémorisation du choix tirage automatique (au changement d'écran) ou non
    @IBAction func activerTirageAutomatique(_ sender: UISwitch) {
        #if DEBUG
        print("activerTirageAutomatique - ParametreController")
        #endif
        
        if sender == demandeTirageAutomatique {
           tirageAutomatique = demandeTirageAutomatique.isOn
        }
    }

    // mémorisation de l'affichage des tirages restants ou non
    @IBAction func activerTirageRestant(_ sender: UISwitch) {
        #if DEBUG
        print("activerTirageRestant - ParametreController")
        #endif
        
        if sender == demandeTirageRestant {
            afficherTirageRestant = demandeTirageRestant.isOn
        }
    }
    
    // stockage dans le tableau des tirages des booléens chiffre et lettre indépendant s'ils ont été changés
    @IBAction func activerSwitch(_ sender: UISwitch) {
        #if DEBUG
        print("activerSwitch - ParametreController")
        #endif
        
        if sender == demandeChiffreIndependant {
            let plageChiffre = listeTirage[placeChiffre].maximum - listeTirage[placeChiffre].minimum + 1      // la plage de chiffre entre le minimum et le maximum doit être supérieur à l'occurence si non répétition de chiffre
            if ((listeTirage[placeChiffre].occurence > plageChiffre) && (!demandeChiffreIndependant.isOn)) {
                let alert = UIAlertController(title: erreurMinimumMaximum, message: erreurIncoherence, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                demandeChiffreIndependant.setOn(true, animated:false)
            } else {
                listeTirage[placeChiffre].repetition = demandeChiffreIndependant.isOn
                initialiserTableauChiffre(item: placeChiffre)
            }
        } else if sender == demandeLettreIndependant {
            listeTirage[placeLettre].repetition = demandeLettreIndependant.isOn
            initialiserTableauLettre()
        } else if sender == demandeJourIndependant {
            listeTirage[placeJour].repetition = demandeJourIndependant.isOn
            initialiserTableauJour(item: placeJour)
        }
    }
    
    // gestion du stepper pour afficher le nombre de dés et stocker la valeur dans le contexte
    @IBAction func boutonDe(_ sender: Any) {
        #if DEBUG
        print("boutonDe - ParametreController")
        #endif
        
        resultatNombreDe.text = "\(Int(demandeNombreDe.value))"
        listeTirage[placeDe].occurence = Int(demandeNombreDe.value)
    }

    // gestion du stepper pour afficher le nombre de cartes et stocker la valeur dans le contexte
    @IBAction func boutonCarte(_ sender: Any) {
        #if DEBUG
        print("boutonCarte - ParametreController")
        #endif
        
        resultatNombreCarte.text = "\(Int(demandeNombreCarte.value))"
        listeTirage[placeCarte].occurence = Int(demandeNombreCarte.value)
    }
}
