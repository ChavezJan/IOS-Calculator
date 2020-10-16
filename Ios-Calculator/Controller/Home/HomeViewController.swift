//
//  HomeViewController.swift
//  Ios-Calculator
//
//  Created by Jorge Alejandro Chavez Nuñez on 16/10/20.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    
    // Resultado
    @IBOutlet weak var resultado: UILabel!
    
    // Numeros
    @IBOutlet weak var cero: UIButton!
    @IBOutlet weak var uno: UIButton!
    @IBOutlet weak var dos: UIButton!
    @IBOutlet weak var tres: UIButton!
    @IBOutlet weak var cuatro: UIButton!
    @IBOutlet weak var cinco: UIButton!
    @IBOutlet weak var seis: UIButton!
    @IBOutlet weak var siete: UIButton!
    @IBOutlet weak var ocho: UIButton!
    @IBOutlet weak var nueve: UIButton!
    @IBOutlet weak var punto: UIButton!
    
    // Operaciones
    @IBOutlet weak var AC: UIButton!
    @IBOutlet weak var masMenos: UIButton!
    @IBOutlet weak var porcentaje: UIButton!
    @IBOutlet weak var igual: UIButton!
    @IBOutlet weak var mas: UIButton!
    @IBOutlet weak var menos: UIButton!
    @IBOutlet weak var por: UIButton!
    @IBOutlet weak var entre: UIButton!
    
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Estilo redondo a los botones
        cero.round()
        uno.round()
        dos.round()
        tres.round()
        cuatro.round()
        cinco.round()
        seis.round()
        siete.round()
        ocho.round()
        nueve.round()
        punto.round()
        
        por.round()
        entre.round()
        mas.round()
        menos.round()
        porcentaje.round()
        masMenos.round()
        igual.round()
        AC.round()
        
        
    }
    
    // MARK: - Buttons Actions
    
    // Numeros
    @IBAction func numberAction(_ sender: UIButton) {
        print(sender.tag)
        sender.shine()
        if Int(resultado.text!) == 0 {
            resultado.text = String(sender.tag)
        } else {
            resultado.text = resultado.text! + String(sender.tag)
        }
    }
    @IBAction func botonPunto(_ sender: UIButton) {
        sender.shine()
    }
    
    // Operaciones
    @IBAction func botonAC(_ sender: UIButton) {
        sender.shine()
    }
    @IBAction func botonMasMenos(_ sender: UIButton) {
        sender.shine()
    }
    @IBAction func botonPorcentaje(_ sender: UIButton) {
        sender.shine()
    }
    @IBAction func botonResultado(_ sender: UIButton) {
        sender.shine()
    }
    @IBAction func botonMas(_ sender: UIButton) {
        sender.shine()
    }
    @IBAction func botonMenos(_ sender: UIButton) {
        sender.shine()
    }
    @IBAction func botonPor(_ sender: UIButton) {
        sender.shine()
    }
    @IBAction func botonEntre(_ sender: UIButton) {
        sender.shine()
    }
    
    


}
