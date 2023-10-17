//
//  CoinsListInteractor.swift
//  IsisMarketCoins
//
//  Created by Guilherme Silveira de Souza on 16/10/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CoinsListBusinessLogic
{
  func doSomething(request: CoinsList.Something.Request)
}

protocol CoinsListDataStore
{
  //var name: String { get set }
}

class CoinsListInteractor: CoinsListBusinessLogic, CoinsListDataStore
{
  var presenter: CoinsListPresentationLogic?
  var worker: CoinsListWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: CoinsList.Something.Request)
  {
    worker = CoinsListWorker()
    worker?.doSomeWork()
    
    let response = CoinsList.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
