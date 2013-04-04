mongoose = require 'mongoose'
Schema = mongoose.Schema
Admin = require './Models/Admin.js'
Slide = require './Models/Slide.js'
Organisation = require "./Models/Organisation.js"
Conference =  require "./Models/Conference.js"

dsn = "mongodb://localhost/WebConference"

mongoose.connect dsn

confDB = mongoose.connection

confDB.on 'error', console.error.bind(console, 'connection error:')

confDB.once 'open', ()->

  ###Fab = new Admin
    firstname: 'Fabrice' 
    lastname: 'Kyams'
    email: 'fabrice.kyams@gmail.com'
    

  Fab.save (err, Fab)->
    if err
      console.log  "saving fab error", err
    
    RTBF = new Organisation
      _admin: Fab._id
      name: 'RTBF'

     RTBF.save (err, RTBF)->
      if err
        console.log "saving error man"
        console.log err

      MyConf = new Conference
      _orga: RTBF._id
      name: "Ma Conférence"

      MyConf.save (err, SansChichiConf)->
        if err
          console.log "saving error man"
          console.log err
  
  Admin
  .findOne 
    firstname: "Fabrice" 
    (err, admin)=>     
      Organisation.findOne name: "RTBF" , (err, organisation) =>
        admin.organisations.pop organisation
        admin.save (err, admin)->
          console.log "organisation pushed"
          #
  .populate('organisations')
  .exec (err, admin)=>
    console.log "admin populated with organisations"
    #
  
  Organisation
  .findOne 
    name: "RTBF" 
    (err, organisation) =>
      MyConf = new Conference
        _orga: organisation._id
        name: "Ma Conférence"

      MyConf.save (err, MyConf)->
        if err
          console.log "saving error man"
          console.log err

      organisation.conferences.push MyConf

      organisation.save (err, organisation)->
        console.log "conferences pushed"
  .populate('conferences')
  .exec (err, organisations)=>
    console.log "Organisation populate with conferences"
  ###
  
  Conference
  .findOne
    name : "Ma Conférence"
    (err, conference)=>
      slide1 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 2
        JsonData: '{"id" : "002" , "content" : " " , "title" : "L écume des jours" , "description" : "histoire surréelle et poétique d’un jeune homme idéaliste et inventif, Colin, qui rencontre Chloé, une jeune femme semblant être l’incarnation d’un blues de Duke Ellington. Leur mariage idyllique tourne à l’amertume quand Chloé tombe malade d’un nénuphar qui grandit dans son poumon. Pour payer ses soins, dans un Paris fantasmatique, Colin doit travailler dans des conditions de plus en plus absurdes, pendant qu’autour d’eux leur appartement se dégrade et que leur groupe d’amis, dont le talentueux Nicolas, et Chick, fanatique du philosophe Jean-Sol Partre, se délite. "}'

      slide1.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide1

      slide2 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 3
        JsonData: '{"id" : "003" , "content" : " " , "title" : "The Place Beyond the Pines" , "description" : "Cascadeur à moto, Luke est réputé pour son spectaculaire numéro du «globe de la mort». Quand son spectacle itinérant revient à Schenectady, dans l’État de New York, il découvre que Romina, avec qui il avait eu une aventure, vient de donner naissance à son fils… Pour subvenir aux besoins de ceux qui sont désormais sa famille, Luke quitte le spectacle et commet une série de braquages. Chaque fois, ses talents de pilote hors pair lui permettent de s’échapper. Mais Luke va bientôt croiser la route d’un policier ambitieux, Avery Cross, décidé à s’élever rapidement dans sa hiérarchie gangrenée par la corruption. Quinze ans plus tard, le fils de Luke et celui d’Avery se retrouvent face à face, hantés par un passé mystérieux dont ils sont loin de tout savoir… "}'

      slide2.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide2
      
      slide3 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 4
        JsonData: '{"id" : "004" , "content" : " " , "title" : "Iron Man 3" , "description" : "Tony Stark, l’industriel flamboyant qui est aussi Iron Man, est confronté cette fois à un ennemi qui va attaquer sur tous les fronts. Lorsque son univers personnel est détruit, Stark se lance dans une quête acharnée pour retrouver les coupables. Plus que jamais, son courage va être mis à l’épreuve, à chaque instant. Dos au mur, il ne peut plus compter que sur ses inventions, son ingéniosité, et son instinct pour protéger ses proches. Alors qu’il se jette dans la bataille, Stark va enfin découvrir la réponse à la question qui le hante secrètement depuis si longtemps : est-ce l’homme qui fait le costume ou bien le costume qui fait l’homme ? "}'

      slide3.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide3
      
      slide4 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 5
        JsonData: '{"id" : "005" , "content" : " " , "title" : "Very Bad Trip 3" , "description" : "Suite et fin des aventures de Phil, Stu, Alan et Doug. "}'

      slide4.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide4
      
      slide5 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 6
        JsonData: '{"id" : "006" , "content" : " " , "title" : "Dead Man Talking" , "description" : "Une prison quelque part. William Lamers est condamné à mort..."}'

      slide5.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide5
      
      slide6 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 7
        JsonData: '{"id" : "007" , "content" : " " , "title" : "Star Trek Into Darkness" , "description" : "Alors qu’il rentre à sa base, l équipage de l’Enterprise doit faire face à des forces terroristes implacables au sein même de son organisation. L’ennemi a fait exploser la flotte et tout ce qu’elle représentait, plongeant notre monde dans le chaos… Dans un monde en guerre, le Capitaine Kirk, animé par la vengeance, se lance dans une véritable chasse à l’homme, pour neutraliser celui qui représente à lui seul une arme de destruction massive. Nos héros entrent dans un jeu d’échecs mortel. L’amour sera menacé, des amitiés seront brisées et des sacrifices devront être faits dans la seule famille qu’il reste à Kirk : son équipe. "}'

      slide6.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide6
      
      slide7 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 8
        JsonData: '{"id" : "008" , "content" : " " , "title" : "Parker" , "description" : "Parker est le plus audacieux et le plus redoutable des cambrioleurs. Spécialiste des casses réputés impossibles, il exige de ses partenaires une loyauté absolue et le respect scrupuleux du plan. Alors qu’une opération vient de mal tourner à cause d’une négligence,..."}'

      slide7.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide7
      
      slide8 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 9
        JsonData: '{"id" : "009" , "content" : " " , "title" : "Gatsby" , "description" : "Printemps 1922. L époque est propice au relâchement des mœurs, à l essor du jazz et à l enrichissement des contrebandiers d alcool… Apprenti écrivain, Nick Carraway quitte la région du Middle-West pour s installer à New York. Voulant sa part du rêve américain, il vit désormais entouré d un mystérieux millionnaire, Jay Gatsby, qui s étourdit en fêtes mondaines, et de sa cousine Daisy et de son mari volage, Tom Buchanan, issu de sang noble. C est ainsi que Nick se retrouve au cœur du monde fascinant des milliardaires, de leurs illusions, de leurs amours et de leurs mensonges. Témoin privilégié de son temps, il se met à écrire une histoire où se mêlent des amours impossibles, des rêves d absolu et des tragédies ravageuses et, chemin faisant, nous tend un miroir où se reflètent notre époque moderne et ses combats. "}'

      slide8.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide8
      
      slide9 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 10
        JsonData: '{"id" : "010" , "content" : " " , "title" : "After Earth" , "description" : "1000 ans après un cataclysme forçant les humains à quitter la Terre, Nova Prime est devenue la nouvelle planète occupée par notre espèce. Le général Cypher Raige, de retour d’une longue mission, retrouve sa famille (et son rôle de père auprès de Kitai, son fils de 13 ans). Lorsqu une tempête d’astéroïdes endommage le vaisseau de Cypher et Kitai, ils s écrasent sur la Terre, devenue très dangereuse. Alors que son père à l’agonie dans le cockpit, Kitai va devoir entreprendre seul, un voyage en terrain hostile pour retrouver leur balise de détresse. Kitai a toujours voulu être un soldat comme son père. Aujourd hui, il en a l’opportunité."}'

      slide9.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide9
      
      slide10 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 11
        JsonData: '{"id" : "011" , "content" : " " , "title" : "Man of Steel" , "description" : "Superman va devoir affronter deux autres survivants de la planète Krypton, le redoutable Général Zod, et Faora, sa partenaire. "}'

      slide10.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide10
      
      slide11 = new Slide
        _conf: conference._id
        Type: 'text'
        Order: 12
        JsonData: '{"id" : "012" , "content" : " " , "title" : "Robocop" , "description" : "Les services de police inventent une nouvelle arme infaillible, Robocop, mi-homme, mi-robot, policier électronique de chair et dacier qui a pour mission de sauvegarder la tranquillité de la ville. Mais ce cyborg a aussi une âme... "}'

      slide11.save (err, slide1)->
        if err
          console.log "erreur"

      conference.slides.push slide11

      conference.save (err, conference)->
        #
  .populate('slides')
  .exec (err, conferences)=>
    #
  









