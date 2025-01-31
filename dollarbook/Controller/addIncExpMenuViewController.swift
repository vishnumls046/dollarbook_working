//
//  addIncExpMenuViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 31/08/22.
//

import UIKit
import Foundation
import Spring
import NVActivityIndicatorView
class addIncExpMenuViewController: UIViewController,NVActivityIndicatorViewable {
    @IBOutlet weak var incTile:SpringLabel!
    @IBOutlet weak var expTile:SpringView!
    @IBOutlet weak var trnsfrTile:SpringView!
    var adVwObj = addViewController()
    var addTrnscViewMdlObj = addTrnscnViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.incTile.alpha = 0
        self.expTile.alpha = 0
        self.trnsfrTile.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
            self.anim()
        })
    }
    override func viewDidAppear(_ animated: Bool) {
//        self.incTile.animation = "squeezeUp"
//
//        self.incTile.delay = 0.4
//        self.incTile.duration = 1.0
//        self.incTile.animate()
//        self.expTile.animation = "slideUp"
//        self.expTile.delay = 0.6
//        self.expTile.duration = 1.6
//        self.expTile.animate()
//        self.incTile.cornerRadius = 17
//        self.expTile.cornerRadius = 17
    }
    func anim()
    {
        self.incTile.animation = "squeezeUp"
        
        self.incTile.delay = 0.0
        self.incTile.duration = 1.0
        self.incTile.animate()
        self.expTile.animation = "slideUp"
        self.expTile.delay = 0.2
        self.expTile.duration = 1.0
        self.expTile.animate()
        
        self.trnsfrTile.animation = "slideUp"
        self.trnsfrTile.delay = 0.0
        self.trnsfrTile.duration = 1.0
        self.trnsfrTile.animate()
        
        self.incTile.cornerRadius = 17
        self.expTile.cornerRadius = 17
        self.trnsfrTile.cornerRadius = 17
    }
    @IBAction func clkIncome()
    {
        //self.adVwObj.IncExpTypeValSet(typ: "1")
        self.startAnimating()
        self.addTrnscViewMdlObj.getAcnts(typ: "trnscn")
        UserDefaults.standard.set("income", forKey: "theme")
        //self.performSegue(withIdentifier: "income", sender: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.stopAnimating()
            self.performSegue(withIdentifier: "income1", sender: self)
        })
    }
    @IBAction func clkExpnse()
    {
        self.startAnimating()
        self.addTrnscViewMdlObj.getAcnts(typ: "trnscn")
        //self.adVwObj.IncExpTypeValSet(typ: "2")
        UserDefaults.standard.set("expense", forKey: "theme")
        //self.performSegue(withIdentifier: "expense", sender: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.stopAnimating()
            self.performSegue(withIdentifier: "expense1", sender: self)
        })
    }
    @IBAction func clkTransfer()
    {
        self.startAnimating()
        self.addTrnscViewMdlObj.getAcnts(typ: "trnscn")
        //self.adVwObj.IncExpTypeValSet(typ: "2")
        UserDefaults.standard.set("transfer", forKey: "theme")
        //self.performSegue(withIdentifier: "expense", sender: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.stopAnimating()
            self.performSegue(withIdentifier: "transfer1", sender: self)
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "income1")
        {
            if let vc = segue.destination as? addTranscnViewController {
                vc.IncExpTypVal = "1"
            }
        }
        else if(segue.identifier == "expense1")
        {
            if let vc = segue.destination as? addTranscnViewController {
                vc.IncExpTypVal = "2"
            }
        }
        else if(segue.identifier == "transfer1")
        {
            if let vc = segue.destination as? addTranscnViewController {
                vc.IncExpTypVal = "3"
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

