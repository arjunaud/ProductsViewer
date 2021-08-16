import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(completion: @escaping ([Product], Error?) -> Void)
}

class ProductService:ProductServiceProtocol {
    static let baseURL = "https://api.target.com/mobile_case_study_deals/v1"
    
    func fetchProducts(completion: @escaping ([Product], Error?) -> Void) {
        let request = URLRequest(url: URL(string: Self.baseURL + "/deals")!)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let responseData = data else {
                completion([], error)
                return
            }
            var products:[Product] = []
            let productList = try? JSONDecoder().decode(ProductList.self, from: responseData)
            if let productList = productList {
                products = productList.products
            }
            completion(products, error)
        }
        task.resume()
    }
}
