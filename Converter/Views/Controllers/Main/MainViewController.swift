//
//  ViewController.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftFlagImage: UIImageView!
    @IBOutlet weak var rightFlagImage: UIImageView!
    @IBOutlet weak var leftFlagButton: UIButton!
    @IBOutlet weak var rightFlagButton: UIButton!
    @IBOutlet weak var leftCurrencyLabel: UILabel!
    @IBOutlet weak var rightCurrencyLabel: UILabel!
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var mainBgImage: UIImageView!
    
    private var viewModel: MainViewModel = MainViewModel()
    public var curTextLeft: String = ""
    public var curTextRight: String = ""
    var service = CurrencyService()
    var data: CurrencyModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        configure()
        setupUI()
        
    }
    
    private func loadData() {
        viewModel.fetchData()
    }
    
    private func parseData() {
        let decoder = JSONDecoder()
        let defaults = UserDefaults.standard
        guard let data = defaults.value(forKey: Constans.dataSaveKey) as? Data else { return }
        do {
            let decodedData = try decoder.decode(CurrencyModel.self, from: data)
            self.data = decodedData
        } catch {
            print("Bad data")
        }
    }
    
    private func configure() {
        leftTextField.delegate = self
        rightTextField.delegate = self
        leftTextField.tag = 1
        rightTextField.tag = 2
        service.delegate = self
    }
    
    private func setupUI() {
        mainBgImage.image = UIImage(named: "bgback_icon")
    }
    
    private func currencyConverter(left: Double, right: Double, tag: Int) -> String {
        guard left != 0,
              right != 0,
              let data = viewModel.currencyModel
              else {return ""}
        switch tag {
        case 1:
            if leftCurrencyLabel.text == "USD" {
                if let value = data.rates[rightCurrencyLabel.text ?? ""] {
                    let result = String(format: "%.2f", left * value)
                    return result
                }
            }
        case 2:
            return ""
        default:
            return ""
        }
        return ""
    }
    
    @IBAction func hideKeyboardTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func leftFlagPressed(_ sender: UIButton) {

    }
    
    @IBAction func rightFlagPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: Constans.listVC) as? ListViewController else { return }
        print("Pressed")
        controller.delegate = self
        controller.buttonDirection = .right
        controller.modalPresentationStyle = .fullScreen
        //self.navigationController?.pushViewController(controller, animated: true)
        self.present(controller, animated: true)
    }

}

extension MainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 1:
            rightTextField.text = String(currencyConverter(left: Double(textField.text ?? "") ?? 0, right: 1, tag: 1))
        case 2:
            return false
        default:
            break
        }
        return true
    }
}

extension MainViewController: CurrencyServiceDelegate {
    
    func didFailError(error: String) {
        showAlert(alertText: "Attention!", alertMessage: "No data!")
    }
    
}

extension MainViewController: ButtonHandlerDelegate {
    
    func select(key: String, button: ButtonDirection) {
        switch button {
        case .right:
            if let rightImage = UIImage(named: key) {
                rightFlagImage.image = rightImage
            } else {
                rightFlagImage.image = UIImage(named: "noimage_icon")
            }
            rightCurrencyLabel.text = key
        case .left:
            if let leftImage = UIImage(named: key) {
                leftFlagImage.image = leftImage
            } else {
                leftFlagImage.image = UIImage(named: "noimage_icon")
            }
            leftCurrencyLabel.text = key
        }
    }
    
}
