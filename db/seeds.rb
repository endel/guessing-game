# encoding: utf-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Special.destroy_all
specials = Special.create([
  {:identifier => "extra_time", :name => "Extra time", :price => 29.0},
  {:identifier => "cut", :name => "Annihilate an option", :price => 55.0},
  {:identifier => "pass", :name => "Jump the picture", :price => 50.0}
  #{:id => "extra_time", :name => "Tip", :price => 80.0},
])

Authorization.destroy_all
User.destroy_all
User.create([
  {:email => "endel.dreyer@gmail.com", :name => "Endel Dreyer", :score => 0, :nickname => 'endel', :image => 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn1/157150_1543869820_876143468_n.jpg'},
  {:email => "b.fbohn@gmail.com", :name => "Bruno Bohn", :score => 0, :nickname => 'brunfb', :image => 'https://secure.gravatar.com/avatar/909da52723d803029eed33ddaf723684?s=420&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png'},
  {:email => "fuadksd@gmail.com", :name => "Fuad Saud", :score => 0, :nickname => 'fuadsaud', :image => 'https://secure.gravatar.com/avatar/22e767367fe9c51fc5d22af7a631c424?s=420&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png'},
  {:email => "caviegas@gmail.com", :name => "Carlos Viegas", :score => 0, :nickname => 'caviegas', :image => 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/372576_1534324128_425777156_n.jpg'}
])


Category.destroy_all
PictureCategory.destroy_all
Picture.destroy_all
Ranking.destroy_all
Matter.destroy_all

user = User.first


cachorros = Category.create(:name => "Cachorros")
cachorros.pictures.create([
  {:name => 'Vira-lata (SRD)', :url => 'http://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Branca.jpg/450px-Branca.jpg'},
  {:name => 'Pointer inglês', :url => 'http://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/English_pointer.jpg/800px-English_pointer.jpg' },
  {:name => 'Setter Inglês', :url => 'http://upload.wikimedia.org/wikipedia/commons/1/15/EnglishSetter9_fx_wb.jpg' },
  {:name => 'Kerry Blue Terrier', :url => 'http://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Kerry_Blue_Terrier.jpg/615px-Kerry_Blue_Terrier.jpg' },
  {:name => 'Cairn Terrier', :url => 'http://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Cairn-Terrier-Garten1.jpg/800px-Cairn-Terrier-Garten1.jpg' },
  {:name => 'Cocker Spaniel Inglês', :url => 'http://upload.wikimedia.org/wikipedia/commons/thumb/9/99/EnglishCockerSpaniel_wb.jpg/699px-EnglishCockerSpaniel_wb.jpg' },
  {:name => 'Setter Gordon', :url => 'http://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Orrvilas_enska_w800px.jpg/747px-Orrvilas_enska_w800px.jpg' },
  {:name => 'Airedale Terrier', :url => 'http://upload.wikimedia.org/wikipedia/commons/9/9e/Airedale_Terriers_Flickr.jpg' },
  {:name => 'Terrier australiano', :url => 'http://upload.wikimedia.org/wikipedia/commons/3/38/Silkyterrier125.jpg' },
  {:name => 'Bedlington Terrier', :url => 'http://upload.wikimedia.org/wikipedia/commons/d/d0/Bedlington_Terriers.jpg' },
  {:name => 'Border Terrier', :url => 'http://upload.wikimedia.org/wikipedia/commons/7/70/Border_Terrier.jpg' },
  {:name => 'Bull Terrier', :url => 'http://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Bull_Terrier.jpg/800px-Bull_Terrier.jpg' },
  {:name => 'Fox Terrier de Pêlo Liso', :url => 'http://upload.wikimedia.org/wikipedia/commons/f/f4/Patrickinfield.jpg' },
  {:name => 'Black and Tan Toy Terrier', :url => 'http://upload.wikimedia.org/wikipedia/commons/f/f5/English_Toy_Terrier_600_01.jpg' },
  {:name => 'Spitz dos Visigodos', :url => 'http://upload.wikimedia.org/wikipedia/commons/6/68/SwedishVallhundAgility_wb.jpg' },
  {:name => 'Pastor belga', :url => 'http://upload.wikimedia.org/wikipedia/commons/9/96/S.r.Ch.CEPPB.CH.E.Fredy_de_Belliamici%2CA.5a.cabeza.jpg' }
])

matters = Matter.create([
  {:name => "Cachorros", :categories => "1"},
  {:name => "Carros", :categories => "2,3,4,5"},
])

Ranking.create([
  { :user_id => user.id, :total_score => 120, :matter_id => 1 },
])

#'Old English Sheepdog'
#'Griffon de Nivernais'
#'Braco Griffon da Vendéia'
#'Cão do Ariége'
#'Grande Gascão Saintongeois'
#'Grande Azul da Gasconha'
#'Poitevin'
#'Billy'
#'Cão de Artois'
#'Porcelana'
#'Pequeno Azul da Gasconha'
#'Griffon Azul da Gasconha'
#'Grande Basset Griffon da Vendeia'
#'Basset Artesiano Normando'
#'Basset Azul da Gasconha'
#'Basset Fulvo da Bretanha'
#'Cão de água português'
#'Welsh Corgi Cardigan'
#'Welsh Corgi Pembroke'
#'Soft Coated Wheaten Terrier'
#'Pastor jugoslavo'
#'Cão Sueco de Caça ao Cervo'
#'Basenji'
#'Pastor-de-beauce'
#'Boiadeiro de Berna'
#'Appenzeller Sennenhund'
#'Boiadeiro de Entlebuch'
#'Cão de Ursos da Carélia'
#'Spitz Finlandês'
#'Terra-nova'
#'Sabujo Finlandês'
#'Braco Polonês'
#'Komondor'
#'Kuvasz'
#'Puli'
#'Pumi'
#'Vizsla'
#'Grande Boiadeiro Suíço'
#'Sabujo Suíço'
#'Pequeno Sabujo Suíço'
#'São-bernardo'
#'Pinscher austríaco'
#'Maltês'
#'Braco Tirolês'
#'Lakeland Terrier'
#'Manchester Terrier'
#'Norwich Terrier'
#'Terrier escocês'
#'Sealyham Terrier'
#'Skye Terrier'
#'Staffordshire Bull Terrier'
#'Papillon'
#'Welsh Terrier'
#'Griffon de Bruxelas'
#'Schipperke'
#'Cão de Santo Humberto'
#'West Highland White Terrier'
#'Yorkshire Terrier'
#'Pastor catalão'
#'Pastor de Shetland'
#'Podengo Ibicenco'
#'Mastim espanhol'
#'Mastim dos Pirenéus'
#'Cão da Serra de Aires'
#'Podengo Português'
#'Spaniel bretão'
#'Spitz alemão'
#'Braco alemão de pelo duro'
#'Weimaraner'
#'Bulldog Francês'
#'Terrier Alemão de Caça'
#'Barbet'
#'Clumber Spaniel'
#'Curly Coated Retriever'
#'Golden Retriever'
#'Pastor de Brie'
#'Dogue de Bordéus'
#'Braco alemão de pelo longo'
#'Braco alemão de pelo curto'
#'Setter Irlandês Ruivo'
#'Labrador Retriever'
#'Springer Spaniel Inglês'
#'Springer Spaniel de Gales'
#'Sussex Spaniel'
#'King Charles Spaniel'
#'Lapphund'
#'Cavalier King Charles Spaniel'
#'Cão de Montanha dos Pirenéus'
#'Pastor dos Pirinéus de pelo curto'
#'Terrier Irlandês'
#'Boston Terrier'
#'Pastor dos Pirinéus de pelo comprido'
#'Cuvac Eslovaco'
#'Dobermann'
#'Boxer'
#'Leonberger'
#'Rhodesian Ridgeback'
#'Rottweiler'
#'Dachshund'
#'Buldogue'
#'Sabujo Sérvio'
#'Dálmata'
#'Sabujo da Bósnia'
#'Rough Collie'
#'Bulmastife'
#'Galgo inglês'
#'Foxhound Inglês'
#'Lébrel irlandês'
#'Beagle'
#'Whippet'
#'Basset Hound'
#'Pastor Alemão'
#'Cocker Spaniel Americano'
#'Dandie Dinmont Terrier'
#'Fox Terrier de Pêlo Duro'
#'Cão de Castro Laboreiro'
#'Boieiro das Ardenas'
#'Poodle'
#'Cão da Serra da Estrela'
#'Pastor da Picardia'
#'Braco de Ariege'
#'Braco de Burbônia'
#'Braco de Auvérnia'
#'Schnauzer gigante'
#'Schnauzer standard'
#'Schnauzer miniatura'
#'Pinscher alemão'
#'Pinscher miniatura'
#'Affenpinscher'
#'Perdigueiro Português'
#'Cão Finlandês da Lapônia'
#'Hovawart'
#'Boieiro das Flandres'
#'Kromfohrländer'
#'Borzoi'
#'Pastor Bergamasco'
#'Vulpino Italiano'
#'Bichon Bolonhês'
#'Mastim napolitano'
#'Cirneco do Etna'
#'Galguinho italiano'
#'Pastor maremano abruzês'
#'Braco Italiano'
#'Dunker'
#'Chow-chow (xau-xau)'
#'Pequinês'
#'Shih-Tzu'
#'Terrier Tibetano'
#'Samoieda'
#'Bichon Frisé'
#'Chihuahua'
#'Tricolor Francês'
#'Branco e Preto Francês'
#'Pastor holandês'
#'Fila brasileiro'
#'Landseer'
#'Lhasa Apso'
#'Galgo afegão'
#'Sabujo Tricolor Sérvio'
#'Mastim tibetano'
#'Spaniel tibetano'
#'Braco alemão de pelo áspero'
#'Pelado mexicano'
#'Dogue alemão'
#'Silky Terrier'
#'Buhund Norueguês'
#'Mudi'
#'Braco da Transilvânia'
#'Elkhound'
#'Malamute-do-alasca'
#'Terrier Checo'
#'Aidi'
#'Pharaoh Hound'
#'Bichon Havanês'
#'Pastor polonês da planície'
#'Pastor de Tatra'
#'Pug'
#'Akita Inu'
#'Shiba Inu'
#'Terrier Japonês'
#'Tosa (raça)'
#'Hokkaido'
#'Spitz Japonês'
#'Chesapeake Bay Retriever'
#'Mastiff'
#'Norsk Lundehund'
#'Elkhound Norueguês Preto'
#'Saluki'
#'Husky siberiano'
#'Bearded Collie'
#'Norfolk Terrier'
#'Cão de Canaã'
#'Gronlandshund'
#'Spitz de Norboten'
#'Pastor croata'
#'Pastor de Kraski'
#'Braco Dinamarquês'
#'Grande Griffon da Vendeia'
#'Coton de Tulear'
#'Pastor Finlandês da Lapônia'
#'American Staffordshire Terrier'
#'Boiadeiro australiano'
#'Cão de Crista Chinês'
#'Cão Islandês de Pastoreio'
#'Beagle Harrier'
#'Eurasier'
#'Dogo argentino'
#'Kelpie australiano'
#'Otterhound'
#'Smooth Collie'
#'Border Collie'
#'Braco Alemão'
#'Black and Tan Coonhound'
#'Glen of Imaal Terrier'
#'Foxhound americano'
#'Laika Russo Europeu'
#'Laika da Sibéria Oriental'
#'Laika da Sibéria Ocidental'
#'Azawakh'
#'Smoushond Holandês'
#'Shar-Pei'
#'Cão Pelado Peruano'
#'Cão lobo de Saarloos'
#'Schapendoes'
#'Pequeno Cão Holandês'
#'Broholmer'
#'Branco e Laranja Francês'
#'Kai'
#'Kishu'
#'Shikoku Inu'
#'Pastor maiorquino'
#'Grande Anglo-Francês Tricolor'
#'Grande Anglo-Francês Branco e Preto'
#'Grande Anglo-Francês Branco e Laranja'
#'Anglo-francês da pequena Vénerie'
#'Pastor da Rússia Meridional'
#'Terrier preto da Rússia'
#'Pastor do Cáucaso'
#'Podengo Canário'
#'Setter Irlandês Ruivo e Branco'
#'Pastor da Anatólia'
#'Cão lobo checoslovaco'
#'Jindo Coreano'
#'Pastor da Ásia Central'
#'Cão Tailandês de Crista Dorsal'
#'Parson Russell Terrier'
#'Cão de Fila de São Miguel'
#'Cão de Fila de São Miguel'
#'Terrier brasileiro'
#'Pastor australiano'
#'Cane corso'
#'Akita Americano'
#'Dogue canário'
#'Pastor branco suíço'
#'Cão de Taiwan'
#'Cimarron uruguayo'
#'Cão Fazendeiro da Dinamarca e Suécia'
#'Pastor do Sudeste Europeu'

#gatos = Category.create(:name => "Gatos")
#roedores = Category.create(:name => "Roedores")
#passaros = Category.create(:name => "Passaros")

#276, 2, Vira-lata (SRD)
#277, 2, Abissínio
#278, 2, Angorá
#279, 2, Bengal (Gato-de-bengala)
#280, 2, Bobtail japonês
#281, 2, Bombaim
#282, 2, Chartreux
#283, 2, Cornish Rex
#284, 2, Himalaio
#285, 2, LaPerm
#286, 2, Maine Coon
#287, 2, Mau egípcio
#288, 2, Mist Australiano
#289, 2, Munchkin
#290, 2, Norueguês da Floresta
#291, 2, Gato de pelo curto americano
#292, 2, Gato de pelo curto brasileiro
#293, 2, Gato de pelo curto europeu
#294, 2, Gato de pelo curto inglês
#295, 2, Persa
#296, 2, Ragdoll
#297, 2, Ocicat
#298, 2, Sagrado da Birmânia
#299, 2, Savannah
#300, 2, Scottish Fold
#301, 2, Siamês
#302, 2, Sphynx
#303, 2, Tonquinês
#304, 3, Alaska
#305, 3, Angorá
#306, 3, Azul de Viena
#307, 3, Beliê
#308, 3, Borboleta Françês
#309, 3, Califórnia
#310, 3, Castor Rex
#311, 3, Chinchila
#312, 3, Gigante de Bouscat
#313, 3, Hermelin
#314, 3, Holandês
#315, 3, Negro e Fogo
#316, 3, Nova Zelândia Branco
#317, 3, Nova Zelândia Vermelho
#318, 3, Prateado de Champagne
#319, 1, Pit bull

