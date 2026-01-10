//
//  SourceSeedDTO.swift
//  BisonC
//
//  Created by Maksim Kosharny on 07.01.2026.
//


struct SourceSeedDTO: Decodable {
    let title: String
    let publisher: String
    let year: Int?
    let note: String?
    let urlText: String?
}