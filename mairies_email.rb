require "google_drive"
require_relative "Scrap_mairies"
require 'json'
require "csv"
#Appel de la Gem Google drive.
#Lien avec le fichier Scrap_mairies qui contient les hash des noms et adresses mail des mairies.
#Appel de la Gem json.
#Appel de la Gem csv.

def tableau_rangement
  session = GoogleDrive::Session.from_config("config.json")
  ws = session.spreadsheet_by_key("1tRnJCWZWQYHh_9RLwS6A8h5894BKrAyrJA3d3NMsKDQ").worksheets[0]
  i = 1
  rangement.each do |mairie|
    ws[i, 1] = mairie[:name]
    ws[i, 2] = mairie[:email]
	i += 1
  end
  ws.save
end
#Fonction tableau_rangement.
#Ouverture de la session Google drive avec les clefs inscrites dans le fichier "config.json".
#Connexion avec le tableau créé sur le drive grace à la cléf.
#Vrariable i qui est égale (débute) à 1. 
#Séparation des chaque hash contenus dans le tableau "rangement". Chaque éléments s'appellent "mairie".
#Dans ligne i de la colonne 1 on stocke les valeurs "name" de chaque mairies. 
#Dans ligne i de la colonne 2 on stocke les valeurs "email" de chaque mairies.
#On dit que dès que la ligne à reçu ses valeurs, on passe à la ligne suivante.
#On ferme la boucle.
#Quand toutes les valeurs de tout les hash sont inscrites, on sauvegarde le spreadsheet.
#On ferme la fonction.

def johnson()
  tempHash = rangement
	
  File.open("jcvd.json","w") do |f|
    f.write(tempHash.to_json)
  end
end
#On créé lafonction "johnson".
#On stocke le tableau de stockage de référence "rangement" dans la variable "tempHash".
#On ouvre (créé ici) un fichier "jcvd.json".
#On enregistre les valeurs de "tempHash" dans le fichier et on lui attribut comme extention .json.
#On ferme la boucle.
#On termine la fonction.


=begin Fonction qui fonctionne mais qui prend beaucoup de ligne. Laissée ici à titre indicatif.
def csv()
  rangement
  column_names = rangement.first.keys
  s=CSV.generate do |csv|
    csv << column_names
    rangement.each do |x|
      csv << x.values
    end
  end
File.write('the_file.csv', s)
   
end

csv()
=end

def csv_file
  rangement

  CSV.open("data2.csv", "w") do |csv|
    rangement.each do |h|
      csv << h.values
    end
  end
end

csv_file
#On créé la fonction csv_file.
#On créé un fichier "data2.csv".
#On sépare chaque hash contenus dans le tableau "rangement".
#On envoie chaque valeurs de chaque hash dans le fichier csv.
#On ferme les boucles.
#On termine la fonction "csv_file".