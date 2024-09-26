//
// File: Recipe.swift
// Project: ReceipeDisplay
// 
// Created by SCOTT CROWDER on 9/26/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import Foundation

struct Recipe: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let course: String
    let cuisine: String
    let mainIngredient: String
    let description: String
    let source: String
    let url: String
    let urlHost: String
    let prepTime: Int
    let cookTime: Int
    let totalTime: Int
    let servings: Int
    let yield: StringConvertible
    let ingredients: String
    let directions: String
    let tags: String
    let rating: String
    let publicUrl: String
    let photoUrl: String
    let nutritionalScoreGeneric: String
    let calories: StringConvertible
    let fat: String
    let cholesterol: StringConvertible
    let sodium: StringConvertible
    let sugar: String
    let carbohydrate: String
    let fiber: String
    let protein: String
    let cost: String
    
    static func ==(rhs: Recipe, lhs: Recipe) -> Bool {
        rhs.id == lhs.id
    }
    
    var prepTimeText: String {
        return prepTime.description == "0" ? "N/A" : "\(prepTime) minutes"
    }
    
    var cookTimeText: String {
        return cookTime.description == "0" ? "N/A" : "\(cookTime) minutes"
    }
    
    var caloriesText: String {
        return "Calories:\t\t\(calories.value == "" ? "N/A" : calories.value)"
    }
    
    var fatText: String {
        return fat == "" ? "N/A" : fat
    }
    
    var cholesterolText: String {
        return cholesterol.value == "" ? "N/A" : cholesterol.value
    }
    
    var sodiumText: String {
        return sodium.value == "" ? "N/A" : sodium.value
    }
    
    var sugarText: String {
        return sugar == "" ? "N/A" : sugar
    }
    
    var carbohydrateText: String {
        return carbohydrate == "" ? "N/A" : carbohydrate
    }
    
    var fiberText: String {
        return fiber == "" ? "N/A" : fiber
    }
    
    var proteinText: String {
        return protein == "" ? "N/A" : protein
    }
}

/// This code is required because the API has values that are sometimes Int and sometimes String
/// This code ensures that the Int are treated as String so that reading the value always returns String
struct StringConvertible: Codable, Hashable {
    let value: String

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Attempt to decode the value as an integer first, then convert to string.
        if let intValue = try? container.decode(Int.self) {
            value = String(intValue)
        }
        // If not an integer, try decoding it as a string.
        else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        }
        // If neither, throw a decoding error.
        else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Value is neither a string nor an integer"))
        }
    }
}

