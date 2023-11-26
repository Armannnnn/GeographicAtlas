//
//  CustomTableViewCell.swift
//  Geographic atlas
//
//  Created by Arman on 26.11.2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var data: CellData?{
        didSet{
            guard let data = data else {return}
//            self.flagImageView = data.flag
            self.country.text = data.country
            self.capital.text = data.capital
            self.population.text = data.population
            self.area.text = data.area
            self.currencies.text = data.currencies

        }
    }
    
    var imageSelectedCallback: ((UIImageView) -> Void)?

    
    var isExpanded = false
    
    func animate(){
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                       options: .curveEaseInOut, animations:{self.contentView.layoutIfNeeded()})
    }
    
    var flagImageView: UIImageView = {
        let flagImageView = UIImageView()
        flagImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = 12
        return flagImageView
    }()
    
    
    let country: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 189, height: 20)
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var capital: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 189, height: 16)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let population: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 80, height: 18)
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.textColor = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let area: UILabel = {
        let label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.textColor = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencies: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 82, height: 18)
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.textColor = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 13.5, height: 7.5)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let learnMoreButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 91, height: 22)
        button.setTitle("Learn more", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0.478, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.976, alpha: 1)
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        container.clipsToBounds = true
        return container
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainer()
        setupCountry()
        setupCapital()
        setupPopulation()
        setupArea()
        setupCurrencies()
        setupArrowButton()
        setupLearnMoreButton()
        setupFlagImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContainer(){
        contentView.addSubview(container)
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupCountry(){
        container.addSubview(country)
        country.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).isActive = true
        country.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 106).isActive = true
        country.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -48).isActive = true
    }
    
    func setupCapital(){
        container.addSubview(capital)
        capital.topAnchor.constraint(equalTo: container.topAnchor, constant: 40).isActive = true
        capital.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 106).isActive = true
        capital.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -48).isActive = true
    }
    
    func setupPopulation (){
        container.addSubview(population)
        population.topAnchor.constraint(equalTo: container.topAnchor, constant: 72).isActive = true
        population.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12).isActive = true
        population.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 251).isActive = true
    }
    
    func setupArea (){
        container.addSubview(area)
        area.topAnchor.constraint(equalTo: container.topAnchor, constant: 98).isActive = true
        area.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12).isActive = true
        area.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 251).isActive = true
    }
    
    func setupCurrencies (){
        container.addSubview(currencies)
        currencies.topAnchor.constraint(equalTo: container.topAnchor, constant: 124).isActive = true
        currencies.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12).isActive = true
        currencies.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 251).isActive = true
    }
    
    func setupArrowButton(){
        container.addSubview(arrowButton)
        arrowButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 28.5).isActive = true
        arrowButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 312.25).isActive = true
        arrowButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -17.25).isActive = true
        arrowButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }
    
    func setupLearnMoreButton(){
        container.addSubview(learnMoreButton)
        learnMoreButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 168).isActive = true
        learnMoreButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 126).isActive = true
    }
    
    func setupFlagImageView(){
        container.addSubview(flagImageView)
        flagImageView.frame = CGRect(x: 0, y: 0, width: 82, height: 48)
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = 12
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 82).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc func buttonTapped() {
        isExpanded = !isExpanded
//        let mainVC = ViewController()
//        mainVC.tableView.beginUpdates()
//        mainVC.tableView.endUpdates()
    }
    
    @objc private func cellTapped() {
        imageSelectedCallback?(flagImageView)
    }

    
}
