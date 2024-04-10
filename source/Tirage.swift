//
//  Tirage.swift
//  Alea
//
//  Created by Loïc DAVID on 03/08/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit

// classe tirage avec ses méthode d'encodage et décodage (pour stockage dans NSUserDefaults)
class Tirage: NSObject, NSCoding {
    var id : Int
    var actif : Bool
    var nom : String
    var resultat : String
    var image1 : String
    var image2 : String
    var image3 : String
    var image4 : String
    var image5 : String
    var occurence : Int
    var minimum : Int
    var maximum : Int
    var repetition : Bool

    init(id: Int, actif: Bool, nom: String, resultat: String, image1: String, image2: String, image3: String, image4: String, image5: String, occurence: Int, minimum: Int, maximum: Int, repetition: Bool) {
        #if DEBUG
        print("init - Tirage")
        #endif
        
        self.id = id
        self.actif = actif
        self.nom = nom
        self.resultat = resultat
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.image4 = image4
        self.image5 = image5
        self.occurence = occurence
        self.minimum = minimum
        self.maximum = maximum
        self.repetition = repetition
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        #if DEBUG
        print("decode - Tirage")
        #endif
        
        let id = aDecoder.decodeInteger(forKey: "id")
        let actif = aDecoder.decodeBool(forKey: "actif")
        var nom = aDecoder.decodeObject(forKey: "nom") as! String
        
        // dans la version 1.2 les noms tirages n'étaient pas sauvegardés dans le contexte. De plus la langue peut avoir changé entre 2 lancements de l'appli. Donc on recharge systématiquement les libéllés dans la langue locale au démarrage de l'appli.
        switch id {
        case Chiffre:
            nom = NSLocalizedString("texteChiffre", comment: "Chiffre")
        case Lettre:
            nom = NSLocalizedString("texteLettre", comment: "Lettre")
        case ToiMoi:
            nom = NSLocalizedString("texteToiMoi", comment: "ToiMoi")
        case VraiFaux:
            nom = NSLocalizedString("texteVraiFaux", comment: "VraiFaux")
        case OuiNon:
            nom = NSLocalizedString("texteOuiNon", comment: "OuiNon")
        case PileFace:
            nom = NSLocalizedString("textePileFace", comment: "PileFace")
        case Chifoumi:
            nom = NSLocalizedString("texteChifoumi", comment: "Chifoumi")
        case De:
            nom = NSLocalizedString("texteDe", comment: "De")
        case Carte:
            nom = NSLocalizedString("texteCarte", comment: "Carte")
        case Roulette:
            nom = NSLocalizedString("texteRoulette", comment: "Roulette")
        case Direction:
            nom = NSLocalizedString("texteDirection", comment: "Direction")
        case Azimut:
            nom = NSLocalizedString("texteAzimut", comment: "Azimut")
        case Jour:
            nom = NSLocalizedString("texteJour", comment: "Jour")
        case Euromillion:
            nom = NSLocalizedString("texteEuromillion", comment: "Euromillion")
        case Loto:
            nom = NSLocalizedString("texteLoto", comment: "Loto")
        default: break
        }
        let resultat = aDecoder.decodeObject(forKey: "resultat") as! String
        let image1 = aDecoder.decodeObject(forKey: "image1") as! String
        let image2 = aDecoder.decodeObject(forKey: "image1") as! String
        let image3 = aDecoder.decodeObject(forKey: "image1") as! String
        let image4 = aDecoder.decodeObject(forKey: "image1") as! String
        let image5 = aDecoder.decodeObject(forKey: "image1") as! String
        let occurence = aDecoder.decodeInteger(forKey: "occurence")
        let minimum = aDecoder.decodeInteger(forKey: "minimum")
        let maximum = aDecoder.decodeInteger(forKey: "maximum")
        let repetition = aDecoder.decodeBool(forKey: "repetition")
        self.init(id: id, actif: actif, nom: nom, resultat: resultat, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, occurence: occurence, minimum: minimum, maximum: maximum, repetition: repetition)
    }
    
    func encode(with aCoder: NSCoder) {
        #if DEBUG
        print("encode - Tirage")
        #endif
        
        aCoder.encode(id, forKey: "id")
        aCoder.encode(actif, forKey: "actif")
        aCoder.encode(nom, forKey: "nom")
        aCoder.encode(resultat, forKey: "resultat")
        aCoder.encode(image1, forKey: "image1")
        aCoder.encode(image2, forKey: "image2")
        aCoder.encode(image3, forKey: "image3")
        aCoder.encode(image4, forKey: "image4")
        aCoder.encode(image5, forKey: "image5")
        aCoder.encode(occurence, forKey: "occurence")
        aCoder.encode(minimum, forKey: "minimum")
        aCoder.encode(maximum, forKey: "maximum")
        aCoder.encode(repetition, forKey: "repetition")
    }
}

// version de l'application
let version = 1.3

