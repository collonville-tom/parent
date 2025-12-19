# Projet Parent TC (Technical socle)

## 1. Vue d'ensemble

Ce dépôt représente la fondation d'un écosystème de projets Java, structuré comme un projet Maven multi-modules. Son objectif principal est de fournir un ensemble de **POMs parents** standardisés pour différents types d'applications et de technologies.

En héritant de ces poms parents, les projets applicatifs bénéficient d'une configuration centralisée et cohérente pour :
- La gestion des dépendances (`dependencyManagement`)
- La configuration des plugins Maven
- Les profils de build
- La génération de la documentation et des rapports

Ce projet n'est pas une application fonctionnelle en soi, mais un **socle technique** destiné à accélérer et normaliser le développement.

## 2. Structure des Modules

Le projet est organisé autour de plusieurs modules parents, chacun spécialisé dans un contexte technologique.

- `tc-parent`: Le parent racine. Tous les autres modules héritent de celui-ci. Il contient les configurations communes à l'ensemble de l'écosystème (plugins de base, gestion des encodages, etc.).
- `tc-osgi-parent`: Parent destiné aux projets basés sur la technologie **OSGi**.
- `tc-jee-parent`: Parent pour les applications **Java Enterprise Edition (JEE)**.
- `tc-maven-plugin-parent`: Parent pour le développement de **plugins Maven** personnalisés.
- `tc-android-parent`: Parent pour les projets d'applications **Android**.
- `tc-asciidoctor-pdf-parent`: Parent spécialisé dans la génération de documentation **PDF** via Asciidoctor.
- `tc-asciidoctor-html-parent`: Parent spécialisé dans la génération de documentation **HTML** via Asciidoctor.

## 3. Prérequis

Pour construire et utiliser ce projet, vous aurez besoin de :

- **Java Development Kit (JDK)** : Version 21 ou supérieure.
- **Apache Maven** : Version 3.9 ou supérieure.

## 4. Processus de Build Local

Le fichier `settings.xml` à la racine est nécessaire pour résoudre certaines dépendances et configurations de repositories.

### Commandes principales

- **Compiler, tester et packager le projet :**
  ```bash
  mvn clean verify -s settings.xml
  ```

- **Construire et installer les artefacts dans votre dépôt local Maven :**
  Cette commande est nécessaire si des projets locaux dépendent de ces parents.
  ```bash
  mvn clean install -s settings.xml
  ```

- **Générer le site de documentation du projet :**
  Les rapports seront générés dans le répertoire `target/site` de chaque module.
  ```bash
  mvn site:site -s settings.xml
  ```

## 5. Intégration et Déploiement Continu (CI/CD)

Le projet est entièrement automatisé via le fichier `Jenkinsfile` à la racine.

Le pipeline Jenkins exécute les étapes suivantes :

1.  **Clean and Verify** : Nettoie le projet et exécute le cycle de vie Maven jusqu'à `verify` (compilation, tests...).
2.  **Compile and install** : Installe les artefacts dans le cache Maven de Jenkins.
3.  **Deploy Artifact** : Si la branche est `develop` ou `main`, les artefacts (JARs, POMs...) sont déployés sur un gestionnaire de dépôts (Nexus).
4.  **Build & Deploy Site** : Si la branche est `develop` ou `main`, le site de documentation complet du projet est généré et déployé sur un serveur web.

## 6. Documentation 

Documentation maven site du projet: 

https://collonvillethomas.freeboxos.fr/public/projets/develop/parent/tc-parent-module/