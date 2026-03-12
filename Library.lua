local Globals = getgenv()

if not game:IsLoaded() then game.Loaded:Wait() end

-- // services & main refs
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PathfindingService = game:GetService("PathfindingService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RemoteFunc = ReplicatedStorage:WaitForChild("RemoteFunction")
local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")
local PlayersService = game:GetService("Players")
local LocalPlayer = PlayersService.LocalPlayer or PlayersService.PlayerAdded:Wait()
local mouse = LocalPlayer:GetMouse()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local FileName = "ADS_Config.json"

local TowerSkins = {
    ["Accelerator"] = {
        ["Champion"] = "rbxassetid://90324305122544", ["Cupid"] = "rbxassetid://16742017040", ["Dank"] = "rbxassetid://18549604688", ["Default"] = "rbxassetid://16742017289", ["Disco"] = "rbxassetid://96135720673651", ["Ducky"] = "rbxassetid://16742017439", ["Eclipse"] = "rbxassetid://16742017644", ["Elite"] = "rbxassetid://16742017935", ["Fallen"] = "rbxassetid://18848269402", ["Ghost Buster"] = "rbxassetid://16742018196", ["Ice Witch"] = "rbxassetid://16742018426", ["Legend"] = "rbxassetid://16742018621", ["Mage"] = "rbxassetid://16742018781", ["Magician"] = "rbxassetid://104973122569052", ["Navy"] = "rbxassetid://16742018971", ["Nuclear"] = "rbxassetid://16742019185", ["Octopus"] = "rbxassetid://138359133170089", ["Patient Zero"] = "rbxassetid://88972169285855", ["Plushie"] = "rbxassetid://16742019393", ["Red"] = "rbxassetid://16742019754", ["Senator"] = "rbxassetid://17363277841", ["Speaker Titan"] = "rbxassetid://16997023622", ["Vigilante"] = "rbxassetid://16742019956"
    },
    ["Ace Pilot"] = {
        ["Aerial Ace"] = "rbxassetid://17859245825", ["Default"] = "rbxassetid://17859246260", ["Easter"] = "rbxassetid://137734270861409", ["Green"] = "rbxassetid://17859246778", ["Navy"] = "rbxassetid://17859247163", ["Pumpkin"] = "rbxassetid://17859247510", ["Purple"] = "rbxassetid://17859247791", ["Red"] = "rbxassetid://17859248266", ["Toy Plane"] = "rbxassetid://90411909913759", ["Yellow"] = "rbxassetid://17859248807"
    },
    ["Archer"] = {
        ["Default"] = "rbxassetid://102469025012991", ["Elf"] = "rbxassetid://118017603574255", ["Huntsman"] = "rbxassetid://108057864574863", ["Ice Soul"] = "rbxassetid://125693199171973", ["Spooky"] = "rbxassetid://109768712967611", ["Valentines"] = "rbxassetid://88010001274532"
    },
    ["Assassin"] = {
        ["Actor"] = "rbxassetid://112178399627918", ["Default"] = "rbxassetid://117970650222627", ["Saber Tooth Tiger"] = "rbxassetid://129525356172974"
    },
    ["Biologist"] = {
        ["Default"] = "rbxassetid://101795075923269", ["Grim"] = "rbxassetid://126912872410229"
    },
    ["Brawler"] = {
        ["Banned"] = "rbxassetid://84628371320634", ["Blazing"] = "rbxassetid://18549605468", ["Default"] = "rbxassetid://17506304027", ["Fallen"] = "rbxassetid://18835925180", ["Horse"] = "rbxassetid://101555481625059", ["Jordan"] = "rbxassetid://70748904383488", ["Loader"] = "rbxassetid://131316320823683", ["Lobster"] = "rbxassetid://123985511698683", ["Lovestriker"] = "rbxassetid://83049730035300", ["Rudolph"] = "rbxassetid://122757939585280", ["Werewolf"] = "rbxassetid://105319960862894"
    },
    ["Combatant"] = {
        ["Default"] = "rbxassetid://16742022822"
    },
    ["Commander"] = {
        ["Aqua"] = "rbxassetid://89379123461384", ["Bloxy"] = "rbxassetid://16742023051", ["Brisk"] = "rbxassetid://16742023299", ["Bunny"] = "rbxassetid://17507647451", ["Candy Cane"] = "rbxassetid://115979067743950", ["Default"] = "rbxassetid://17507647561", ["Director"] = "rbxassetid://140380406065215", ["Ducky"] = "rbxassetid://16742023989", ["Eclipse"] = "rbxassetid://16742024255", ["Eggrypted"] = "rbxassetid://16742024613", ["Fallen"] = "rbxassetid://80567934657980", ["Frost"] = "rbxassetid://16742024893", ["Galactic"] = "rbxassetid://17507647660", ["Gargoyle"] = "rbxassetid://17507647804", ["General"] = "rbxassetid://17507647965", ["Ghost"] = "rbxassetid://17507648068", ["Green"] = "rbxassetid://17507648232", ["Holiday"] = "rbxassetid://16742026260", ["Lifeguard"] = "rbxassetid://16742026508", ["Maid"] = "rbxassetid://17507648382", ["Neko"] = "rbxassetid://17507648601", ["Patriotic"] = "rbxassetid://18323544710", ["Pattern"] = "rbxassetid://17507648760", ["Phantom"] = "rbxassetid://16742027114", ["Pirate"] = "rbxassetid://16742027462", ["Plushie"] = "rbxassetid://16742027624", ["Red"] = "rbxassetid://17507648923", ["Santa"] = "rbxassetid://117501182181139", ["Spring Time"] = "rbxassetid://17507649066", ["Umbra"] = "rbxassetid://16742028241", ["Valentines"] = "rbxassetid://16742028419", ["Victorian"] = "rbxassetid://17507649166", ["Vigilante"] = "rbxassetid://17507649270", ["War Lord"] = "rbxassetid://16742028910", ["Wasteland"] = "rbxassetid://93243165798255", ["Werewolf"] = "rbxassetid://110092626333388", ["Wonderland"] = "rbxassetid://86397469450446"
    },
    ["Commando"] = {
        ["Default"] = "rbxassetid://140552401698797", ["Pirate"] = "rbxassetid://135452131994371", ["Trooper"] = "rbxassetid://81411979969960"
    },
    ["Cowboy"] = {
        ["Agent"] = "rbxassetid://16742029625", ["Badlands"] = "rbxassetid://16742029785", ["Bandit"] = "rbxassetid://16742029974", ["Bounty Hunter"] = "rbxassetid://16742030178", ["Cop"] = "rbxassetid://16742030440", ["Cyberpunk"] = "rbxassetid://16742030746", ["Dark Frost"] = "rbxassetid://78872525322359", ["Default"] = "rbxassetid://16742031062", ["Ducky"] = "rbxassetid://16742031273", ["Fallen"] = "rbxassetid://18848220133", ["Golden"] = "rbxassetid://16742031462", ["Holiday"] = "rbxassetid://16742031725", ["Kasodus"] = "rbxassetid://16742031988", ["Masquerade"] = "rbxassetid://16742032218", ["Mecha Bunny"] = "rbxassetid://70870846433248", ["Megalodon"] = "rbxassetid://129525988654572", ["Noir"] = "rbxassetid://16742032406", ["Plushie"] = "rbxassetid://84617405752906", ["Pumpkin"] = "rbxassetid://16742032605", ["Redemption"] = "rbxassetid://16742032735", ["Retired"] = "rbxassetid://16742032911", ["Spring Time"] = "rbxassetid://127656855808415", ["Valentines"] = "rbxassetid://16742033284", ["Vampire Hunter"] = "rbxassetid://99306749260135"
    },
    ["Crook Boss"] = {
        ["Alien Focus"] = "rbxassetid://133134889361359", ["Assassin"] = "rbxassetid://16742033599", ["Blue"] = "rbxassetid://16742033877", ["Checker"] = "rbxassetid://16742034068", ["Corso"] = "rbxassetid://16742034286", ["Cupid"] = "rbxassetid://16742034551", ["Cybernetic"] = "rbxassetid://16996940813", ["DRKSHDW"] = "rbxassetid://16742034843", ["Dark Frost"] = "rbxassetid://125130339305089", ["Default"] = "rbxassetid://16742035067", ["Demon"] = "rbxassetid://16742035383", ["Easter"] = "rbxassetid://101408307745429", ["Game Master"] = "rbxassetid://75261782948960", ["Golden"] = "rbxassetid://16742035712", ["Holiday"] = "rbxassetid://16742036050", ["Intern"] = "rbxassetid://16742036260", ["Narrator"] = "rbxassetid://92111450115834", ["Necromancer"] = "rbxassetid://16742036503", ["Null"] = "rbxassetid://102269930328399", ["Pirate"] = "rbxassetid://16742036700", ["Rat King"] = "rbxassetid://99680623337214", ["Red"] = "rbxassetid://16742036972", ["Soviet"] = "rbxassetid://17363278550", ["Spooky"] = "rbxassetid://16742037577", ["SteamPunk"] = "rbxassetid://16742037752", ["Victorian"] = "rbxassetid://95810120766308", ["Xmas"] = "rbxassetid://16742038000"
    },
    ["Cryomancer"] = {
        ["Default"] = "rbxassetid://16742059533", ["Krampus Slayer"] = "rbxassetid://16742059785"
    },
    ["DJ Booth"] = {
        ["Default"] = "rbxassetid://90127560097295", ["Ducky"] = "rbxassetid://108324875176244", ["Garage Band"] = "rbxassetid://102404432745932", ["Ghost"] = "rbxassetid://111981689753740", ["Gingerbread"] = "rbxassetid://88595674290447", ["Mako"] = "rbxassetid://105492996309734", ["Masquerade"] = "rbxassetid://16742060736", ["Neko"] = "rbxassetid://115310627249069", ["Neon Rave"] = "rbxassetid://88395223637973", ["Plushie"] = "rbxassetid://16742061708", ["Seal"] = "rbxassetid://124438946534088"
    },
    ["Demoman"] = {
        ["Blue"] = "rbxassetid://16742061940", ["Default"] = "rbxassetid://16742062171", ["Ducky"] = "rbxassetid://112748767260662", ["Fortress"] = "rbxassetid://16742062515", ["Ghost"] = "rbxassetid://81760835645289", ["Green"] = "rbxassetid://16742062839", ["Military"] = "rbxassetid://16742063163", ["Pirate"] = "rbxassetid://16742063574", ["Pumpkin"] = "rbxassetid://16742063839", ["Red"] = "rbxassetid://16742064120", ["Yellow"] = "rbxassetid://16742064313"
    },
    ["Electroshocker"] = {
        ["Banned"] = "rbxassetid://118823738322908", ["Bunny"] = "rbxassetid://16742064560", ["Classic"] = "rbxassetid://17744633836", ["Dark Frost"] = "rbxassetid://92937669662901", ["Default"] = "rbxassetid://16742064918", ["Ducky"] = "rbxassetid://16742065360", ["Frankenstein"] = "rbxassetid://16742065631", ["Ghost"] = "rbxassetid://16742065873", ["Hazmat"] = "rbxassetid://16742066166", ["Jellyfish"] = "rbxassetid://85663070964840", ["Korblox"] = "rbxassetid://122538908879439", ["Lovestriker"] = "rbxassetid://106374635483378", ["TeeVee"] = "rbxassetid://16997023926", ["Valentines"] = "rbxassetid://16742066423", ["Vigilante"] = "rbxassetid://16742066740"
    },
    ["Elementalist"] = {
        ["Default"] = "rbxassetid://78382857674962"
    },
    ["Elf Camp"] = {
        ["Chocolatier"] = "rbxassetid://79600048176341", ["Classic"] = "rbxassetid://89043476285776", ["Default"] = "rbxassetid://90684298180076"
    },
    ["Engineer"] = {
        ["Beach"] = "rbxassetid://70830745549464", ["Dark Frost"] = "rbxassetid://72967186484602", ["Default"] = "rbxassetid://16742067184", ["DraxRex"] = "rbxassetid://18549606104", ["Ducky"] = "rbxassetid://16742040216", ["Fallen"] = "rbxassetid://18950630600", ["Ghost"] = "rbxassetid://104901982243529", ["Grave Digger"] = "rbxassetid://16742067352", ["Heartbreak"] = "rbxassetid://16742067565", ["Holiday"] = "rbxassetid://16742067797", ["Mechanic"] = "rbxassetid://16742068076", ["Phantom"] = "rbxassetid://16742068314", ["Plushie"] = "rbxassetid://16742068525", ["Wikia"] = "rbxassetid://16742068760"
    },
    ["Executioner"] = {
        ["Default"] = "rbxassetid://16742069000", ["Eclipse"] = "rbxassetid://16742069213", ["Heartbreak"] = "rbxassetid://100643097900090", ["Vanquisher"] = "rbxassetid://17363278858"
    },
    ["Farm"] = {
        ["Arcade"] = "rbxassetid://16742069471", ["Booth"] = "rbxassetid://114387520669997", ["Cinema"] = "rbxassetid://113467369649039", ["Cozy Camp"] = "rbxassetid://140408163540785", ["Crab"] = "rbxassetid://80117562627776", ["Crypto"] = "rbxassetid://16742069733", ["Cube"] = "rbxassetid://80832036812275", ["Default"] = "rbxassetid://16742069981", ["Ducky"] = "rbxassetid://16742070242", ["Graveyard"] = "rbxassetid://16742070511", ["Lemonade Stand"] = "rbxassetid://81915340530819", ["Null Soul"] = "rbxassetid://81613076972732", ["PNG"] = "rbxassetid://102229660485968", ["Pirate"] = "rbxassetid://16742070778", ["Present"] = "rbxassetid://16742071112", ["Tycoon"] = "rbxassetid://16742071421", ["Vendor"] = "rbxassetid://16742071670", ["Wasteland"] = "rbxassetid://115389901462450", ["Xmas"] = "rbxassetid://16742072101"
    },
    ["Firework Technician"] = {
        ["2026"] = "rbxassetid://122550929943456", ["Default"] = "rbxassetid://113647654122910", ["Inventor"] = "rbxassetid://76009529192577"
    },
    ["Freezer"] = {
        ["Cryptid"] = "rbxassetid://16742072500", ["Deep Freeze"] = "rbxassetid://16742072779", ["Default"] = "rbxassetid://16742073034", ["Foam"] = "rbxassetid://16742073341", ["Frost Legion"] = "rbxassetid://80819236795571", ["IcyTea"] = "rbxassetid://16742073604", ["Mint Choco"] = "rbxassetid://16742073860", ["Polar Bear"] = "rbxassetid://78779113854366", ["Vendor"] = "rbxassetid://109388902986099"
    },
    ["Frost Blaster"] = {
        ["Default"] = "rbxassetid://16742074063"
    },
    ["Gatling Gun"] = {
        ["Default"] = "rbxassetid://81281360352088", ["Easter"] = "rbxassetid://102642733564095"
    },
    ["Gladiator"] = {
        ["Beach"] = "rbxassetid://16742074319", ["Cameraman"] = "rbxassetid://17119429753", ["Default"] = "rbxassetid://16742074569", ["Demon"] = "rbxassetid://16742074780", ["Galactic"] = "rbxassetid://16742075002", ["Phantom"] = "rbxassetid://16742075283", ["Pirate"] = "rbxassetid://16742075600", ["Pumpkin"] = "rbxassetid://16742075866", ["Slugger"] = "rbxassetid://16742076100", ["Umbrella"] = "rbxassetid://16742076293", ["Vigilante"] = "rbxassetid://16742076549"
    },
    ["Hacker"] = {
        ["Camera Operator"] = "rbxassetid://83759196809017", ["Default"] = "rbxassetid://111199743077047", ["Fallen"] = "rbxassetid://122092656436424", ["Reindeer Mech"] = "rbxassetid://71250983401324", ["Triumphant"] = "rbxassetid://122127536135971"
    },
    ["Hallow Punk"] = {
        ["Default"] = "rbxassetid://134504826386080", ["Lunar"] = "rbxassetid://108437763960397"
    },
    ["Harvester"] = {
        ["Default"] = "rbxassetid://87684607767207", ["Lunar"] = "rbxassetid://137379745720939", ["Wasteland"] = "rbxassetid://74677227259405"
    },
    ["Hunter"] = {
        ["Blue"] = "rbxassetid://16742076812", ["Default"] = "rbxassetid://16742077024", ["Ducky"] = "rbxassetid://16742077321", ["Halloween"] = "rbxassetid://16742077487", ["Pirate"] = "rbxassetid://16742077780", ["Vampire Slayer"] = "rbxassetid://16742078183"
    },
    ["Jester"] = {
        ["Clown"] = "rbxassetid://17744634147", ["Default"] = "rbxassetid://16742096294", ["Heartbreak"] = "rbxassetid://119670783538459", ["The Beast"] = "rbxassetid://75863398247354", ["The Flea"] = "rbxassetid://105377590942476"
    },
    ["Juggernaut"] = {
        ["Default"] = "rbxassetid://16742096516"
    },
    ["Kingpin"] = {
        ["Default"] = "rbxassetid://16742128592"
    },
    ["Mecha Base"] = {
        ["Default"] = "rbxassetid://16742097118"
    },
    ["Medic"] = {
        ["Bartender"] = "rbxassetid://76122446126363", ["Bunny"] = "rbxassetid://81292807669872", ["Cyber"] = "rbxassetid://77947916767981", ["Default"] = "rbxassetid://70910607127530", ["Fallen"] = "rbxassetid://131777122693897", ["Masquerade"] = "rbxassetid://102457549018286", ["Mermaid"] = "rbxassetid://107509961893175", ["Plague"] = "rbxassetid://86420908708799", ["Second Chance"] = "rbxassetid://103107154309507", ["Stranded"] = "rbxassetid://97722323410544", ["Toy Ballerina"] = "rbxassetid://87046562754510", ["Valentines"] = "rbxassetid://98455922318086", ["Witch"] = "rbxassetid://120995785751376"
    },
    ["Mercenary Base"] = {
        ["Default"] = "rbxassetid://17202640474", ["Frost Legion"] = "rbxassetid://78931994632689", ["Graveyard"] = "rbxassetid://98029015468306", ["Liberator"] = "rbxassetid://17767106489"
    },
    ["Militant"] = {
        ["Ace Pilot"] = "rbxassetid://16742099577", ["Acheron"] = "rbxassetid://114000424593798", ["Arsenal"] = "rbxassetid://16742099799", ["Beach"] = "rbxassetid://16742100038", ["Chocolatier"] = "rbxassetid://16742100398", ["Davinchi"] = "rbxassetid://16742100635", ["Default"] = "rbxassetid://16742100840", ["Ducky"] = "rbxassetid://16742101071", ["Easter"] = "rbxassetid://86436209069316", ["Fallen"] = "rbxassetid://18835926439", ["Ghost"] = "rbxassetid://16742101377", ["Hazmat"] = "rbxassetid://16742101622", ["John"] = "rbxassetid://16742101804", ["Lumberjack"] = "rbxassetid://16742102093", ["Pumpkin"] = "rbxassetid://16742102372", ["Star Spartan"] = "rbxassetid://76196766882530", ["Undead"] = "rbxassetid://99237916719964", ["Wasteland"] = "rbxassetid://140245000984082"
    },
    ["Military Base"] = {
        ["Base 1776"] = "rbxassetid://82822915671522", ["Classic"] = "rbxassetid://16997024256", ["Cyber"] = "rbxassetid://109839701132351", ["Default"] = "rbxassetid://16997024735", ["Wasteland"] = "rbxassetid://78972347785643"
    },
    ["Minigunner"] = {
        ["Beach"] = "rbxassetid://16742103082", ["Black Ops"] = "rbxassetid://16742103323", ["Blue"] = "rbxassetid://16742103560", ["Bunny"] = "rbxassetid://16742103808", ["Chad"] = "rbxassetid://16997025666", ["Chocolatier"] = "rbxassetid://123838075161800", ["Community"] = "rbxassetid://16742104107", ["Crusader"] = "rbxassetid://16742104409", ["Cursed"] = "rbxassetid://120591121926081", ["Default"] = "rbxassetid://16742104678", ["Ducky"] = "rbxassetid://16742104895", ["Fallen"] = "rbxassetid://18739982182", ["Frost"] = "rbxassetid://16742105137", ["Gardener"] = "rbxassetid://82544636570442", ["Ghost"] = "rbxassetid://16742105452", ["Golden"] = "rbxassetid://16742105731", ["Golden Plushie"] = "rbxassetid://18563673298", ["Green"] = "rbxassetid://16742105989", ["Hazmat"] = "rbxassetid://16742106200", ["Heavy"] = "rbxassetid://16742106470", ["Holiday"] = "rbxassetid://16742106731", ["Nutcracker"] = "rbxassetid://123307115343441", ["Ox"] = "rbxassetid://74202120404385", ["Party"] = "rbxassetid://16742106926", ["Phantom"] = "rbxassetid://16742107196", ["Plushie"] = "rbxassetid://16742107455", ["Pumpkin"] = "rbxassetid://16742107785", ["Road Rage"] = "rbxassetid://127265987839477", ["Space Elite"] = "rbxassetid://16742108056", ["Sweaking"] = "rbxassetid://16742108280", ["Toy"] = "rbxassetid://16742108498", ["Trucker"] = "rbxassetid://16997026080", ["Twitter"] = "rbxassetid://16742108697", ["Warlord"] = "rbxassetid://16742108927", ["Wraith"] = "rbxassetid://16742109128", ["Xmas"] = "rbxassetid://16742109340"
    },
    ["Mortar"] = {
        ["Baseball"] = "rbxassetid://18549606696", ["Bunny"] = "rbxassetid://16742109548", ["Dark Frost"] = "rbxassetid://75806838714392", ["Default"] = "rbxassetid://16742109840", ["DefaultOld"] = "rbxassetid://16742110099", ["Defender"] = "rbxassetid://16742110354", ["Ducky"] = "rbxassetid://16742110596", ["Eclipse"] = "rbxassetid://16742110815", ["Fallen"] = "rbxassetid://18835927281", ["Festive"] = "rbxassetid://136722938963670", ["Frost"] = "rbxassetid://119613427526708", ["Krampus"] = "rbxassetid://91368433364360", ["Mecha Ducky"] = "rbxassetid://70538066358366", ["Pirate"] = "rbxassetid://16742111011", ["Valentines"] = "rbxassetid://133447641741866", ["Vigilante"] = "rbxassetid://16742111168"
    },
    ["Necromancer"] = {
        ["Creepy Santa"] = "rbxassetid://121558895628032", ["Default"] = "rbxassetid://16742111373", ["Duck"] = "rbxassetid://106663322139673", ["Fallen"] = "rbxassetid://18950652558", ["Mage"] = "rbxassetid://16997026277"
    },
    ["Operator"] = {
        ["Default"] = "rbxassetid://16742111580"
    },
    ["Paintballer"] = {
        ["Bunny"] = "rbxassetid://16742111855", ["Default"] = "rbxassetid://16742112045", ["Green"] = "rbxassetid://17766383428", ["Red"] = "rbxassetid://16742112218"
    },
    ["Pursuit"] = {
        ["Default"] = "rbxassetid://71565475215945", ["Dragon"] = "rbxassetid://75987818617959", ["Eggy"] = "rbxassetid://129121886854482"
    },
    ["Pyromancer"] = {
        ["Acidic"] = "rbxassetid://16742112759", ["Barbecue"] = "rbxassetid://16742112955", ["Blue"] = "rbxassetid://16742113148", ["Bunny"] = "rbxassetid://16742113383", ["Default"] = "rbxassetid://16742113730", ["Dwarf"] = "rbxassetid://16742114045", ["Fire Breather"] = "rbxassetid://87818829094012", ["Frost"] = "rbxassetid://16742114293", ["Ghost"] = "rbxassetid://16742114699", ["Golden"] = "rbxassetid://16742128811", ["Hallow Punk"] = "rbxassetid://100038154702519", ["Hazmat"] = "rbxassetid://16742128975", ["Mage"] = "rbxassetid://16742129185", ["Plushie"] = "rbxassetid://110949683234465", ["Pool Party"] = "rbxassetid://104604814725961", ["Reindeer"] = "rbxassetid://128884594892871", ["Scarecrow"] = "rbxassetid://16742129397", ["Valentines"] = "rbxassetid://16742129623", ["Vigilante"] = "rbxassetid://16742129830"
    },
    ["Ranger"] = {
        ["5ouls"] = "rbxassetid://18549607210", ["Badlands"] = "rbxassetid://16801603418", ["Beast Slayer"] = "rbxassetid://16742130037", ["Black Ops"] = "rbxassetid://16742130258", ["Blue"] = "rbxassetid://16742130444", ["Bunny"] = "rbxassetid://16742130675", ["Classic"] = "rbxassetid://16742130816", ["Dark Matter"] = "rbxassetid://16742131006", ["Default"] = "rbxassetid://16742131160", ["Eclipse"] = "rbxassetid://16742131402", ["Eskimo"] = "rbxassetid://128714714796489", ["Frankenstein"] = "rbxassetid://123830216490388", ["Frost"] = "rbxassetid://16742131549", ["Green"] = "rbxassetid://16742131725", ["Gun Gale"] = "rbxassetid://16742131902", ["Mecha Ducky"] = "rbxassetid://111106612615105", ["Partisan"] = "rbxassetid://16742132072", ["Phantom"] = "rbxassetid://16742132284", ["Propellars"] = "rbxassetid://16742132454", ["Pumpkin"] = "rbxassetid://16742048328", ["Railgunner"] = "rbxassetid://16742132622", ["Shark"] = "rbxassetid://118641195806072", ["SteamPunk"] = "rbxassetid://17766383629", ["Valentines"] = "rbxassetid://16742132842", ["Wraith"] = "rbxassetid://16742133100"
    },
    ["Rocketeer"] = {
        ["Bosanka"] = "rbxassetid://97562066551955", ["Dark Matter"] = "rbxassetid://82619969731160", ["Default"] = "rbxassetid://72053097584198", ["Duck"] = "rbxassetid://82581428525440", ["Fortress"] = "rbxassetid://104029788106610", ["Ghost"] = "rbxassetid://126109130686279", ["Lovestriker"] = "rbxassetid://122261435962808", ["Lunar"] = "rbxassetid://106246370633835", ["Pumpkin"] = "rbxassetid://103379695538461", ["Steampunk"] = "rbxassetid://132152532289629", ["Toy"] = "rbxassetid://125539379459445", ["Trombone"] = "rbxassetid://127541134546574", ["Xmas"] = "rbxassetid://94263168154969"
    },
    ["Scout"] = {
        ["Banned"] = "rbxassetid://98679998862541", ["Beach"] = "rbxassetid://16742135002", ["Black Ops"] = "rbxassetid://16742135175", ["Blue"] = "rbxassetid://16742135394", ["Bunny"] = "rbxassetid://16742135669", ["Cookie"] = "rbxassetid://16742135838", ["Default"] = "rbxassetid://16742136020", ["Ducky"] = "rbxassetid://16742136236", ["Eclipse"] = "rbxassetid://16742136452", ["Fallen"] = "rbxassetid://18739982633", ["Frost Hunter"] = "rbxassetid://16742136608", ["Golden"] = "rbxassetid://16742136768", ["Green"] = "rbxassetid://16742136919", ["Guest"] = "rbxassetid://17571579155", ["Haz3mn"] = "rbxassetid://130252324129434", ["Holiday"] = "rbxassetid://16742137176", ["Intern"] = "rbxassetid://16742137311", ["King of Rock"] = "rbxassetid://117402710044000", ["Masquerade"] = "rbxassetid://16742137522", ["Party"] = "rbxassetid://16742137715", ["Penguin"] = "rbxassetid://102209448087896", ["Phantom"] = "rbxassetid://16742137918", ["Plushie"] = "rbxassetid://16742138111", ["Prime Raven"] = "rbxassetid://16742138286", ["Red"] = "rbxassetid://16742138539", ["Shark"] = "rbxassetid://89854318503673", ["Skull Trooper"] = "rbxassetid://16742138815", ["Survivor"] = "rbxassetid://16742139178", ["Toilet"] = "rbxassetid://16997026586", ["Valentines"] = "rbxassetid://16742139334", ["Valhalla"] = "rbxassetid://16742139584"
    },
    ["Shotgunner"] = {
        ["Classic"] = "rbxassetid://16742139792", ["Dance Fever"] = "rbxassetid://139385538174792", ["Default"] = "rbxassetid://16742140018", ["Ducky"] = "rbxassetid://16742140221", ["Gardener"] = "rbxassetid://98658379166107", ["Hallow Punk"] = "rbxassetid://16742140448", ["Holiday"] = "rbxassetid://16742140772", ["Null"] = "rbxassetid://93120520148959", ["Phantom"] = "rbxassetid://16742140988", ["Slayer"] = "rbxassetid://16998519554", ["Spooky"] = "rbxassetid://16742141438", ["Trumpeter"] = "rbxassetid://96004685279062", ["Vigilante"] = "rbxassetid://16742050157"
    },
    ["Slasher"] = {
        ["Default"] = "rbxassetid://85826790424914", ["Jason"] = "rbxassetid://80815511240891", ["Spooky"] = "rbxassetid://87446356234317", ["Spring Time"] = "rbxassetid://100945870370166"
    },
    ["Sledger"] = {
        ["Brave Soul"] = "rbxassetid://16742142332", ["Chocolatier"] = "rbxassetid://128749730055893", ["Default"] = "rbxassetid://75780199539960", ["Fallen"] = "rbxassetid://18961805501", ["Phantom"] = "rbxassetid://16742142970"
    },
    ["Sniper"] = {
        ["Blue"] = "rbxassetid://16742143211", ["Bunny"] = "rbxassetid://16742143396", ["Davinchi"] = "rbxassetid://16742143675", ["Default"] = "rbxassetid://16742143963", ["Ducky"] = "rbxassetid://16742144110", ["Frost Legion"] = "rbxassetid://93332491661008", ["Ghillie"] = "rbxassetid://16742144423", ["Red"] = "rbxassetid://16742144687", ["Redemption"] = "rbxassetid://16997027118", ["Shrimp"] = "rbxassetid://139661519405754", ["Silent"] = "rbxassetid://16742144921", ["Valentines"] = "rbxassetid://16742158141"
    },
    ["Snowballer"] = {
        ["Default"] = "rbxassetid://114134096038917"
    },
    ["Soldier"] = {
        ["Aerobics"] = "rbxassetid://104435661189010", ["Beast Slayer"] = "rbxassetid://16742158393", ["Blue"] = "rbxassetid://16742158617", ["Bunny"] = "rbxassetid://90125360452717", ["Classic"] = "rbxassetid://16742158900", ["Cold Soldier"] = "rbxassetid://16742159220", ["Dark Frost"] = "rbxassetid://79808121861280", ["Default"] = "rbxassetid://16742159440", ["Doughboy"] = "rbxassetid://16742159744", ["Ducky"] = "rbxassetid://16742159991", ["Golden"] = "rbxassetid://16742160355", ["Grand Theft"] = "rbxassetid://16742160584", ["Holiday"] = "rbxassetid://16742160760", ["Korblox"] = "rbxassetid://70787227887803", ["Liberator"] = "rbxassetid://16997027649", ["Null"] = "rbxassetid://124579321748902", ["Party"] = "rbxassetid://16742161040", ["Red"] = "rbxassetid://16742161237", ["Stealth Ops"] = "rbxassetid://100325781772079", ["Toilet"] = "rbxassetid://16997028225", ["Toy"] = "rbxassetid://16742161627", ["Valentines"] = "rbxassetid://16742161860"
    },
    ["Spotlight Tech"] = {
        ["Default"] = "rbxassetid://100541687228569"
    },
    ["Swarmer"] = {
        ["Default"] = "rbxassetid://130558134123777"
    },
    ["Tesla"] = {
        ["Default"] = "rbxassetid://82978810572655"
    },
    ["Toxic Gunner"] = {
        ["Default"] = "rbxassetid://73834896430233", ["Phantom"] = "rbxassetid://16742162641"
    },
    ["Trapper"] = {
        ["Banned"] = "rbxassetid://138302025230911", ["Chocolatier"] = "rbxassetid://97990283366444", ["Dark Frost"] = "rbxassetid://120378214035608", ["Default"] = "rbxassetid://16742162831", ["Hermit"] = "rbxassetid://132047366954925", ["Holiday"] = "rbxassetid://135434192278722", ["Jolly Tree"] = "rbxassetid://122626004746795", ["Mallard Duck"] = "rbxassetid://128010558189605", ["Plushie"] = "rbxassetid://17362851197"
    },
    ["Turret"] = {
        ["Crossbow"] = "rbxassetid://114313678039848", ["Default"] = "rbxassetid://98957331113953", ["Grinch"] = "rbxassetid://121152276423958", ["Jetski"] = "rbxassetid://135352734380419", ["XR300"] = "rbxassetid://107330122678487", ["XR500"] = "rbxassetid://88505927728819"
    },
    ["War Machine"] = {
        ["Default"] = "rbxassetid://16742163808"
    },
    ["Warden"] = {
        ["Baseball"] = "rbxassetid://16742164022", ["Dark Frost"] = "rbxassetid://137394918093332", ["Default"] = "rbxassetid://16742164273", ["Ducky"] = "rbxassetid://16742051899", ["Fallen"] = "rbxassetid://18960948589", ["Freddy"] = "rbxassetid://106739389283977", ["Galactic"] = "rbxassetid://16742164510", ["Isaac"] = "rbxassetid://16742164667", ["Korblox"] = "rbxassetid://16742164799", ["Masquerade"] = "rbxassetid://16742165002", ["Pirate"] = "rbxassetid://16742165168", ["Shark"] = "rbxassetid://70941336840822", ["Slaughter"] = "rbxassetid://16742165310"
    },
    ["Warlock"] = {
        ["Default"] = "rbxassetid://91902523805977", ["Rockstar"] = "rbxassetid://82651587906745", ["Tiger"] = "rbxassetid://139541269723119"
    }
}

-- // TOWER RESOLVER LOGIC (For Equipper & Unequipper)
local ValidTowersList = {
    "Scout","Sniper","Paintballer","Demoman","Hunter","Soldier","Militant",
    "Freezer","Assassin","Shotgunner","Pyromancer","Ace Pilot","Medic","Farm",
    "Rocketeer","Trapper","Military Base","Crook Boss",
    "Electroshocker","Commander","Warden","Cowboy","DJ Booth","Minigunner",
    "Ranger","Pursuit","Gatling Gun","Turret","Mortar","Mercenary Base",
    "Brawler","Necromancer","Accelerator","Engineer","Hacker",
    "Gladiator","Commando","Slasher","Frost Blaster","Archer","Swarmer",
    "Toxic Gunner","Sledger","Executioner","Elf Camp","Jester","Cryomancer",
    "Hallow Punk","Harvester","Snowballer","Elementalist",
    "Firework Technician","Biologist","Warlock","Spotlight Tech","Mecha Base"
}

local function NormalizeString(s)
    return s:lower():gsub("[^a-z0-9]", "")
end

local NormalizedTowers = {}
for _, name in ipairs(ValidTowersList) do
    NormalizedTowers[#NormalizedTowers + 1] = {
        raw = name,
        norm = NormalizeString(name),
        words = name:lower():split(" ")
    }
end

local function ResolveTowerName(input)
    if input == "" then return end
    local n = NormalizeString(input)

    for _, t in ipairs(NormalizedTowers) do
        if t.norm == n then return t.raw end
    end
    for _, t in ipairs(NormalizedTowers) do
        if t.norm:sub(1, #n) == n then return t.raw end
    end
    for _, t in ipairs(NormalizedTowers) do
        for _, w in ipairs(t.words) do
            if w:sub(1, #n) == n then return t.raw end
        end
    end
    return nil
end

task.spawn(function()
    local function DisableIdled()
        local success, connections = pcall(getconnections, LocalPlayer.Idled)
        if success then
            for _, v in pairs(connections) do
                v:Disable()
            end
        end
    end
    DisableIdled()
end)

task.spawn(function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end)
end)

task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    local overlay = CoreGui:WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")

    overlay.ChildAdded:Connect(function(child)
        if child.Name == 'ErrorPrompt' then
            while true do
                TeleportService:Teleport(3260590327)
                task.wait(5)
            end
        end
    end)
end)

local function IdentifyGameState()
    local players = game:GetService("Players")
    local TempPlayer = players.LocalPlayer or players.PlayerAdded:Wait()
    local TempGui = TempPlayer:WaitForChild("PlayerGui")

    while true do
        if TempGui:FindFirstChild("ReactLobbyHud") then
            return "LOBBY"
        elseif TempGui:FindFirstChild("ReactUniversalHotbar") then
            return "GAME"
        end
        task.wait(1)
    end
end

local GameState = IdentifyGameState()

local function StartAntiAfk()
    task.spawn(function()
        local LobbyTimer = 0
        while GameState == "LOBBY" do 
            task.wait(1)
            LobbyTimer = LobbyTimer + 1
            if LobbyTimer >= 600 then
                TeleportService:Teleport(3260590327)
                break 
            end
        end
    end)
end

StartAntiAfk()

local SendRequest = request or http_request or httprequest
    or GetDevice and GetDevice().request

if not SendRequest then 
    warn("failure: no http function") 
    return 
end

local BackToLobbyRunning = false
local AutoPickupsRunning = false
local AutoSkipRunning = false
local AutoClaimRewards = false
local AntiLagRunning = false
local AutoChainRunning = false
local AutoDjRunning = false
local AutoNecroRunning = false
local TimeScaleRunning = false
local TimeScaleNoTicketsWarned = false
local AutoMercenaryBaseRunning = false
local AutoMilitaryBaseRunning = false
local SellFarmsRunning = false

local MaxPathDistance = 300 
local MilMarker = nil
local MercMarker = nil

local CurrentEquippedTowers = {"None"}

local StackEnabled = false
local SelectedTower = nil
local StackSphere = nil

local AllModifiers = {
    "HiddenEnemies", "Glass", "ExplodingEnemies", "Limitation", 
    "Committed", "HealthyEnemies", "Fog", "FlyingEnemies", 
    "Broke", "SpeedyEnemies", "Quarantine", "JailedTowers", "Inflation"
}

local DefaultSettings = {
    PathVisuals = false,
    MilitaryPath = false,
    MercenaryPath = false,
    AutoSkip = false,
    AutoChain = false,
    SupportCaravan = false,
    AutoDJ = false,
    AutoNecro = false,
    AutoRejoin = true,
    TimeScaleEnabled = false,
    TimeScaleValue = 2,
    SellFarms = false,
    AutoMercenary = false,
    AutoMilitary = false,
    Frost = false,
    Fallen = false,
    Easy = false,
    AntiLag = false,
    Disable3DRendering = false,
    AutoPickups = false,
    ClaimRewards = false,
    SendWebhook = false,
    NoRecoil = false,
    SellFarmsWave = 1,
    WebhookURL = "",
    Cooldown = 0.01,
    Multiply = 1,
    AutoCooldown = 0.01,
    AutoMultiply = 1,
    AutoGatling = false,
    TargetChamsEnabled = false,
    TargetChamsType = "Highlight",
    PickupMethod = "Pathfinding",
    StreamerMode = false,
    HideUsername = false,
    StreamerName = "",
    tagName = "None",
    Modifiers = {},
    SilentAimEnabled = false,
    TargetPriority = "First",
    AutoGatlingPriority = "First"
}

local TimeScaleValues = {0.5, 1, 1.5, 2}

local function NormalizeTimeScaleValue(val)
    val = tonumber(val)
    if not val then return nil end
    for _, v in ipairs(TimeScaleValues) do
        if v == val then return v end
    end
    return nil
end

local function CoerceTimeScaleValue(val, fallback)
    return NormalizeTimeScaleValue(val) or fallback
end

local function GetTimescaleFrame()
    local hotbar = PlayerGui:FindFirstChild("ReactUniversalHotbar")
    local frame = hotbar and hotbar:FindFirstChild("Frame")
    return frame and frame:FindFirstChild("timescale")
end

local StartTimeScale
local ApplyTimeScaleOnce

local ItemNames = {
    ["17447507910"] = "Timescale Ticket(s)",
    ["17438486690"] = "Range Flag(s)",
    ["17438486138"] = "Damage Flag(s)",
    ["17438487774"] = "Cooldown Flag(s)",
    ["17429537022"] = "Blizzard(s)",
    ["17448596749"] = "Napalm Strike(s)",
    ["18493073533"] = "Spin Ticket(s)",
    ["17429548305"] = "Supply Drop(s)",
    ["18443277308"] = "Low Grade Consumable Crate(s)",
    ["136180382135048"] = "Santa Radio(s)",
    ["18443277106"] = "Mid Grade Consumable Crate(s)",
    ["18443277591"] = "High Grade Consumable Crate(s)",
    ["132155797622156"] = "Christmas Tree(s)",
    ["124065875200929"] = "Fruit Cake(s)",
    ["17429541513"] = "Barricade(s)",
    ["110415073436604"] = "Holy Hand Grenade(s)",
    ["17429533728"] = "Frag Grenade(s)",
    ["17437703262"] = "Molotov(s)",
    ["139414922355803"] = "Present Clusters(s)"
}

TDS = {
    PlacedTowers = {},
    ActiveStrat = true,
    MatchmakingMap = {
        ["Hardcore"] = "hardcore",
        ["Pizza Party"] = "halloween",
        ["Badlands"] = "badlands",
        ["Polluted"] = "polluted"
    }
}
TDS["placed_towers"] = TDS.PlacedTowers
TDS["active_strat"] = TDS.ActiveStrat
TDS["matchmaking_map"] = TDS.MatchmakingMap

local UpgradeHistory = {}
shared.TDSTable = TDS
shared["TDS_Table"] = TDS

local function SaveSettings()
    local DataToSave = {}
    for key, _ in pairs(DefaultSettings) do
        DataToSave[key] = Globals[key]
    end
    writefile(FileName, HttpService:JSONEncode(DataToSave))
end

local function LoadSettings()
    if isfile(FileName) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(FileName))
        end)
        if success and type(data) == "table" then
            for key, DefaultVal in pairs(DefaultSettings) do
                if data[key] ~= nil then
                    Globals[key] = data[key]
                else
                    Globals[key] = DefaultVal
                end
            end
            return
        end
    end
    for key, value in pairs(DefaultSettings) do
        Globals[key] = value
    end
    SaveSettings()