// variables
var texte = ""
var tableauChiffre:[Int] = []
var tableauLettre:[String] = []
var jeuCarte:[String] = []
var tableauJour:[Int] = []
var random:Int = 0
var plageChiffre:UInt32 = 0
var plageLettre :UInt32 = 26
var plageCarte :UInt32 = 52
let plageRoulette :UInt32 = 37
var plageJour :UInt32 = 7
var nb :Int = 0
var afficherTirageRestant :Bool = false
var tirageAutomatique :Bool = true

// constantes
let alphabet =  ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
let deck =  ["club-1","club-2","club-3","club-4","club-5","club-6","club-7","club-8","club-9","club-10","club-11","club-12","club-13","diamond-1","diamond-2","diamond-3","diamond-4","diamond-5","diamond-6","diamond-7","diamond-8","diamond-9","diamond-10","diamond-11","diamond-12","diamond-13","heart-1","heart-2","heart-3","heart-4","heart-5","heart-6","heart-7","heart-8","heart-9","heart-10","heart-11","heart-12","heart-13","spade-1","spade-2","spade-3","spade-4","spade-5","spade-6","spade-7","spade-8","spade-9","spade-10","spade-11","spade-12","spade-13"]
let rouge = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
let noir = [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35]
let colonne1 = [1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31 ,34]
let colonne2 = [2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35]
let colonne3 = [3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36]

// tableau des tirages
var listeTirage = [Tirage]()

// libellés multi-langues dans les fichiers Localizable.string Fr et En
let texteToi = NSLocalizedString("texteToi", comment: "Toi")
let texteMoi = NSLocalizedString("texteMoi", comment: "Moi")
let texteNous = NSLocalizedString("texteNous", comment: "Nous")
let texteVrai = NSLocalizedString("texteVrai", comment: "Vrai")
let texteFaux = NSLocalizedString("texteFaux", comment: "Faux")
let texteOui = NSLocalizedString("texteOui", comment: "Oui")
let texteNon = NSLocalizedString("texteNon", comment: "Non")
let textePile = NSLocalizedString("textePile", comment: "Pile")
let texteFace = NSLocalizedString("texteFace", comment: "Face")
let texteChifoumi = [NSLocalizedString("textePierre", comment: "Pierre"),
                     NSLocalizedString("texteFeuille", comment: "Feuille"),
                     NSLocalizedString("texteCiseaux", comment: "Ciseaux")]
let texteRouge = NSLocalizedString("texteRouge", comment: "Rouge")
let texteNoir = NSLocalizedString("texteNoir", comment: "Noir")
let texteVert = NSLocalizedString("texteVert", comment: "Vert")
let textePair = NSLocalizedString("textePair", comment: "Pair")
let texteImpair = NSLocalizedString("texteImpair", comment: "Impair")
let textePremier = NSLocalizedString("textePremier", comment: "Premier")
let texteMilieu = NSLocalizedString("texteMilieu", comment: "Milieu")
let texteDernier = NSLocalizedString("texteDernier", comment: "Dernier")
let texteDirection = [NSLocalizedString("texteGauche", comment: "Gauche"),
                      NSLocalizedString("texteDroite", comment: "Droite"),
                      NSLocalizedString("texteToutDroit", comment: "Tout droit"),
                      NSLocalizedString("texteDemiTour", comment: "Demi tour")]
let nbAzimut = 8
let tableauDegre = [45,90,135,180,225,270,315,0]
let tableauCardinal = [NSLocalizedString("texteNordEst", comment: "Nord Est"),
                       NSLocalizedString("texteEst", comment: "Est"),
                       NSLocalizedString("texteSudEst", comment: "Sud Est"),
                       NSLocalizedString("texteSud", comment: "Sud"),
                       NSLocalizedString("texteSudOuest", comment: "Sud Ouest"),
                       NSLocalizedString("texteOuest", comment: "Ouest"),
                       NSLocalizedString("texteNordOuest", comment: "Nord Ouest"),
                       NSLocalizedString("texteNord", comment: "Nord")]
let tableauNomJour = [NSLocalizedString("texteLundi", comment: "Lundi"),
                      NSLocalizedString("texteMardi", comment: "Mardi"),
                      NSLocalizedString("texteMercredi", comment: "Mercredi"),
                      NSLocalizedString("texteJeudi", comment: "Jeudi"),
                      NSLocalizedString("texteVendredi", comment: "Vendredi"),
                      NSLocalizedString("texteSamedi", comment: "Samedi"),
                      NSLocalizedString("texteDimanche", comment: "Dimanche")]

// référence le contexte de la session
let choixUtilisateur = UserDefaults.standard

// récupération du numéro de version du tableau des tirages pour réinitialiser les paramètres utilisateur s'ils existaient en version antérieure
let versionTableau = choixUtilisateur.double(forKey: "versionTableau")

