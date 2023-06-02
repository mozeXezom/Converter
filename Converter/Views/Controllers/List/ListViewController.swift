//
//  ListViewController.swift
//  Converter
//
//  Created by mozeX on 02.06.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var listTableView: UITableView!
    
    public var buttonDirection: ButtonDirection = .left
    private let viewModel: ListViewModel = ListViewModel()
    weak var delegate: ButtonHandlerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupUI()

    }
    
    private func configure() {
        viewModel.getDataDefaults()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: Constans.listTableViewCell, bundle: nil), forCellReuseIdentifier: Constans.listTableViewCell)
    }
    
    func setupUI() {
        bgImageView.image = UIImage(named: "bgback_icon")
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.dismiss(controller: self)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constans.listTableViewCell, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.curNameLbl.text = viewModel.currencyData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch buttonDirection {
        case .left:
            delegate?.select(key: viewModel.currencyData[indexPath.row], button: .left)
        case .right:
            delegate?.select(key: viewModel.currencyData[indexPath.row], button: .right)
        }
        navigationController?.popViewController(animated: true)
    }
}
