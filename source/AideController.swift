//
//  AideController.swift
//  Alea
//
//  Created by Loïc DAVID on 26/06/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit
import WebKit

// class extension pour faire marcher le lien mailTo qui ne fonctionne pas nativement dans une WKWebView
extension AideController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if webView != self.webView {
            decisionHandler(.allow)
            return
        }
        let app = UIApplication.shared
        if let url = navigationAction.request.url {
            // handle target="_blank"
            if navigationAction.targetFrame == nil {
                if app.canOpenURL(url) {
                    app.open(url, options: [:], completionHandler: nil)
                    decisionHandler(.cancel)
                    return
                }
            }
            // handle phone and email links
            if url.scheme == "tel" || url.scheme == "mailto" {
                if app.canOpenURL(url) {
                    app.open(url, options: [:], completionHandler: nil)
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
    }
}

class AideController: UIViewController {
   
    // création du navigateur Web
    var webView: WKWebView!
    
    override func loadView() {
        #if DEBUG
        print("loadView - AideController")
        #endif
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    // traitement au chargement de la fenêtre
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        print("viewDidLoad - AideController")
        #endif

        let fileName = NSLocalizedString("nomFichierAide", comment: "nom du fichier aide suiavnt la langue")
        
        // affichage du fichier d'aide Html
        let url = Bundle.main.url(forResource: fileName, withExtension: "html", subdirectory: "")!
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
    }

    // à chaque affichage de la fenêtre on effectue ...
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #if DEBUG
        print("viewDidAppear - AideController")
        #endif
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        #if DEBUG
        print("didReceiveMemoryWarning - AideController")
        #endif
        
        // le traitement est fait dans AppDelegate
    }

}