end

local function SetSetting(name, value)
    if DefaultSettings[name] ~= nil then
        if name == "TimeScaleValue" then
            value = CoerceTimeScaleValue(value, Globals.TimeScaleValue or 2)
        end
        Globals[name] = value
        SaveSettings()
    end
end

-- ==========================================
-- // REAL-TIME RADAR, ESP & TRACER LOGIC
-- ==========================================
Globals.CurrentTargetModel = nil
Globals.CurrentHighlight = nil
Globals.LockedTargetPosition = nil -- Posisi yang akan ditembak oleh Gatling/Silent Aim

local function ClearESP()
    if Globals.CurrentHighlight then
        Globals.CurrentHighlight:Destroy()
        Globals.CurrentHighlight = nil
    end
    Globals.CurrentTargetModel = nil
end

local function ApplyTargetChams(enemyModel)
    if not enemyModel then 
        ClearESP()
        return 
    end

    if Globals.CurrentTargetModel ~= enemyModel then
        ClearESP() -- Hapus highlight dari musuh lama
        
        -- Buat Highlight baru ke musuh yang baru
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Adornee = enemyModel
        -- Simpan di CoreGui agar tidak error saat musuh terhapus
        highlight.Parent = game:GetService("CoreGui") 

        Globals.CurrentHighlight = highlight
        Globals.CurrentTargetModel = enemyModel
    end