// identifiant des tirages (qui sert aussi d'ordre par défaut)
let Chiffre :Int = 0
let Lettre :Int = 1
let ToiMoi :Int = 2
let VraiFaux :Int = 3
let OuiNon :Int = 4
let PileFace :Int = 5
let Chifoumi :Int = 6
let De :Int = 7
let Carte :Int = 8
let Roulette :Int = 9
let Direction :Int = 10
let Azimut :Int = 11
let Jour :Int = 12
let Euromillion :Int = 13
let Loto :Int = 14

// rang des tirages dans le tableau listeTirage
var placeChiffre = Chiffre
var placeLettre = Lettre
var placeToiMoi = ToiMoi
var placeVraiFaux = VraiFaux
var placeOuiNon = OuiNon
var placePileFace = PileFace
var placeChifoumi = Chifoumi
var placeDe = De
var placeCarte = Carte
var placeRoulette = Roulette
var placeDirection = Direction
var placeAzimut = Azimut
var placeJour = Jour
var placeEuromillion = Euromillion
var placeLoto = Loto

// initialisation du tableau des tirages
func initialiserListeTirage() {
    #if DEBUG
    print("initialiserListeTirage - Tirage")
    #endif
    
    listeTirage = [
        Tirage(id: Chiffre, actif: true, nom: NSLocalizedString("texteChiffre", comment: "Chiffre"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 10, repetition:false),
        Tirage(id: Lettre, actif: true, nom: NSLocalizedString("texteLettre", comment: "Lettre"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: ToiMoi, actif: true, nom: NSLocalizedString("texteToiMoi", comment: "ToiMoi"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: VraiFaux, actif: true, nom: NSLocalizedString("texteVraiFaux", comment: "VraiFaux"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: OuiNon, actif: true, nom: NSLocalizedString("texteOuiNon", comment: "OuiNon"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: PileFace, actif: true, nom: NSLocalizedString("textePileFace", comment: "PileFace"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: Chifoumi, actif: true, nom: NSLocalizedString("texteChifoumi", comment: "Chifoumi"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: De, actif: true, nom: NSLocalizedString("texteDe", comment: "De"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: Carte, actif: true, nom: NSLocalizedString("texteCarte", comment: "Carte"), resultat: "", image1: "", image2: "", image3: "", image4: "1", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: Roulette, actif: true, nom: NSLocalizedString("texteRoulette", comment: "Roulette"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: Direction, actif: true, nom: NSLocalizedString("texteDirection", comment: "Direction"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: Azimut, actif: true, nom: NSLocalizedString("texteAzimut", comment: "Azimut"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: Jour, actif: true, nom: NSLocalizedString("texteJour", comment: "Jour"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: Euromillion, actif: true, nom: "Euromillion", resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false),
        Tirage(id: Loto, actif: true, nom: NSLocalizedString("texteLoto", comment: "Loto"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false)
    ]
}

// initialisation du tableau de chiffres
func initialiserTableauChiffre(item: Int) {
    #if DEBUG
    print("initialiserTableauChiffre - Tirage")
    #endif
    
    tableauChiffre.removeAll()
    plageChiffre = UInt32(listeTirage[item].maximum - listeTirage[item].minimum + 1)
    for nb in 0...Int(plageChiffre - 1) {
        tableauChiffre.append (listeTirage[item].minimum + nb)
    }
}

// initialisation du tableau de lettres
func initialiserTableauLettre() {
    #if DEBUG
    print("initialiserTableauLettre - Tirage")
    #endif
    
    tableauLettre.removeAll()
    tableauLettre = alphabet
    plageLettre = 26
}

// initialisation du tableau des cartes à jouer et tri aléatoire du tableau
func initialiserCarte() {
    #if DEBUG
        print("initialiserCarte - Tirage")
    #endif
    
    jeuCarte.removeAll()
    jeuCarte = deck
    plageCarte = 52
    for idx in 0..<jeuCarte.count {
        let rnd = Int(arc4random_uniform(UInt32(idx)))
        if rnd != idx {
            jeuCarte.swapAt(idx, rnd)
        }
    }
}

// initialisation du tableau des jours
func initialiserTableauJour(item: Int) {
    #if DEBUG
    print("initialiserTableauJour - Tirage")
    #endif
    
    tableauJour.removeAll()
    plageJour = 7
    tableauJour = [0, 1, 2, 3, 4, 5, 6]
}

// (ré)initialisation des tableaux et des variables
func initialiserTableaux() {
    #if DEBUG
    print("initialiserTableaux - Tirage")
    #endif
    
    // ajouter test : init tableaux que si nécessaire (modif faite dans paramètre OU première fois) ?
    initialiserTableauChiffre(item: placeChiffre)
    initialiserTableauLettre()
    initialiserCarte()
    initialiserTableauJour(item: placeJour)
}

// sauvegarde du tableau des tirages et de paramètres dans le contexte utilisateur
func sauvegarderTirage() {
    #if DEBUG
    print("sauvegarderTirage - Tirage")
    #endif
    
    // sauvegarde de la version du tableau des tirages (même version que l'application pour simplifier)
    choixUtilisateur.set(version, forKey: "versionTableau")
    
    // sauvegarde du tableau des tirages (pour mémoriser les choix utilisateurs)
    let encodedContexte: Data = NSKeyedArchiver.archivedData(withRootObject: listeTirage)
    choixUtilisateur.set(encodedContexte, forKey: "savedListeTirage")
    #if DEBUG
    dump(listeTirage)
    #endif
    
    // sauvegarde choix afficher tirages restants ou non
    choixUtilisateur.set(afficherTirageRestant, forKey: "affichageTirageRestant")

    // sauvegarde du choix d'effectuer des tirages automatiques à chaque changement ou rechargement de fenêtre
    choixUtilisateur.set(tirageAutomatique, forKey: "tirageAutomatique")
}

// récupération du tableau des tirages sauvgardés (pour récupérer les choix utilisateurs) s'il existe, sinon initialisation du tableau
func recupererTirage() {
    #if DEBUG
        print("recupererTirage - Tirage")
        print("version tableau = " + String(versionTableau))
    #endif

    // suppression du contexte antérieur à la version 1.2 du tableau listeTirage
    purgerVieuxContexte()
    
    // récupération du contexte pour les version à partir de 1.2, et ajout des 2 nouveaux tirages si inexistants
    if ((choixUtilisateur.object(forKey: "savedListeTirage") != nil) && (versionTableau >= 1.2)) {
        let decodedContexte  = choixUtilisateur.object(forKey: "savedListeTirage") as! Data
        listeTirage = NSKeyedUnarchiver.unarchiveObject(with: decodedContexte) as! [Tirage]
        if chercherNomTirage(idTirage: Euromillion) == "" {
            listeTirage.append(Tirage(id: Euromillion, actif: true, nom: "Euromillion", resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false))
        }
        if chercherNomTirage(idTirage: Loto) == "" {
            listeTirage.append(Tirage(id: Loto, actif: true, nom: NSLocalizedString("texteLoto", comment: "Loto"), resultat: "", image1: "", image2: "", image3: "", image4: "", image5: "", occurence: 1, minimum: 1, maximum: 1, repetition:false))
        }
    // sinon initialisation du tableau des tirages
    } else {
        initialiserListeTirage()
    }
    initialiserTableaux()
    #if DEBUG
    dump(listeTirage)
    #endif
    
    // recuperation du choix d'afficher les tirages restants ou non
    if (choixUtilisateur.object(forKey: "affichageTirageRestant") != nil) {
        afficherTirageRestant = choixUtilisateur.bool(forKey: "affichageTirageRestant")
    }
    
    // recuperation du choix d'effectuer des tirages automatiques à chaque changement ou rechargement de fenêtre
    if (choixUtilisateur.object(forKey: "tirageAutomatique") != nil) {
        tirageAutomatique = choixUtilisateur.bool(forKey: "tirageAutomatique")
    }
}

// suppression du contexte antérieur à la version 1.2 (les différentes clés sont remplacées désormais par le tableau listeTirage
func purgerVieuxContexte() {
    #if DEBUG
    print("purgerVieuxContexte - Tirage")
    #endif
    
    if versionTableau < 1.2 {
        choixUtilisateur.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
}

// retrouve les bons rangs des tirages (au cas où ils auraient été réordonnés par l'utilisateur)
func trouverPlaceTirage() {
    #if DEBUG
    print("trouverPlaceTirage - Tirage")
    #endif
    
    for item in 0..<listeTirage.count {
        switch listeTirage[item].id {
        case Chiffre:
            placeChiffre = item
        case Lettre:
            placeLettre = item
        case ToiMoi:
            placeToiMoi = item
        case VraiFaux:
            placeVraiFaux = item
        case OuiNon:
            placeOuiNon = item
        case PileFace:
            placePileFace = item
        case Chifoumi:
            placeChifoumi = item
        case De:
            placeDe = item
        case Carte:
            placeCarte = item
        case Roulette:
            placeRoulette = item
        case Direction:
            placeDirection = item
        case Azimut:
            placeAzimut = item
        case Jour:
            placeJour = item
        case Euromillion:
            placeEuromillion = item
        case Loto:
            placeLoto = item
        default: break
        }
    }
}

// remise à blanc de tous les label random
func effacerTirage() {
    #if DEBUG
    print("effacerTirage - Tirage")
    #endif
    
    for item in 0..<listeTirage.count {
        listeTirage[item].resultat = ""
        listeTirage[item].image1 = ""
        listeTirage[item].image2 = ""
        listeTirage[item].image3 = ""
        listeTirage[item].image4 = ""
        listeTirage[item].image5 = ""
    }
}

// retourne le nom de l'image correspondant au numéro de dé tiré au sort
func trouverImageDe (_ numeroDe : Int) -> String {
    #if DEBUG
    print("trouverImageDe - Tirage")
    #endif
    
    var imageName: String!
    switch numeroDe {
    case 0:
        imageName = "dice-1"
    case 1:
        imageName = "dice-2"
    case 2:
        imageName = "dice-3"
    case 3:
        imageName = "dice-4"
    case 4:
        imageName = "dice-5"
    case 5:
        imageName = "dice-6"
    default:
        imageName = ""
    }
    return imageName
}

// retourne le nom de l'image correspondant à la direction tiré au sort (0=gauche, 1=droite, 2=tout droit, 3=demi tour)
func trouverImageDirection (_ numeroDirection : Int) -> String {
    #if DEBUG
    print("afficherImageDirection - Tirage")
    #endif
    
    var imageName: String!
    switch numeroDirection {
    case 0:
        imageName = "left"
    case 1:
        imageName = "right"
    case 2:
        imageName = "straight"
    case 3:
        imageName = "back"
    default:
        imageName = ""
    }
    return imageName
}

// tirage aléatoire du chiffre
func tirageChiffre(item :Int) {
    #if DEBUG
    print("tirageChiffre - Tirage")
    #endif
    
    texte = ""
    if (plageChiffre < listeTirage[item].occurence) {           // quand tous les chiffres sont sortis (ou que ceux qui restent ne sont pas assez nombreux), on réinitialise
        initialiserTableauChiffre(item: item)
    }
    for nb in 1...listeTirage[item].occurence {
        random = Int(arc4random_uniform(plageChiffre))
        texte += String(tableauChiffre[random])
        compterTirageChiffre(chiffreApparu:tableauChiffre[random])   // pour les statistiques

        if (!listeTirage[item].repetition) {
            tableauChiffre.remove(at: random)              // à chaque tirage on enlève le chiffre tiré pour ne pas la ressortir
            plageChiffre -= 1
        }
        if nb < listeTirage[item].occurence {
            texte += " - "
        }
    }
    listeTirage[item].resultat = texte
    insererHistoriqueChiffre(historiqueAInserer: HistoriqueTirage(id: Chiffre, dateTirage: Date(), resultat: texte, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire d'une lettre
func tirageLettre(item :Int) {
    #if DEBUG
    print("tirageLettre - Tirage")
    #endif
    
    texte = ""
    if (plageLettre < listeTirage[item].occurence) {           // quand toutes les lettres sont sorties (ou que celles qui restent ne sont pas assez nombreuses), on réinitialise
        initialiserTableauLettre()
    }
    for nb in 1...listeTirage[item].occurence {
        random = Int(arc4random_uniform(plageLettre))
        texte += tableauLettre[random]
        compterTirageLettre(lettreApparue: tableauLettre[random])   // pour les statistiques
        if (!listeTirage[item].repetition) {
            tableauLettre.remove(at: random)               // à chaque tirage on enlève la lettre tirée pour ne pas la ressortir
            plageLettre -= 1
        }
        if nb < listeTirage[item].occurence {
            texte += " - "
        }
    }
    listeTirage[item].resultat = texte
    insererHistoriqueLettre(historiqueAInserer: HistoriqueTirage(id: Lettre, dateTirage: Date(), resultat: texte, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire de toi ou moi
func tirageToiMoi(item :Int) {
    #if DEBUG
    print("tirageToiMoi - Tirage")
    #endif
    
    texte = ""
    random = Int(arc4random_uniform(3))
    compterTirageToiMoi(toiMoiApparu: random)        // pour les statistiques
    if random == 0 {
        texte = texteToi
    } else if random == 1 {
        texte = texteMoi
    } else {
        texte = texteNous
    }
    listeTirage[item].resultat = texte
    insererHistoriqueToiMoi(historiqueAInserer: HistoriqueTirage(id: ToiMoi, dateTirage: Date(), resultat: texte, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire de vrai ou faux
func tirageVraiFaux(item :Int) {
    #if DEBUG
    print("tirageVraiFaux - Tirage")
    #endif
    
    texte = ""
    random = Int(arc4random_uniform(2))
    compterTirageVraiFaux(vraiFauxApparu: random)
    if random == 0 {
        texte = texteFaux
    } else {
        texte = texteVrai
    }
    listeTirage[item].resultat = texte
    insererHistoriqueVraiFaux(historiqueAInserer: HistoriqueTirage(id: VraiFaux, dateTirage: Date(), resultat: texte, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire de oui ou non
func tirageOuiNon(item :Int) {
    #if DEBUG
    print("tirageOuiNon - Tirage")
    #endif
    
    texte = ""
    random = Int(arc4random_uniform(2))
    compterTirageOuiNon(ouiNonApparu:random)
    if random == 0 {
        texte = texteNon
    } else {
        texte = texteOui
    }
    listeTirage[item].resultat = texte
    insererHistoriqueOuiNon(historiqueAInserer: HistoriqueTirage(id: OuiNon, dateTirage: Date(), resultat: texte, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire de pile ou face
func tiragePileFace(item :Int) {
    #if DEBUG
    print("tiragePileFace - Tirage")
    #endif
    
    texte = ""
    random = Int(arc4random_uniform(2))
    compterTiragePileFace(pileFaceApparu:random)
    if random == 0 {
        texte = textePile
    } else {
        texte = texteFace
    }
    listeTirage[item].resultat = texte
    insererHistoriquePileFace(historiqueAInserer: HistoriqueTirage(id: PileFace, dateTirage: Date(), resultat: texte, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire chifoumi
func tirageChifoumi(item :Int) {
    #if DEBUG
    print("tirageChifoumi - Tirage")
    #endif
    
    texte = ""
    random = Int(arc4random_uniform(3))
    compterTirageChifoumi(chifoumiApparu:random)
    texte = texteChifoumi[random]
    listeTirage[item].resultat = texte
    insererHistoriqueChifoumi(historiqueAInserer: HistoriqueTirage(id: Chifoumi, dateTirage: Date(), resultat: texte, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire de dés
func tirageDe(item :Int) {
    #if DEBUG
    print("tirageDe - Tirage")
    #endif
    
    for nb in 1...listeTirage[item].occurence {
        random = Int(arc4random_uniform(6))
        compterTirageDe(deApparu:random)
        switch nb {
        case 1:
            listeTirage[item].image3 = trouverImageDe(random)
        case 2:
            listeTirage[item].image2 = trouverImageDe(random)
        case 3:
            listeTirage[item].image4 = trouverImageDe(random)
        case 4:
            listeTirage[item].image1 = trouverImageDe(random)
        case 5:
            listeTirage[item].image5 = trouverImageDe(random)
        default: break
        }
    }
    insererHistoriqueDe(historiqueAInserer: HistoriqueTirage(id: De, dateTirage: Date(), resultat: "", image1: listeTirage[item].image1,  image2: listeTirage[item].image2, image3: listeTirage[item].image3, image4: listeTirage[item].image4, image5: listeTirage[item].image5))
}

// tirage aléatoire d'une carte
func tirageCarte(item :Int) {
    #if DEBUG
    print("tirageCarte - Tirage")
    #endif
    
    if (plageCarte < listeTirage[item].occurence) {         // quand toutes les cartes sont sorties (ou que celles qui restent ne sont pas assez nombreuses), on réinitialise
        initialiserCarte()
    }
    for nb in 1...listeTirage[item].occurence {
        random = Int(arc4random_uniform(plageCarte))
        compterTirageCarte(carteApparue:jeuCarte[random])
        switch nb {
        case 1:
            listeTirage[item].image3 = jeuCarte[random]
        case 2:
            listeTirage[item].image2 = jeuCarte[random]
        case 3:
            listeTirage[item].image4 = jeuCarte[random]
        case 4:
            listeTirage[item].image1 = jeuCarte[random]
        case 5:
            listeTirage[item].image5 = jeuCarte[random]
        default: break
        }
        jeuCarte.remove(at: random)                    // à chaque tirage on enlève la carte tirée pour ne pas la ressortir
        plageCarte -= 1
    }
    insererHistoriqueCarte(historiqueAInserer: HistoriqueTirage(id: Carte, dateTirage: Date(), resultat: "", image1: listeTirage[item].image1,  image2: listeTirage[item].image2, image3: listeTirage[item].image3, image4: listeTirage[item].image4, image5: listeTirage[item].image5))
}

// tirage aléatoire de la roulette
func tirageRoulette(item :Int) {
    #if DEBUG
    print("tirageRoulette - Tirage")
    #endif
    
    texte = ""
    random = Int(arc4random_uniform(plageRoulette))
    compterTirageRoulette(rouletteApparue: random)
    texte = String(random)
    if rouge.contains(random) {
        texte += "  " + texteRouge
    } else if noir.contains(random) {
        texte += "  " + texteNoir
    } else {
        texte += "  " + texteVert
    }
    if random > 0 {
        if random % 2 == 0 {
            texte += "  " + textePair
        } else {
            texte += "  " + texteImpair
        }
    }
    if random > 0 {
        if random < 13  {
            texte += "  " + textePremier
        } else if random < 25 {
            texte += "  " + texteMilieu
        } else {
            texte += "  " + texteDernier
        }
    }
    if random > 0 {
        if colonne1.contains(random) {
            texte += "  " + "C1"
        } else if colonne2.contains(random) {
            texte += "  " + "C2"
        } else {
            texte += "  " + "C3"
        }
    }
    listeTirage[item].resultat = texte
    insererHistoriqueRoulette(historiqueAInserer: HistoriqueTirage(id: Roulette, dateTirage: Date(), resultat: texte, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire d'une direction
func tirageDirection(item :Int) {
    #if DEBUG
    print("tirageDirection - Tirage")
    #endif
    
    random = Int(arc4random_uniform(4))
    compterTirageDirection(directionApparue: random)
    listeTirage[item].resultat = texteDirection[random]
    listeTirage[item].image5 = trouverImageDirection(random)
    insererHistoriqueDirection(historiqueAInserer: HistoriqueTirage(id: Direction, dateTirage: Date(), resultat: listeTirage[item].resultat, image1: "",image2: "",image3: "",image4: "",image5: listeTirage[item].image5))
}

// tirage aléatoire d'un azimut
func tirageAzimut(item :Int) {
    #if DEBUG
    print("tirageAzimut - Tirage")
    #endif
    
    random = Int(arc4random_uniform(8))
    compterTirageAzimut(azimutApparu: random)
    listeTirage[item].resultat = String(tableauDegre[random]) + "°"
    listeTirage[item].resultat += "  " + tableauCardinal[random]
    insererHistoriqueAzimut(historiqueAInserer: HistoriqueTirage(id: Azimut, dateTirage: Date(), resultat: listeTirage[item].resultat, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire d'un jour
func tirageJour(item :Int) {
    #if DEBUG
    print("tirageJour - Tirage")
    #endif
    
    if (plageJour == 0) {           // quand tous les jours de la semaine sont sortis, on réinitialise
        initialiserTableauJour(item: item)
    }
    random = Int(arc4random_uniform(plageJour))
    let jour = tableauJour[random]
    compterTirageJour(jourApparu: jour)
    listeTirage[item].resultat = String(tableauNomJour[jour])
    if (!listeTirage[item].repetition) {
        tableauJour.remove(at: random)           // à chaque tirage on enlève le jour tiré pour ne pas la ressortir
        plageJour -= 1
    }
    insererHistoriqueJour(historiqueAInserer: HistoriqueTirage(id: Jour, dateTirage: Date(), resultat: listeTirage[item].resultat, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire d'Euromillion
func tirageEuromillion(item :Int) {
    #if DEBUG
    print("tirageEuromillion - Tirage")
    #endif
    
    // Euromillion : 5 chiffres entre 1 et 50 triés croissant, 2 numéros étoiles de 1 à 12 triés croissant
    var tableauEuromillion = [Int] (1...50)
    var tableauEtoile = [Int] (1...12)
    var chiffreEuromillion: [Int] = [0,0,0,0,0]
    var chiffreEtoile: [Int] = [0,0]
    
    // tirage des 5 chiffres et tri croissant
    random = Int(arc4random_uniform(50))
    chiffreEuromillion[0] = tableauEuromillion[random]
    compterTirageEuromillion(euromillionApparu: tableauEuromillion[random])
    tableauEuromillion.remove(at: random)

    random = Int(arc4random_uniform(49))
    chiffreEuromillion[1] = tableauEuromillion[random]
    compterTirageEuromillion(euromillionApparu: tableauEuromillion[random])
    tableauEuromillion.remove(at: random)

    random = Int(arc4random_uniform(48))
    chiffreEuromillion[2] = tableauEuromillion[random]
    compterTirageEuromillion(euromillionApparu: tableauEuromillion[random])
    tableauEuromillion.remove(at: random)

    random = Int(arc4random_uniform(47))
    chiffreEuromillion[3] = tableauEuromillion[random]
    compterTirageEuromillion(euromillionApparu: tableauEuromillion[random])
    tableauEuromillion.remove(at: random)

    random = Int(arc4random_uniform(46))
    chiffreEuromillion[4] = tableauEuromillion[random]
    compterTirageEuromillion(euromillionApparu: tableauEuromillion[random])
    tableauEuromillion.remove(at: random)

    chiffreEuromillion.sort()
    
    // tirage des 2 étoiles et tri croissant
    random = Int(arc4random_uniform(12))
    chiffreEtoile[0] = tableauEtoile[random]
    tableauEtoile.remove(at: random)
    random = Int(arc4random_uniform(11))
    chiffreEtoile[1] = tableauEtoile[random]
    tableauEtoile.remove(at: random)
    chiffreEtoile.sort()
    
    // préparation du résultat sur 2 lignes
    let resultat1 = String(chiffreEuromillion[0]) + " - " + String(chiffreEuromillion[1]) + " - " + String(chiffreEuromillion[2]) + " - " + String(chiffreEuromillion[3]) + " - " + String(chiffreEuromillion[4])
    let resultat2 = "\u{2605} " + String(chiffreEtoile[0]) + "   \u{2605} " + String(chiffreEtoile[1])
    listeTirage[item].resultat = resultat1 + "\n" + resultat2

    // historisation
    insererHistoriqueEuromillion(historiqueAInserer: HistoriqueTirage(id: Euromillion, dateTirage: Date(), resultat: listeTirage[item].resultat, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// tirage aléatoire du Loto
func tirageLoto(item :Int) {
    #if DEBUG
    print("tirageLoto - Tirage")
    #endif
    
    // Loto : 5 chiffre entre 1 et 49 triés croissant, 1 numéro complémentaire de 1 à 10
    var tableauLoto = [Int] (1...49)
    var chiffreLoto: [Int] = [0,0,0,0,0]
    var chiffreChance: Int = 0
    
    // tirage des 5 chiffres
    random = Int(arc4random_uniform(49))
    chiffreLoto[0] = tableauLoto[random]
    compterTirageLoto(lotoApparu: tableauLoto[random])
    tableauLoto.remove(at: random)

    random = Int(arc4random_uniform(48))
    chiffreLoto[1] = tableauLoto[random]
    compterTirageLoto(lotoApparu: tableauLoto[random])
    tableauLoto.remove(at: random)

    random = Int(arc4random_uniform(47))
    chiffreLoto[2] = tableauLoto[random]
    compterTirageLoto(lotoApparu: tableauLoto[random])
    tableauLoto.remove(at: random)

    random = Int(arc4random_uniform(46))
    chiffreLoto[3] = tableauLoto[random]
    compterTirageLoto(lotoApparu: tableauLoto[random])
    tableauLoto.remove(at: random)

    random = Int(arc4random_uniform(45))
    chiffreLoto[4] = tableauLoto[random]
    compterTirageLoto(lotoApparu: tableauLoto[random])
    tableauLoto.remove(at: random)

    chiffreLoto.sort()
    
    // tirage du chiffre chance
    chiffreChance = Int(arc4random_uniform(10)) + 1
    
    // préparation du résultat sur 2 lignes
    listeTirage[item].resultat = String(chiffreLoto[0]) + " - " + String(chiffreLoto[1]) + " - " + String(chiffreLoto[2]) + " - " + String(chiffreLoto[3]) + " - " + String(chiffreLoto[4]) + "\n" + "✚  " + String(chiffreChance)

    // historisation
    insererHistoriqueLoto(historiqueAInserer: HistoriqueTirage(id: Loto, dateTirage: Date(), resultat: listeTirage[item].resultat, image1: "",image2: "",image3: "",image4: "",image5: ""))
}

// appelle tous les tirages au sort
func tirageAuSort() {
    #if DEBUG
    print("tirageAuSort - Tirage")
    #endif
    
    for item in 0..<listeTirage.count {
        if (listeTirage[item].actif == true) {
            switch listeTirage[item].id {
            case Chiffre:
                tirageChiffre(item: item)
            case Lettre:
                tirageLettre(item: item)
            case ToiMoi:
                tirageToiMoi(item: item)
            case VraiFaux:
                tirageVraiFaux(item: item)
            case OuiNon:
                tirageOuiNon(item: item)
            case PileFace:
                tiragePileFace(item: item)
            case Chifoumi:
                tirageChifoumi(item: item)
            case De:
                tirageDe(item: item)
            case Carte:
                tirageCarte(item: item)
            case Roulette:
                tirageRoulette(item: item)
            case Direction:
                tirageDirection(item: item)
            case Azimut:
                tirageAzimut(item: item)
            case Jour:
                tirageJour(item: item)
            case Euromillion:
                tirageEuromillion(item: item)
            case Loto:
                tirageLoto(item: item)
            default: break
            }
        }
    }
}

// recherche de l'id d'un tirage à partir de son nom
func chercherIdTirage(nomTirage: String) -> Int {
    #if DEBUG
    print("chercherIdTirage - Tirage")
    #endif
    
    for item in 0..<listeTirage.count {
        if listeTirage[item].nom == nomTirage {
            return listeTirage[item].id
        }
    }
    return -1   // erreur : tirage non trouvé
}

// recherche de le nom d'un tirage à partir de son id
func chercherNomTirage(idTirage: Int) -> String {
    #if DEBUG
    print("chercherNomTirage - Tirage")
    #endif
    
    for item in 0..<listeTirage.count {
        if listeTirage[item].id == idTirage {
            return listeTirage[item].nom
        }
    }
    return ""   // erreur : tirage non trouvé
}

// formatte le résultat Euromillion pour que les numéros star soient en vert
func formaterEuromillion (resultatEuromillion: String) -> NSMutableAttributedString {
    #if DEBUG
    print("formaterEuromillion - Tirage")
    #endif
    
    let firstStar = resultatEuromillion.index(of: "\u{2605}") ?? resultatEuromillion.endIndex
    let firstPart = resultatEuromillion[..<firstStar]
    let secondPart = resultatEuromillion[firstStar..<resultatEuromillion.endIndex]
    let firstPartAttributed = NSMutableAttributedString(string:String(firstPart))
    let secondPartAttributed = NSAttributedString(string:String(secondPart), attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
    firstPartAttributed.append(secondPartAttributed)
    return firstPartAttributed
}

// formatte le résultat Loto pour que le numéro chance soit en vert
func formaterLoto (resultatLoto: String) -> NSMutableAttributedString {
    #if DEBUG
    print("formaterLoto - Tirage")
    #endif
    
    let firstStar = resultatLoto.index(of: "✚") ?? resultatLoto.endIndex
    let firstPart = resultatLoto[..<firstStar]
    let secondPart = resultatLoto[firstStar..<resultatLoto.endIndex]
    let firstPartAttributed = NSMutableAttributedString(string:String(firstPart))
    let secondPartAttributed = NSAttributedString(string:String(secondPart), attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
    firstPartAttributed.append(secondPartAttributed)
    return firstPartAttributed
}
