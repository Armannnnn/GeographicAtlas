//
//  ViewController.swift
//  Geographic atlas
//
//  Created by Arman on 21.11.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let activityIndicator = UIActivityIndicatorView()
    
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    var viewModel = MainViewModel()
    
    var cellDataSource = [CountryModel]()
    
    var data: [CellData] = []

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getCountries()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        viewModel.getCountries()
        viewModel.getFlags()
        bindViewModel()
    }
    
    func setupViews(){
        title = "Geographic atlas"
        view.backgroundColor = .white
        
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.configureWithOpaqueBackground()
        navBarApperance.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarApperance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperance
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        setupTableView()

        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func bindViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading else {return}
            DispatchQueue.main.async {
                isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] countryModel in
            guard let self, let countryModel else {return}
            cellDataSource = countryModel
            reloadTableView()
        }
    }
    
}


extension MainViewController{
    
    private func setConstraints(){
        tableView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
