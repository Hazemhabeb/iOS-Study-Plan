//
//  PostResponse.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//
struct PostResponse : Codable {
    let posts : [Post]
    let total : Int
    let skip : Int
    let limit : Int
}
