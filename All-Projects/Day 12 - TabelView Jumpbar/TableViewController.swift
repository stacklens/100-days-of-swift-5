//
//  TableViewController.swift
//  Day 12 - TabelView Jumpbar
//
//  Created by 杜赛 on 2020/3/4.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let movies: [String: [String]] = [
        "A": ["Aladdin", "Aliens", "American History X", "Anchorman: The Legend of Ron Burgundy", "A World Without Thieves"],
        "B": ["Basic Instinct", "Batman Begins", "Beauty and The Beast", "The Beach", "Big Trouble in Little China"],
        "C": ["Catch Me If You Can", "Cloudy with a Chance of Meatballs", "The Crow"],
        "D": ["The Departed", "Dredd", "Dr. Strangelove", "Dumb & Dumber"],
        "E": ["Enter The Dragon", "Equilibrium", "Escape from New York", "Event Horizon"],
        "F": ["Fight Club", "Finding Nemo", "First Blood", "Full Metal Jacket"],
        "G": ["Gladiator", "The Godfather", "Good Will Hunting", "Goodfellas", "The Goonies"],
        "H": ["Harry Potter", "Hercules", "Hero", "Horton Hears A Who", "How to Train Your Dragon"],
        "I": ["Ice Age", "Inception", "The Incredibles", "Indiana Jones", "Iron Man"],
        "J": ["Jaws", "Jumanji", "Jurassic Park"],
        "K": ["Kill Bill", "King Kong", "Knocked Up", "Kung Fu Hustle"],
        "L": ["The Land Before Time", "The Lego Movie", "The Lord of the Rings", "Lost in Space"],
        "M": ["The Mask", "The Matrix", "Men in Black", "Minority Report", "Mission Impossible", "Monsters, Inc."],
        "N": ["Napoleon Dynamite", "National Treasure", "Night of the Museum"],
        "O": ["Office Space", "Old Boy", "Old School", "Over the Hedge"],
        "P": ["The Pacifier", "Pan's Labyrinth", "Pinocchio", "Pride & Prejudice", "Public Enemies"],
        "Q": ["Quarantine", "Quick Gun Murugun", "A Quiet Little Marriage"],
        "R": ["Ratatouille", "Red Eye", "Resident Evil", "Rocky", "Rush Hour"],
        "S": ["Schindler's List", "Se7en", "The Shawshank Redemption", "Sherlock Holmes", "Shrek", "Silent Hill", "Sin City"],
        "T": ["Terminator", "Texas Chainsaw Massacre", "Titanic", "Toy Story", "Transformers", "The Truman Show"],
        "U": ["Undercover Brother", "Underworld", "Up In the Air"],
        "V": ["V for Vendetta", "Vanilla Sky", "Venus Boyz"],
        "W": ["Wall-E", "Wanted", "The Wild", "Willy Wonka and the Chocolate Factory", "The Wizard of Oz"],
        "X": ["The X-Files: Fight the Future", "X-Men", "xXx"],
        "Y": ["You Got Served", "You've Got Mail", "You Only Live Twice", "Young Frankenstein"],
        "Z": ["Zombieland", "Zookeeper", "Zoolander", "Zorro"]
    ]
    
    var movieKey: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        movieKey = movies.keys.sorted()
    }

    // MARK: - Table view data source
    
    // Prepare Jumpbar here.
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return movieKey
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }

    // Old content here.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = movies[movieKey[section]]?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieKey[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie Cell", for: indexPath)
        
        // Configure the cell...
        if let moviesInSection = movies[movieKey[indexPath.section]] {
            cell.textLabel?.text = moviesInSection[indexPath.row]
        } else {
            cell.textLabel?.text = ""
        }
        return cell
    }
}
