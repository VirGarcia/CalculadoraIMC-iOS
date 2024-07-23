//
//  ViewController.swift
//  CalculadoraIMC-iOS
//
//  Created by Mañanas on 23/7/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    //declaro e inicializo estas variables porque luego tengo que convertirlas y tratarlas
    
    var height: Int = 160
    var weight: Float = 70

    //Los outlet es como el equivalente al binding de Android
    //aqui estoy referenciando el 160 cm que está en negrita
    @IBOutlet weak var heightLabel: UILabel!
    //aqui referencio 70 kg que está en negrita
    @IBOutlet weak var weightLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //referencio los listener debajo del viewDidLoad
    //como quiero recuperar el dato para tratarlo, tengo que cambiar el sender y no puedo dejarlo como any
    @IBAction func onHeightChanged(_ sender: UIStepper) {
        height = Int(sender.value)
        heightLabel.text = "\(height) cm"
    }
    
    @IBAction func onWeightchanged(_ sender: UISlider) {
        
        //aqui no ponemos Float(sender.value) porque el valor viene ya como float
        weight = sender.value
        weightLabel.text = "\(weight) kg"
    }
    
    
    @IBAction func calculate(_ sender: Any) {
        print("Altura: \(height)")
        print("Altura: \(height)")

    }
    
}

