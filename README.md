# README

Foodiegram è un applicativo web nato perchè gli utenti possano condividere ricette di cucina.

Il progetto è realizzato utilizzando Ruby on Rails.

Ogni ricetta è caratterizzata:
.un titolo
.un campo di tipo integer che indica le porzioni
.un campo di tipo integer che indica il tempo di preparazione, espresso in minuti
.un campo di tipo integer che indica l'eventuale tempo di cottura, espresso in minuti
.un campo di tipo text contenente gli ingredienti
.un campo di dipo text contenente le istruzioni
.un campo di tipo text contenente eventuali note
.un'immagine

Ogni ricetta può appartenere a più categorie. Ogni categoria è caraterizzata da un nome univoco.

Un utente registrato è descritto da:
.una email (univoca)
.una password
.uno username (univoco)
.un avatar

Ci sono 3 tipi di utenti che si possono interfacciare con l'applicativo web.

Gli utenti non registrati possono:
1. Registrarsi attraverso un form
2. Visualizzare le ricette
3. Visualizzare i commenti
4. Visualizzare le categorie
5. Ricercare il titolo di una ricetta attraverso una barra di ricerca
6. Visualizzare i like di ogni ricetta

L'utente registrato può effettuare il login e una volta loggato può:
1. Modificare o eliminare le proprie ricette
2. Modificare o eliminare i propri commenti
3. Modificare il proprio profilo
4. Mettere 'mi piace' a ricette ed eventualmente rimuovere il 'mi piace'
5. Seguire altri utenti ed eventualmente non seguirli più
6. Visualizzare, in una pagina dedicata, le ricetta postate dagli utenti seguiti
5. Effettuare logout

L'amministratore una volta autenticato può:
1. Gestire utenti
2. Gestire categorie
3. Gestire ricette
4. Gestire commenti
5. Gestire i voti

Nel processo di sviluppo sono stati sviluppati anche dei test automatici, nello specifico:
. test dei modelli
. test dei controller
. test integrazione
. test di systema, attraverso Selenium Web Driver e Capybara per simulare le azioni dell'utente.


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