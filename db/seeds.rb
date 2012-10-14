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

cars_categories = Category.create([
    { :name => '1910-1950 (decades)' },
    { :name => '1960-1980 (decades)' },
    { :name => '1990-today (decades)' }
])

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
  {:name => "Cars", :categories => cars_categories.collect {|x| x.id }.to_s.gsub("[","").gsub("]", "").gsub(" ", "")},
])



Picture.create([
  { :category_id => cars_categories[0].id, :name => '1917 Ford Model T Woody Wagon', :url => 'http://mafia-team.r12.railsrumble.com/uploads/5e08f9e55a3227a9e01f4f3dd1f782a9da47551c.jpg' },
  { :name => '1920 Ford Model T', :url => 'http://mafia-team.r12.railsrumble.com/uploads/4329d0d193a1c1522636bd1f75ec0a43e3bf1471.jpg' },
  { :name => '1928 Ford Model A', :url => 'http://mafia-team.r12.railsrumble.com/uploads/fd817986222574d6e461a14f7a86311ac5eb28de.jpg' },
  { :name => '1934 Ford LeBaron Sedan', :url => 'http://mafia-team.r12.railsrumble.com/uploads/5202275a85c0a92f912c6024320834adc10d8a56.jpg' },
  { :name => '1935 Ford Phaeton', :url => 'http://mafia-team.r12.railsrumble.com/uploads/cd7cf86fca23f22d2a32961ace07e4336ce38f7a.jpg' },
  { :name => '1937 Ford Woody', :url => 'http://mafia-team.r12.railsrumble.com/uploads/5913dc88994c163b579c295e12aa3df35a89a9ec.jpg' },
  { :name => '1939 Chevrolet Coupe', :url => 'http://mafia-team.r12.railsrumble.com/uploads/a1528ac235c02613899981ee550cf5ea201f08cb.jpg' },
  { :name => '1941 Chrysler Royal', :url => 'http://mafia-team.r12.railsrumble.com/uploads/0f77d8fdbde13ac629efb2af18e164c296bf63e4.jpg' },
  { :name => '1946 Ford Sedan', :url => 'http://mafia-team.r12.railsrumble.com/uploads/8399b246ef57d71a4d0b349ed733289e0b0e8d01.jpg' },
  { :name => '1948 Chevrolet Fleetmaster Sedan', :url => 'http://mafia-team.r12.railsrumble.com/uploads/868ecd6cbebd2669c5421cb208a6a107bbfec43e.jpg' },
  { :name => '1949 Cadillac', :url => 'http://mafia-team.r12.railsrumble.com/uploads/abd91a2080ab62ca43030640c9badf1da8795f1e.jpg' },
  { :name => '1949 Ford Maroon', :url => 'http://mafia-team.r12.railsrumble.com/uploads/7307ad8901d1c26c3d378a8740dd2ceac4922288.jpg' },
  { :name => '1950 Ford Coupe', :url => 'http://mafia-team.r12.railsrumble.com/uploads/c3724913fb3fa25f98a64c7b7aa1e31793761e55.jpg' },
  { :name => '1951 Chevrolet Hardtop', :url => 'http://mafia-team.r12.railsrumble.com/uploads/3dc712968bc2d80478fdbdb08590ef1257fa2af2.jpg' },
  { :name => '1951 Chrysler Windsor Sedan', :url => 'http://mafia-team.r12.railsrumble.com/uploads/a3db988b8ebfb7598f9468914b9605b9bd13050c.jpg' },
  { :name => '1953 Chevrolet Station Wagon', :url => 'http://mafia-team.r12.railsrumble.com/uploads/12857d759f515b681bac5081827a6aec97acf8b2.jpg' },
  { :name => '1955 Ford Thunderbird', :url => 'http://mafia-team.r12.railsrumble.com/uploads/7bab47aa93b0285c4f315b12dd86fc8ef2f915ad.jpg' },
  { :name => '1956 Chevrolet Bel Air', :url => 'http://mafia-team.r12.railsrumble.com/uploads/07dd1d0d92277b08457310b28d99c09cbd7795d3.jpg' },
  { :name => '1956 Chevrolet Corvette', :url => 'http://mafia-team.r12.railsrumble.com/uploads/92e9e2f4b21303fcafa291c3fa625cda2979517f.jpg' },
  { :name => '1956 Ford Fairlane Sunliner', :url => 'http://mafia-team.r12.railsrumble.com/uploads/e8210d967a9c6df157150683bb79ba9c7c9330f6.jpg' },
  { :name => '1957 Ford Thunderbird', :url => 'http://mafia-team.r12.railsrumble.com/uploads/3f50eba79fd90c95116c240a9fb50ab9f77afc23.jpg' },
  { :name => '1958 Ferrari 250 GT Coupe', :url => 'http://mafia-team.r12.railsrumble.com/uploads/4f7e706eed222b58604aa10b8fe9211edca531e6.jpg' },
  { :name => '1959 Chevrolet Corvette', :url => 'http://mafia-team.r12.railsrumble.com/uploads/9314dd2ac3407d0deeb2b47d90ecd2cf09071f53.jpg' },
  { :name => '1959 Ford Galaxie Fairlane 500', :url => 'http://mafia-team.r12.railsrumble.com/uploads/ce3be32efe07c9bd69020a06bbdb6959bb84029a.jpg' },
  { :name => '1959 Ford Ranchero', :url => 'http://mafia-team.r12.railsrumble.com/uploads/26f05faff2432c7cd15a413fd7d80dfe3156fd81.jpg' },
  { :name => '1962 Ford Thunderbird', :url => 'http://mafia-team.r12.railsrumble.com/uploads/2b6db4a706d3275b8a544f410488bf4fbee4f07d.jpg' },
  { :name => '1964 Ford Thunderbird', :url => 'http://mafia-team.r12.railsrumble.com/uploads/8824443184a52969208099d0075e39ff558a2135.jpg' },
  { :name => '1965 Chevrolet Corvair', :url => 'http://mafia-team.r12.railsrumble.com/uploads/1601a45eb839e7a0249f4a39a65416323880d066.jpg' },
  { :name => '1966 Chevrolet El Camino', :url => 'http://mafia-team.r12.railsrumble.com/uploads/29d3e5d0a64533eb815c47d25fd0bf524d0004f4.jpg' },
  { :name => '1966 Chevrolet Impala Hardtop', :url => 'http://mafia-team.r12.railsrumble.com/uploads/6de0524e4591f9a0cfcb6ca68ae8cff887c5c195.jpg' },
  { :name => '1966 Ford Thunderbird', :url => 'http://mafia-team.r12.railsrumble.com/uploads/1b1eec1ce2bd379b6d04a9c8e6aab85aaa488c15.jpg' },
  { :name => '1967 Chevrolet Camaro', :url => 'http://mafia-team.r12.railsrumble.com/uploads/414a35bbec96e037de1403be3b1eca6e47832ce0.jpg' },
  { :name => '1967 Chevrolet Chevelle SS 396 Hardtop', :url => 'http://mafia-team.r12.railsrumble.com/uploads/15e33390b8e866c5594009933bc09dddf16e4eaf.jpg' },
  { :name => '1967 Chevrolet Corvette', :url => 'http://mafia-team.r12.railsrumble.com/uploads/3b9901acafd180ceb99753cda4eda0ba3e87de76.jpg' },
  { :name => '1968 Chevrolet Malibu', :url => 'http://mafia-team.r12.railsrumble.com/uploads/510a5c6ed54472a19bd1b81c6ed1fac7001e15d6.jpg' },
  { :name => '1968 Ford Mustang Fastback', :url => 'http://mafia-team.r12.railsrumble.com/uploads/e9d1a476a1b8bf03e93e44c687325bef547b7244.jpg' },
  { :name => '1968 Ford Torino', :url => 'http://mafia-team.r12.railsrumble.com/uploads/770c84224af6a9f5ca3a79b435d51203f8230f10.jpg' },
  { :name => '1970 Chevrolet Corvette', :url => 'http://mafia-team.r12.railsrumble.com/uploads/de02ba2de5fcc57fd2e323626e4eadda899032a4.jpg' },
  { :name => '1970 Ford Mustang Fastback', :url => 'http://mafia-team.r12.railsrumble.com/uploads/4a2da08551b30cc7ff1e98ae38e520ed1b5e24af.jpg' },
  { :name => '1971 Chevrolet Camaro', :url => 'http://mafia-team.r12.railsrumble.com/uploads/6b788db8e4e73029a34c6dec28964335addc6970.jpg' },
  { :name => '1972 Chevrolet Chevelle SS', :url => 'http://mafia-team.r12.railsrumble.com/uploads/ae5f58e7afd5ec26b8ab22de9a9a66ed00191f7c.jpg' },
  { :name => '1973 Ford Mustang Mach 1', :url => 'http://mafia-team.r12.railsrumble.com/uploads/a6f1926f170f81e579792af86c694491140fc651.jpg' },
  { :name => '1975 Chevrolet Corvette', :url => 'http://mafia-team.r12.railsrumble.com/uploads/1b247c50bc09d7eab2175f67c3243044b5c56f3d.jpg' },
  { :name => '1977 Ford Mustang Cobra II', :url => 'http://mafia-team.r12.railsrumble.com/uploads/e45abdd65ea7944c90b0c455ba532da030a0b9bb.jpg' },
  { :name => '1988 Ferrari Testarossa', :url => 'http://mafia-team.r12.railsrumble.com/uploads/ab06fbee5d47baff9f6f032c2c733211b75478ea.jpg' },
  { :name => '1990 Ford Mustang', :url => 'http://mafia-team.r12.railsrumble.com/uploads/ae60c1b10cbdca89fdf1491da32aa54e6c8c63a9.jpg' },
  { :name => '1995 Ferrari 512M', :url => 'http://mafia-team.r12.railsrumble.com/uploads/ff9ffe187165bc8b0811c3090a30a352d69fe4ff.jpg' },
  { :name => '2001 Ferrari 550 Barchetta Pininfarina', :url => 'http://mafia-team.r12.railsrumble.com/uploads/65c1ffcd030bdec0d125b1c3b07b4111cd8de065.jpg' },
  { :name => '2001 Ferrari 550 Maranello', :url => 'http://mafia-team.r12.railsrumble.com/uploads/06ced7c0dde5e8f97c1e302efa90fc614d98154a.jpg' }
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

