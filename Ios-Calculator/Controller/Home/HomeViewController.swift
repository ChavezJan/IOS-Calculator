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
    
    // MARK: - Variables
    
    private var total: Double = 0                   // Total (Resultado)
    private var temp: Double = 0                    // Temporal
    private var operating: Bool = false             // nos dira si se selecciono un operados
    private var decimal: Bool = false               // indicara si hay decimal
    private var operation: OperationType = .none    // Operacion Actual
    
    // MARK: - Constants
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kTotal = "total"
    
    private enum OperationType {
        case none, addicion, substraction, multiplicador, division, percent
    }
    
    // Formateo de valores auxiliares
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores auxiliares
    private let auxTotalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // Formateo de valores por pantalla en formato cientifico
    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
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
        
        punto.setTitle(kDecimalSeparator, for: .normal)
        
        total = UserDefaults.standard.double(forKey: kTotal)
        
        result()
    
    }
    override func viewDidAppear(_ animated: Bool) {
        // UI Estilo redondo a los botones
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
    
    // Operaciones
    @IBAction func botonAC(_ sender: UIButton) {
        
        clear()
        
        sender.shine()
    }
    @IBAction func botonMasMenos(_ sender: UIButton) {
        
        print("\(total) <- total y \(temp) <- temp")
        
        if total != 0 {
            total = total * (-1)
            resultado.text = printFormatter.string(from: NSNumber(value: total))
        } else {
            temp = temp * (-1)
            resultado.text = printFormatter.string(from: NSNumber(value: temp))
        }
        
        
        sender.shine()
    }
    @IBAction func botonPorcentaje(_ sender: UIButton) {
        
        if operation != .percent {
            result()
        }
        
        operating = true
        operation = .percent
        result()
        
        sender.shine()
    }
    @IBAction func botonResultado(_ sender: UIButton) {
        
        result()
        
        sender.shine()
    }
    @IBAction func botonMas(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .addicion
        
        sender.selectOperation(true)

        
        sender.shine()
    }
    @IBAction func botonMenos(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }

        operating = true
        operation = .substraction
        
        sender.selectOperation(true)

        
        sender.shine()
    }
    @IBAction func botonPor(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }

        operating = true
        operation = .multiplicador
        
        sender.selectOperation(true)

        
        sender.shine()
    }
    @IBAction func botonEntre(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }

        operating = true
        operation = .division
        
        sender.selectOperation(true)

        
        sender.shine()
    }
    
    // Numeros
    @IBAction func botonPunto(_ sender: UIButton) {
        
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if resultado.text?.contains(kDecimalSeparator) ?? false || (!operating && currentTemp.count >= kMaxLength){
            return
        }
        
        resultado.text = resultado.text! + kDecimalSeparator
        decimal = true
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        
        AC.setTitle("C", for: .normal)
        
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        // Hemos seleccionado una operacion
        if operating {
            total = total == 0 ? temp : total
            resultado.text = ""
            currentTemp = ""
            operating = false
        }
        
        // Hemos seleccionado decimales
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultado.text = printFormatter.string(from: NSNumber(value: temp))
   
        selectVisualOperation()
        
        sender.shine()
    }
    
    
    // Limpia valores
    private func clear() {
        if operation == .none {
            total = 0
        }
        operation = .none
        AC.setTitle("AC", for: .normal)
        
        if temp != 0{
            temp = 0
            resultado.text = "0"
        } else {
            total = 0
            result()
        }
    }
    
    // Obtiene el resultado final
    private func result() {
        
        switch operation {
        
        case .none:
            // no hacemos nada
            break
        case .addicion:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .multiplicador:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
        
        // Formateo de pantalla
        if let currentTotal = auxTotalFormatter.string(from: NSNumber(value: total)), currentTotal.count > kMaxLength {
            resultado.text = printScientificFormatter.string(from: NSNumber(value: total))
        } else {
            resultado.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        selectVisualOperation()
        
        UserDefaults.standard.set(total, forKey: kTotal)
        
        print("Total \(total)")
    }
    
    // Muestra de forma visual la operación seleccionada
    private func selectVisualOperation() {
        
        if !operating {
            // No estamos operando
            mas.selectOperation(false)
            menos.selectOperation(false)
            por.selectOperation(false)
            entre.selectOperation(false)
        } else {
            switch operation {
            case .none, .percent:
                mas.selectOperation(false)
                menos.selectOperation(false)
                por.selectOperation(false)
                entre.selectOperation(false)
                break
            case .addicion:
                mas.selectOperation(true)
                menos.selectOperation(false)
                por.selectOperation(false)
                entre.selectOperation(false)
                break
            case .substraction:
                mas.selectOperation(false)
                menos.selectOperation(true)
                por.selectOperation(false)
                entre.selectOperation(false)
                break
            case .multiplicador:
                mas.selectOperation(false)
                menos.selectOperation(false)
                por.selectOperation(true)
                entre.selectOperation(false)
                break
            case .division:
                mas.selectOperation(false)
                menos.selectOperation(false)
                por.selectOperation(false)
                entre.selectOperation(true)
                break
            }
        }
    }


}
