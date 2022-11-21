//
//  WhatsappAPI.swift
//  FrentMC
//
//  Created by daniel stefanus christiawan on 21/11/22.
//

import Foundation

class WhatsAppManager {
    func createLink(goods: DataFieldDisplayGood) -> String {
        guard let numberString = goods.fields?.phoneNumber?[0] else {return ""}
        guard let goodsName = goods.fields?.name else {return ""}
        
        let goodsNameSpacing = goodsName.replacingOccurrences(of: " ", with: "%20")
        let textTemplate = "Halo%20saya%20ingin%20meminjam%20barang%20\(goodsNameSpacing)"
        let whatsAppURL = "https://wa.me/\(numberString)?text=\(textTemplate)"
        
        return whatsAppURL
    }
    
    func createLinkAdmin() -> String {
        let numberString = "628174960937"
        let textTemplate = "Hi%20admin,%20I%20need%20help"
        let whatsAppURL = "https://wa.me/\(numberString)?text=\(textTemplate)"
        
        return whatsAppURL
    }

}
