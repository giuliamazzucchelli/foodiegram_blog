# README

Realizzazione di un applicativo web per la condivisione di ricette di cucina.
Si distinguono 3 tipologie di utente che possono interfacciarsi con il sistema.

Gli utenti non registrati (guest) hanno la possibilità di:
1. Visualizzare l'elenco delle ricette.
2. Visualizzare le categorie delle ricette e le ricette presenti per ogni categoria.
3. Visualizzare una ricetta, i commenti e i like relativi alla ricetta.
4. Visualizzare l'elenco dei Blogger (utenti registrati).
5. Visualizzare il profilo del singolo Blogger.
6. Effettuare, attraverso una barra di ricerca, una ricerca per il titolo della ricetta.
7. Registrarsi al sistema compilando un apposito modulo.

Gli utenti registrati, una volta autenticati attraverso un form di login hanno la possibilità di:
1. Visualizzare, modificare il proprio profilo.
2. Creare nuove ricette, modificare e/o eliminare le proprie ricette.
3. Commentare le ricette sia proprie che di altri utenti, con la possibilità di modificare e/o eliminare i propri commenti.
4. Seguire altri utenti.
5. Togliere il 'segui' da utenti seguiti.
6. Visualizzare in una pagina dedicata, le sole ricette degli utenti seguiti.
7. Mettere 'like' alle ricette (sia proprie che di altri utenti) ed eventualmente rimuoverlo.
8. Effettuare il logout.
9. Eliminare il proprio account.

Gli utenti amministratori, una volta autenticati, hanno la possibilità di:
1. Visualizzare, modificare, eliminare e aggiungere gli utenti.
2. Visualizzare, modificare, eliminare e aggiungere gli utenti amministratori.
3. Visualizzare, modificare, eliminare e aggiungere categorie.
4. Visualizzare, modificare, eliminare e aggiungere le ricette.
5. Visualizzare, modificare, eliminare e aggiungere i commenti.
6. Visualizzare, eliminare o aggiungere i voti (like).

Ogni ricetta è caratterizzata:
1. un titolo
2. un campo di tipo integer che indica le porzioni (opzionale)
3. un campo di tipo integer che indica il tempo di preparazione, espresso in minuti
5. un campo di tipo integer che indica l'eventuale tempo di cottura, espresso in minuti (opzionale)
6. un campo di tipo text contenente gli ingredienti
7. un campo di dipo text contenente le istruzioni
8. un campo di tipo text contenente eventuali note (opzionale)
9. un'immagine (opzionale)
10. un id univoco

Ogni ricetta può appartenere a più categorie. Ogni categoria è caraterizzata da un nome univoco e da un id univoco.

Un utente registrato è descritto da:
.una email (univoca)
.una password
.uno username (univoco)
.una bio
.un avatar
.un id univoco

Un utente amministratore è descritto da:
.un id univoco
.una email univoca
.una password



TECNOLOGIE IMPIEGATE

Il progetto è stato sviluppato utilizzando Ruby on Rails.
Le principali gemme utilizzate sono state:
1. Devise per gestire autenticazione e sessione.
2. Acts_as_votable per implementare meccanismo di like/unlike.
3. RailsAdmin per realizzare una admin dashboard.

I commenti sono stati implementati utilizzando assocazioni polimorfiche.

E' presente una suite di test automatizzati realizzati con MiniTest, Capybara e Selenium.




----------------------------------------------

Foodiegram is a blog where people can post and share their food recipes.
A recipe is described by:
. title
. ingredients (text field)
. directions (text field)
. servings
. preparation time
. cooking time 
. notes
. picture

A recipe can belong to 0 or multiple categories, each category has an unique name.

Signed in users are able to:
. Create, edit and delete recipes
. Create, edit and delete comments
. Like/unlike recipes
. Follow/unfollow other users
. See on a specific page the followed user's recipes
. Logout

Admin are able to handle the resources.