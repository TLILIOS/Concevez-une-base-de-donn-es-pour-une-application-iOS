# Documentation du Modèle Physique de Données

## Vue d'ensemble
Le MPD a été conçu pour stocker efficacement les données de l'application de bien-être tout en maintenant l'intégrité référentielle et en optimisant les performances des requêtes.

## Tables Principales

### 1. Users (Utilisateurs)
- Stockage des informations d'authentification
- Champs uniques pour username et email
- Hachage sécurisé des mots de passe
- Suivi des dates de création et dernière connexion

### 2. Sleep_Records (Enregistrements de sommeil)
- Liaison avec l'utilisateur via user_id
- Enregistrement des heures de coucher et réveil
- Calcul automatique de la durée de sommeil
- Possibilité d'ajouter des notes

### 3. Exercise_Records (Enregistrements d'exercices)
- Référence aux types d'exercices et niveaux d'intensité
- Calcul des calories brûlées
- Suivi temporel précis
- Notes pour des détails supplémentaires

### 4. Meals (Repas)
- Structure hiérarchique avec meal_types
- Relation many-to-many avec les aliments via meal_foods
- Calcul des apports nutritionnels
- Horodatage précis des repas

### 5. Hydration_Records (Enregistrements d'hydratation)
- Suivi simple et efficace de la consommation d'eau
- Horodatage de chaque enregistrement
- Mesures en millilitres pour la précision

## Tables de Référence

### 1. Exercise_Types
- Catalogue des types d'exercices disponibles
- Extensible pour ajouter de nouveaux types

### 2. Intensity_Levels
- Niveaux d'intensité standardisés
- Description pour chaque niveau

### 3. Meal_Types
- Catégorisation standard des repas
- Facilite l'analyse des habitudes alimentaires

### 4. Foods
- Base de données des aliments
- Informations nutritionnelles détaillées

## Table d'Optimisation

### Daily_Statistics
- Agrégation quotidienne des données
- Optimise les requêtes de rapport
- Mise à jour automatique
- Facilite la génération de graphiques

## Optimisations

### Index
- Optimisation des requêtes fréquentes
- Index sur les colonnes de jointure
- Index sur les colonnes de filtrage temporel

## Intégrité des Données

### Contraintes
- Clés étrangères avec suppression en cascade
- Contraintes de validation sur les valeurs
- Unicité des données critiques

### Horodatage
- Suivi automatique des dates de création
- Gestion des mises à jour
- Facilite l'audit et l'historique

## Évolutivité
- Structure modulaire permettant l'ajout de nouvelles fonctionnalités
- Tables de référence extensibles
- Support pour les futures fonctionnalités
