import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let aisle: String
    let imageURL: URL?
    let amountInCents: Int
    let currencySymbol: String
    let displayString: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case aisle
        case regularPrice = "regular_price"
        case imageURL = "image_url"
        case amountInCents = "amount_in_cents"
        case currencySymbol = "currency_symbol"
        case displayString = "display_string"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.aisle = try container.decode(String.self, forKey: .aisle)
        if let imageURLString = try? container.decode(String.self, forKey: .imageURL) {
            self.imageURL = URL(string: imageURLString)
        } else {
            self.imageURL = nil
        }
        
        let regularPrice = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .regularPrice)
        self.amountInCents = try regularPrice.decode(Int.self, forKey: .amountInCents)
        self.currencySymbol = try regularPrice.decode(String.self, forKey: .currencySymbol)
        self.displayString = try regularPrice.decode(String.self, forKey: .displayString)
    }
}

struct ProductList: Decodable {
    let products: [Product]
}
