# Plan de migration : lazy.nvim vers le gestionnaire natif de Neovim 0.12

## Objectif
Migrer cette configuration Neovim d'un gestionnaire basé sur lazy.nvim vers une approche native et minimaliste avec `packadd` et la structure standard `pack/` de Neovim 0.12.

## Décision de principe
- Priorité au minimalisme, même si cela implique de perdre une partie du lazy loading et de l'automatisation de lazy.nvim.
- Utiliser les plugins natifs chargés via `pack/` pour les dépendances essentielles.
- Garder un mécanisme simple d'installation/mise à jour basé sur Git et/ou un petit script Lua.

## Étapes prévues
1. Recenser tous les plugins actuels et leurs dépendances.
2. Classer les plugins en deux groupes : essentiels (`pack/plugins/start`) et optionnels (`pack/plugins/opt`).
3. Remplacer `lua/config/lazy.lua` par un module d'initialisation natif, par exemple `lua/config/plugins_init.lua`.
4. Adapter les modules dans `lua/plugins/*.lua` pour fonctionner sans `lazy.nvim`.
5. Créer un script d'installation ou de synchronisation des plugins.
6. Vérifier le démarrage, le LSP, le colorscheme et les plugins critiques.
7. Nettoyer la configuration une fois la migration validée.

## Fichiers à toucher
- `init.lua`
- `lua/config/lazy.lua`
- `lua/config/plugins_init.lua` à créer
- `lua/plugins/*.lua`
- éventuellement un script d'installation des plugins

## Points d'attention
- Le chargement au démarrage sera plus direct et potentiellement moins flexible.
- Les dépendances entre plugins devront être gérées de façon plus explicite.
- Les plugins optionnels resteront accessibles via `:packadd`.

## Prochaine étape
Quand vous revenez, on pourra convertir ce plan en changements concrets dans la configuration.
