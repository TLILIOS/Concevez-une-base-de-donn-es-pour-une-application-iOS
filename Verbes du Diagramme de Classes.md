# Traduction des Verbes du Diagramme de Classes en Code Swift

Ce document explique comment les verbes utilisés dans le diagramme de classes sont traduits en code Swift concret.

## 1. "has" (User -- Sleep)
```swift
class User {
    private var sleepRecords: [Sleep] = []
    
    // Le verbe "has" se traduit par des méthodes d'accès et de gestion
    func hasSleep(_ sleep: Sleep) -> Bool {
        return sleepRecords.contains(where: { $0.id == sleep.id })
    }
    
    func addSleep(_ sleep: Sleep) {
        sleepRecords.append(sleep)
    }
    
    func getSleeps() -> [Sleep] {
        return sleepRecords
    }
}
```

## 2. "performs" (User -- Exercise)
```swift
class User {
    private var exercises: [Exercise] = []
    
    // Le verbe "performs" devient des actions
    func performExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
    
    func getPerformedExercises() -> [Exercise] {
        return exercises
    }
    
    func hasPerformedExercise(_ exercise: Exercise) -> Bool {
        return exercises.contains(where: { $0.id == exercise.id })
    }
}
```

## 3. "consumes" (User -- Meal)
```swift
class User {
    private var meals: [Meal] = []
    
    // Le verbe "consumes" devient des actions liées à la consommation
    func consumeMeal(_ meal: Meal) {
        meals.append(meal)
    }
    
    func getConsumedMeals() -> [Meal] {
        return meals
    }
    
    func getConsumedMealsForDate(_ date: Date) -> [Meal] {
        return meals.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}
```

## 4. "tracks" (User -- Hydration)
```swift
class User {
    private var hydrationRecords: [Hydration] = []
    
    // Le verbe "tracks" devient des méthodes de suivi
    func trackHydration(_ hydration: Hydration) {
        hydrationRecords.append(hydration)
    }
    
    func getHydrationTracking() -> [Hydration] {
        return hydrationRecords
    }
    
    func getDailyHydrationTracking(_ date: Date) -> Double {
        return hydrationRecords
            .filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
            .reduce(0) { $0 + $1.amount }
    }
}
```

## 5. "contains" (Meal -- MealItem)
```swift
class Meal {
    private var items: [MealItem] = []
    
    // Le verbe "contains" devient des méthodes de gestion du contenu
    func containsItem(_ item: MealItem) -> Bool {
        return items.contains(where: { $0.id == item.id })
    }
    
    func addItem(_ item: MealItem) {
        items.append(item)
    }
    
    func removeItem(_ item: MealItem) {
        items.removeAll(where: { $0.id == item.id })
    }
    
    func getContainedItems() -> [MealItem] {
        return items
    }
}
```

## 6. "generates" (User -- Statistics)
```swift
class User {
    private var statistics: Statistics?
    
    // Le verbe "generates" devient des méthodes de génération
    func generateStatistics() {
        statistics = Statistics(user: self)
        updateStatistics()
    }
    
    private func updateStatistics() {
        statistics?.updateSleepStats(from: sleepRecords)
        statistics?.updateExerciseStats(from: exercises)
        statistics?.updateMealStats(from: meals)
        statistics?.updateHydrationStats(from: hydrationRecords)
    }
    
    func getGeneratedStatistics() -> Statistics? {
        return statistics
    }
}
```

## Principes clés de la traduction des verbes

1. Les verbes deviennent des **méthodes d'action** (performExercise, consumeMeal)
2. Chaque verbe génère généralement **plusieurs méthodes associées** :
   - Une méthode pour effectuer l'action (add/perform/track)
   - Une méthode pour vérifier l'état (has/contains)
   - Une méthode pour récupérer les données (get)
3. Les noms des méthodes sont **explicites** et reprennent le verbe du diagramme
4. Les méthodes incluent souvent des **fonctionnalités supplémentaires** utiles (comme le filtrage par date)

## Avantages de cette approche

Cette approche permet de :
- Maintenir une cohérence entre le diagramme et le code
- Rendre le code plus lisible et compréhensible
- Faciliter la maintenance et l'évolution du code
- Respecter les principes de l'encapsulation et de la programmation orientée objet