end

-- // LOOP RADAR: BERJALAN 60x PER DETIK SECARA REAL-TIME
RunService.Heartbeat:Connect(function()
    -- 1. Bersihkan semua jika fitur mati
    if not Globals.AutoGatling and not Globals.SilentAimEnabled then
        ClearESP()
        Globals.LockedTargetPosition = nil
        return
    end

    -- 2. Cari Posisi Tower / Kamera untuk hitungan jarak (Priority: Close)
    local towerPos = workspace.CurrentCamera.CFrame.Position
    local towersFolder = workspace:FindFirstChild("Towers")
    if towersFolder then
        for _, tower in pairs(towersFolder:GetChildren()) do
            local rep = tower:FindFirstChild("TowerReplicator")
            if rep and rep:GetAttribute("OwnerId") == LocalPlayer.UserId and rep:GetAttribute("Name") == "Gatling Gun" then
                if tower.PrimaryPart then
                    towerPos = tower.PrimaryPart.Position
                    break
                end
            end
        end
    end

    -- 3. Mulai mencari musuh
    local BestTargetEnemy = nil
    local TargetHitbox = nil
    local MaxDistance = -1
    local MaxHealth = -1
    local MinDist = math.huge
    local MinDistancePath = math.huge -- Tambahan untuk target "Last"
    
    -- Auto Gatling priority menimpa Silent Aim priority jika Auto Gatling menyala
    local activePriority = Globals.AutoGatling and Globals.AutoGatlingPriority or Globals.TargetPriority

    local npcs = workspace:FindFirstChild("NPCs")
    if npcs then
        for _, enemy in pairs(npcs:GetChildren()) do
            local hitbox = enemy:FindFirstChild("HumanoidRootPart")
            local pointer = enemy:FindFirstChild("RootPointer") 
            
            if hitbox and pointer and pointer.Value then
                local repFolder = pointer.Value
                local health = repFolder:GetAttribute("Health") or 0
                local pathDist = repFolder:GetAttribute("PathDistance") or 0
                
                if health > 0 then
                    if activePriority == "First" and pathDist > MaxDistance then
                        MaxDistance = pathDist
                        BestTargetEnemy = enemy
                        TargetHitbox = hitbox
                    elseif activePriority == "Last" and pathDist < MinDistancePath then -- Logika Target "Last"
                        MinDistancePath = pathDist
                        BestTargetEnemy = enemy
                        TargetHitbox = hitbox
                    elseif activePriority == "Strongest" and health > MaxHealth then
                        MaxHealth = health
                        BestTargetEnemy = enemy
                        TargetHitbox = hitbox
                    elseif activePriority == "Close" then
                        local dist = (hitbox.Position - towerPos).Magnitude
                        if dist < MinDist then
                            MinDist = dist
                            BestTargetEnemy = enemy
                            TargetHitbox = hitbox
                        end
                    end
                end
            end
        end
    end

    -- 4. Simpan posisi target untuk ditembak
    if TargetHitbox then
        Globals.LockedTargetPosition = TargetHitbox.Position
    else
        Globals.LockedTargetPosition = nil
    end

    -- 5. Urus Highlight Visual secara instan
    if BestTargetEnemy and Globals.TargetChamsEnabled and (Globals.TargetChamsType == "Highlight" or Globals.TargetChamsType == "Both") then
        ApplyTargetChams(BestTargetEnemy)
    else
        ClearESP()
    end
end)

-- Visual Tracer
local function CreateTracer(targetPos)
    local startPos = nil
    local towersFolder = workspace:FindFirstChild("Towers")
    if towersFolder then
        for _, tower in pairs(towersFolder:GetChildren()) do
            local rep = tower:FindFirstChild("TowerReplicator")
            -- Pastikan ini tower Gatling Gun milik kita
            if rep and rep:GetAttribute("OwnerId") == LocalPlayer.UserId and rep:GetAttribute("Name") == "Gatling Gun" then
                
                -- Mencari Path: Weapon -> Main -> Barrel (Berdasarkan path yang Anda berikan)
                local weapon = tower:FindFirstChild("Weapon")
                if weapon then
                    local main = weapon:FindFirstChild("Main")
                    local barrel = main and main:FindFirstChild("Barrel")
                    
                    if barrel then
                        startPos = barrel.Position
                    elseif weapon.PrimaryPart then
                        startPos = weapon.PrimaryPart.Position
                    end
                end
                
                -- Fallback: Jika Barrel tidak ditemukan (misal lag render), ambil posisi tengah tower
                if not startPos and tower.PrimaryPart then
                    startPos = tower.PrimaryPart.Position
                end
                
                if startPos then
                    break
                end
            end
        end
    end

    -- Jika masih tidak ketemu titik awalnya, batalkan
    if not startPos then return end

    local tracer = Instance.new("Part")
    tracer.Name = "GatlingTracer"
    tracer.Anchored = true
    tracer.CanCollide = false
    tracer.CastShadow = false
    tracer.Material = Enum.Material.Neon
    tracer.Color = Color3.fromRGB(255, 200, 50) 
    
    local distance = (targetPos - startPos).Magnitude
    tracer.Size = Vector3.new(0.15, 0.15, distance) 
    
    -- Memposisikan tracer tepat di antara moncong senjata (Barrel) dan Musuh
    tracer.CFrame = CFrame.lookAt(startPos, targetPos) * CFrame.new(0, 0, -(distance / 2))
    tracer.Parent = workspace.Terrain

    -- Animasi pudar (Fade out)
    TweenService:Create(tracer, TweenInfo.new(0.15), {Transparency = 1}):Play()
    game:GetService("Debris"):AddItem(tracer, 0.15)
end

-- Hook Remote
if hookmetamethod then
    local lastTracerTime = 0
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        
        if method == "FireServer" and typeof(self) == "Instance" and self.Name == "RE:Fire" then
            local p = self.Parent
            if p and p.Name == "GatlingGun" then
                if (Globals.AutoGatling or Globals.SilentAimEnabled) and Globals.TargetChamsEnabled and (Globals.TargetChamsType == "Tracer" or Globals.TargetChamsType == "Both") then
                    local args = {...}
                    local targetPos = args[1]
                    if typeof(targetPos) == "Vector3" then
                        local now = os.clock()
                        if now - lastTracerTime >= 0.05 then 
                            lastTracerTime = now
                            task.spawn(CreateTracer, targetPos)
                        end
                    end
                end
            end
        end

        if method == "InvokeServer" and typeof(self) == "Instance" and self.Name == "RemoteFunction" then
            local args = {...}
            if args[1] == "Troops" and args[2] == "Abilities" and args[3] == "Activate" then
                local payload = args[4]
                if type(payload) == "table" and payload.Name == "FPS" then
                    if payload.Data and payload.Data.enabled == false then
                        if Globals.AutoGatling then
                            args[4] = { Troop = payload.Troop, Name = payload.Name, Data = { enabled = true } }
                            return oldNamecall(self, unpack(args))
                        end
                    end
                end
            end
        end

        return oldNamecall(self, ...)
    end)
end

local function Apply3dRendering()
    if Globals.Disable3DRendering then
        game:GetService("RunService"):Set3dRenderingEnabled(false)
    else
        RunService:Set3dRenderingEnabled(true)
    end
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local gui = PlayerGui and PlayerGui:FindFirstChild("ADS_BlackScreen")
    if Globals.Disable3DRendering then
        if PlayerGui and not gui then
            gui = Instance.new("ScreenGui")
            gui.Name = "ADS_BlackScreen"
            gui.IgnoreGuiInset = true
            gui.ResetOnSpawn = false
            gui.DisplayOrder = -1000
            gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            gui.Parent = PlayerGui
            local frame = Instance.new("Frame")
            frame.Name = "Cover"
            frame.BackgroundColor3 = Color3.new(0, 0, 0)
            frame.BorderSizePixel = 0
            frame.Size = UDim2.fromScale(1, 1)
            frame.ZIndex = 0
            frame.Parent = gui
        end
        gui.Enabled = true
    else
        if gui then gui.Enabled = false end
    end
end

LoadSettings()
Globals.TimeScaleValue = CoerceTimeScaleValue(Globals.TimeScaleValue, 2)
Apply3dRendering()

local isTagChangerRunning = false
local tagChangerConn = nil
local tagChangerTag = nil
local tagChangerOrig = nil

