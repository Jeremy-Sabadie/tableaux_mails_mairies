require 'rubygems'
require 'open-uri'
require 'nokogiri'
require "google_drive"


def get_the_email_of_a_townhal_from_its_webpage(url)
	doc = Nokogiri::HTML(open(url))
	email = doc.css("td.style27 p.Style22 font")[6]
	email.text
end
#On créé une foction "get_the_email_of_a_townhal_from_its_webpage" qui prend comme argument "url".
#On créé une variable qui appelle Nokogiri sur l'url.
#On créé une deuxième variable qui correspond à l'emplacement de l'adresse mail dans la page html.
#On affiche l'adresse mail correspondante. 

def get_all_the_urls_of_val_doise_townhalls()
	doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	urls = doc.css('table.Style20 a.lientxt')
	urls.each do |url|  url["href"]= right_url(url["href"])
	end	
	urls
end
#On créé la fonction "get_all_the_urls_of_val_doise_townhalls".
#On créé une variable qui qui appelle l'ouverture de l'annuaire de l'annuaire des mairies.
#On créé une autre variable qui correspond au liens trouvés avec le css sur la page ouverte.
#on sépare chaque liens et on créé une variable qui est égale aux liens qu'on rectifie avec la fonction "right_url" construite plus bas dans le code. 

def right_url(url)
	url = 'http://annuaire-des-mairies.com' + url.split('').drop(1)*''
end
#On créé une fonction "right_url" qui enlève le premier caractère (.)des urls fournies par la fonction précédente et qui les remplace par rien.

def rangement
	res = []
	get_all_the_urls_of_val_doise_townhalls().each do |mairie_url|
		nom = mairie_url.text
		mail = get_the_email_of_a_townhal_from_its_webpage(mairie_url["href"])
		res << {:name =>nom , :email =>mail}
		#print "nom : #{nom} , mail : #{mail}"		
	end
	res
end
#On créé une fonction "rangement".
#On créé un tableau vide par défaut nommé "res".
#On créé une variable "nom" pour y stocker noms des mairies.
#On créé une autre variable "mail" pour y stocker les adresses mails des mairies.
#On ajoute au tableau "res" un hashpour chaque mairies qui contient le nom et le mail.
#On affiche le nom et l'adresse mail des mairies.

#puts rangement()
#On affiche les éléments de la fonction "rangement".

=begin
def sheet
  session = GoogleDrive::Session.from_config("config.json")
  ws = session.spreadsheet_by_key("1tRnJCWZWQYHh_9RLwS6A8h5894BKrAyrJA3d3NMsKDQ").worksheets[0]

  (1..ws.num_rows).each do |row|
  (1..ws.num_cols).each do |col|
    p ws[row = :name, col = :email]
  end
end
	sheet
end

=end