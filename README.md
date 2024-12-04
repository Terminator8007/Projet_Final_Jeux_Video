# The Oath of Astral Sword Tempest (T.O.A.S.T)
Par Erwann Naud

Le jeu consiste en un action rpg ressemblant aux jeux de la série Ys. Le personnage principal pourra faire un combo de trois attaques à la suite et une attaque spéciale limité par une barre point de technique. Il devra combatre des ennemis pour sortir de la zone.

## Concept utilisé

### Autonomous agent
Ce concept sert à faire en sorte que les ennemis puisse se déplacer tout seul afin de rendre le jeu plus dynamique.
[source](https://en.wikipedia.org/wiki/Autonomous_agent)

![Autonomous agent](gif%20documentation/autonomous%20agent.gif)

### Champs de vision
Un champ de vision pour la détection du joueur par les ennemis
[source](https://gamedev.stackexchange.com/questions/120430/drawing-visibility-polygons-in-unity-for-vision-cones-with-occlusion)

![Champs de vision](gif%20documentation/acone%20vision.gif)

### Regénération de la vie et de la jauge de capacité spéciale
La vie commencera à se regénérer toute seule si le joueur reste immobile pendant trois seconde. Si il bouge la vie arrêtera de se regénérer. La jauge de capacité spéciale commence à se regénérer après cinq secondes dìnutilisation de l'attaqie spéciale. Cette mécanique permet de faire en sorte que le joueur puisse se soigner mais il doit être en lieu sûr et qu'il puisse utiliser son attaque spéciale plusieurs fois sans en abuser.
[source](https://www.giantbomb.com/regenerating-health/3015-83/)

![Régénération](gif%20documentation/regeneration.gif)

### Apparition de coffre
Faire en sorte qu'un coffre apparaisse lorsqu'une certaine condition est rempli. Pour le jeu ce sera une toast a collecter qui apparait une fois les ennemis de la zone éliminé.
[source](https://www.reddit.com/r/EnterTheGungeon/comments/q2nodl/i_got_black_chest_spawning_after_cleaning_a_room/)

![Apparition de coffre](gif%20documentation/apparition%20coffre.gif)