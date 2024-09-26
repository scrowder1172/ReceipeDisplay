//
// File: ContentView.swift
// Project: ReceipeDisplay
// 
// Created by SCOTT CROWDER on 9/26/24.
// 
// Copyright © Playful Logic Studios, LLC 2024. All rights reserved.
// 


import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        NavigationStack {
            List {
                Section("Breakfast") {
                    ForEach(recipes) { recipe in
                        if recipe.course == "Breakfast" {
                            NavigationLink(value: recipe) {
                                RecipeSummaryView(recipe: recipe)
                            }
                        }
                    }
                }
                
                Section("Lunch") {
                    ForEach(recipes) { recipe in
                        if recipe.course == "Lunch" {
                            NavigationLink(value: recipe) {
                                RecipeSummaryView(recipe: recipe)
                            }
                        }
                    }
                }
                
                Section("Main Course") {
                    ForEach(recipes) { recipe in
                        if recipe.course == "Main Course" {
                            NavigationLink(value: recipe) {
                                RecipeSummaryView(recipe: recipe)
                            }
                        }
                    }
                }
                
                Section("Snacks and Sandwiches") {
                    ForEach(recipes) { recipe in
                        if recipe.course == "Snacks and Sandwiches" {
                            NavigationLink(value: recipe) {
                                RecipeSummaryView(recipe: recipe)
                            }
                        }
                    }
                }
                
                Section("Side Dishes") {
                    ForEach(recipes) { recipe in
                        if recipe.course == "Side Dishes" {
                            NavigationLink(value: recipe) {
                                RecipeSummaryView(recipe: recipe)
                            }
                        }
                    }
                }
                
                Section("Soup") {
                    ForEach(recipes) { recipe in
                        if recipe.course == "Soup" {
                            NavigationLink(value: recipe) {
                                RecipeSummaryView(recipe: recipe)
                            }
                        }
                    }
                }
                
                Section("Desserts") {
                    ForEach(recipes) { recipe in
                        if recipe.course == "Desserts" {
                            NavigationLink(value: recipe) {
                                RecipeSummaryView(recipe: recipe)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
        .onAppear() {
            getReceipes()
        }
    }
    
    func getReceipes() {
        Task{
            guard let url = URL(string: "https://api.sampleapis.com/recipes/recipes") else { return }
            
            let request = URLRequest(url: url)
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    let error = String(decoding: data, as: UTF8.self)
                    print("Error getting recipes: \(error)")
                    return
                }
                
                recipes = try JSONDecoder().decode([Recipe].self, from: data)
                
            } catch {
                print("Error getting recipes: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}

struct RecipeSummaryView: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: recipe.photoUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(.rect(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
            }
        }
    }
}

struct RecipeDetailView: View {
    
    let recipe: Recipe
    @State private var isShowingNutrition: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) { // Adjust alignment if needed
            AsyncImage(url: URL(string: recipe.photoUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200) // Set a fixed height for the image
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(height: 200) // Keep the same height for placeholder
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.3))
            }
            .padding(.top, 7)
            
            Text(recipe.title)
                .font(.title.bold())
                .padding([.leading, .trailing, .bottom], 10) // Add padding around the text
            
            Divider()
            
            HStack {
                Text(recipe.course)
                Spacer()
                Text(recipe.cuisine)
            }
            .padding(.horizontal)
            .font(.subheadline.smallCaps())
            .fontDesign(.monospaced)
            
            Divider()
            
            ScrollView{
                VStack(alignment: .leading) {
                    
                    Group{
                        Text("Prep Time: \(recipe.prepTimeText)")
                        Text("Cook Time: \(recipe.cookTimeText)")
                        Text("Servings: \(recipe.servings)")
                        Text("Ingredients")
                    }
                    .font(.title2)
                    .padding(.bottom, 5)
                    
                    Text(recipe.ingredients)
                        .padding(.vertical, 5)
                    
                    Text("Directions")
                        .font(.title2)
                        .padding(.bottom, 5)
                    Text(recipe.directions)
                }
                .padding(.horizontal)
                
                Link("Found At: \(recipe.urlHost)", destination: URL(string: recipe.url)!)
                Button {
                    isShowingNutrition = true
                } label: {
                    Text("Nutrition Facts")
                }
            }
            
        }
        .textSelection(.enabled)
        .sheet(isPresented: $isShowingNutrition) {
            RecipeNutrionInfo(recipe: recipe)
                .presentationDetents([.medium])
        }
    }
}

struct RecipeNutrionInfo: View {
    
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nutrion Facts")
                .font(.title)
            
            Rectangle()
                .frame(height: 5)
            
            Text("Amount per serving")
                .font(.caption)
            
            Text(recipe.caloriesText)
            
            Rectangle()
                .frame(height: 2)
            
            Text("Total Fat ")
                .fontWeight(.bold) +
            Text(recipe.fatText)
            
            Text("Cholesterol ")
                .fontWeight(.bold) +
            Text(recipe.cholesterolText)
            
            Text("Sodium ")
                .fontWeight(.bold) +
            Text(recipe.sodiumText)
            
            Text("Total Carbohydrate ")
                .fontWeight(.bold) +
            Text(recipe.carbohydrateText)
            
            Text("\tTotal Sugars ")
                .fontWeight(.bold) +
            Text(recipe.sugarText)
            
            Text("Protein ")
                .fontWeight(.bold) +
            Text(recipe.proteinText)
            
            Text("Fiber ")
                .fontWeight(.bold) +
            Text(recipe.fiberText)
        }
        .fontWidth(.expanded)
        .textSelection(.enabled)
    }
}

struct SelectableTextView: UIViewRepresentable {
    var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false // Disable editing
        textView.isSelectable = true // Enable selection
        textView.isScrollEnabled = false // Disable scrolling if you want it to fit the content
        textView.backgroundColor = UIColor.clear // Match the background to your SwiftUI design
        textView.font = UIFont.systemFont(ofSize: 16) // Customize font size if needed
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
