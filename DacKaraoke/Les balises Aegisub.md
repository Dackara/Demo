<p align="center">
  <img src="https://github.com/user-attachments/assets/1549129d-d867-4cc1-b9d1-2fbd333ae6db" alt="Aegisub Supplément" width="400"/>
</p>

## I/Les balises classiques :

Il existe un grand nombre de balise et le travail de timeur ou Karamaker n'est pas de tout repos ne vous faite pas d'illusion :p Ils doivent sans cesse savoir quel Police utiliser, quel taille, quel effet *o* et à la fin on obtient un chef d'œuvre.

* **`{\k}`** : Il s'agit de la balise de base (chez le karamaker entre autre) la plus simple à comprendre. Elle permet un remplissage du mot ou de la syllabe de façon saccadé. Elle est automatiquement placé quand vous faites un kara.
* **`{\K}`** : Il s'agit de la même balise sauf que cette fois-ci le remplissage de la syllabe ce fera de façon fluide et régulière. Pour le placer, vous n'avez qu'à changer le k de la balise d'origine en K.
* **`{\ko}`** : Même fonctionnement sauf que cette fois on remplis les bordures.
* **`{\b}`** : Met le texte en gras. Si l'on veut seulement mettre une partie du texte en gras il faut faire de cette façon => {\b1} le texte {\b0} ... *par Exemple: Son nom est Detective {\b1}Conan{\b0} ... ici Conan sera noté en gras
* **`{\i}`** : Même principe de fonctionnement sauf que le texte sera en italique. Donc on fait {\i1} le texte {\i0}.
* **`{\u}`** : Cette balise sert à souligné le texte.
* **`{\s}`** : Sert à barrer le texte.
* **`{\fn}`** : Cette balise est assez spécial puisse qu'elle permet de changer la police du texte que vous aviez déjà réglé auparavant dans les styles. Pour l'utiliser et changer à votre guise la police à certain endroit du sous titre, vous devez placer la commande puis y insérer le nom de la police comme ça {\fn }... *Exemple: j'ai écrit mon texte avec la police Cry Uncial et je veux le mettre en Arial et bien il vous suffit simplement de faire ceci => {\fnarial} votre texte.
* **`{\fs}`** : Elle permet de modifier la taille de la police de votre sous-titre ... *Exemple: {\fs20} le texte ... votre police aura alors une taille de 20
* **`{\be}`** : Effet de flou aussi appelé Blur Edge. Elle permet de donner à vos contours de sous-titre un effet de flou flou.
* **`{\fscx}`** : Permet une distorsion horizontale du texte. *Exemple: {\fscx120} ... votre texte sera allongé de façon horizontale de 20% de plus (la valeur par défaut étant de 100%; la taille initial de votre police sur l'axe des abscisses ... 100+20=120 OMG des Maths oO).
* **`{\fscy}`** : Pareil mais permet une distorsion verticale du texte. le principe est le même. *Exemple: {\fscy140}.
* **`{\fsp}`** : Il s'agit de l'espacement entre chaque (s'exprime en pixels). *Exemple: {\fsp10} ... chaque lettre sera séparé de 10 pixels.
* **`{\an}`** : Celle-ci suis un code assez spécial qui permet de définir la position du sous-titre sur la vidéo ...*{\an1} => le sous-titre sera placé en bas à gauche.
  * **`{\an2}`**  => le sous-titre sera placé en bas au centre.
  * **`{\an3}`**  => le sous-titre sera placé en bas à droite.
  * **`{\an4}`**  => le sous-titre sera placé au milieu à gauche.
  * **`{\an5}`**  => le sous-titre sera placé au milieu au centre.
  * **`{\an6}`**  => le sous titre sera placé au milieu à droite.
  * **`{\an7}`**  => le sous-titre sera placé en haut à gauche.
  * **`{\an8}`**  => le sous titre sera placé en haut au centre.
  * **`{\an9}`**  => le sous-titre sera placé en haut à droite.
* **`{\frx}`** : Le texte s'incline suivant l'axe horizontale x. *Exemple: {\frx50} le texte s'inclinera sur l'axe horizontale d'un angle de 50°.
* **`{\fry}`** : Même principe que {\frx} mais sur l'axe vertical y.
* **`{\frz}`** : Là aussi même principe mais sur l'axe de profondeur z (assez spécial à utiliser).
* **`{\shad}`** : Permet de régler le décalage des ombres du sous-titre (s'exprime en pixels) ...*Exemple: {\shad5} les ombres du sous-titre seront plus visibles (en effet ils seront décalé de 5 pixels).
* **`{\bord}`** : Est utilisé pour agrandir ou rétrécir les bordures du sous-titres (s'exprime en pixels). ... *Exemple: {\bord4} votre sous-titres aura ses bordures étiré de 4 pixels.
* **`{\pos}`** : Alors cette balise est bien pratique pour positionner les sous-titres à un endroit sur la vidéo (les valeurs s'expriment en pixels). Pour positionner le sous-titre à un certain endroit il faut faire de cette façon => {\pos(x,y)} ... le x représente la position du sous-titre sur l'axe des abscisses et le y sur l'axe des ordonnés ...*Exemple: {\pos(150,300)} votre sous-titre sera placé à 150 pixels sur l'axe des abscisses et à 300 pixels sur l'axe des ordonnés. Cette balise peut être pratique si l'ont doit traduire un endroit de la vidéo comme une pancarte, un e-mail ou un sms ...
* **`{\move}`** : Déplace le texte d'un endroit à un autre selon la durée du sous-titre. On peut également régler à quel moment le texte commencera à bouger et quand est-ce qu'il va s'arrêter ainsi que où. Pour comprendre il vous suffis de faire ceci => {\move(x1,y1,x2,y2)} le x1 représente la position de départ du sous-titre sur l'axe des abscisses et le y représente la position de départ sur l'axe des ordonnés. le x2 et y2 représente donc le point d'arrivé de votre sous-titre à la fin de celui-ci. Mais comme je vous l'ai dis, vous pouvez régler le temps à là quel votre sous titre bougera. C'est à peu près de la même façon sauf qu'il vous rajouter le temps => {\move(x1,y1,x2,y2,t1,t2)} et donc t1 représente le moment où le sous-titre commence à bouger et t2 le moment où il s'arrête (En millisecondes).
* **`{\org}`** : Cette commande est assez spécial et compliqué à utiliser mais elle représente l'origine du point de gravité du sous-titre (je sais c'est barbare comme mot lol) c'est à dire qu'il définit l'axe de rotation de votre sous-titres à partir d'un point fixé. Il pourra surtout servir lors des Kara pour donner certain effets plus ou moins complexes ...*Exemple: {\org(100,400)} l'origine du point de gravité du sous-titre se trouvera à 100 pixels sur l'axe des x et à 400 pixels sur l'axe des y. Lors des Kara, si l'ont prend des valeurs plus grande tel que => {\org(10000,50000)} on pourra donner quelque effets de rotation intéressant surtout sur l'axes des z.
* **`{\fad}`** : l'effet de fading ou effet de fondu est un effet agréable à l'œil qui permet de faire apparaitre ou disparaitre le sous-titre en fondu (beaucoup utilisé pour les times et les kara). On l'utilise de cette façon => {\fad(T1,T2)} ici T1 montre en combien de temps va apparaitre le sous-titre et T2 désigne lui la disparition du sous-titre en fondu (le tout s'exprime en millisecondes). *Exemple: {\fad(100,300)} le sous titre apparaitra en fondu pendant 100 millisecondes et disparaitra en fondu pendant 300 millisecondes.
* **`{\r}`** : Cette permet tout simplement d'arrêter les effets d'autre balise à l'endroit où il est placé. Je reprend l'exemple de Conan => Son nom est Detective {\b1}Conan{\r} ... Conan est écrit en gras et l'effet s'arrêtera que à Conan. Si il y a plusieurs effets d'affilés, ils seront tous annulé pour le reste de la phrase.
* **`{\fe}`** : Elle permet de régler le type d'encodage du sous-titre. *Exemple: {\fe128} pour un encodage des caractères Japonais. Je n'ai jamais utilisé cette console donc je ne pourrais pas vous dire comment vous en servir. Désolé
* **`{\clip(x1,y1,x2,y2)}`** : Il s'agit d'un clip ou d'une zone de visibilité. Elle permet de faire apparaitre ou disparaitre un sous-titre à certain point partiellement ou totalement. Vous n'avez pas besoin de taper les commandes Clignement d'œil elles sont déjà prête à être placé ... c'est l'option à côté de la vidéo.

## II/Les Couleurs et transparence :

Si vous voulez donner de beau effet à vos sous titre (notamment lors des kara et parfois lors des times simples), il vous faut savoir manier l'hexadécimal ... et là vous vous dites c'est quoi ce machin truc chouette; ne vous inquiétez pas, ce n'est pas bien compliqué à comprendre ^^ même moi qui suis une quiche en Maths à réussi à déchiffrer ce que ça voulait dire x) donc ne vous inquiétez pas.

### 1) Les couleurs :

Pour régler manuellement les couleurs ou pour donner un effet, vous pouvez utilisé ces commandes :
* **`{\1c&H**&}`** : Cette commande permet de régler les couleurs primaires. Les * représente une combinaison de chiffre et de lettres qui définissent la couleur.
* **`{\2c&H**&}`** : Même principe que pour les couleurs primaire, sauf qu'il permet de régler les couleurs secondaires.
* **`{\3c&H**&}`** : Cette fois-ci, cette commande permet de modifier la couleur des bordures.
* **`{\4c&H**&}`** : Et enfin celle-ci permet de changer la couleur des ombres du sous-titre.
Et là vous me dites oui mais ça ne m'explique toujours pas comment ça marche x) et bien j'y arrive.
Arigato Kami-sama, grâce à Aegisub vous n'avez pas besoin de tester toutes les commandes pour trouver la couleur de vos rêves.
En effet, vous pouvez utiliser le gestionnaire de style pour pouvoir avoir accès au code ass. des différentes couleurs.

![logo2_10](https://github.com/user-attachments/assets/1335d723-09a7-4a42-b849-7538b82b67bf) <br/>
![sans_t19](https://github.com/user-attachments/assets/ffb0031b-65e0-4734-afc9-745621cd2795)
Vous n'avez plus qu'à copier/coller la petite ligne puis de taper le code et voilà votre couleur à changer o It's magical
Avec ceci vous pouvez déjà donner de petit effet très sympa.

### 2) Transparence :

C'est ici que l'hexadécimal va vraiment vous servir alors suivez bien
Pour appliquer un effet de transparence partiel ou totale de vos sous-titres, vous devez insérer ce code :
* **`{\alpha&Hxx&}`** : avec ceci vous pouvez définir le pourcentage de transparence de votre sous-titre. Les ** doivent être remplacer par des chiffres. *Exemple: Je veux que mon sous-titre disparaisse de 25%, alors je tape => {\alpha&H33&}
![sans_t11](https://github.com/user-attachments/assets/5d4e023c-2572-4fe7-8557-37251e7dbf13) <br/>
![sans_t10](https://github.com/user-attachments/assets/260b7925-a057-4272-957f-f482ac3467b6) <br/>
50%, alors je tape => {\alpha&H66&} <br/>
![sans_t12](https://github.com/user-attachments/assets/ea29584f-1291-49f8-813b-2efeb2790f30) <br/>
![sans_t13](https://github.com/user-attachments/assets/d707b99d-2313-4d86-a06a-4f40bf427543) <br/>
75%, alors je tape => {\alpha&H99&} <br/>
![sans_t16](https://github.com/user-attachments/assets/a1c2547f-d6a5-4bd8-a10b-821ce9c7bfe3) <br/>
![sans_t15](https://github.com/user-attachments/assets/f41c7503-4205-4df4-8858-3037a039d5e4) <br/>
100%, alors je tape => {\alpha&HFF&} <br/>
![sans_t17](https://github.com/user-attachments/assets/2e540de8-5be2-46d8-bceb-e52cb19ae9d1) <br/>
![sans_t18](https://github.com/user-attachments/assets/5da6f48d-e43c-4f8a-b0d8-dd3d698b9a33) <br/>

En plus de pouvoir le faire sur les sous-titres en général, vous pouvez choisir quelle zone doit être transparente.
Ce n'est pas bien compliquer si vous avez compris le fonctionnement des couleurs et de la commande alpha.
Alors, on réutilise la même commande de début pour les couleurs. C'est à dire \1c, \2c, \3c et \4c. Sauf que l'ont va changer un petit truc.
* **`{\1a&H**&}`** : Pour définir la transparence de la couleur primaire.
* **`{\2a&H**&}`** : Pour définir la transparence de la couleur secondaire.
* **`{\3a&H**&}`** : Pour définir la transparence des bordures.
* **`{\4a&H**&}`** : Pour définir la transparence des ombres du sous-titre.
Le tout en remplaçant les `**` de la même façon que alpha.

### 3) Effets et suite d'effets :

Pour ceux qui veulent apprendre à faire des effets de présentation ou faire des effets karaokés plus poussé je vous suggère vivement d'utiliser ces commandes :p 
Il y a très peu à connaitre mais certaine peuvent être très complexe et je n'ai malheureusement pas réussi à tout comprendre ^^'
Si vous avez suivi jusque ici et que vous voulez aller encore plus loin, alors ne trainez pas et lisez la suite.
* **`{\t(t1,t2,\effet)}`** : Cette balise est très utile et vraiment indispensable pour un Karamaker car il s'agit d'un effet temporelle o 
C'est à dire, vous réglez vos temps et vous ajouter un effet; 
L'effet se déclenchera un un moment dans le sous-titre. 
`t1` représente le temps à partir du quel il se déclenchera après le début de celui-ci; 
`t2` représente le temps auquel fini l'effet ... *Exemple : mon texte à une police 20 est je veux le faire passer à disons 500ms à une police de 50 et l'effet se finira à 850ms par rapport au début du sous-titre ... et bien vous faites ceci => {\t(500,850,\fs50)}.
Vous voulez appliquer plusieurs effet à la fois et en même temps ? Et bien ce n'est pas plus compliquer que ça Clignement d'œil => {\t(t1,t2,\effet1\effet2)} ou {\t(t1,t2,\effet1\effet2\effet3)} ... et ainsi de suite, il n'y a pas de limite. 
Mais si vous mettez beaucoup d'effets (surtout lors d'un Kara) vous pourrez facilement tout mélanger (les temps, effets) oO alors faites y très attention si vous vous lancez dedans.
