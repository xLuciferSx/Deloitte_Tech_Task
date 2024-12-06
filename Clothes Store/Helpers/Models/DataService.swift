//
//  DataService.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation

enum DataServiceError: Error {
  case invalidURL
  case noData
  case decodingError(Error)
  case networkError(Error)
}

class DataService {
  static let shared = DataService()
  private init() {}

  private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, *) {
      decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
  }()

  func getProducts(completion: @escaping (Result<Products, DataServiceError>) -> Void) {
    guard let url = URL(string: URLCall.catalogue.rawValue) else {
      DispatchQueue.main.async { completion(.failure(.invalidURL)) }
      return
    }

    URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
      guard let self = self else { return }

      DispatchQueue.main.async {
        if let error = error {
          completion(.failure(.networkError(error)))
          return
        }
        guard let data = data else {
          completion(.failure(.noData))
          return
        }
        do {
          let products = try self.decoder.decode(Products.self, from: data)
          completion(.success(products))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }.resume()
  }
}
