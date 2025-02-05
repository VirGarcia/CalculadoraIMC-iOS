//
//  ViewController.swift
//  CalculadoraIMC-iOS
//
//  Created by Mañanas on 23/7/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    static let obesityAdvice = "https://www.teknon.es/es/especialidades/gonzalbez-morgaez-jose/dietetica-obesidad/recomendaciones-pacientes-obesidad"
    
    
    //Los outlet es como el equivalente al binding de Android
    //aqui estoy referenciando el 160 cm que está en negrita
    @IBOutlet weak var heightLabel: UILabel!
    //aqui referencio 70 kg que está en negrita
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var heightStepper: UIStepper!
    @IBOutlet weak var weightSlider: UISlider!
    
    
    @IBOutlet weak var imcLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    //El stepper tiene un fallo de iOS, está como mal hecho, coge el valor que tiene metido en la casilla del inspector y para solucionar esto, tenemos que referenciarlo como UIStepper y en el viewDidLoad recuperar el valor, porque si no lo que sucede es que al darle al +, no empieza a aumentar el valor en el número que espera el usuario.
   
    //declaro e inicializo estas variables porque luego tengo que convertirlas y tratarlas
    
    var height: Int = 160
    var weight: Float = 70.0
    
    var imc: Float = 27.34
    var result: String = "Peso normal"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heightStepper.value = Double(height)
        weightSlider.value = weight
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
        weightLabel.text = String(format: "%.2f kg", weight)
    }
    
    
    @IBAction func calculate(_ sender: Any) {
        
        var descriptionColor: UIColor
        let heightInMeters = Float(height) / 100.0
        let imc = weight / (heightInMeters * heightInMeters)
        
        imcLabel.text = String(format: "IMC: %.2f", imc)
        var showAlert = false
        
        switch imc {
            case 0..<18.5:
                result = "Bajo peso"
            descriptionColor = UIColor(named: "under_weight")!
            case 18.5..<24.9:
                result = "Peso normal"
            descriptionColor = UIColor(named: "normal_weight")!
            case 25..<29.9:
                result = "Sobrepeso"
            descriptionColor = UIColor(named: "over_weight")!
            default:
                showAlert = true
                result = "Obesidad"
            descriptionColor = UIColor(named: "obesity_weight")!
            }
            
        resultLabel.text = result
        resultView.backgroundColor = descriptionColor
        //print("Imc: \(imc)")
        //print("Altura: \(height)")
        
        if (showAlert) {
            showObesityAlert()
        }

    }
    func showObesityAlert() {
        let alert = UIAlertController(
            title: "Alerta sanitaria",
            message: "Deberías cuidar tu salud y asistir al médico para estudiar tu caso porque estás en riesgo",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(
            title: "Me da igual, si de algo voy a morir",
            style: UIAlertAction.Style.destructive,
            handler: nil)
        )
        
        alert.addAction(UIAlertAction(
            title: "Ver recomendaciones",
            style: UIAlertAction.Style.cancel,
            handler: { action in
                if let url = URL(string: HomeViewController.obesityAdvice), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            })
        )
        
        alert.view.tintColor = UIColor.systemIndigo
        
        self.present(alert, animated: true, completion: nil)
    }
}

