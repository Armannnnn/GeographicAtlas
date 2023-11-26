//
//  MainViewController + TableView.swift
//  Geographic atlas
//
//  Created by Arman on 21.11.2023.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        register()
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func register(){
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleOfSection(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(section)
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
    ////        cell.textLabel?.text = cellDataSource[indexPath.row].name.common
    ////        cell.country.text = cellDataSource[indexPath.row].name.common
    ////        cell.capital.text = "\(removeSpecialCharacters(from: cellDataSource[indexPath.row].capital!))"
    ////        let url = URL(string: cellDataSource[indexPath.row].flags.png)
    ////        cell.flagImageView = UIImageView(data: url)
    //
    ////        switch cellDataSource[indexPath]
    //
    //        if let imageUrl = URL(string: cellDataSource[indexPath.row].flags.png) {
    //            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
    //                guard let data = data, error == nil else { return }
    //
    //                DispatchQueue.main.async {
    //                    cell.flagImageView.image = UIImage(data: data)
    //                }
    //            }.resume()
    //        }
    //
    //        let cellData = CellData(flag: cell.flagImageView,
    //                                country: cellDataSource[indexPath.row].name.common,
    //                                capital: "\(removeSpecialCharacters(from: cellDataSource[indexPath.row].capital ??                                                                          cellDataSource[0].capital!))",
    //                                population: "Population: \(checkPopulationNumber(cellDataSource[indexPath.row].population))",
    //                                area: "Area: \(checkArea(cellDataSource[indexPath.row].area))",
    //                                currencies: "Currencies: \(cellDataSource[indexPath.row].currencies ?? cellDataSource[0].currencies)")
    ////        data.insert(cellData, at: indexPath.row)
    //        cell.data = cellData
    //        return cell
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let countriesByContinent = viewModel.countryForSectionCount()
        
        let continent = Continent.allCases[indexPath.section].rawValue
        
        if let countries = countriesByContinent[continent] {
            let country = countries[indexPath.row]
            
            //            cell.country.text = country.name.common
            //            cell.capital.text = "\(removeSpecialCharacters(from: country.capital ?? cellDataSource[0].capital!))"
            //            cell.population.text = "Population: \(checkPopulationNumber(country.population))"
            //            cell.area.text = "Area: \(checkArea(country.area))"
            //            cell.currencies.text = "Currencies: \(country.currencies ?? cellDataSource[0].currencies)"
            //
            //            if let imageUrl = URL(string: country.flags.png) {
            //                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            //                    guard let data = data, error == nil else { return }
            //
            //                    DispatchQueue.main.async {
            //                        cell.flagImageView.image = UIImage(data: data)
            //                    }
            //                }.resume()
            //            }
            
            if let imageUrl = URL(string: country.flags.png) {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async {
                        cell.flagImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
            
            let cellData = CellData(country: country.name.common,
                                    capital: "\(removeSpecialCharacters(from: (country.capital ?? ["None"])))",
                                    population: "Population: \(checkPopulationNumber(country.population))",
                                    area: "Area: \(checkArea(country.area))",
                                    currencies: "Currencies: \(country.currencies ?? country.currencies)")
            cell.data = cellData
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        if cell.isExpanded || selectedIndex == indexPath {
            return 222.0
        } else {
            return 84.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex], with: .none)
        tableView.endUpdates()
    }
    
    private func checkPopulationNumber(_ number: Int) -> String {
        switch number {
        case 1000000000...Int.max:
            let billions = number / 1000000000
            return "\(billions) billion"
        case 1000000...999999999:
            let millions = number / 1000000
            return "\(millions) million"
        case 1000...999999:
            let thousands = number / 1000
            return "\(thousands) thousand"
        default:
            return "\(number)"
        }
    }
    
    private func checkArea(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        
        switch number {
        case 1_000_000_000...Double.infinity:
            let billions = number / 1_000_000_000
            let formattedString = formatter.string(from: NSNumber(value: billions)) ?? ""
            return "\(formattedString) billion km²"
        case 1_000_000..<1_000_000_000:
            let millions = number / 1_000_000
            let formattedString = formatter.string(from: NSNumber(value: millions)) ?? ""
            return "\(formattedString) million km²"
        case 1_000..<1_000_000:
            let thousands = number / 1_000
            let formattedString = formatter.string(from: NSNumber(value: thousands)) ?? ""
            return "\(formattedString) thousand km²"
        case 0..<1_000:
            return "\(number) km²"
        default:
            let formattedString = formatter.string(from: NSNumber(value: number)) ?? ""
            return formattedString
        }
    }
    
    func removeSpecialCharacters(from strings: [String?]) -> String {
        let filteredStrings = strings.compactMap { $0 }
        let joinedString = filteredStrings.joined(separator: ", ")
        return joinedString
    }
    
}