local function collectTagOptions()
    local list = {}
    local seen = {}
    local function addFolder(folder)
        if not folder then return end
        for _, child in ipairs(folder:GetChildren()) do
            local childName = child.Name
            if childName and not seen[childName] then
                seen[childName] = true
                list[#list + 1] = childName
            end
        end
    end
    local content = ReplicatedStorage:FindFirstChild("Content")
    if content then
        local nametag = content:FindFirstChild("Nametag")
        if nametag then
            addFolder(nametag:FindFirstChild("Basic"))
            addFolder(nametag:FindFirstChild("Exclusive"))
        end
    end
    table.sort(list)
    table.insert(list, 1, "None")
    return list
end

local function stopTagChanger()
    if tagChangerConn then
        tagChangerConn:Disconnect()
        tagChangerConn = nil
    end
    if tagChangerTag and tagChangerTag.Parent and tagChangerOrig ~= nil then
        pcall(function() tagChangerTag.Value = tagChangerOrig end)
    end
    tagChangerTag = nil
    tagChangerOrig = nil
end

local function startTagChanger()
    if isTagChangerRunning then return end
    isTagChangerRunning = true
    task.spawn(function()
        while Globals.tagName and Globals.tagName ~= "" and Globals.tagName ~= "None" do
            local tag = LocalPlayer:FindFirstChild("Tag")
            if tag then
                if tagChangerTag ~= tag then
                    if tagChangerConn then
                        tagChangerConn:Disconnect()
                        tagChangerConn = nil
                    end
                    tagChangerTag = tag
                    if tagChangerOrig == nil then
                        tagChangerOrig = tag.Value
                    end
                end
                if tag.Value ~= Globals.tagName then
                    tag.Value = Globals.tagName
                end
                if not tagChangerConn then
                    tagChangerConn = tag:GetPropertyChangedSignal("Value"):Connect(function()
                        if Globals.tagName and Globals.tagName ~= "" and Globals.tagName ~= "None" then
                            if tag.Value ~= Globals.tagName then
                                tag.Value = Globals.tagName
                            end
                        end
                    end)
                end
            end
            task.wait(0.5)
        end
        isTagChangerRunning = false
    end)
end

if Globals.tagName and Globals.tagName ~= "" and Globals.tagName ~= "None" then
    startTagChanger()
end

local OriginalDisplayName = LocalPlayer.DisplayName
local OriginalUserName = LocalPlayer.Name

local SpoofTextCache = setmetatable({}, {__mode = "k"})
local PrivacyRunning = false
local LastSpoofName = nil
local PrivacyConns = {}
local PrivacyTextNodes = setmetatable({}, {__mode = "k"})
local StreamerTag = nil
local StreamerTagOrig = nil
local StreamerTagConn = nil

local function AddPrivacyConn(conn)
    if conn then PrivacyConns[#PrivacyConns + 1] = conn end
end

local function ClearPrivacyConns()
    for _, c in ipairs(PrivacyConns) do pcall(function() c:Disconnect() end) end
    PrivacyConns = {}
    for inst in pairs(PrivacyTextNodes) do PrivacyTextNodes[inst] = nil end
end

local function MakeSpoofName() return "BelowNatural" end

local function EnsureSpoofName()
    local nm = Globals.StreamerName
    if not nm or nm == "" then
        nm = MakeSpoofName()
        SetSetting("StreamerName", nm)
    end
    return nm
end

local function IsTagChangerActive()
    return Globals.tagName and Globals.tagName ~= "" and Globals.tagName ~= "None"
end

local function SetLocalDisplayName(nm)
    if not nm or nm == "" then return end
    pcall(function() LocalPlayer.DisplayName = nm end)
end

local function ReplacePlain(str, old, new)
    if not str or str == "" or not old or old == "" or old == new then return str, false end
    local start = 1
    local out = {}
    local changed = false
    while true do
        local i, j = string.find(str, old, start, true)
        if not i then
            out[#out + 1] = string.sub(str, start)
            break
        end
        changed = true
        out[#out + 1] = string.sub(str, start, i - 1)
        out[#out + 1] = new
        start = j + 1
    end
    if changed then return table.concat(out), true end
    return str, false
end

local function ApplySpoofToInstance(inst, OldA, OldB, NewName)
    if not inst then return end
    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
        local txt = inst.Text
        if type(txt) == "string" and txt ~= "" then
            local HasA = OldA and OldA ~= "" and string.find(txt, OldA, 1, true)
            local HasB = OldB and OldB ~= "" and string.find(txt, OldB, 1, true)
            if not HasA and not HasB then return end
            local t = txt
            local changed = false
            local ch
            if OldA and OldA ~= "" then
                t, ch = ReplacePlain(t, OldA, NewName)
                if ch then changed = true end
            end
            if OldB and OldB ~= "" then
                t, ch = ReplacePlain(t, OldB, NewName)
                if ch then changed = true end
            end
            if changed then
                if SpoofTextCache[inst] == nil then SpoofTextCache[inst] = txt end
                inst.Text = t
            end
        end
    end
end

local function RestoreSpoofText()
    for inst, txt in pairs(SpoofTextCache) do
        if inst and inst.Parent then pcall(function() inst.Text = txt end) end
        SpoofTextCache[inst] = nil
    end
end

local function GetPrivacyName()
    if Globals.StreamerMode then return EnsureSpoofName() end
    if Globals.HideUsername then return "████████" end
    return nil
end

local function AddPrivacyNode(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    PrivacyTextNodes[inst] = true
    local nm = GetPrivacyName()
    if nm then ApplySpoofToInstance(inst, OriginalDisplayName, OriginalUserName, nm) end
end

local function HookPrivacyRoot(root)
    if not root then return end
    for _, inst in ipairs(root:GetDescendants()) do AddPrivacyNode(inst) end
    AddPrivacyConn(root.DescendantAdded:Connect(function(inst)
        if GetPrivacyName() then AddPrivacyNode(inst) end
    end))
end

local function SweepPrivacyText(nm)
    for inst in pairs(PrivacyTextNodes) do
        if inst and inst.Parent then
            ApplySpoofToInstance(inst, OriginalDisplayName, OriginalUserName, nm)
        else
            PrivacyTextNodes[inst] = nil
        end
    end
end

local function ApplyStreamerTag()
    if IsTagChangerActive() then
        if StreamerTagConn then StreamerTagConn:Disconnect(); StreamerTagConn = nil end
        StreamerTag = nil
        StreamerTagOrig = nil
        return
    end
    local nm = EnsureSpoofName()
    local tag = LocalPlayer:FindFirstChild("Tag")
    if not tag then return end
    if StreamerTag and StreamerTag ~= tag then
        if StreamerTagConn then StreamerTagConn:Disconnect(); StreamerTagConn = nil end
    end
    if StreamerTag ~= tag then
        StreamerTag = tag
        StreamerTagOrig = tag.Value
    end
    if tag.Value ~= nm then tag.Value = nm end
    if StreamerTagConn then StreamerTagConn:Disconnect(); StreamerTagConn = nil end
    StreamerTagConn = tag:GetPropertyChangedSignal("Value"):Connect(function()
        if not Globals.StreamerMode then return end
        if IsTagChangerActive() then return end
        local nm2 = EnsureSpoofName()
        if tag.Value ~= nm2 then tag.Value = nm2 end
    end)
end

local function RestoreStreamerTag()
    if StreamerTagConn then StreamerTagConn:Disconnect(); StreamerTagConn = nil end
    if IsTagChangerActive() then
        StreamerTag = nil
        StreamerTagOrig = nil
        return
    end
    if StreamerTag and StreamerTag.Parent and StreamerTagOrig ~= nil then
        pcall(function() StreamerTag.Value = StreamerTagOrig end)
    end
    StreamerTag = nil
    StreamerTagOrig = nil
end

local function ApplyPrivacyOnce()
    local nm = GetPrivacyName()
    if not nm then return end
    if LastSpoofName and LastSpoofName ~= nm then RestoreSpoofText() end
    if Globals.StreamerMode then ApplyStreamerTag() else RestoreStreamerTag() end
    SetLocalDisplayName(nm)
    SweepPrivacyText(nm)
    LastSpoofName = nm
end

local function StopPrivacyMode()
    ClearPrivacyConns()
    RestoreSpoofText()
    LastSpoofName = nil
    RestoreStreamerTag()
    SetLocalDisplayName(OriginalDisplayName)
    PrivacyRunning = false
end

local function StartPrivacyMode()
    if PrivacyRunning then return end
    PrivacyRunning = true
    ClearPrivacyConns()
    ApplyPrivacyOnce()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg then HookPrivacyRoot(pg) end
    local CoreGui = game:GetService("CoreGui")
    if CoreGui then HookPrivacyRoot(CoreGui) end
    local TagsRoot = workspace:FindFirstChild("Nametags")
    if TagsRoot then HookPrivacyRoot(TagsRoot) end
    local ch = LocalPlayer.Character
    if ch then HookPrivacyRoot(ch) end
    AddPrivacyConn(LocalPlayer.CharacterAdded:Connect(function(NewChar)
        if GetPrivacyName() then
            HookPrivacyRoot(NewChar)
            ApplyPrivacyOnce()
        end
    end))
    AddPrivacyConn(workspace.ChildAdded:Connect(function(inst)
        if GetPrivacyName() and inst.Name == "Nametags" then
            HookPrivacyRoot(inst)
            ApplyPrivacyOnce()
        end
    end))
    local function step()
        if not GetPrivacyName() then StopPrivacyMode() return end
        ApplyPrivacyOnce()
        task.delay(0.5, step)
    end
    task.defer(step)
end

local function UpdatePrivacyState()
    if GetPrivacyName() then
        if not PrivacyRunning then StartPrivacyMode() else ApplyPrivacyOnce() end
    else
        if PrivacyRunning then StopPrivacyMode() end
    end
end
UpdatePrivacyState()

local function FindPath()
    local MapFolder = workspace:FindFirstChild("Map")
    if not MapFolder then return nil end
    local PathsFolder = MapFolder:FindFirstChild("Paths")
    if not PathsFolder then return nil end
    local PathFolder = PathsFolder:GetChildren()[1]
    if not PathFolder then return nil end

    local PathNodes = {}
    for _, node in ipairs(PathFolder:GetChildren()) do
        if node:IsA("BasePart") then
            table.insert(PathNodes, node)
        end
    end

    table.sort(PathNodes, function(a, b)
        local NumA = tonumber(a.Name:match("%d+"))
        local NumB = tonumber(b.Name:match("%d+"))
        if NumA and NumB then return NumA < NumB end
        return a.Name < b.Name
    end)
    return PathNodes
end

local function TotalLength(PathNodes)
    local TotalLength = 0
    for i = 1, #PathNodes - 1 do
        TotalLength = TotalLength + (PathNodes[i + 1].Position - PathNodes[i].Position).Magnitude
    end
    return TotalLength
end

local MercenarySlider, MilitarySlider, MaxLenght

local function CalcLength()
    local map = workspace:FindFirstChild("Map")
    if GameState == "GAME" and map then
        local PathNodes = FindPath()
        if PathNodes and #PathNodes > 0 then
            MaxPathDistance = TotalLength(PathNodes)
            if MercenarySlider then MercenarySlider:SetMax(MaxPathDistance) end
            if MilitarySlider then MilitarySlider:SetMax(MaxPathDistance) end
            if MaxLenght then MaxLenght = MaxPathDistance end
            return true
        end
    end
    return false
end

local function GetPointAtDistance(PathNodes, distance)
    if not PathNodes or #PathNodes < 2 then return nil end

    local CurrentDist = 0
    for i = 1, #PathNodes - 1 do
        local StartPos = PathNodes[i].Position
        local EndPos = PathNodes[i+1].Position
        local SegmentLen = (EndPos - StartPos).Magnitude

        if CurrentDist + SegmentLen >= distance then
            local remaining = distance - CurrentDist
            local direction = (EndPos - StartPos).Unit
            return StartPos + (direction * remaining)
        end
        CurrentDist = CurrentDist + SegmentLen
    end
    return PathNodes[#PathNodes].Position
end

local function UpdatePathVisuals()
    if not Globals.PathVisuals then
        if MilMarker then MilMarker:Destroy() MilMarker = nil end
        if MercMarker then MercMarker:Destroy() MercMarker = nil end
        return
    end

    local PathNodes = FindPath()
    if not PathNodes then return end

    if not MilMarker then
        MilMarker = Instance.new("Part")
        MilMarker.Name = "MilVisual"
        MilMarker.Shape = Enum.PartType.Cylinder
        MilMarker.Size = Vector3.new(0.3, 3, 3)
        MilMarker.Color = Color3.fromRGB(0, 255, 0)
        MilMarker.Material = Enum.Material.Plastic
        MilMarker.Anchored = true
        MilMarker.CanCollide = false
        MilMarker.Orientation = Vector3.new(0, 0, 90)
        MilMarker.Parent = workspace
    end

    if not MercMarker then
        MercMarker = MilMarker:Clone()
        MercMarker.Name = "MercVisual"
        MercMarker.Color = Color3.fromRGB(255, 0, 0)
        MercMarker.Parent = workspace
    end

    local MilPos = GetPointAtDistance(PathNodes, Globals.MilitaryPath or 0)
    local MercPos = GetPointAtDistance(PathNodes, Globals.MercenaryPath or 0)

    if MilPos then
        MilMarker.Position = MilPos + Vector3.new(0, 0.2, 0)
        MilMarker.Transparency = 0.7
    end
    if MercPos then
        MercMarker.Position = MercPos + Vector3.new(0, 0.2, 0)
        MercMarker.Transparency = 0.7
    end
end

-- === DUMMY ADDONS FUNCTION ===
function TDS:Addons()
    -- Fitur Premium / Key System Bypassed!
    return true
end

-- === NATIVE EQUIP AND UNEQUIP ===
function TDS:Equip(tower_name)
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
    local success, err = pcall(function()
        return remote:InvokeServer("Inventory", "Equip", "tower", tower_name)
    end)
    return success
end

function TDS:Unequip(tower_name)
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
    local success, err = pcall(function()
        return remote:InvokeServer("Inventory", "Unequip", "tower", tower_name)
    end)
    return success
end

local function GetEquippedTowers()
    local towers = {}
    local StateReplicators = ReplicatedStorage:FindFirstChild("StateReplicators")

    if StateReplicators then
        for _, folder in ipairs(StateReplicators:GetChildren()) do
            if folder.Name == "PlayerReplicator" and folder:GetAttribute("UserId") == LocalPlayer.UserId then
                local equipped = folder:GetAttribute("EquippedTowers")
                if type(equipped) == "string" then
                    local CleanedJson = equipped:match("%[.*%]") 
                    local success, TowerTable = pcall(function()
                        return HttpService:JSONDecode(CleanedJson)
                    end)

                    if success and type(TowerTable) == "table" then
                        for i = 1, 5 do
                            if TowerTable[i] then
                                table.insert(towers, TowerTable[i])
                            end
                        end
                    end
                end
            end
        end
    end
    return #towers > 0 and towers or {"None"}
end

CurrentEquippedTowers = GetEquippedTowers()

-- // ui
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Sources/UI.lua"))()

local Window = Library:Window({
    Title = "Aether Hub",
    Desc = "your #1 hub (Premium Unlocked)",
    Theme = "Dark",
    DiscordLink = "https://discord.gg/autostrat",
    Icon = 126403638319957,
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 400)
    }
})

local Autostrat = Window:Tab({Title = "Autostrat", Icon = "star"}) do
    Autostrat:Section({Title = "Main"})

    Autostrat:Toggle({
        Title = "Auto Rejoin",
        Desc = "Rejoins the gamemode after you've won and does the strategy again.",
        Value = Globals.AutoRejoin,
        Callback = function(v)
            SetSetting("AutoRejoin", v)
        end
    })

    Autostrat:Toggle({
        Title = "Auto Skip Waves",
        Desc = "Skips all Waves",
        Value = Globals.AutoSkip,
        Callback = function(v)
            SetSetting("AutoSkip", v)
        end
    })

    Autostrat:Toggle({
        Title = "Auto Chain",
        Desc = "Chains Commander Ability",
        Value = Globals.AutoChain,
        Callback = function(v)
            SetSetting("AutoChain", v)
        end
    })

    Autostrat:Toggle({
        Title = "Support Caravan",
        Desc = "Uses Commander Support Caravan",
        Value = Globals.SupportCaravan,
        Callback = function(v)
            SetSetting("SupportCaravan", v)
        end
    })

    Autostrat:Toggle({
        Title = "Auto DJ Booth",
        Desc = "Uses DJ Booth Ability",
        Value = Globals.AutoDJ,
        Callback = function(v)
            SetSetting("AutoDJ", v)
        end
    })

    Autostrat:Toggle({
        Title = "Auto Necro",
        Desc = "Uses Necromancer Ability",
        Value = Globals.AutoNecro,
        Callback = function(v)
            SetSetting("AutoNecro", v)
        end
    })

    Autostrat:Section({Title = "TimeScale"})
    Autostrat:Toggle({
        Title = "Enable TimeScale",
        Desc = "Unlocks and sets game speed using tickets",
        Value = Globals.TimeScaleEnabled,
        Callback = function(v)
            SetSetting("TimeScaleEnabled", v)
            if v then
                StartTimeScale()
            end
        end
    })

    Autostrat:Dropdown({
        Title = "TimeScale Speed",
        Desc = "Choose: 0.5, 1, 1.5, 2",
        List = {"0.5", "1", "1.5", "2"},
        Value = tostring(Globals.TimeScaleValue or 2),
        Callback = function(choice)
            local selected = type(choice) == "table" and choice[1] or choice
            local value = CoerceTimeScaleValue(selected, Globals.TimeScaleValue or 2)
            SetSetting("TimeScaleValue", value)
            if Globals.TimeScaleEnabled then
                ApplyTimeScaleOnce()
            end
        end
    })

    Autostrat:Dropdown({
        Title = "Modifiers:",
        List = AllModifiers,
        Value = Globals.Modifiers,
        Multi = true,
        Callback = function(choice)
            SetSetting("Modifiers", choice)
        end
    })

    Autostrat:Section({Title = "Farm"})
    Autostrat:Toggle({
        Title = "Sell Farms",
        Desc = "Sells all your farms on the specified wave",
        Value = Globals.SellFarms,
        Callback = function(v)
            SetSetting("SellFarms", v)
        end
    })

    Autostrat:Textbox({
        Title = "Wave:",
        Desc = "Wave to sell farms",
        Placeholder = "40",
        Value = tostring(Globals.SellFarmsWave),
        ClearTextOnFocus = false,
        Callback = function(text)
            local number = tonumber(text)
            if number then
                SetSetting("SellFarmsWave", number)
            else
                Window:Notify({
                    Title = "ADS",
                    Desc = "Invalid number entered!",
                    Time = 3,
                    Type = "error"
                })
            end
        end
    })

    Autostrat:Section({Title = "Abilities"})
    Autostrat:Toggle({
        Title = "Enable Path Distance Marker",
        Desc = "Red = Mercenary Base, Green = Military Baset",
        Value = Globals.PathVisuals,
        Callback = function(v)
            SetSetting("PathVisuals", v)
        end
    })

    Autostrat:Toggle({
        Title = "Auto Mercenary Base",
        Desc = "Uses Air-Drop Ability",
        Value = Globals.AutoMercenary,
        Callback = function(v)
            SetSetting("AutoMercenary", v)
        end
    })

    MercenarySlider = Autostrat:Slider({
        Title = "Path Distance",
        Min = 0,
        Max = 300,
        Rounding = 0,
        Value = Globals.MercenaryPath,
        Callback = function(val)
            SetSetting("MercenaryPath", val)
        end
    })

    Autostrat:Toggle({
        Title = "Auto Military Base",
        Desc = "Uses Airstrike Ability",
        Value = Globals.AutoMilitary,
        Callback = function(v)
            SetSetting("AutoMilitary", v)
        end
    })

    MilitarySlider = Autostrat:Slider({
        Title = "Path Distance",
        Min = 0,
        Max = 300,
        Rounding = 0,
        Value = Globals.MilitaryPath,
        Callback = function(val)
            SetSetting("MilitaryPath", val)
        end
    })

    task.spawn(function()
        while true do
            local success = CalcLength()
            if success then break end 
            task.wait(3)
        end
    end)
end

Window:Line()

local Main = Window:Tab({Title = "Main", Icon = "stamp"}) do
    Main:Section({Title = "Tower Options"})
    local TowerDropdown = Main:Dropdown({
        Title = "Tower:",
        List = CurrentEquippedTowers,
        Value = CurrentEquippedTowers[1],
        Callback = function(choice)
            SelectedTower = choice
        end
    })

    local function RefreshDropdown()
        local NewTowers = GetEquippedTowers()
        if table.concat(NewTowers, ",") ~= table.concat(CurrentEquippedTowers, ",") then
            TowerDropdown:Clear() 

            for _, TowerName in ipairs(NewTowers) do
                TowerDropdown:Add(TowerName)
            end

            CurrentEquippedTowers = NewTowers
        end
    end

    task.spawn(function()
        while task.wait(2) do
            RefreshDropdown()
        end
    end)

    Main:Toggle({
        Title = "Stack Tower",
        Desc = "Enables Stacking placement",
        Value = false,
        Callback = function(v)
            StackEnabled = v

            if StackEnabled then
                Window:Notify({
                    Title = "ADS",
                    Desc = "Make sure not to equip the tower, only select it and then place where you want to!",
                    Time = 5,
                    Type = "normal"
                })
            end
        end
    })

    Main:Button({
        Title = "Upgrade Selected",
        Desc = "",
        Callback = function()
            if SelectedTower then
                for _, v in pairs(workspace.Towers:GetChildren()) do
                    if v:FindFirstChild("TowerReplicator") and v.TowerReplicator:GetAttribute("Name") == SelectedTower and v.TowerReplicator:GetAttribute("OwnerId") == LocalPlayer.UserId then
                        RemoteFunc:InvokeServer("Troops", "Upgrade", "Set", {Troop = v})
                    end
                end
                Window:Notify({
                    Title = "ADS",
                    Desc = "Attempted to upgrade all the selected towers!",
                    Time = 3,
                    Type = "normal"
                })
            end
        end
    })

    Main:Button({
        Title = "Sell Selected",
        Desc = "",
        Callback = function()
            if SelectedTower then
                for _, v in pairs(workspace.Towers:GetChildren()) do
                    if v:FindFirstChild("TowerReplicator") and v.TowerReplicator:GetAttribute("Name") == SelectedTower and v.TowerReplicator:GetAttribute("OwnerId") == LocalPlayer.UserId then
                        RemoteFunc:InvokeServer("Troops", "Sell", {Troop = v})
                    end
                end
                Window:Notify({
                    Title = "ADS",
                    Desc = "Attempted to sell all the selected towers!",
                    Time = 3,
                    Type = "normal"
                })
            end
        end
    })

    Main:Button({
        Title = "Upgrade All",
        Desc = "",
        Callback = function()
            for _, v in pairs(workspace.Towers:GetChildren()) do
                if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer.UserId then
                    RemoteFunc:InvokeServer("Troops", "Upgrade", "Set", {Troop = v})
                end
            end
            Window:Notify({
                Title = "ADS",
                Desc = "Attempted to upgrade all the towers!",
                Time = 3,
                Type = "normal"
            })
        end
    })

    Main:Button({
        Title = "Sell All",
        Desc = "",
        Callback = function()
            Window:Dialog({
                Title = "Do you want to sell all the towers?",
                Button1 = {
                    Title = "Confirm",
                    Color = Color3.fromRGB(226, 39, 6),
                    Callback = function()
                        for _, v in pairs(workspace.Towers:GetChildren()) do
                            if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer.UserId then
                                RemoteFunc:InvokeServer("Troops", "Sell", {Troop = v})
                            end
                        end

                        Window:Notify({
                            Title = "ADS",
                            Desc = "Attempted to sell all the towers!",
                            Time = 3,
                            Type = "normal"
                        })
                    end
                },
                Button2 = {
                    Title = "Cancel",
                    Color = Color3.fromRGB(0, 188, 0)
                }
            })
        end
    })

    Main:Section({Title = "Equipper"})
    
    -- Kotak Equip Tower
    Main:Textbox({
        Title = "Equip:",
        Desc = "Type a tower name to equip",
        Placeholder = "E.g. Gatling Gun",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(text)
            if text == "" or text == nil then return end
            task.spawn(function()
                local real_tower_name = ResolveTowerName(text)
                if not real_tower_name then
                    Window:Notify({
                        Title = "ADS",
                        Desc = "Tower not found: " .. tostring(text),
                        Time = 3,
                        Type = "error"
                    })
                    return
                end

                local success = TDS:Equip(real_tower_name)

                if success then
                    Window:Notify({
                        Title = "ADS",
                        Desc = "Successfully equipped: " .. real_tower_name,
                        Time = 3,
                        Type = "normal"
                    })
                else
                    Window:Notify({
                        Title = "ADS",
                        Desc = "Failed to equip: " .. real_tower_name,
                        Time = 3,
                        Type = "error"
                    })
                end
            end)
        end
    })

    -- Kotak Unequip Tower
    Main:Textbox({
        Title = "Unequip:",
        Desc = "Type a tower name to unequip",
        Placeholder = "E.g. Farm",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(text)
            if text == "" or text == nil then return end
            task.spawn(function()
                local real_tower_name = ResolveTowerName(text)
                if not real_tower_name then
                    Window:Notify({
                        Title = "ADS",
                        Desc = "Tower not found: " .. tostring(text),
                        Time = 3,
                        Type = "error"
                    })
                    return
                end

                local success = TDS:Unequip(real_tower_name)

                if success then
                    Window:Notify({
                        Title = "ADS",
                        Desc = "Successfully unequipped: " .. real_tower_name,
                        Time = 3,
                        Type = "normal"
                    })
                else
                    Window:Notify({
                        Title = "ADS",
                        Desc = "Failed to unequip: " .. real_tower_name,
                        Time = 3,
                        Type = "error"
                    })
                end
            end)
        end
    })

    Main:Section({Title = "Skins"})
    
    local tower_skin_list = {}
    for t_name, _ in pairs(TowerSkins) do
        table.insert(tower_skin_list, t_name)
    end
    table.sort(tower_skin_list)

    local selected_skin_tower = tower_skin_list[1]
    local selected_skin_name = "Default"

    local function get_skins(tower)
        local list = {}
        if TowerSkins[tower] then
            for s_name, _ in pairs(TowerSkins[tower]) do
                table.insert(list, s_name)
            end
            table.sort(list)
        end
        return list
    end

    local SkinDropdown -- placeholder definition

    Main:Dropdown({
        Title = "Select Tower:",
        List = tower_skin_list,
        Value = selected_skin_tower,
        Callback = function(choice)
            selected_skin_tower = choice
            local new_skins = get_skins(choice)
            selected_skin_name = new_skins[1] or "Default"
            
            if SkinDropdown then
                SkinDropdown:Clear()
                for _, s in ipairs(new_skins) do
                    SkinDropdown:Add(s)
                end
                SkinDropdown:SetValue(selected_skin_name)
            end
        end
    })

    SkinDropdown = Main:Dropdown({
        Title = "Select Skin:",
        List = get_skins(selected_skin_tower),
        Value = selected_skin_name,
        Callback = function(choice)
            selected_skin_name = choice
        end
    })

    Main:Button({
        Title = "Apply Skin",
        Callback = function()
            if selected_skin_tower and selected_skin_name then
                local args = {
                    "Inventory",
                    "Equip",
                    "Skin",
                    selected_skin_tower,
                    selected_skin_name
                }
                
                local success, result = pcall(function()
                    return game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
                end)

                if success then
                    Window:Notify({
                        Title = "ADS",
                        Desc = "Successfully equipped " .. selected_skin_name .. " skin for " .. selected_skin_tower .. "!",
                        Time = 3,
                        Type = "normal"
                    })
                else
                    Window:Notify({
                        Title = "ADS",
                        Desc = "Failed to equip skin.",
                        Time = 3,
                        Type = "error"
                    })
                end
            end
        end
    })

    Main:Section({Title = "Stats"})
    local CoinsLabel = Main:Label({Title = "Coins: 0", Desc = ""})
    local GemsLabel = Main:Label({Title = "Gems: 0", Desc = ""})
    local LevelLabel = Main:Label({Title = "Level: 0", Desc = ""})
    local WinsLabel = Main:Label({Title = "Wins: 0", Desc = ""})
    local LosesLabel = Main:Label({Title = "Loses: 0", Desc = ""})
    local ExpLabel = Main:Label({Title = "Experience: 0 / 0", Desc = ""})
    local ExpSlider = Main:Slider({
        Title = "EXP",
        Desc = "",
        Min = 0,
        Max = 100,
        Rounding = 0,
        Value = 0,
        Callback = function()
        end
    })

    local function ParseNumber(val)
        if type(val) == "number" then
            return val
        end
        if type(val) == "string" then
            local cleaned = string.gsub(val, ",", "")
            local n = tonumber(cleaned)
            if n then
                return n
            end
        end
        if type(val) == "table" and val.get then
            local ok, v = pcall(function()
                return val:get()
            end)
            if ok then
                return ParseNumber(v)
            end
        end
        return nil
    end

    local function ReadValue(obj)
        if not obj then
            return nil
        end
        local ok, v = pcall(function()
            return obj.Value
        end)
        if ok then
            return ParseNumber(v)
        end
        return nil
    end

    local function GetStatNumber(name)
        local obj = LocalPlayer:FindFirstChild(name)
        local v = ReadValue(obj)
        if v ~= nil then
            return v
        end
        local attr = LocalPlayer:GetAttribute(name)
        v = ParseNumber(attr)
        if v ~= nil then
            return v
        end
        return nil
    end

    local function PickExpMax()
        local ExpObj = LocalPlayer:FindFirstChild("Experience")
        local AttrMax = ExpObj and ParseNumber(ExpObj:GetAttribute("Max"))
        local AttrNeed = ExpObj and ParseNumber(ExpObj:GetAttribute("Required"))
        local AttrNext = ExpObj and ParseNumber(ExpObj:GetAttribute("Next"))
        return AttrMax
            or AttrNeed
            or AttrNext
            or GetStatNumber("ExperienceMax")
            or GetStatNumber("ExperienceNeeded")
            or GetStatNumber("ExperienceRequired")
            or GetStatNumber("ExperienceToNextLevel")
            or GetStatNumber("ExperienceToLevel")
            or GetStatNumber("NextLevelExp")
            or GetStatNumber("ExpToNextLevel")
            or GetStatNumber("ExpNeeded")
            or GetStatNumber("ExpRequired")
            or GetStatNumber("MaxExp")
            or GetStatNumber("MaxExperience")
            or 100
    end

    local GcExpCache = { t = nil, last = 0 }
    local function GetGcExp()
        if not getgc then
            return nil
        end
        local t = GcExpCache.t
        if t then
            local exp = ParseNumber(rawget(t, "exp") or rawget(t, "Exp") or rawget(t, "experience") or rawget(t, "Experience"))
            local MaxExp = ParseNumber(rawget(t, "maxExp") or rawget(t, "MaxExp") or rawget(t, "maxEXP") or rawget(t, "MaxEXP") or rawget(t, "maxExperience") or rawget(t, "MaxExperience"))
            local lvl = ParseNumber(rawget(t, "level") or rawget(t, "Level") or rawget(t, "lvl") or rawget(t, "Lvl"))
            if exp and MaxExp then
                return exp, MaxExp, lvl
            end
        end
        local now = os.clock()
        if now - GcExpCache.last < 3 then
            return nil
        end
        GcExpCache.last = now
        local plvl = GetStatNumber("Level")
        for _, obj in ipairs(getgc(true)) do
            if type(obj) == "table" then
                local exp = ParseNumber(rawget(obj, "exp") or rawget(obj, "Exp") or rawget(obj, "experience") or rawget(obj, "Experience"))
                local MaxExp = ParseNumber(rawget(obj, "maxExp") or rawget(obj, "MaxExp") or rawget(obj, "maxEXP") or rawget(obj, "MaxEXP") or rawget(obj, "maxExperience") or rawget(obj, "MaxExperience"))
                if exp and MaxExp then
                    local lvl = ParseNumber(rawget(obj, "level") or rawget(obj, "Level") or rawget(obj, "lvl") or rawget(obj, "Lvl"))
                    if not plvl or not lvl or lvl == plvl then
                        GcExpCache.t = obj
                        return exp, MaxExp, lvl
                    end
                end
            end
        end
        return nil
    end

    local function UpdateStats()
        local coins = GetStatNumber("Coins") or 0
        local gems = GetStatNumber("Gems") or 0
        local lvl = GetStatNumber("Level") or 0
        local wins = GetStatNumber("Triumphs") or 0
        local loses = GetStatNumber("Loses") or 0
        local exp = GetStatNumber("Experience") or 0
        local MaxExp = PickExpMax()
        local GcExp, GcMax, GcLvl = GetGcExp()
        if GcExp and GcMax then
            exp = GcExp
            MaxExp = GcMax
            if GcLvl then
                lvl = GcLvl
            end
        end
        if MaxExp < 1 then
            MaxExp = 1
        end
        if exp > MaxExp then
            MaxExp = exp
        end
        if CoinsLabel then CoinsLabel:SetTitle("Coins: " .. tostring(coins)) end
        if GemsLabel then GemsLabel:SetTitle("Gems: " .. tostring(gems)) end
        if LevelLabel then LevelLabel:SetTitle("Level: " .. tostring(lvl)) end
        if WinsLabel then WinsLabel:SetTitle("Wins: " .. tostring(wins)) end
        if LosesLabel then LosesLabel:SetTitle("Loses: " .. tostring(loses)) end
        if ExpLabel then ExpLabel:SetTitle("Experience: " .. tostring(exp) .. " / " .. tostring(MaxExp)) end
        if ExpSlider then
            ExpSlider:SetMin(0)
            ExpSlider:SetMax(MaxExp)
            ExpSlider:SetValue(exp)
        end
    end

    local StatsQueued = false
    local function QueueStatsUpdate()
        if StatsQueued then
            return
        end
        StatsQueued = true
        task.delay(0.2, function()
            StatsQueued = false
            UpdateStats()
        end)
    end

    local function HookStatObj(obj)
        if not obj then
            return
        end
        if obj.Changed then
            obj.Changed:Connect(QueueStatsUpdate)
        end
        obj:GetAttributeChangedSignal("Max"):Connect(QueueStatsUpdate)
        obj:GetAttributeChangedSignal("Required"):Connect(QueueStatsUpdate)
        obj:GetAttributeChangedSignal("Next"):Connect(QueueStatsUpdate)
    end

    local StatNames = {"Coins", "Gems", "Level", "Triumphs", "Loses", "Experience"}
    local ExpAttrNames = {
        "ExperienceMax",
        "ExperienceNeeded",
        "ExperienceRequired",
        "ExperienceToNextLevel",
        "ExperienceToLevel",
        "NextLevelExp",
        "ExpToNextLevel",
        "ExpNeeded",
        "ExpRequired",
        "MaxExp",
        "MaxExperience"
    }

    for _, name in ipairs(StatNames) do
        HookStatObj(LocalPlayer:FindFirstChild(name))
        LocalPlayer:GetAttributeChangedSignal(name):Connect(QueueStatsUpdate)
    end

    for _, name in ipairs(ExpAttrNames) do
        LocalPlayer:GetAttributeChangedSignal(name):Connect(QueueStatsUpdate)
    end

    LocalPlayer.ChildAdded:Connect(function(child)
        if table.find(StatNames, child.Name) then
            HookStatObj(child)
            QueueStatsUpdate()
        end
    end)

    LocalPlayer.ChildRemoved:Connect(function(child)
        if table.find(StatNames, child.Name) then
            QueueStatsUpdate()
        end
    end)

    QueueStatsUpdate()
end

Window:Line()

local Strategies = Window:Tab({Title = "Strategies", Icon = "newspaper"}) do
    Strategies:Section({Title = "Survival Strategies"})
    Strategies:Toggle({
        Title = "Frost Mode",
        Desc = "Skill tree: MAX\n\nTowers:\nGolden Scout,\nFirework Technician,\nHacker,\nBrawler,\nDJ Booth,\nCommander,\nEngineer,\nAccelerator,\nTurret,\nMercenary Base",
        Value = Globals.Frost,
        Callback = function(v)
            SetSetting("Frost", v)

            if v then
                 task.spawn(function()
                    local url = "https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Frost.lua"
                    local content = game:HttpGet(url)

                    while not (TDS and TDS.Loadout) do
                        task.wait(0.5) 
                    end

                    local func, err = loadstring(content)
                    if func then
                        func() 
                        Window:Notify({ Title = "ADS", Desc = "Running...", Time = 3 })
                    end
                end)
            end
        end
    })

    Strategies:Toggle({
        Title = "Fallen Mode",
        Desc = "Skill tree: Not needed\n\nTowers:\nGolden Scout,\nBrawler,\nMercenary Base,\nElectroshocker,\nEngineer",
        Value = Globals.Fallen,
        Callback = function(v)
            SetSetting("Fallen", v)

            if v then
                task.spawn(function()
                    local url = "https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Fallen.lua"
                    local content = game:HttpGet(url)

                    while not (TDS and TDS.Loadout) do
                        task.wait(0.5) 
                    end

                    local func, err = loadstring(content)
                    if func then
                        func() 
                        Window:Notify({ Title = "ADS", Desc = "Running...", Time = 3 })
                    end
                end)
            end
        end
    })

    Strategies:Toggle({
        Title = "Intermediate Mode",
        Desc = "Skill tree: Not needed\n\nTowers:\nShotgunner,\nCrook Boss",
        Value = Globals.Intermediate,
        Callback = function(v)
            SetSetting("Intermediate", v)

            if v then
                task.spawn(function()
                    local url = "https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Intermediate.lua"
                    local content = game:HttpGet(url)

                    while not (TDS and TDS.Loadout) do
                        task.wait(0.5) 
                    end

                    local func, err = loadstring(content)
                    if func then
                        func() 
                        Window:Notify({ Title = "ADS", Desc = "Running...", Time = 3 })
                    end
                end)
            end
        end
    })

    Strategies:Toggle({
        Title = "Casual Mode",
        Desc = "Skill tree: Not needed\n\nTowers:\nShotgunner",
        Value = Globals.Casual,
        Callback = function(v)
            SetSetting("Casual", v)

            if v then
                task.spawn(function()
                    local url = "https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Casual.lua"
                    local content = game:HttpGet(url)

                    while not (TDS and TDS.Loadout) do
                        task.wait(0.5) 
                    end

                    local func, err = loadstring(content)
                    if func then
                        func() 
                        Window:Notify({ Title = "ADS", Desc = "Running...", Time = 3 })
                    end
                end)
            end
        end
    })

    Strategies:Toggle({
        Title = "Easy Mode",
        Desc = "Skill tree: Not needed\n\nTowers:\nNormal Scout",
        Value = Globals.Easy,
        Callback = function(v)
            SetSetting("Easy", v)

            if v then
                task.spawn(function()
                    local url = "https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Easy.lua"
                    local content = game:HttpGet(url)

                    while not (TDS and TDS.Loadout) do
                        task.wait(0.5) 
                    end

                    local func, err = loadstring(content)
                    if func then
                        func() 
                        Window:Notify({ Title = "ADS", Desc = "Running...", Time = 3 })
                    end
                end)
            end
        end
    })

    Strategies:Section({Title = "Other Strategies"})
    Strategies:Toggle({
        Title = "Hardcore Mode",
        Desc = "Towers:\nFarm,\nGolden Scout,\nDJ Booth,\nCommander,\nElectroshocker,\nRanger,\nFreezer,\nGolden Minigunner",
        Value = Globals.Hardcore,
        Callback = function(v)
            SetSetting("Hardcore", v)

            if v then
                task.spawn(function()
                    local url = "https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Strategies/Hardcore.lua"
                    local content = game:HttpGet(url)

                    while not (TDS and TDS.Loadout) do
                        task.wait(0.5) 
                    end

                    local func, err = loadstring(content)
                    if func then
                        func() 
                        Window:Notify({ Title = "ADS", Desc = "Running...", Time = 3 })
                    end
                end)
            end
        end
    })
end

Window:Line()

local Misc = Window:Tab({Title = "Misc", Icon = "box"}) do
    Misc:Section({Title = "Misc"})
    Misc:Toggle({
        Title = "Enable Anti-Lag",
        Desc = "Boosts your FPS",
        Value = Globals.AntiLag,
        Callback = function(v)
            SetSetting("AntiLag", v)
        end
    })

    Misc:Toggle({
        Title = "Disable 3d rendering",
        Desc = "Turns off 3d rendering",
        Value = Globals.Disable3DRendering,
        Callback = function(v)
            SetSetting("Disable3DRendering", v)
            Apply3dRendering()
        end
    })

    -- // ==========================================
    -- // ADVANCED RADAR: UPCOMING WAVE & LIVE ENEMY
    -- // ==========================================
    
    local TrackerUI, TrackerConnection
    local GroupCards, EnemyPills = {}, {} 
    local CachedModeModule, CachedModeName
    local LastProcessedWave = -1

    -- Format Angka (1500 -> 1.5K)
    local function FormatNumber(n)
        if type(n) ~= "number" then return "0" end
        if n >= 1e6 then return string.format("%.1fM", n / 1e6)
        elseif n >= 1e3 then return string.format("%.1fK", n / 1e3)
        end
        return tostring(math.floor(n))
    end

    -- Sistem Pencarian Module Waves (TANPA DEFAULT & TANPA SANDBOX)
    local function GetModeDataModule()
        if CachedModeModule then return CachedModeModule, CachedModeName end
        
        local state = ReplicatedStorage:FindFirstChild("State") or workspace:FindFirstChild("State")
        if not state then return nil, "Waiting for State..." end

        local modeObj = state:FindFirstChild("Mode")
        local diffObj = state:FindFirstChild("Difficulty")

        local modeName = (modeObj and modeObj.Value ~= "") and modeObj.Value or nil
        local diffName = (diffObj and diffObj.Value ~= "") and diffObj.Value or nil

        if not modeName or not diffName then return nil, "None" end

        CachedModeName = diffName

        local content = ReplicatedStorage:FindFirstChild("Content")
        local gamemodes = content and content:FindFirstChild("Gamemodes")
        if not gamemodes then return nil, "Missing Gamemodes Folder" end

        local function cleanString(str)
            return str:lower():gsub("[%s%p]", "")
        end

        local safeMode = cleanString(modeName)
        local safeDiff = cleanString(diffName)

        -- METHOD A: Direct Path
        local mFolder = gamemodes:FindFirstChild(modeName)
        if mFolder then
            local diffsFolder = mFolder:FindFirstChild("Difficulties")
            if diffsFolder then
                local targetDiff = diffsFolder:FindFirstChild(diffName)
                if targetDiff and targetDiff:FindFirstChild("Waves") then
                    CachedModeModule = targetDiff.Waves
                    return CachedModeModule, CachedModeName
                end
            end
        end

        -- METHOD B: Fuzzy Search
        for _, mDir in ipairs(gamemodes:GetChildren()) do
            if cleanString(mDir.Name) == safeMode or string.find(cleanString(mDir.Name), safeMode) then
                local diffsDir = mDir:FindFirstChild("Difficulties")
                if diffsDir then
                    for _, dDir in ipairs(diffsDir:GetChildren()) do
                        if cleanString(dDir.Name) == safeDiff or string.find(cleanString(dDir.Name), safeDiff) then
                            if dDir:FindFirstChild("Waves") then
                                CachedModeModule = dDir.Waves
                                return CachedModeModule, CachedModeName .. " (Fuzzy)"
                            end
                        end
                    end
                end
            end
        end

        -- METHOD C: Deep Scan
        for _, folder in ipairs(gamemodes:GetDescendants()) do
            if folder:IsA("Folder") and cleanString(folder.Name) == safeDiff then
                if folder:FindFirstChild("Waves") then
                    CachedModeModule = folder.Waves
                    return CachedModeModule, CachedModeName .. " (Deep Scan)"
                end
            end
        end

        return nil, "Waves Not Found"
    end

    local function GetFastWave()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        local container = pg and pg:FindFirstChild("ReactGameTopGameDisplay") 
        local waveContainer = container and container:FindFirstChild("Frame") and container.Frame:FindFirstChild("wave")
        
        if waveContainer and waveContainer:FindFirstChild("container") then
            return tonumber(waveContainer.container.value.Text:match("^(%d+)")) or 0
        end
        return 0
    end

    local TDS_Modifiers = {
        ["1"] = "God", ["2"] = "Hidden", ["3"] = "Flying", ["4"] = "Stunned", 
        ["5"] = "Lead", ["6"] = "CliffUnit", ["7"] = "StunImmune", ["8"] = "Ignore", 
        ["9"] = "HiddenDetection", ["10"] = "Boss", ["11"] = "ExplosionImmune", 
        ["12"] = "EnergyImmune", ["13"] = "FreezeImmune", ["14"] = "FireImmune", 
        ["15"] = "Ghost", ["16"] = "Invincible", ["17"] = "HealthRegen", 
        ["18"] = "Slime", ["19"] = "Nimble", ["20"] = "Bloated", ["21"] = "LastSlime", 
        ["22"] = "Tank", ["23"] = "Explosive", ["24"] = "Jailed", ["25"] = "Aggro", 
        ["26"] = "DoubleDamage", ["27"] = "MoltenCorpse", ["28"] = "Frozen", 
        ["29"] = "FullRefund", ["30"] = "FireworkBuff", ["31"] = "Hologram", 
        ["32"] = "Blessed", ["33"] = "Shield", ["34"] = "SpeedBoost", ["35"] = "HiddenExposed"
    }

    local function ParseModifiers(modTable)
        if type(modTable) ~= "table" then return "" end
        local mods = {}
        for k, v in pairs(modTable) do
            if v then
                local strKey = tostring(k)
                if typeof(k) == "EnumItem" then strKey = tostring(k.Value)
                elseif type(k) == "table" and k.Value then strKey = tostring(k.Value)
                else strKey = tostring(k):match("%d+") or tostring(k) end
                
                local modName = TDS_Modifiers[strKey] or strKey
                if tonumber(strKey) == nil then modName = strKey end 
                table.insert(mods, modName)
            end
        end
        return #mods > 0 and " [" .. table.concat(mods, ", ") .. "]" or ""
    end

    local function CreateTrackerUI()
        if TrackerUI then TrackerUI:Destroy() end
        GroupCards, EnemyPills, LastProcessedWave, CachedModeModule = {}, {}, -1, nil
        
        TrackerUI = Instance.new("ScreenGui")
        TrackerUI.Name = "ADS_AdvancedTracker"
        TrackerUI.ResetOnSpawn = false
        TrackerUI.Parent = game:GetService("CoreGui")

        local MainFrame = Instance.new("Frame", TrackerUI)
        MainFrame.Size = UDim2.new(0, 260, 0, 480)
        MainFrame.Position = UDim2.new(1, -270, 0.5, -240)
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
        MainFrame.BackgroundTransparency = 0.2
        Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
        Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(50, 50, 65)

        local UpcomingHeader = Instance.new("Frame", MainFrame)
        UpcomingHeader.Size = UDim2.new(1, 0, 0, 28)
        UpcomingHeader.BackgroundColor3 = Color3.fromRGB(40, 30, 15)
        UpcomingHeader.BackgroundTransparency = 0.3
        Instance.new("UICorner", UpcomingHeader).CornerRadius = UDim.new(0, 8)

        local UpcomingTitle = Instance.new("TextLabel", UpcomingHeader)
        UpcomingTitle.Size = UDim2.new(1, -10, 1, 0)
        UpcomingTitle.Position = UDim2.new(0, 10, 0, 0)
        UpcomingTitle.BackgroundTransparency = 1
        UpcomingTitle.Text = "🔮 UPCOMING WAVE"
        UpcomingTitle.TextColor3 = Color3.fromRGB(255, 200, 100)
        UpcomingTitle.Font = Enum.Font.GothamBold
        UpcomingTitle.TextSize = 12
        UpcomingTitle.TextXAlignment = Enum.TextXAlignment.Left

        -- DI SINI DIUBAH: Dibuat lebih tinggi (40) agar muat 3 baris teks
        local WaveInfoLabel = Instance.new("TextLabel", MainFrame)
        WaveInfoLabel.Size = UDim2.new(1, -20, 0, 40)
        WaveInfoLabel.Position = UDim2.new(0, 10, 0, 30)
        WaveInfoLabel.BackgroundTransparency = 1
        WaveInfoLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
        WaveInfoLabel.Font = Enum.Font.GothamSemibold
        WaveInfoLabel.TextSize = 10
        WaveInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
        WaveInfoLabel.TextYAlignment = Enum.TextYAlignment.Top
        WaveInfoLabel.RichText = true

        -- DI SINI DIUBAH: ScrollFrame diturunkan posisinya karena teks info wave lebih tinggi
        local UpcomingScroll = Instance.new("ScrollingFrame", MainFrame)
        UpcomingScroll.Size = UDim2.new(1, -10, 0, 140)
        UpcomingScroll.Position = UDim2.new(0, 5, 0, 72)
        UpcomingScroll.BackgroundTransparency = 1
        UpcomingScroll.ScrollBarThickness = 2
        Instance.new("UIListLayout", UpcomingScroll).Padding = UDim.new(0, 2)

        local Divider = Instance.new("Frame", MainFrame)
        Divider.Size = UDim2.new(1, -20, 0, 2)
        Divider.Position = UDim2.new(0, 10, 0, 215)
        Divider.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        Divider.BorderSizePixel = 0

        local LiveHeader = Instance.new("Frame", MainFrame)
        LiveHeader.Size = UDim2.new(1, 0, 0, 28)
        LiveHeader.Position = UDim2.new(0, 0, 0, 225)
        LiveHeader.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        LiveHeader.BackgroundTransparency = 0.3
        Instance.new("UICorner", LiveHeader).CornerRadius = UDim.new(0, 8)

        local LiveTitle = Instance.new("TextLabel", LiveHeader)
        LiveTitle.Size = UDim2.new(1, -10, 1, 0)
        LiveTitle.Position = UDim2.new(0, 10, 0, 0)
        LiveTitle.BackgroundTransparency = 1
        LiveTitle.Text = "📡 LIVE THREAT RADAR"
        LiveTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        LiveTitle.Font = Enum.Font.GothamBold
        LiveTitle.TextSize = 12
        LiveTitle.TextXAlignment = Enum.TextXAlignment.Left

        local LiveScroll = Instance.new("ScrollingFrame", MainFrame)
        LiveScroll.Size = UDim2.new(1, -10, 1, -260)
        LiveScroll.Position = UDim2.new(0, 5, 0, 255)
        LiveScroll.BackgroundTransparency = 1
        LiveScroll.ScrollBarThickness = 2
        Instance.new("UIListLayout", LiveScroll).Padding = UDim.new(0, 6)

        return LiveScroll, UpcomingScroll, UpcomingTitle, WaveInfoLabel
    end

    local function CreateUpcomingEntry(parent, text, color)
        local Entry = Instance.new("TextLabel", parent)
        Entry.Size = UDim2.new(1, -5, 0, 18)
        Entry.BackgroundTransparency = 1
        Entry.Text = text
        Entry.TextColor3 = color
        Entry.Font = Enum.Font.Gotham
        Entry.TextSize = 11
        Entry.TextXAlignment = Enum.TextXAlignment.Left
        Entry.RichText = true
    end

    local function CreateGroupCard(groupName, parent)
        local Card = Instance.new("Frame", parent)
        Card.Size = UDim2.new(1, 0, 0, 40)
        Card.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        Card.BackgroundTransparency = 0.5
        Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 6)

        local Title = Instance.new("TextLabel", Card)
        Title.Size = UDim2.new(1, -10, 0, 18)
        Title.Position = UDim2.new(0, 8, 0, 2)
        Title.BackgroundTransparency = 1
        Title.TextColor3 = Color3.fromRGB(220, 220, 220)
        Title.Font = Enum.Font.GothamSemibold
        Title.TextSize = 11
        Title.TextXAlignment = Enum.TextXAlignment.Left

        local PillContainer = Instance.new("Frame", Card)
        PillContainer.Size = UDim2.new(1, -12, 1, -22)
        PillContainer.Position = UDim2.new(0, 6, 0, 20)
        PillContainer.BackgroundTransparency = 1
        
        local Grid = Instance.new("UIGridLayout", PillContainer)
        Grid.CellSize = UDim2.new(0, 48, 0, 16)
        Grid.CellPadding = UDim2.new(0, 4, 0, 4)
        Grid.SortOrder = Enum.SortOrder.LayoutOrder

        GroupCards[groupName] = { Card = Card, Title = Title, Container = PillContainer }
        return GroupCards[groupName]
    end

    local function CreatePill(enemyObj, parentContainer)
        local PillBg = Instance.new("Frame", parentContainer)
        PillBg.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
        Instance.new("UICorner", PillBg).CornerRadius = UDim.new(0, 4)

        local TargetStroke = Instance.new("UIStroke", PillBg)
        TargetStroke.Color = Color3.fromRGB(255, 50, 50)
        TargetStroke.Thickness = 1.5
        TargetStroke.Transparency = 1 

        local HPFill = Instance.new("Frame", PillBg)
        HPFill.Size = UDim2.new(1, 0, 1, 0)
        HPFill.BackgroundColor3 = Color3.fromRGB(235, 50, 50)
        HPFill.ZIndex = 1
        Instance.new("UICorner", HPFill).CornerRadius = UDim.new(0, 4)

        local ShieldFill = Instance.new("Frame", PillBg)
        ShieldFill.Size = UDim2.new(0, 0, 1, 0)
        ShieldFill.BackgroundColor3 = Color3.fromRGB(40, 160, 255)
        ShieldFill.ZIndex = 2
        ShieldFill.Visible = false
        Instance.new("UICorner", ShieldFill).CornerRadius = UDim.new(0, 4)

        local HitOverlay = Instance.new("Frame", PillBg)
        HitOverlay.Size = UDim2.new(1, 0, 1, 0)
        HitOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        HitOverlay.Transparency = 1
        HitOverlay.ZIndex = 3
        Instance.new("UICorner", HitOverlay).CornerRadius = UDim.new(0, 4)

        local HPText = Instance.new("TextLabel", PillBg)
        HPText.Size = UDim2.new(1, 0, 1, 0)
        HPText.BackgroundTransparency = 1
        HPText.TextColor3 = Color3.fromRGB(255, 255, 255)
        HPText.Font = Enum.Font.GothamBold
        HPText.TextSize = 10
        HPText.ZIndex = 4

        EnemyPills[enemyObj] = { Pill = PillBg, HPFill = HPFill, ShieldFill = ShieldFill, HitOverlay = HitOverlay, TargetStroke = TargetStroke, Text = HPText, LastHP = 0, LastShield = 0 }
        return EnemyPills[enemyObj]
    end

    Misc:Toggle({
        Title = "Advanced Enemy Radar",
        Desc = "Displays Upcoming Waves and Live Enemy Tracker",
        Value = Globals.EnemyTracker or false,
        Callback = function(v)
            Globals.EnemyTracker = v
            SetSetting("EnemyTracker", v)

            if v then
                local LiveScroll, UpcomingScroll, UpcomingTitle, WaveInfoLabel = CreateTrackerUI()
                
                TrackerConnection = RunService.Heartbeat:Connect(function()
                    if not Globals.EnemyTracker then return end
                    
                    -- ==========================================
                    -- 1. UPDATE UPCOMING WAVE
                    -- ==========================================
                    local currentWave = GetFastWave()
                    if currentWave ~= LastProcessedWave then
                        LastProcessedWave = currentWave
                        local nextWaveNum = currentWave + 1
                        UpcomingTitle.Text = "🔮 UPCOMING WAVE (" .. nextWaveNum .. ")"
                        
                        for _, child in ipairs(UpcomingScroll:GetChildren()) do 
                            if child:IsA("TextLabel") then child:Destroy() end 
                        end

                        local modeDataModule, stateDiffName = GetModeDataModule()
                        
                        if modeDataModule then
                            local success, modeData = pcall(function() return require(modeDataModule) end)
                            
                            if success and type(modeData) == "table" and modeData.Waves then
                                
                                -- Fungsi Helper untuk Menghitung Uang & Bonus secara Aman
                                local function GetWaveEconomy(targetWave)
                                    local wCash, cBonus = 0, 0
                                    if targetWave > 0 then
                                        pcall(function()
                                            if modeData.ExtraOptions and type(modeData.ExtraOptions.WaveCash) == "function" then
                                                wCash = modeData.ExtraOptions.WaveCash(targetWave)
                                            else
                                                wCash = 200 + ((targetWave - 1) * 160)
                                            end
                                            if modeData.ExtraOptions and modeData.ExtraOptions.ClearBonus then
                                                cBonus = wCash * (modeData.ExtraOptions.ClearBonus.Percentage or 0.2)
                                            end
                                        end)
                                    end
                                    return math.floor(wCash), math.floor(cBonus)
                                end

                                -- Kalkulasi Uang Wave Sekarang & Wave Depan
                                local currCash, currBonus = GetWaveEconomy(currentWave)
                                local nextCash, nextBonus = GetWaveEconomy(nextWaveNum)
                                
                                -- Update Text UI (Dibuat bertumpuk agar rapi dan terbaca jelas)
                                WaveInfoLabel.Text = string.format(
                                    "<font color='#FFAA55'>Mode: %s</font>\n[W%d] Cash: $<font color='#88FF88'>%d</font> | Bonus: $<font color='#88FF88'>%d</font>\n[W%d] Cash: $<font color='#88FF88'>%d</font> | Bonus: $<font color='#88FF88'>%d</font>", 
                                    stateDiffName, 
                                    currentWave, currCash, currBonus,
                                    nextWaveNum, nextCash, nextBonus
                                )

                                -- Render List Musuh
                                local nextWaveData = modeData.Waves[nextWaveNum]
                                if nextWaveData and nextWaveData.WaveTimeline and nextWaveData.WaveTimeline.Enemies then
                                    for _, enemy in ipairs(nextWaveData.WaveTimeline.Enemies) do
                                        local eMods = ParseModifiers(enemy.Modifiers)
                                        local color = (eMods ~= "") and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(220, 220, 220)
                                        local text = string.format("<b>x%d %s</b> <font color=\"#888888\">(%.1fs)</font><font color=\"#ffaa55\">%s</font>", enemy.Amount or 1, enemy.Name or "Unknown", enemy.Delay or 0, eMods)
                                        CreateUpcomingEntry(UpcomingScroll, text, color)
                                    end
                                    UpcomingScroll.CanvasSize = UDim2.new(0, 0, 0, #nextWaveData.WaveTimeline.Enemies * 20)
                                else
                                    CreateUpcomingEntry(UpcomingScroll, "No more waves or MAX Wave reached.", Color3.fromRGB(150, 150, 150))
                                end
                            else
                                WaveInfoLabel.Text = "Error: Failed to read module data"
                                CachedModeModule = nil 
                                CreateUpcomingEntry(UpcomingScroll, "Data couldn't be loaded properly.", Color3.fromRGB(255, 80, 80))
                            end
                        else
                            WaveInfoLabel.Text = "Mode: " .. tostring(stateDiffName)
                            CreateUpcomingEntry(UpcomingScroll, "Waiting for wave data...", Color3.fromRGB(150, 150, 150))
                        end
                    end

                    -- ==========================================
                    -- 2. UPDATE LIVE ENEMY 
                    -- ==========================================
                    local EnemyGroups, ProcessedEnemies = {}, {}
                    local NPCs = workspace:FindFirstChild("NPCs")
                    
                    if NPCs then
                        for _, enemy in ipairs(NPCs:GetChildren()) do
                            local pointer = enemy:FindFirstChild("RootPointer")
                            if pointer and pointer.Value then
                                local state = pointer.Value
                                local health = state:GetAttribute("Health") or 0
                                
                                if health > 0 then
                                    local name = enemy.Name:gsub("Enemy$", "")
                                    local shield = state:GetAttribute("Shield") or 0
                                    local maxHP = state:GetAttribute("MaxHealth") or health
                                    local maxShield = state:GetAttribute("MaxShield") or shield

                                    if not EnemyGroups[name] then 
                                        EnemyGroups[name] = { Name = name, Count = 0, MaxHP_Sample = maxHP, Individuals = {} } 
                                    end
                                    
                                    EnemyGroups[name].Count = EnemyGroups[name].Count + 1
                                    table.insert(EnemyGroups[name].Individuals, { 
                                        Obj = enemy, 
                                        HP = health, 
                                        MaxHP = maxHP, 
                                        Shield = shield, 
                                        MaxShield = maxShield, 
                                        IsTargeted = (enemy == Globals.CurrentTargetModel) 
                                    })
                                    ProcessedEnemies[enemy] = true
                                end
                            end
                        end
                    end

                    local SortedGroups, ProcessedGroups = {}, {}
                    for _, gd in pairs(EnemyGroups) do table.insert(SortedGroups, gd) end
                    table.sort(SortedGroups, function(a, b) return a.MaxHP_Sample > b.MaxHP_Sample end)

                    for groupOrder, groupData in ipairs(SortedGroups) do
                        ProcessedGroups[groupData.Name] = true
                        local groupUI = GroupCards[groupData.Name] or CreateGroupCard(groupData.Name, LiveScroll)
                        groupUI.Card.Visible = true
                        groupUI.Card.LayoutOrder = groupOrder
                        groupUI.Title.Text = string.format("%s %s (x%d)", groupData.MaxHP_Sample > 10000 and "💀" or "👾", groupData.Name, groupData.Count)

                        table.sort(groupData.Individuals, function(a, b)
                            if a.IsTargeted ~= b.IsTargeted then return a.IsTargeted end
                            return a.HP > b.HP
                        end)

                        for pillOrder, indv in ipairs(groupData.Individuals) do
                            local pillUI = EnemyPills[indv.Obj] or CreatePill(indv.Obj, groupUI.Container)
                            pillUI.Pill.Visible = true
                            pillUI.Pill.LayoutOrder = pillOrder

                            if (pillUI.LastHP > 0 and indv.HP < pillUI.LastHP) or (pillUI.LastShield > 0 and indv.Shield < pillUI.LastShield) then
                                pillUI.HitOverlay.Transparency = 0
                                TweenService:Create(pillUI.HitOverlay, TweenInfo.new(0.3), {Transparency = 1}):Play()
                            end
                            pillUI.LastHP, pillUI.LastShield = indv.HP, indv.Shield

                            pillUI.TargetStroke.Transparency = indv.IsTargeted and 0 or 1
                            if indv.IsTargeted then 
                                pillUI.TargetStroke.Thickness = 1.5 + math.sin(os.clock() * 15) * 1 
                            end

                            pillUI.HPFill.Size = UDim2.new(math.clamp(indv.HP / math.max(1, indv.MaxHP), 0, 1), 0, 1, 0)

                            if indv.MaxShield > 0 and indv.Shield > 0 then
                                pillUI.ShieldFill.Visible = true
                                pillUI.ShieldFill.Size = UDim2.new(math.clamp(indv.Shield / indv.MaxShield, 0, 1), 0, 1, 0)
                                pillUI.Text.Text = string.format("🛡️ %s", FormatNumber(indv.Shield))
                                pillUI.Text.TextColor3 = Color3.fromRGB(180, 230, 255) 
                            else
                                pillUI.ShieldFill.Visible = false
                                pillUI.Text.Text = FormatNumber(indv.HP)
                                pillUI.Text.TextColor3 = Color3.fromRGB(255, 255, 255) 
                            end
                        end
                        groupUI.Card.Size = UDim2.new(1, 0, 0, 25 + (math.ceil(#groupData.Individuals / 4) * 20))
                    end

                    for enemyObj, pillUI in pairs(EnemyPills) do 
                        if not ProcessedEnemies[enemyObj] then 
                            pillUI.Pill:Destroy()
                            EnemyPills[enemyObj] = nil 
                        end 
                    end

                    for groupName, groupUI in pairs(GroupCards) do 
                        if not ProcessedGroups[groupName] then 
                            groupUI.Card:Destroy()
                            GroupCards[groupName] = nil 
                        end 
                    end
                end)
            else
                if TrackerConnection then TrackerConnection:Disconnect() end
                if TrackerUI then TrackerUI:Destroy() end
            end
        end
    })

    Misc:Toggle({
        Title = "Auto Collect Pickups",
        Desc = "Collects Logbooks + Snowballs",
        Value = Globals.AutoPickups,
        Callback = function(v)
            SetSetting("AutoPickups", v)
        end
    })

    Misc:Dropdown({
        Title = "Pickup Method",
        Desc = "",
        List = {"Pathfinding", "Instant"},
        Value = Globals.PickupMethod or "Pathfinding",
        Callback = function(choice)
            local selected = type(choice) == "table" and choice[1] or choice
            if not selected or selected == "" then
                selected = "Pathfinding"
            end
            SetSetting("PickupMethod", selected)
        end
    })

    Misc:Toggle({
        Title = "Claim Rewards",
        Desc = "Claims your playtime and uses spin tickets in Lobby",
        Value = Globals.ClaimRewards,
        Callback = function(v)
            SetSetting("ClaimRewards", v)
        end
    })

    Misc:Section({Title = "Target Visual"})
    Misc:Dropdown({
        Title = "Target Visual Type",
        Desc = "Applies to both Auto Gatling & Silent Aim",
        List = {"Highlight", "Tracer", "Both"},
        Value = Globals.TargetChamsType or "Highlight",
        Callback = function(choice)
            local selected = type(choice) == "table" and choice[1] or choice
            if not selected or selected == "" then selected = "Highlight" end
            Globals.TargetChamsType = selected
            SetSetting("TargetChamsType", selected)
        end
    })

    Misc:Toggle({
        Title = "Enable Target Visual",
        Value = Globals.TargetChamsEnabled, 
        Callback = function(state)
            Globals.TargetChamsEnabled = state
            SetSetting("TargetChamsEnabled", state) 
            
            if not state then
                ClearESP() -- INSTAN HILANG
            end
        end
    })

    Misc:Section({Title = "Auto Gatling Gun"})
    
    Misc:Dropdown({
        Title = "Auto Gatling Priority",
        Desc = "Choose target priority for Auto Gatling",
        List = {"First", "Last", "Strongest", "Close"}, -- Ditambah "Last"
        Value = Globals.AutoGatlingPriority or "First",
        Callback = function(choice)
            local selected = type(choice) == "table" and choice[1] or choice
            SetSetting("AutoGatlingPriority", selected)
        end
    })

    Misc:Textbox({
        Title = "Auto Cooldown:",
        Placeholder = "0.01",
        Value = tostring(Globals.AutoCooldown),
        ClearTextOnFocus = true,
        Callback = function(value)
            if tonumber(value) then
                Globals.AutoCooldown = tonumber(value)
                SetSetting("AutoCooldown", tonumber(value)) 
            end
        end
    })

    Misc:Textbox({
        Title = "Auto Multiply:",
        Placeholder = "1",
        Value = tostring(Globals.AutoMultiply),
        ClearTextOnFocus = true,
        Callback = function(value)
            if tonumber(value) then
                Globals.AutoMultiply = tonumber(value)
                SetSetting("AutoMultiply", tonumber(value)) 
            end
        end
    })

    Misc:Toggle({
        Title = "Enable Auto Gatling",
        Value = Globals.AutoGatling, 
        Callback = function(state)
            Globals.AutoGatling = state
            SetSetting("AutoGatling", state) 

            local function FireFPSAbility(isEnabled)
                pcall(function()
                    local towersFolder = workspace:FindFirstChild("Towers")
                    local defaultTroop = towersFolder and towersFolder:FindFirstChild("Default")
                    if defaultTroop then
                        local args = {
                            "Troops", "Abilities", "Activate",
                            { Troop = defaultTroop, Name = "FPS", Data = { enabled = isEnabled } }
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
                    end
                end)
            end

            if state then
                Window:Notify({ Title = "ADS", Desc = "Auto Gatling Enabled", Time = 3 })
                FireFPSAbility(true)

                task.spawn(function()
                    local network = game:GetService("ReplicatedStorage"):WaitForChild("Network")
                    local gatlingNetwork = network:WaitForChild("GatlingGun")
                    local fireRemote = gatlingNetwork:WaitForChild("RE:Fire")
                    local reloadRemote = gatlingNetwork:WaitForChild("RE:Reload")

                    while Globals.AutoGatling do
                        local myGatlingRep = nil
                        local towersFolder = workspace:FindFirstChild("Towers")
                        if towersFolder then
                            for _, tower in pairs(towersFolder:GetChildren()) do
                                local rep = tower:FindFirstChild("TowerReplicator")
                                if rep and rep:GetAttribute("OwnerId") == LocalPlayer.UserId and rep:GetAttribute("Name") == "Gatling Gun" then
                                    myGatlingRep = rep
                                    break
                                end
                            end
                        end

                        if myGatlingRep then
                            local currentAmmo = myGatlingRep:GetAttribute("Ammo")
                            local isReloading = myGatlingRep:GetAttribute("Reloading")

                            if (currentAmmo ~= nil and currentAmmo <= 0) or isReloading then
                                if not isReloading then pcall(function() reloadRemote:FireServer() end) end
                                task.wait(0.01)
                                continue 
                            end
                        end

                        -- Tembak ke target yang sudah dikunci oleh Sistem Radar (Globals.LockedTargetPosition)
                        if Globals.LockedTargetPosition then
                            for i = 1, Globals.AutoMultiply do
                                pcall(function()
                                    fireRemote:FireServer(Globals.LockedTargetPosition, workspace:GetAttribute("Sync"), workspace:GetServerTimeNow())
                                end)
                            end
                        end

                        task.wait(Globals.AutoCooldown or 0.05)
                    end
                end)
            else
                FireFPSAbility(false)
            end
        end
    })

    Misc:Section({Title = "Gatling Gun"})
    
    Globals.CustomGatlingApplied = false -- Tidak perlu di-save karena status running (sementara)

    local function EnsureGatlingHook()
        local success, gganim = pcall(function()
            return require(game.ReplicatedStorage.Content.Tower["Gatling Gun"].Animator)
        end)

        if not success or not gganim then return false end

        if not Globals.OriginalFireGun then
            Globals.OriginalFireGun = gganim._fireGun
        end

        gganim._fireGun = function(self)
            local TargetPosition = nil

            -- Ambil target dari Sistem Radar
            if Globals.SilentAimEnabled and Globals.LockedTargetPosition then
                TargetPosition = Globals.LockedTargetPosition
            end

            -- Jika target tidak ada / fitur mati, tembak lurus ngikutin crosshair player
            if not TargetPosition then
                local CameraController = require(game.ReplicatedStorage.Content.Tower["Gatling Gun"].Animator.CameraController)
                TargetPosition = CameraController.result and CameraController.result.Position or CameraController.position
            end

            if not TargetPosition then return end

            local isMinigun = self.Replicator:Get("Minigun")
            local canFire = self.Replicator:Get("CanFire")
            if not isMinigun and true or canFire then
                pcall(function() self:_fire(TargetPosition) end)
            end

            local GatlingChannel = require(game.ReplicatedStorage.Shared.Modules.NewNetwork).Channel("GatlingGun")
            local sync = workspace:GetAttribute("Sync")
            local serverTime = workspace:GetServerTimeNow()

            if Globals.CustomGatlingApplied then
                for i = 1, (Globals.Multiply or 1) do
                    GatlingChannel:fireServer("Fire", TargetPosition, sync, serverTime)
                end
                self:Wait(Globals.Cooldown or 0.01)
            else
                GatlingChannel:fireServer("Fire", TargetPosition, sync, serverTime)
                self:Wait(self:GetCooldown())
            end
        end

        return true
    end

    Misc:Dropdown({
        Title = "Silent Aim Priority",
        Desc = "Choose target priority for Silent Aim",
        List = {"First", "Last", "Strongest", "Close"}, -- Ditambah "Last"
        Value = Globals.TargetPriority, 
        Callback = function(choice)
            local selected = type(choice) == "table" and choice[1] or choice
            SetSetting("TargetPriority", selected)
        end
    })

    Misc:Toggle({
        Title = "Enable Silent Aim",
        Desc = "Magic bullets auto-hit enemies.",
        Value = Globals.SilentAimEnabled, 
        Callback = function(state)
            Globals.SilentAimEnabled = state
            SetSetting("SilentAimEnabled", state)
            
            if not state then
                ClearESP() -- INSTAN HILANG JIKA DIMATIKAN
            end
            
            local hooked = EnsureGatlingHook()
            if not hooked and state then
                Window:Notify({Title = "Error", Desc = "Equip Gatling Gun first!", Time = 3, Type = "error"})
                SetSetting("SilentAimEnabled", false)
                Globals.SilentAimEnabled = false
            else
                Window:Notify({Title = "Silent Aim", Desc = state and "Activated!" or "Deactivated!", Time = 3, Type = "normal"})
            end
        end
    })

    Misc:Textbox({
        Title = "Cooldown:",
        Placeholder = "0.01",
        Value = tostring(Globals.Cooldown),
        ClearTextOnFocus = true,
        Callback = function(value)
            local num = tonumber(value)
            if num then
                SetSetting("Cooldown", num)
            end
        end
    })

    Misc:Textbox({
        Title = "Multiply:",
        Placeholder = "1",
        Value = tostring(Globals.Multiply),
        ClearTextOnFocus = true,
        Callback = function(value)
            local num = tonumber(value)
            if num then
                SetSetting("Multiply", num)
            end
        end
    })

    Misc:Button({
        Title = "Apply Gatling",
        Callback = function()
            Globals.CustomGatlingApplied = true
            local hooked = EnsureGatlingHook()
            if hooked then
                Window:Notify({ Title = "ADS", Desc = "Successfully applied Custom Cooldown & Multiply!", Time = 3, Type = "normal" })
            else
                Window:Notify({ Title = "Error", Desc = "Equip Gatling Gun first!", Time = 3, Type = "error" })
            end
        end
    })

    Misc:Button({
        Title = "Reset Gatling",
        Callback = function()
            Globals.CustomGatlingApplied = false
            Window:Notify({ Title = "ADS", Desc = "Gatling speed & multiply reset to normal!", Time = 3, Type = "normal" })
        end
    })

    Misc:Section({Title = "Experimental"})
    Misc:Toggle({
        Title = "Sticker Spam",
        Desc = "This will drop everyones FPS to like 5 (you will not be able to see this unless you have an alt)",
        Value = false,
        Callback = function(v)
            StickerSpam = v

            if StickerSpam then
                task.spawn(function()
                    while StickerSpam do
                        for i = 1, 9999 do
                            if not StickerSpam then break end

                            local args = {"Flex"}
                            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Sticker"):WaitForChild("URE:Show"):FireServer(unpack(args))
                        end
                        task.wait()
                    end
                end)
            end
        end
    })

    Misc:Toggle({
        Title = "Party Invite Spam (Lobby)",
        Desc = "Spam invites to everyone in the lobby (Warning: annoying!)",
        Value = false,
        Callback = function(state)
            Globals.PartySpamEnabled = state
            
            if state then
                -- Fitur ini hanya bisa dipakai di LOBBY
                if GameState ~= "LOBBY" then
                    Window:Notify({
                        Title = "Error",
                        Desc = "You can only use this feature in the Lobby!",
                        Time = 3,
                        Type = "error"
                    })
                    Globals.PartySpamEnabled = false
                    return
                end

                Window:Notify({Title = "ADS", Desc = "Party Spam Enabled!", Time = 3, Type = "normal"})
                
                task.spawn(function()
                    local plrs = game:GetService("Players")
                    local rfunc = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
                    
                    while Globals.PartySpamEnabled do
                        pcall(function()
                            -- Buat Party
                            rfunc:InvokeServer("Party", "CreateParty")
                            
                            -- Invite semua orang
                            for _, plr in ipairs(plrs:GetPlayers()) do
                                if plr ~= plrs.LocalPlayer then
                                    rfunc:InvokeServer("Party", "InvitePlayer", plr)
                                end
                            end
                            
                            -- Keluar Party
                            rfunc:InvokeServer("Party", "LeaveParty")
                        end)
                        task.wait(0.2) -- Diberi delay 0.2 agar kamu tidak kena kick "Error 268" dari server
                    end
                end)
            end
        end
    })

    Misc:Button({
        Title = "Open Inventory",
        Desc = "Open Inventory",
        Callback = function()
            local RS = game:GetService("ReplicatedStorage")

            -- 1. Memberi tahu server bahwa kita membuka inventory (Sama seperti fungsi aslinya)
            pcall(function()
                local NewNetwork = require(RS.Shared.Modules.NewNetwork)
                NewNetwork.Channel("Inventory"):fireUnreliableServer("OpenInventory")
            end)

            -- 2. Memaksa UI Client untuk Muncul di Layar
            local foundStore = false
            for _, module in ipairs(getloadedmodules()) do
                -- Mencari module "View" yang ada di dalam folder "Stores"
                if module.Name == "View" and module.Parent and module.Parent.Name == "Stores" then
                    local Store = require(module)
                    
                    -- Mengubah tampilan layar langsung ke Inventory (Bypass fungsi setView)
                    Store:commit("setView", "Inventory")
                    foundStore = true
                    print("Berhasil membuka UI Inventory secara paksa!")
                    break
                end
            end

            if not foundStore then
                warn("Gagal menemukan Module Store UI. Pastikan game sudah loading sepenuhnya.")
            end
        end
    })

    Misc:Button({
        Title = "Unlock Admin+ (Sandbox)",
        Desc = "Keep in mind that some features such as selecting maps, spawning in enemies and changing tower stats will not work!",
        Callback = function()
            if GameState == "GAME" then
                local args = {
                    game.Players.LocalPlayer.UserId,
                    true
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Sandbox"):WaitForChild("RE:SetAdmin"):FireServer(unpack(args))

                Window:Notify({
                    Title = "ADS",
                    Desc = "Successfully unlocked Admin+ Mode!",
                    Time = 3,
                    Type = "normal"
                })
            else
                Window:Notify({
                    Title = "ADS",
                    Desc = "You must be in Sandbox mode for this to work!",
                    Time = 3,
                    Type = "normal"
                })
            end
        end
    })
end

Window:Line()

local Logger

local Logger = Window:Tab({Title = "Logger", Icon = "notebook-pen"}) do
    Logger = Logger:CreateLogger({
        Title = "STRATEGY LOGGER:",
        Size = UDim2.new(0, 330, 0, 300)
    })
end

Window:Line()

local RecorderInit = loadstring(game:HttpGet("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Sources/Recorder.lua"))()
if type(RecorderInit) == "function" then
    RecorderInit({
        Window = Window,
        ReplicatedStorage = ReplicatedStorage,
        LocalPlayer = LocalPlayer,
        HttpService = HttpService,
        GameState = GameState,
        workspace = workspace
    })
end

Window:Line()

local Settings = Window:Tab({Title = "Settings", Icon = "settings"}) do
    Settings:Section({Title = "Settings"})
    Settings:Button({
        Title = "Save Settings",
        Callback = function()
            Window:Notify({
                    Title = "ADS",
                    Desc = "Settings Saved!",
                    Time = 3,
                    Type = "normal"
                })
            LoadSettings()
        end
    })

    Settings:Button({
        Title = "Load Settings",
        Callback = function()
            Window:Notify({
                    Title = "ADS",
                    Desc = "Settings Loaded!",
                    Time = 3,
                    Type = "normal"
                })
            SaveSettings()
        end
    })

    Settings:Section({Title = "Privacy"})
    Settings:Toggle({
        Title = "Hide Username",
        Desc = "",
        Value = Globals.HideUsername,
        Callback = function(v)
            SetSetting("HideUsername", v)
            UpdatePrivacyState()
        end
    })

    Settings:Textbox({
        Title = "Streamer Name",
        Desc = "",
        Placeholder = "Spoof Name",
        Value = Globals.StreamerName or "",
        ClearTextOnFocus = false,
        Callback = function(value)
            SetSetting("StreamerName", value or "")
            UpdatePrivacyState()
        end
    })

    Settings:Toggle({
        Title = "Streamer Mode",
        Desc = "",
        Value = Globals.StreamerMode,
        Callback = function(v)
            SetSetting("StreamerMode", v)
            UpdatePrivacyState()
        end
    })

    Settings:Section({Title = "Tags"})
    local tagOptions = collectTagOptions()
    local tagValue = Globals.tagName or "None"
    if not table.find(tagOptions, tagValue) then
        tagValue = "None"
    end
    Settings:Dropdown({
        Title = "Tag Changer",
        Desc = "",
        List = tagOptions,
        Value = tagValue,
        Callback = function(choice)
            local selected = choice
            if type(choice) == "table" then
                selected = choice[1]
            end
            if not selected or selected == "" then
                selected = "None"
            end
            SetSetting("tagName", selected)
            if selected == "None" then
                stopTagChanger()
            else
                startTagChanger()
            end
        end
    })

    Settings:Section({Title = "Webhook"})
    Settings:Toggle({
        Title = "Send Webhook",
        Desc = "",
        Value = Globals.SendWebhook,
        Callback = function(v)
            SetSetting("SendWebhook", v)
        end
    })

    Settings:Button({
        Title = "Test Webhook",
        Callback = function()
            if not Globals.WebhookURL or Globals.WebhookURL == "" then
                return Window:Notify({Title = "Error", Desc = "Webhook URL is empty!", Time = 3, Type = "error"})
            end

            local success, response = pcall(function()
                return SendRequest({
                    Url = Globals.WebhookURL,
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = game:GetService("HttpService"):JSONEncode({["content"] = "Webhook Test"})
                })
            end)

            if success and response.StatusCode >= 200 and response.StatusCode < 300 then
                Window:Notify({
                    Title = "ADS",
                    Desc = "Webhook sent successfully and is working!",
                    Time = 3,
                    Type = "normal"
                })
            else
                Window:Notify({
                    Title = "Error",
                    Desc = "Invalid Webhook, Discord returned an error.",
                    Time = 5,
                    Type = "error"
                })
            end
        end
    })

    Settings:Textbox({
        Title = "Webhook URL:",
        Desc = "",
        Placeholder = "https://discord.com/api/webhooks/...",
        Value = Globals.WebhookURL,
        ClearTextOnFocus = true,
        Callback = function(value)
            if value ~= "" and value:find("https://discord.com/api/webhooks/") then
                SetSetting("WebhookURL", value)

                Window:Notify({
                    Title = "ADS",
                    Desc = "Webhook is successfully set!",
                    Time = 3,
                    Type = "normal"
                })
            else
                Window:Notify({
                    Title = "ADS",
                    Desc = "Invalid Webhook URL!",
                    Time = 3,
                    Type = "normal"
                })
            end
        end
    })
end

RunService.RenderStepped:Connect(function()
    if StackEnabled then
        if not StackSphere then
            StackSphere = Instance.new("Part")
            StackSphere.Shape = Enum.PartType.Ball
            StackSphere.Size = Vector3.new(1.5, 1.5, 1.5)
            StackSphere.Color = Color3.fromRGB(0, 255, 0)
            StackSphere.Transparency = 0.5
            StackSphere.Anchored = true
            StackSphere.CanCollide = false
            StackSphere.Material = Enum.Material.Neon
            StackSphere.Parent = workspace
            mouse.TargetFilter = StackSphere
        end
        local hit = mouse.Hit
        if hit then StackSphere.Position = hit.Position end
    elseif StackSphere then
        StackSphere:Destroy()
        StackSphere = nil
    end

    UpdatePathVisuals()
end)

mouse.Button1Down:Connect(function()
    if StackEnabled and StackSphere and SelectedTower then
        local pos = StackSphere.Position
        local newpos = Vector3.new(pos.X, pos.Y + 25, pos.Z)
        RemoteFunc:InvokeServer("Troops", "Pl\208\176ce", {Rotation = CFrame.new(), Position = newpos}, SelectedTower)
    end
end)

-- // currency tracking
local StartCoins, CurrentTotalCoins, StartGems, CurrentTotalGems = 0, 0, 0, 0
if GameState == "GAME" then
    pcall(function()
        repeat task.wait(1) until LocalPlayer:FindFirstChild("Coins")
        StartCoins = LocalPlayer.Coins.Value
        CurrentTotalCoins = StartCoins
        StartGems = LocalPlayer.Gems.Value
        CurrentTotalGems = StartGems
    end)
end

-- // check if remote returned valid
local function CheckResOk(data)
    if data == true then return true end
    if type(data) == "table" and data.Success == true then return true end

    local success, IsModel = pcall(function()
        return data and data:IsA("Model")
    end)

    if success and IsModel then return true end
    if type(data) == "userdata" then return true end

    return false
end

-- // scrap ui for match data
local function GetAllRewards()
    local results = {
        Coins = 0, 
        Gems = 0, 
        XP = 0, 
        Wave = 0,
        Level = 0,
        Time = "00:00",
        Status = "UNKNOWN",
        Others = {} 
    }

    local UiRoot = PlayerGui:FindFirstChild("ReactGameNewRewards")
    local MainFrame = UiRoot and UiRoot:FindFirstChild("Frame")
    local GameOver = MainFrame and MainFrame:FindFirstChild("gameOver")
    local RewardsScreen = GameOver and GameOver:FindFirstChild("RewardsScreen")

    local GameStats = RewardsScreen and RewardsScreen:FindFirstChild("gameStats")
    local StatsList = GameStats and GameStats:FindFirstChild("stats")

    if StatsList then
        for _, frame in ipairs(StatsList:GetChildren()) do
            local l1 = frame:FindFirstChild("textLabel")
            local l2 = frame:FindFirstChild("textLabel2")
            if l1 and l2 and l1.Text:find("Time Completed:") then
                results.Time = l2.Text
                break
            end
        end
    end

    local TopBanner = RewardsScreen and RewardsScreen:FindFirstChild("RewardBanner")
    if TopBanner and TopBanner:FindFirstChild("textLabel") then
        local txt = TopBanner.textLabel.Text:upper()
        results.Status = txt:find("TRIUMPH") and "WIN" or (txt:find("LOST") and "LOSS" or "UNKNOWN")
    end

    local LevelValue = LocalPlayer.Level
    if LevelValue then
        results.Level = LevelValue.Value or 0
    end

    local label = PlayerGui:WaitForChild("ReactGameTopGameDisplay").Frame.wave.container.value
    local WaveNum = label.Text:match("^(%d+)")

    if WaveNum then
        results.Wave = tonumber(WaveNum) or 0
    end

    local SectionRewards = RewardsScreen and RewardsScreen:FindFirstChild("RewardsSection")
    if SectionRewards then
        for _, item in ipairs(SectionRewards:GetChildren()) do
            if tonumber(item.Name) then 
                local IconId = "0"
                local img = item:FindFirstChildWhichIsA("ImageLabel", true)
                if img then IconId = img.Image:match("%d+") or "0" end

                for _, child in ipairs(item:GetDescendants()) do
                    if child:IsA("TextLabel") then
                        local text = child.Text
                        local amt = tonumber(text:match("(%d+)")) or 0

                        if text:find("Coins") then
                            results.Coins = amt
                        elseif text:find("Gems") then
                            results.Gems = amt
                        elseif text:find("XP") then
                            results.XP = amt
                        elseif text:lower():find("x%d+") then 
                            local displayName = ItemNames[IconId] or "Unknown Item (" .. IconId .. ")"
                            table.insert(results.Others, {Amount = text:match("x%d+"), Name = displayName})
                        end
                    end
                end
            end
        end
    end

    return results
end

-- // rejoining
local function RejoinMatch()
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
    local success = false
    local res

    repeat
        local StateFolder = ReplicatedStorage:FindFirstChild("State")
        local CurrentMode = StateFolder and StateFolder.Difficulty.Value

        if CurrentMode then
            local ok, result = pcall(function()
                local payload

                if CurrentMode == "PizzaParty" then
                    payload = { mode = "halloween", count = 1 }
                elseif CurrentMode == "Hardcore" then
                    payload = { mode = "hardcore", count = 1 }
                elseif CurrentMode == "PollutedWasteland" then
                    payload = { mode = "polluted", count = 1 }
                elseif CurrentMode == "Badlands" then
                    payload = { mode = "badlands", count = 1 }
                else
                    payload = { difficulty = CurrentMode, mode = "survival", count = 1 }
                end

                return remote:InvokeServer("Multiplayer", "v2:start", payload)
            end)

            if ok and CheckResOk(result) then
                success = true
                res = result
            else
                task.wait(0.5) 
            end
        else
            task.wait(1)
        end
    until success

    return res
end

local function HandlePostMatch()
    local UiRoot
    repeat
        task.wait(1)

        local root = PlayerGui:FindFirstChild("ReactGameNewRewards")
        local frame = root and root:FindFirstChild("Frame")
        local gameOver = frame and frame:FindFirstChild("gameOver")
        local RewardsScreen = gameOver and gameOver:FindFirstChild("RewardsScreen")
        UiRoot = RewardsScreen and RewardsScreen:FindFirstChild("RewardsSection")
    until UiRoot

    if not UiRoot then return RejoinMatch() end
    if not Globals.AutoRejoin then return end

    if not Globals.SendWebhook then
        RejoinMatch()
        return
    end

    task.wait(1)

    local match = GetAllRewards()

    CurrentTotalCoins += match.Coins
    CurrentTotalGems += match.Gems

    local BonusString = ""
    if #match.Others > 0 then
        for _, res in ipairs(match.Others) do
            BonusString = BonusString .. "🎁 **" .. res.Amount .. " " .. res.Name .. "**\n"
        end
    else
        BonusString = "_No bonus rewards found._"
    end

    local PostData = {
        username = "TDS AutoStrat",
        embeds = {{
            title = (match.Status == "WIN" and "🏆 TRIUMPH" or "💀 DEFEAT"),
            color = (match.Status == "WIN" and 0x2ecc71 or 0xe74c3c),
            description =
                "### 📋 Match Overview\n" ..
                "> **Status:** `" .. match.Status .. "`\n" ..
                "> **Time:** `" .. match.Time .. "`\n" ..
                "> **Current Level:** `" .. match.Level .. "`\n" ..
                "> **Wave:** `" .. match.Wave .. "`\n",

            fields = {
                {
                    name = "✨ Rewards",
                    value = "```ansi\n" ..
                            " [2;33mCoins: [0m +" .. match.Coins .. "\n" ..
                            " [2;34mGems:  [0m +" .. match.Gems .. "\n" ..
                            " [2;32mXP:    [0m +" .. match.XP .. "```",
                    inline = false
                },
                {
                    name = "🎁 Bonus Items",
                    value = BonusString,
                    inline = true
                },
                {
                    name = "📊 Session Totals",
                    value = "```py\n# Total Amount\nCoins: " .. CurrentTotalCoins .. "\nGems:  " .. CurrentTotalGems .. "```",
                    inline = true
                }
            },
            footer = { text = "Logged for " .. LocalPlayer.Name .. " • TDS AutoStrat" },
            timestamp = DateTime.now():ToIsoDate()
        }}
    }

    pcall(function()
        SendRequest({
            Url = Globals.WebhookURL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = game:GetService("HttpService"):JSONEncode(PostData)
        })
    end)

    task.wait(1.5)

    RejoinMatch()
end

-- // voting & map selection
local function RunVoteSkip()
    while true do
        local success = pcall(function()
            RemoteFunc:InvokeServer("Voting", "Skip")
        end)
        if success then break end
        task.wait(0.2)
    end
end

local function MatchReadyUp()
    local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local UiOverrides = PlayerGui:WaitForChild("ReactOverridesVote", 30)
    local MainFrame = UiOverrides and UiOverrides:WaitForChild("Frame", 30)

    if not MainFrame then
        return
    end

    local VoteReady = nil

    while not VoteReady do
        local VoteNode = MainFrame:FindFirstChild("votes")

        if VoteNode then
            local container = VoteNode:FindFirstChild("container")
            if container then
                local ready = container:FindFirstChild("ready")
                if ready then
                    VoteReady = ready
                end
            end
        end

        if not VoteReady then
            task.wait(0.5) 
        end
    end

    repeat task.wait(0.1) until VoteReady.Visible == true

    RunVoteSkip()
end

local function CastMapVote(MapId, PosVec)
    local TargetMap = MapId or "Simplicity"
    local TargetPos = PosVec or Vector3.new(0,0,0)
    RemoteEvent:FireServer("LobbyVoting", "Vote", TargetMap, TargetPos)
    if Logger then Logger:Log("Cast map vote: " .. TargetMap) end
end

local function LobbyReadyUp()
    pcall(function()
        RemoteEvent:FireServer("LobbyVoting", "Ready")
        if Logger then Logger:Log("Lobby ready up sent") end
    end)
end

local function SelectMapOverride(MapId, ...)
    local args = {...}

    if args[#args] == "vip" then
        RemoteFunc:InvokeServer("LobbyVoting", "Override", MapId)
    end

    task.wait(3)
    CastMapVote(MapId, Vector3.new(12.59, 10.64, 52.01))
    task.wait(1)
    LobbyReadyUp()
    MatchReadyUp()
end

local function CastModifierVote(ModsTable)
    local BulkModifiers = ReplicatedStorage:WaitForChild("Network"):WaitForChild("Modifiers"):WaitForChild("RF:BulkVoteModifiers")

    local SelectedMods = {}

    if ModsTable and #ModsTable > 0 then
        for _, modName in ipairs(ModsTable) do
            SelectedMods[modName] = true
        end
    end

    pcall(function()
        BulkModifiers:InvokeServer(SelectedMods)
        if Logger then Logger:Log("Successfully casted modifier votes.") end
    end)
end

local function IsMapAvailable(name)
    for _, g in ipairs(workspace:GetDescendants()) do
        if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
            local t = g:FindFirstChild("Title")
            if t and t.Text == name then return true end
        end
    end

repeat
        local IntermissionFrame = PlayerGui:WaitForChild("ReactGameIntermission"):WaitForChild("Frame")
        local VetoText = IntermissionFrame:WaitForChild("buttons"):WaitForChild("veto"):WaitForChild("value").Text
        
        if IntermissionFrame.Visible and VetoText:match("Veto %(0/") then 
            RemoteEvent:FireServer("LobbyVoting", "Veto") 
        end
        
        wait(1)

        local found = false
        for _, g in ipairs(workspace:GetDescendants()) do
            if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
                local t = g:FindFirstChild("Title")
                if t and t.Text == name then
                    found = true
                    break
                end
            end
        end

        local TotalPlayer = #PlayersService:GetChildren()

    until found or VetoText == "Veto ("..TotalPlayer.."/"..TotalPlayer..")"

    for _, g in ipairs(workspace:GetDescendants()) do
        if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
            local t = g:FindFirstChild("Title")
            if t and t.Text == name then return true end
        end
    end

    return false
end

-- // timescale logic
local function SetGameTimescale(TargetVal)
    if GameState ~= "GAME" then 
        return false 
    end

    local SpeedList = {0, 0.5, 1, 1.5, 2}

    local TargetIdx
    for i, v in ipairs(SpeedList) do
        if v == TargetVal then
            TargetIdx = i
            break
        end
    end
    if not TargetIdx then return end

    local SpeedLabel = game.Players.LocalPlayer.PlayerGui.ReactUniversalHotbar.Frame.timescale.Speed

    local CurrentVal = tonumber(SpeedLabel.Text:match("x([%d%.]+)"))
    if not CurrentVal then return end

    local CurrentIdx
    for i, v in ipairs(SpeedList) do
        if v == CurrentVal then
            CurrentIdx = i
            break
        end
    end
    if not CurrentIdx then return end

    local diff = TargetIdx - CurrentIdx
    if diff < 0 then
        diff = #SpeedList + diff
    end

    for _ = 1, diff do
        ReplicatedStorage.RemoteFunction:InvokeServer(
            "TicketsManager",
            "CycleTimeScale"
        )
        task.wait(0.5)
    end
end

local function UnlockSpeedTickets()
    if GameState ~= "GAME" then 
        return false 
    end

    if LocalPlayer.TimescaleTickets.Value >= 1 then
        if game.Players.LocalPlayer.PlayerGui.ReactUniversalHotbar.Frame.timescale.Lock.Visible then
            ReplicatedStorage.RemoteFunction:InvokeServer('TicketsManager', 'UnlockTimeScale')
            if Logger then Logger:Log("Unlocked timescale tickets") end
        end
    else
        if Logger then Logger:Log("No timescale tickets left") end
    end
end

ApplyTimeScaleOnce = function()
    if not Globals.TimeScaleEnabled or GameState ~= "GAME" then
        return
    end

    local frame = GetTimescaleFrame()
    if not frame or not frame.Visible then
        return
    end

    local desired = CoerceTimeScaleValue(Globals.TimeScaleValue, 2)
    if not desired then
        return
    end

    local lock = frame:FindFirstChild("Lock")
    if lock and lock.Visible then
        if LocalPlayer.TimescaleTickets.Value < 1 then
            if not TimeScaleNoTicketsWarned then
                if Logger then Logger:Log("No timescale tickets left") end
                TimeScaleNoTicketsWarned = true
            end
            return
        end
        UnlockSpeedTickets()
        task.wait(0.4)
    else
        TimeScaleNoTicketsWarned = false
    end

    SetGameTimescale(desired)
end

StartTimeScale = function()
    if TimeScaleRunning or not Globals.TimeScaleEnabled then
        return
    end
    TimeScaleRunning = true

    task.spawn(function()
        while Globals.TimeScaleEnabled do
            ApplyTimeScaleOnce()
            task.wait(3)
        end
        TimeScaleNoTicketsWarned = false
        TimeScaleRunning = false
    end)
end

-- // ingame control
local function TriggerRestart()
    local UiRoot = PlayerGui:WaitForChild("ReactGameNewRewards")
    local FoundSection = false

    repeat
        task.wait(0.3)
        local f = UiRoot:FindFirstChild("Frame")
        local g = f and f:FindFirstChild("gameOver")
        local s = g and g:FindFirstChild("RewardsScreen")
        if s and s:FindFirstChild("RewardsSection") then
            FoundSection = true
        end
    until FoundSection

    task.wait(3)
    RunVoteSkip()
end

local function GetCurrentWave()
    local label

    repeat
        task.wait(0.5)
        label = PlayerGui:FindFirstChild("ReactGameTopGameDisplay", true) 
            and PlayerGui.ReactGameTopGameDisplay.Frame.wave.container:FindFirstChild("value")
    until label ~= nil

    local text = label.Text
    local WaveNum = text:match("(%d+)")

    return tonumber(WaveNum) or 0
end

local function DoPlaceTower(TName, TPos)
    if Logger then Logger:Log("Placing tower: " .. TName) end
    while true do
        local ok, res = pcall(function()
            return RemoteFunc:InvokeServer("Troops", "Pl\208\176ce", {
                Rotation = CFrame.new(),
                Position = TPos
            }, TName)
        end)

        if ok and CheckResOk(res) then return true end
        task.wait(0.25)
    end
end

local function DoUpgradeTower(TObj, PathId)
    while true do
        local ok, res = pcall(function()
            return RemoteFunc:InvokeServer("Troops", "Upgrade", "Set", {
                Troop = TObj,
                Path = PathId
            })
        end)
        if ok and CheckResOk(res) then return true end
        task.wait(0.25)
    end
end

local function DoSellTower(TObj)
    while true do
        local ok, res = pcall(function()
            return RemoteFunc:InvokeServer("Troops", "Sell", { Troop = TObj })
        end)
        if ok and CheckResOk(res) then return true end
        task.wait(0.25)
    end
end

local function DoSetOption(TObj, OptName, OptVal, ReqWave)
    if ReqWave then
        repeat task.wait(0.3) until GetCurrentWave() >= ReqWave
    end

    while true do
        local ok, res = pcall(function()
            return RemoteFunc:InvokeServer("Troops", "Option", "Set", {
                Troop = TObj,
                Name = OptName,
                Value = OptVal
            })
        end)
        if ok and CheckResOk(res) then return true end
        task.wait(0.25)
    end
end

local function DoActivateAbility(TObj, AbName, AbData, IsLooping)
    if type(AbData) == "boolean" then
        IsLooping = AbData
        AbData = nil
    end

    AbData = type(AbData) == "table" and AbData or nil

    local positions
    if AbData and type(AbData.towerPosition) == "table" then
        positions = AbData.towerPosition
    end

    local CloneIdx = AbData and AbData.towerToClone
    local TargetIdx = AbData and AbData.towerTarget

    local function attempt()
        while true do
            local ok, res = pcall(function()
                local data

                if AbData then
                    data = table.clone(AbData)

                    if positions and #positions > 0 then
                        data.towerPosition = positions[math.random(#positions)]
                    end

                    if type(CloneIdx) == "number" then
                        data.towerToClone = TDS.PlacedTowers[CloneIdx]
                    end

                    if type(TargetIdx) == "number" then
                        data.towerTarget = TDS.PlacedTowers[TargetIdx]
                    end
                end

                return RemoteFunc:InvokeServer(
                    "Troops",
                    "Abilities",
                    "Activate",
                    {
                        Troop = TObj,
                        Name = AbName,
                        Data = data
                    }
                )
            end)

            if ok and CheckResOk(res) then
                return true
            end

            task.wait(0.25)
        end
    end

    if IsLooping then
        local active = true
        task.spawn(function()
            while active do
                attempt()
                task.wait(1)
            end
        end)
        return function() active = false end
    end

    return attempt()
end

local function StartAutoPickups()
    if AutoPickupsRunning or not Globals.AutoPickups then return end
    AutoPickupsRunning = true

    task.spawn(function()
        while Globals.AutoPickups do
            local folder = workspace:FindFirstChild("Pickups")
            local hrp = GetRoot()

            if folder and hrp then
                local char = hrp.Parent
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                local function MoveToPos(TargetPos)
                    if not humanoid then
                        return false
                    end
                    local function MoveDirect(pos)
                        humanoid:MoveTo(pos)
                        local StartT = os.clock()
                        while os.clock() - StartT < 2 do
                            if not Globals.AutoPickups then
                                return false
                            end
                            if (hrp.Position - pos).Magnitude < 4 then
                                return true
                            end
                            task.wait(0.1)
                        end
                        return (hrp.Position - pos).Magnitude < 4
                    end
                    local path = PathfindingService:CreatePath({
                        AgentRadius = 2,
                        AgentHeight = 6,
                        AgentCanJump = true,
                        AgentJumpHeight = 7,
                        AgentMaxSlope = 45
                    })
                    local ok = pcall(function()
                        path:ComputeAsync(hrp.Position, TargetPos)
                    end)
                    if ok and path.Status == Enum.PathStatus.Success then
                        local waypoints = path:GetWaypoints()
                        local BlockedConn = nil
                        BlockedConn = path.Blocked:Connect(function()
                            if BlockedConn then
                                BlockedConn:Disconnect()
                            end
                            if Globals.AutoPickups then
                                task.spawn(function()
                                    MoveToPos(TargetPos)
                                end)
                            end
                        end)
                        for _, wp in ipairs(waypoints) do
                            if not Globals.AutoPickups then
                                if BlockedConn then
                                    BlockedConn:Disconnect()
                                end
                                return false
                            end
                            if wp.Action == Enum.PathWaypointAction.Jump then
                                humanoid.Jump = true
                            end
                            if not MoveDirect(wp.Position) then
                                if BlockedConn then
                                    BlockedConn:Disconnect()
                                end
                                return false
                            end
                        end
                        if BlockedConn then
                            BlockedConn:Disconnect()
                        end
                        return true
                    end
                    return MoveDirect(TargetPos)
                end

                for _, item in ipairs(folder:GetChildren()) do
                    if not Globals.AutoPickups then break end

                    if item:IsA("MeshPart") and (item.Name == "SnowCharm" or item.Name == "Lorebook") then
                        if not IsVoidCharm(item) then
                            if Globals.PickupMethod == "Instant" then
                                hrp.CFrame = item.CFrame * CFrame.new(0, 3, 0)
                                task.wait(0.2)
                                task.wait(0.3)
                            else
                                local TargetPos = item.Position + Vector3.new(0, 3, 0)
                                MoveToPos(TargetPos)
                                task.wait(0.2)
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end

            task.wait(1)
        end

        AutoPickupsRunning = false
    end)
end

local function StartAutoSkip()
    if AutoSkipRunning or not Globals.AutoSkip then return end
    AutoSkipRunning = true

    task.spawn(function()
        while Globals.AutoSkip do
            local SkipVisible =
                PlayerGui:FindFirstChild("ReactOverridesVote")
                and PlayerGui.ReactOverridesVote:FindFirstChild("Frame")
                and PlayerGui.ReactOverridesVote.Frame:FindFirstChild("votes")
                and PlayerGui.ReactOverridesVote.Frame.votes:FindFirstChild("vote")

            if SkipVisible and SkipVisible.Position == UDim2.new(0.5, 0, 0.5, 0) then
                RunVoteSkip()
            end

            task.wait(1)
        end

        AutoSkipRunning = false
    end)
end

local function StartClaimRewards()
    if AutoClaimRewards or not Globals.ClaimRewards or GameState ~= "LOBBY" then 
        return 
    end

    AutoClaimRewards = true

    local player = game:GetService("Players").LocalPlayer
    local network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

    local SpinTickets = player:WaitForChild("SpinTickets", 15)

    if SpinTickets and SpinTickets.Value > 0 then
        local TicketCount = SpinTickets.Value

        local DailySpin = network:WaitForChild("DailySpin", 5)
        local RedeemRemote = DailySpin and DailySpin:WaitForChild("RF:RedeemSpin", 5)

        if RedeemRemote then
            for i = 1, TicketCount do
                RedeemRemote:InvokeServer()
                task.wait(0.5)
            end
        end
    end

    for i = 1, 6 do
        local args = { i }
        network:WaitForChild("PlaytimeRewards"):WaitForChild("RF:ClaimReward"):InvokeServer(unpack(args))
        task.wait(0.5)
    end

    game:GetService("ReplicatedStorage").Network.DailySpin["RF:RedeemReward"]:InvokeServer()
    AutoClaimRewards = false
end

local function StartBackToLobby()
    if BackToLobbyRunning then return end
    BackToLobbyRunning = true

    task.spawn(function()
        while true do
            pcall(function()
                HandlePostMatch()
            end)
            task.wait(5)
        end
        BackToLobbyRunning = false
    end)
end

local function StartAntiLag()
    if AntiLagRunning then return end
    AntiLagRunning = true

    local settings = settings().Rendering
    local OriginalQuality = settings.QualityLevel
    settings.QualityLevel = Enum.QualityLevel.Level01

    task.spawn(function()
        while Globals.AntiLag do
            local TowersFolder = workspace:FindFirstChild("Towers")
            local ClientUnits = workspace:FindFirstChild("ClientUnits")
            local enemies = workspace:FindFirstChild("NPCs")

            if TowersFolder then
                for _, tower in ipairs(TowersFolder:GetChildren()) do
                    local anims = tower:FindFirstChild("Animations")
                    local weapon = tower:FindFirstChild("Weapon")
                    local projectiles = tower:FindFirstChild("Projectiles")

                    if anims then anims:Destroy() end
                    if projectiles then projectiles:Destroy() end
                    if weapon then weapon:Destroy() end
                end
            end
            if ClientUnits then
                for _, unit in ipairs(ClientUnits:GetChildren()) do
                    unit:Destroy()
                end
            end
            if enemies then
                for _, npc in ipairs(enemies:GetChildren()) do
                    npc:Destroy()
                end
            end
            task.wait(0.5)
        end
        AntiLagRunning = false
    end)
end

local function StartAutoChain()
    if AutoChainRunning or not Globals.AutoChain then return end
    AutoChainRunning = true

    task.spawn(function()
        local idx = 1

        while Globals.AutoChain do
            local commander = {}
            local TowersFolder = workspace:FindFirstChild("Towers")

            if TowersFolder then
                for _, towers in ipairs(TowersFolder:GetDescendants()) do
                    if towers:IsA("Folder") and towers.Name == "TowerReplicator"
                    and towers:GetAttribute("Name") == "Commander"
                    and towers:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId
                    and (towers:GetAttribute("Upgrade") or 0) >= 2 then
                        commander[#commander + 1] = towers.Parent
                    end
                end
            end

            if #commander >= 3 then
                if idx > #commander then idx = 1 end

                local CurrentCommander = commander[idx]
                local replicator = CurrentCommander:FindFirstChild("TowerReplicator")
                local UpgradeLevel = replicator and replicator:GetAttribute("Upgrade") or 0

                if UpgradeLevel >= 4 and Globals.SupportCaravan then
                    RemoteFunc:InvokeServer(
                        "Troops",
                        "Abilities",
                        "Activate",
                        { Troop = CurrentCommander, Name = "Support Caravan", Data = {} }
                    )
                    task.wait(0.1) 
                end

                local response = RemoteFunc:InvokeServer(
                    "Troops",
                    "Abilities",
                    "Activate",
                    { Troop = CurrentCommander, Name = "Call Of Arms", Data = {} }
                )

                if response then
                    idx += 1

                    local hotbar = PlayerGui:FindFirstChild("ReactUniversalHotbar")
                    local TimescaleFrame = hotbar and hotbar.Frame:FindFirstChild("timescale")

                    if TimescaleFrame and TimescaleFrame.Visible then
                        if TimescaleFrame:FindFirstChild("Lock") then
                            task.wait(10.3)
                        else
                            task.wait(5.25)
                        end
                    else
                        task.wait(10.3)
                    end
                else
                    task.wait(0.5)
                end
            else
                task.wait(1)
            end
        end

        AutoChainRunning = false
    end)
end

local function StartAutoDjBooth()
    if AutoDjRunning or not Globals.AutoDJ then return end
    AutoDjRunning = true

    task.spawn(function()
        while Globals.AutoDJ do
            local TowersFolder = workspace:FindFirstChild("Towers")
            local DJ = nil

            if TowersFolder then
                for _, towers in ipairs(TowersFolder:GetDescendants()) do
                    if towers:IsA("Folder") and towers.Name == "TowerReplicator"
                    and towers:GetAttribute("Name") == "DJ Booth"
                    and towers:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId
                    and (towers:GetAttribute("Upgrade") or 0) >= 3 then
                        DJ = towers.Parent
                    end
                end
            end

            if DJ then
                RemoteFunc:InvokeServer(
                    "Troops",
                    "Abilities",
                    "Activate",
                    { Troop = DJ, Name = "Drop The Beat", Data = {} }
                )
            end

            task.wait(1)
        end

        AutoDjRunning = false
    end)
end

local function StartAutoNecro()
    if AutoNecroRunning or not Globals.AutoNecro then return end
    AutoNecroRunning = true

    local lastActivation = 0
    local ownerId = game.Players.LocalPlayer.UserId

    local function getNecros(towersFolder)
        local list = {}
        if not towersFolder then
            return list
        end
        for _, rep in ipairs(towersFolder:GetDescendants()) do
            if rep:IsA("Folder") and rep.Name == "TowerReplicator"
            and rep:GetAttribute("Name") == "Necromancer"
            and rep:GetAttribute("OwnerId") == ownerId then
                list[#list + 1] = rep.Parent
            end
        end
        return list
    end

    local function pickMaxGraves(rep, graveStore, up)
        local maxGraves = rep and rep:GetAttribute("Max_Graves")
        if graveStore then
            local gMax = graveStore:GetAttribute("Max_Graves")
            if type(gMax) == "number" and gMax > 0 then
                maxGraves = gMax
            end
        end
        if not maxGraves or maxGraves < 2 then
            if up >= 4 then
                maxGraves = 9
            elseif up >= 2 then
                maxGraves = 6
            else
                maxGraves = 3
            end
        end
        return maxGraves
    end

    local function countGraves(graveStore)
        if not graveStore then
            return 0
        end
        local cnt = 0
        for k, v in pairs(graveStore:GetAttributes()) do
            if type(k) == "string" and #k > 20 then
                local isDestroy = false
                if type(v) == "table" then
                    for _, elem in pairs(v) do
                        if tostring(elem) == "Destroy" then
                            isDestroy = true
                            break
                        end
                    end
                elseif tostring(v):find("Destroy") then
                    isDestroy = true
                end
                if isDestroy then
                    graveStore:SetAttribute(k, nil)
                else
                    cnt += 1
                end
            end
        end
        return cnt
    end

    local function cleanAllGraves(list)
        for _, necro in ipairs(list) do
            local rep = necro and necro:FindFirstChild("TowerReplicator")
            local store = rep and rep:FindFirstChild("GraveStone")
            if store then
                countGraves(store)
            end
        end
    end

    task.spawn(function()
        local idx = 1

        while Globals.AutoNecro do
            local TowersFolder = workspace:FindFirstChild("Towers")
            local necromancer = getNecros(TowersFolder)
            cleanAllGraves(necromancer)

            if #necromancer >= 1 then
                if idx > #necromancer then idx = 1 end
                local CurrentNecromancer = necromancer[idx]
                local replicator = CurrentNecromancer:FindFirstChild("TowerReplicator")

                local up = replicator and (replicator:GetAttribute("Upgrade") or 0) or 0
                local graveStore = replicator and replicator:FindFirstChild("GraveStone")
                local maxGraves = pickMaxGraves(replicator, graveStore, up)
                local graveCount = countGraves(graveStore)
                local debounce = (replicator and replicator:GetAttribute("AbilityDebounce")) or 5
                local now = os.clock()

                if maxGraves and graveCount >= maxGraves and (now - lastActivation >= debounce) then
                    local response = RemoteFunc:InvokeServer(
                        "Troops",
                        "Abilities",
                        "Activate",
                        { Troop = CurrentNecromancer, Name = "Raise The Dead", Data = {} }
                    )

                    if response then 
                        lastActivation = now
                        idx += 1
                        task.wait(1)
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.1)
                end
            else
                task.wait(1)
            end
        end

        AutoNecroRunning = false
    end)
end

local function StartAutoMercenary()
    if not Globals.AutoMercenary and not Globals.AutoMilitary then return end

    if AutoMercenaryBaseRunning then return end
    AutoMercenaryBaseRunning = true

    task.spawn(function()
        while Globals.AutoMercenary do
            local TowersFolder = workspace:FindFirstChild("Towers")

            if TowersFolder then
                for _, towers in ipairs(TowersFolder:GetDescendants()) do
                    if towers:IsA("Folder") and towers.Name == "TowerReplicator"
                    and towers:GetAttribute("Name") == "Mercenary Base"
                    and towers:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId
                    and (towers:GetAttribute("Upgrade") or 0) >= 5 then

                        RemoteFunc:InvokeServer(
                            "Troops",
                            "Abilities",
                            "Activate",
                            { 
                                Troop = towers.Parent, 
                                Name = "Air-Drop", 
                                Data = {
                                    pathName = 1, 
                                    directionCFrame = CFrame.new(), 
                                    dist = Globals.MercenaryPath or 195
                                } 
                            }
                        )

                        task.wait(0.5)

                        if not Globals.AutoMercenary then break end
                    end
                end
            end

            task.wait(0.5)
        end

        AutoMercenaryBaseRunning = false
    end)
end

local function StartAutoMilitary()
    if not Globals.AutoMilitary then return end

    if AutoMilitaryBaseRunning then return end
    AutoMilitaryBaseRunning = true

    task.spawn(function()
        while Globals.AutoMilitary do
            local TowersFolder = workspace:FindFirstChild("Towers")
            if TowersFolder then
                for _, towers in ipairs(TowersFolder:GetDescendants()) do
                    if towers:IsA("Folder") and towers.Name == "TowerReplicator"
                    and towers:GetAttribute("Name") == "Military Base"
                    and towers:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId
                    and (towers:GetAttribute("Upgrade") or 0) >= 4 then

                        RemoteFunc:InvokeServer(
                            "Troops",
                            "Abilities",
                            "Activate",
                            { 
                                Troop = towers.Parent, 
                                Name = "Airstrike", 
                                Data = {
                                    pathName = 1, 
                                    pointToEnd = CFrame.new(), 
                                    dist = Globals.MilitaryPath or 195
                                } 
                            }
                        )

                        task.wait(0.5)

                        if not Globals.AutoMilitary then break end
                    end
                end
            end

            task.wait(0.5)
        end

        AutoMilitaryBaseRunning = false
    end)
end

local function StartSellFarm()
    if SellFarmsRunning or not Globals.SellFarms then return end
    SellFarmsRunning = true

    if GameState ~= "GAME" then 
        return false 
    end

    task.spawn(function()
        while Globals.SellFarms do
            local CurrentWave = GetCurrentWave()
            if Globals.SellFarmsWave and CurrentWave < Globals.SellFarmsWave then
                task.wait(1)
                continue
            end

            local TowersFolder = workspace:FindFirstChild("Towers")
            if TowersFolder then
                for _, replicator in ipairs(TowersFolder:GetDescendants()) do
                    if replicator:IsA("Folder") and replicator.Name == "TowerReplicator" then
                        local IsFarm = replicator:GetAttribute("Name") == "Farm"
                        local IsMine = replicator:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId

                        if IsFarm and IsMine then
                            local TowerModel = replicator.Parent
                            RemoteFunc:InvokeServer("Troops", "Sell", { Troop = TowerModel })

                            task.wait(0.2)
                        end
                    end
                end
            end

            task.wait(1)
        end
        SellFarmsRunning = false
    end)
end

task.spawn(function()
    while true do
        if Globals.AutoPickups and not AutoPickupsRunning then
            StartAutoPickups()
        end

        if Globals.AutoSkip and not AutoSkipRunning then
            StartAutoSkip()
        end

        if Globals.TimeScaleEnabled and not TimeScaleRunning then
            StartTimeScale()
        end

        if Globals.AutoChain and not AutoChainRunning then
            StartAutoChain()
        end

        if Globals.AutoDJ and not AutoDjRunning then
            StartAutoDjBooth()
        end

        if Globals.AutoNecro and not AutoNecroRunning then
            StartAutoNecro()
        end

        if Globals.AutoMercenary and not AutoMercenaryBaseRunning then
            StartAutoMercenary()
        end

        if Globals.AutoMilitary and not AutoMilitaryBaseRunning then
            StartAutoMilitary()
        end

        if Globals.SellFarms and not SellFarmsRunning then
            StartSellFarm()
        end

        if Globals.AntiLag and not AntiLagRunning then
            StartAntiLag()
        end

        if Globals.AutoRejoin and not BackToLobbyRunning then
            StartBackToLobby()
        end

        task.wait(1)
    end
end)

if Globals.ClaimRewards and not AutoClaimRewards then
    StartClaimRewards()
end

return TDS
