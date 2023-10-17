//
//  MarketChartDataWorker.swift
//  MarketCoins
//
//  Created by Robson Moreira on 07/11/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class MarketChartDataWorker {
    
    private let dataProvider: MarketChartDataProvider?
    private var completion: ((Result<MarketChartModel?, KarketCoinsError>) -> Void)?
    
    init(dataProvider: MarketChartDataProvider = MarketChartDataProvider()) {
        self.dataProvider = dataProvider
        self.dataProvider?.delegate = self
    }
    
    func doFetchMarketChart(id: String,
                            baseCoin: String,
                            from: String,
                            to: String,
                            completion: @escaping ((Result<MarketChartModel?, KarketCoinsError>) -> Void)) {
        dataProvider?.fetchMarketChartRange(by: id, currency: baseCoin, from: from, to: to)
        self.completion = completion
    }
}

extension MarketChartDataWorker: MarketChartDataProviderDelegate {
    
    func success(model: Any) {
        guard let completion = completion else {
            fatalError("Completion not implemented!")
        }
        completion(.success(model as? MarketChartModel))
    }
    
    func errorData(_ provider: GenericDataProviderDelegate?, error: Error) {
        guard let completion = completion else {
            fatalError("Completion not implemented!")
        }
        
        if error.errorCode == 500 {
            completion(.failure(.internalServerError))
        } else if error.errorCode == 400 {
            completion(.failure(.badRequestError))
        } else if error.errorCode == 404 {
            completion(.failure(.notFoundError))
        } else {
            completion(.failure(.undefinedError))
        }
    }
}