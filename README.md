# Compilateur d'Expressions Arithmétiques

Projet utilisant LEX et YACC pour l'analyse et l'évaluation d'expressions arithmétiques.

## 📋 Description

Ce projet implémente un analyseur et évaluateur d'expressions arithmétiques en deux parties :

### Partie A - Analyseur Syntaxique
- Analyse lexicale et syntaxique d'expressions arithmétiques
- Support des nombres entiers et flottants
- Détection et signalement des erreurs lexicales et syntaxiques
- Lecture depuis la ligne de commande ou fichier

### Partie B - Évaluateur avec Fonctions
- Évaluation complète des expressions syntaxiquement correctes
- Fonctions intégrées : `SOMME`, `PRODUIT`, `MOYENNE`, `VARIANCE`
- Support des imbrications de fonctions
- Exemple : `5 + 3 * SOMME(4, SOMME(1,2,3), VARIANCE(1, 1+1, MOYENNE(2,4), 4, 6-2))`

## 🛠️ Technologies

- **Flex** (LEX) - Analyseur lexical
- **Bison** (YACC) - Générateur d'analyseur syntaxique
- **GCC** - Compilateur C

## 📁 Structure du Projet

```
Arithmetic-Expression-Compiler/
├── lexerpb.l              # Analyseur lexical (avec fonctions)
├── parserpb.y             # Analyseur syntaxique (avec fonctions)
├── Makefile               # Script de compilation
├── expb.txt               # Fichier de tests
├── test.txt               # Tests additionnels
└── README.md              # Documentation
```

## 🚀 Installation

### Prérequis
- Git Bash ou MSYS2/MinGW (Windows)
- Flex
- Bison
- GCC

### Compilation

```bash
# Nettoyer les fichiers générés
make clean

# Compiler le projet
make

# L'exécutable calculateur.exe sera créé
```

## 💻 Utilisation

### Mode Fichier
```bash
./calculateur.exe expb.txt
```

### Mode Interactif
```bash
./calculateur.exe
# Tapez vos expressions ligne par ligne
# Appuyez sur Ctrl+D (Linux/Mac) ou Ctrl+Z (Windows) pour terminer
```

## 📝 Exemples d'Expressions

### Expressions Arithmétiques Simples
```
5 + 3 * 2                    → 11
10 / 2 - 1                   → 4
(2 + 3) * 4                  → 20
3.5 + 2.5                    → 6.0
-5 + 3                       → -2
-(2 + 3) * 4                 → -20
```

### Fonctions Simples
```
SOMME(1,2,3,4)              → 10
PRODUIT(2,3,4)              → 24
MOYENNE(2,4,6)              → 4
VARIANCE(2,4,6)             → 2.666...
```

### Fonctions Imbriquées
```
5 + 3 * SOMME(4, SOMME(1,2,3), 5)              → 50
PRODUIT(2, SOMME(1,2,3), 4)                     → 48
MOYENNE(SOMME(1,2), 3, 4)                       → 3.333...
VARIANCE(1, 1+1, MOYENNE(2,4), 4, 6-2)         → 1.2
```

### Nombres Flottants
```
SOMME(1.2, 2.3, 3.5)        → 7.0
PRODUIT(1.5, 2.0, 3.0)      → 9.0
MOYENNE(1.5, 2.5, 3.5)      → 2.5
```

### Nombres Négatifs
```
SOMME(-1, -2, 3)            → 0
PRODUIT(-2, 3, -4)          → 24
```

## 🔍 Détection d'Erreurs

Le compilateur détecte et signale :
- **Erreurs lexicales** : Caractères non reconnus
- **Erreurs syntaxiques** : Structure incorrecte de l'expression

Exemple d'erreur :
```bash
$ echo "5 + + 3" | ./calculateur.exe
Erreur de syntaxe : syntax error
Analyse complète : ÉCHEC
```

## 🧪 Tests

Créez un fichier de test `test.txt` avec vos expressions (une par ligne) :

```bash
./calculateur.exe test.txt
```

Le programme affichera le résultat de chaque expression.

## 📊 Fonctions Implémentées

| Fonction | Description | Exemple |
|----------|-------------|---------|
| `SOMME(a,b,c,...)` | Somme de tous les arguments | `SOMME(1,2,3)` → 6 |
| `PRODUIT(a,b,c,...)` | Produit de tous les arguments | `PRODUIT(2,3,4)` → 24 |
| `MOYENNE(a,b,c,...)` | Moyenne arithmétique | `MOYENNE(2,4,6)` → 4 |
| `VARIANCE(a,b,c,...)` | Variance statistique | `VARIANCE(2,4,6)` → 2.666... |

## 🔧 Compilation Manuelle

Si vous ne voulez pas utiliser le Makefile :

```bash
# Générer l'analyseur lexical
flex lexerpb.l

# Générer l'analyseur syntaxique
bison -d parserpb.y

# Compiler
gcc lex.yy.c parserpb.tab.c -o calculateur.exe -Wall -lm
```

## ⚠️ Notes Importantes

- Les expressions doivent être sur des lignes séparées
- Les espaces sont ignorés
- Les fonctions acceptent un nombre variable d'arguments
- Les imbrications de fonctions sont supportées
- Les nombres flottants utilisent le point (.) comme séparateur décimal

## 📚 Grammaire

### Tokens
```
ENTIER, FLOTTANT, PLUS (+), MOINS (-), MULT (*), DIV (/)
PARG ((), PARD ()), VIRG (,)
SOMME, PRODUIT, MOYENNE, VARIANCE
```

### Règles de Priorité
1. Parenthèses
2. Fonctions
3. Unaire moins (-)
4. Multiplication (*) et Division (/)
5. Addition (+) et Soustraction (-)

## 👤 Auteur

Soumia Hariz
## 📅 Date

14 Décembre 2025

## 📄 Licence

Projet académique - Université USTHB

