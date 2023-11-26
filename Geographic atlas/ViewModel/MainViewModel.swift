//
//  MainViewModel.swift
//  Geographic atlas
//
//  Created by Arman on 21.11.2023.
//

import Foundation
import UIKit

class MainViewModel{
    
    var isLoading: Observable<Bool> = Observable(value: false)
    var cellDataSource: Observable<[CountryModel]> = Observable(value: nil)
    var dataSource: [CountryModel]?
    let url = "https://restcountries.com/v3.1/all"
    let cell = CustomTableViewCell()

    func numberOfSection() -> Int{
        return Continent.allCases.count
    }
    
    func titleOfSection(_ section: Int) -> String{
        return Continent.allCases[section].rawValue.uppercased()
    }
    
    func numberOfRows(_ section: Int) -> Int {
        let countriesByContinent = countryForSectionCount()

        let continent = Continent.allCases[section].rawValue

        if let countries = countriesByContinent[continent] {
            return countries.count
        } else {
            return 0
        }
    }

    
    func countryForSectionCount() -> [String: [CountryModel]] {
        guard let dataSource = dataSource else { return [:] }

        var countriesByContinent: [String: [CountryModel]] = [:]

        for country in dataSource {
            guard let continent = country.continents.first?.rawValue else { continue }

            if countriesByContinent[continent] == nil {
                countriesByContinent[continent] = []
            }

            countriesByContinent[continent]?.append(country)
        }

        return countriesByContinent
    }
    
    func getCountries(){
        isLoading.value = true
        
        NetworkManager.shared.fetchRequest(url) {result in
            switch result {
            case .success(let model):
                self.dataSource = model
                self.isLoading.value = false
                self.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getFlags() {
        NetworkManager.shared.imageFetchRequest(url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else  { return }
                self.cell.flagImageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    func mapCellData(){
        cellDataSource.value = dataSource
    }
}
