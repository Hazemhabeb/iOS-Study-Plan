//
//  Post.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//
import Foundation

struct Post : Codable , Identifiable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}
