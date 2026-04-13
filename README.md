DPD Viewer 🇫🇷
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
5. Cliquez sur OK pour démarrer la simulation.
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

---
---
DPD Viewer 🇬🇧
---

> DPD-Viewer is an application for simulating and visualizing dynamic particle systems. Developed as part of the M1 Chemoinformatics program, it allows users to model the behavior of particles subjected to complex physical constraints (conservative, dissipative, and random forces).

---
**Objectives**
The objective is to provide an interface capable of simulating the behavior of moving particles and delivering immediate visual feedback through two approaches: 
- Graphical Display: Real-time dynamic scatter plot via the TChart library.
- Numerical Display: Precise logging of positions, velocities, and accelerations in a TMemo
---
**Technical Operation**
The simulation is based on an iterative loop that calculates the system’s evolution in three key steps:
- Verlet Algorithm: Use of the Velocity-Verlet model to calculate trajectories in a stable manner, synchronizing positions, velocities, and accelerations at each time step.
- Force Modeling (DPD): Calculation of pairwise interactions combining three forces: Conservative (repulsion), Dissipative (damping), and Random (thermal fluctuations).
- Domain Handling: Integration of Periodic Boundary Conditions (PBC) to simulate an infinite system without boundary effects.
---
**Installation & Setup** 
0. Prerequisites - Lazarus IDE installed on your computer.
1. Clone the repository or download the source code.
2. Open Lazarus and load the project via File -> Open by selecting uxDPD.lpr
3. Compile and run the program (F9)
4. In the Settings tab, enter the number of particles and the number of time steps.
5. Click OK to start the simulation.---
---
**Future Developments** 
- Two-Phase Systems: Handling of mixtures (e.g., water/oil) with specific interactions.
- Advanced Visualization: Color coding by particle type and 3D rendering.
- Statistical Analysis: Generation of density maps in real time.
---
**Authors**
- Pierre LE MEUR
- Hugo INGUIMBERTY
- Project Director: Mr. Gilles MARCOU
