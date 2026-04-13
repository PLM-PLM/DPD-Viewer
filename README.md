DPD Viewer
---

> DPD-Viewer est une application de simulation et de visualisation de systèmes dynamiques de particules. Développée dans le cadre du M1 Chemoinformatique, elle permet de modéliser l'évolution de particules soumises à des contraintes physiques complexes (forces conservatives, dissipatives et aléatoires).

---
**Objectifs**
L'objectif est d'offrir une interface capable de simuler le comportement de particules en mouvement et de fournir un retour visuel immédiat grâce à deux approches : 
- Affichage Graphique : Nuage de points dynamique en temps réel via la bibliothèque TChart.
- Affichage Numérique : Journalisation précise des positions, vitesses et accélérations dans un TMemo
---
**Fonctionnement technique**
La simulation repose sur une boucle itérative qui calcule l'évolution du système en trois étapes clés :
- Algorithme de Verlet : Utilisation du modèle Velocity-Verlet pour calculer les trajectoires de manière stable, en synchronisant positions, vitesses et accélérations à chaque pas de temps.
- Modélisation des Forces (DPD) : Calcul des interactions par paires combinant trois forces : Conservative (répulsion), Dissipative (amortissement) et Aléatoire (fluctuations thermiques).
- Gestion de l'Espace : Intégration de Conditions Périodiques de Limite (PBC) pour simuler un système infini sans effets de bord.
---
**Installation & démarrage** 

 
0. Prérequis - Lazarus IDE installé sur votre machine.
1. Clonez le dépôt ou téléchargez les sources.
2. Ouvrez Lazarus et chargez le projet via File -> Open en sélectionnant uxDPD.lpr
3. Compilez et lancez le programme (F9)
4. Dans l'onglet Paramètres, saisissez le nombre de particules et le nombre de pas de temps.
5. Cliquez sur OK pour démarrer la simulation.---**Perspectives d'évolution**
---
**Perspectives d'évolutions** 
- Systèmes Biphasiques : Gestion de mélanges (ex: eau/huile) avec interactions spécifiques.
- Visualisation Avancée : Code couleur par type de particule et rendu 3D.
- Analyse Statistique : Génération de cartes de densité en temps réel.
---
**Auteurs**
- Pierre LE MEUR
- Hugo INGUIMBERTY
- Directeur de projet : Mr. Gilles MARCOU

