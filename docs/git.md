# Git

## Branchs

Pour créer une branche, **le faire directement en local** avec les commandes git :
`git checkout main`
`git branch <branch-name>`

Pour chaque fiche Jira, créer une branche **partant du main** avec ce format pour le nom : "**DF-<n° ticket>--<nom-fiche>**" 
avec *<n° ticket>* étant le numéro du ticket qui correspond à la branche, et *<nom-fiche>* étant le nom de la fiche espacé par des tirets ( - )

Une fois la branche créee, **la push directement sur le remote** :
`git push -u origin <branch name>`

## Commits 

Faire un commit pour **chaque changements/étapes** de la réalisation de la fiche.

Le nom du commit doit être sous cette forme : "**DF-<n° ticket> <titre>**" 
avec <n° ticket> étant le numéro du ticket qui correspond à la branche, et <titre> qui correspond au titre du commit (un résumé court en quelques mots)

On peut aussi rajouter une description en plus du titre pour les commimts en rajoutant un `-m` :
`git commit -m "DF-xx titre" -m "description"`

## Merge Requests

Les merges requests se font **directement sur Jetbrains Space**. **Créer la merge requests assez tôt**, même si la fiche n'est pas terminé.
Cela permet de suivre mieux l'avancements des tâches.

**Faire une belle description bien détaillée et bien présentée !**

Pour le nom des merges requests : "**DF-<n° ticket> <titre>**"
avec <n° ticket> étant le numéro du ticket qui correspond à la branche, et <titre> qui correspond au titre de la fiche, de la branche ou un résumé bref des changements

**Mettre en reviewer, au minimum *Théo Constant*, *Yohan Rudny* et *Mehdi Ali***

Une fois la fiche terminé, **changer son statut en "In Review"**, **avertir sur la merge request que les travail est terminé**,
et attendre les reviews

Si vous êtes reviewer, après avoir vérifié et tester le code, approuver ou demander des modifications via des commentaires

**Pour merge les branches et changer le statut de la fiche à "Travail Terminé" ou à "Travail Invalidé",
c'est "Théo Constant" qui s'en occupe**