 
 

local v1 = {
    DuoEmotes = {
        CarryGiver = "rbxassetid://136025392449178",
        CarryReceiver = "rbxassetid://135859598790010",
        HandshakeGiver = "rbxassetid://113344662558331",
        HandshakeReceiver = "rbxassetid://82453985282100",
        SunscreenSlapGiver = "rbxassetid://83467516954993",
        SunscreenSlapReceiver = "rbxassetid://110073312292627",
        IceCreamTruckGiverStart = "rbxassetid://91294233194070",
        IceCreamTruckGiverLoop = "rbxassetid://104422562841499",
        IceCreamTruckReceiverLoop = "rbxassetid://111972697175482",
        TodoGiver = "rbxassetid://140002037105644",
        TodoReceiver = "rbxassetid://107919137450468",
        REFGiver = "rbxassetid://82528828332744",
        REFReceiver = "rbxassetid://90377286626160",
        DuoDanceGiver = "rbxassetid://80391988468625",
        DuoDanceReceiver = "rbxassetid://70634715878435",
        WeDidItPlayer1 = "rbxassetid://122067470996512",
        WeDidItPlayer2 = "rbxassetid://110753789944030",
        WeDidItCamera = "rbxassetid://92759727611576",
        YouCantRunPlayer1 = "rbxassetid://130957138236213",
        YouCantRunPlayer2 = "rbxassetid://100376829481162",
        YouCantRunCamera = "rbxassetid://79005541263763",
        HeyPlayer = "rbxassetid://136742468180415",
        HeyCamera = "rbxassetid://98773646889323",
        TheDancePlayer = "rbxassetid://140344678076070",
        TheDanceCamera = "rbxassetid://103940677652970",
        TheDanceTentacle1 = "rbxassetid://140344678076070",
        TheDanceTentacle2 = "rbxassetid://124309311484935",
        TheDanceTentacle3 = "rbxassetid://85107949830735",
        TheDanceTentacle4 = "rbxassetid://82127268662452",
        DioCamera = "rbxassetid://135133423325753",
        DioPlayer = "rbxassetid://79221677358920",
        YouLadiesAlright = "rbxassetid://95930691826131",
        YouLadiesAlrightBall = "rbxassetid://116480630583366",
        VALENTINEPlayer = "rbxassetid://110909958503928",
        VALENTINEStand = "rbxassetid://94831080126794",
        VALENTINECamera = "rbxassetid://132979032329170",
        RunThatBackPlayer = "rbxassetid://82030410877485",
        RunThatBackCamera = "rbxassetid://125687920751869",
        RunThatBackPreview = "rbxassetid://109877489552733",
        ChampionPlayer0 = "rbxassetid://73525288986323",
        ChampionPlayer1 = "rbxassetid://98857611951032",
        ChampionPlayer2 = "rbxassetid://99355845187943",
        ChampionCamera = "rbxassetid://78141368714143",
        ChampionTrophy = "rbxassetid://119836963304951",
        ChampionMic = "rbxassetid://77689139296581",
        ChampionInterviewCamera = "rbxassetid://121835433046714",
        EyeBattlePlayer0 = "rbxassetid://75642037246928",
        EyeBattlePlayer1 = "rbxassetid://102504071779075",
        EyeBattleCamera = "rbxassetid://130996967796546",
        RequiemPlayer = "rbxassetid://82473422273017",
        RequiemFish1 = "rbxassetid://121299363207723",
        RequiemFish2 = "rbxassetid://136932774419464",
        RequiemFish3 = "rbxassetid://81688545567281",
        RequiemCamera = "rbxassetid://137794971304629",
        KneelForVampirePlayer0 = "rbxassetid://78140747922962",
        KneelForVampirePlayer1 = "rbxassetid://138517851574163",
        KneelForVampirePlayer2 = "rbxassetid://113295413221223",
        KneelForVampireCamera = "rbxassetid://75487334849512",
        SCARYMONSTERPlayer = "rbxassetid://96591778407468",
        SCARYMONSTERTail = "rbxassetid://85332090597767",
        SCARYMONSTERCamera = "rbxassetid://137899826864753",
        RunAwayPlayer0 = "rbxassetid://100245104628144",
        RunAwayPlayer1 = "rbxassetid://88427827380624",
        RunAwayCamera = "rbxassetid://136993303008354",
        PaperGunPlayer = "rbxassetid://103453339823632",
        PaperGunPaper = "rbxassetid://74188562311235",
        PaperGunGun = "rbxassetid://109124261212591",
        PaperGunCamera = "rbxassetid://125226190242637",
        AscendedVampirePlayer = "rbxassetid://117971392519551",
        AscendedVampireCamera = "rbxassetid://122908786570120",
        ThrillerPlayer = "rbxassetid://134387751699818",
        ThrillerCamera = "rbxassetid://123552963797794"
    }
};
local v2 = game:GetService("RunService"):IsStudio();
v1.Emotes = {
    ["YOU CAN\'T RUN"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["WE DID IT!"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["Hey!"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["The Dance"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["You Ladies Alright?"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    VAMPIRE = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    VALENTINE = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["Run That Back"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    Champion = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["Eye Battle"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    Requiem = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["Kneel For Vampire"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["SCARY MONSTER"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["Run Away"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["Paper Gun"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["Ascended Vampire"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    Thriller = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        GlobalCooldown = v2 and 0.1 or 70
    },
    ["Ice Cream Truck"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayOnScore = true,
        DuoCallback = "Ice Cream Truck Duo",
        CannotPlayInRanked = true
    },
    Rollerskates = {
        Rarity = "Limited",
        ID = "rbxassetid://74951946468289",
        CanMove = true
    },
    ["Sunscreen Slap"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        DuoCallback = "Sunscreen Slap Duo"
    },
    Grill = {
        Rarity = "Limited",
        ID = "rbxassetid://80562775399250"
    },
    Surfboard = {
        Rarity = "Limited",
        ID = "rbxassetid://107247692735361",
        DisableAirChecks = true,
        CanMove = true,
        CannotPlayInRanked = true
    },
    ["Water Balloon"] = {
        Rarity = "Limited",
        ID = "rbxassetid://107505802911249"
    },
    ["Beach Ball"] = {
        Rarity = "Limited",
        ID = "rbxassetid://121636763566058",
        CannotPlayInRanked = true
    },
    ["Slip \'n Slide"] = {
        Rarity = "Limited",
        ID = "rbxassetid://129577609479131",
        CanMove = true
    },
    Motorcycle = {
        Rarity = "Limited",
        ID = "rbxassetid://97618316794641",
        CanMove = true,
        DisableAirChecks = true,
        CannotPlayInRanked = true
    },
    Carry = {
        Rarity = "Limited",
        ID = "rbxassetid://136025392449178",
        CanMove = true,
        DuoCallback = "Carry Duo",
        CannotPlayOnScore = true
    },
    ["Meteor Joyride"] = {
        Rarity = "Limited",
        ID = "rbxassetid://123647752339082",
        CanMove = true
    },
    ["BASKETBALL GOD\'S CAR"] = {
        Rarity = "Limited",
        ID = "rbxassetid://102724839932963",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    ["Emperor\'s Rage"] = {
        Rarity = "Limited",
        ID = "rbxassetid://125141898114991",
        CanMove = true
    },
    Dog = {
        Rarity = "Limited",
        ID = "rbxassetid://80084005174594",
        CanMove = true
    },
    ["Final Boss"] = {
        Rarity = "Limited",
        ID = "rbxassetid://92333010164302",
        CanMove = false,
        CannotPlayInRanked = true
    },
    Skateboard = {
        Rarity = "Limited",
        ID = "rbxassetid://126713627031739",
        CanMove = true,
        CannotPlayInRanked = true
    },
    ["Perfect Mind"] = {
        Rarity = "Limited",
        ID = "rbxassetid://138402573473129",
        CanMove = false
    },
    Handshake = {
        Rarity = "Limited",
        ID = "rbxassetid://78145518604914",
        CanMove = false,
        DuoCallback = "Handshake Duo"
    },
    ["Jackpot!"] = {
        Rarity = "Limited",
        ID = "rbxassetid://87309398473838",
        ID2 = "rbxassetid://126634258939603",
        CanMove = false,
        CannotPlayInRanked = true
    },
    ["Jackpot Preview"] = {
        Rarity = "Limited",
        ID = "rbxassetid://87309398473838",
        CanMove = false
    },
    ["Hero Landing"] = {
        Rarity = "Limited",
        ID = "rbxassetid://91950173741703",
        ID2 = "rbxassetid://78769092808696",
        CanMove = false
    },
    ["Hero Preview"] = {
        Rarity = "Limited",
        ID = "rbxassetid://76762366344184",
        CanMove = false
    },
    ["Chalk Toss"] = {
        Rarity = "Limited",
        ID = "rbxassetid://113794507093105",
        CanMove = false
    },
    Pose = {
        Rarity = "Limited",
        ID = "rbxassetid://130763555815867",
        CanMove = false
    },
    ["Fancy Walk"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83150383941982",
        CanMove = true
    },
    ["Life Force"] = {
        Rarity = "Limited",
        ID = "rbxassetid://75465539620187",
        CanMove = false,
        CannotPlayOnScore = true
    },
    Next = {
        Rarity = "Limited",
        ID = "rbxassetid://110730936274486",
        CanMove = false
    },
    ["The Banana Song"] = {
        Rarity = "Limited",
        ID = "rbxassetid://115408394002443",
        CanMove = false
    },
    ["Passo Bem Solto"] = {
        Rarity = "Limited",
        ID = "rbxassetid://137159573935940",
        CanMove = false
    },
    Sugarphonk = {
        Rarity = "Limited",
        ID = "rbxassetid://108438657792612",
        CanMove = false
    },
    ["Luna Bala"] = {
        Rarity = "Limited",
        ID = "rbxassetid://118202659796680",
        CanMove = false
    },
    ["Spinning Cat"] = {
        Rarity = "Limited",
        ID = "rbxassetid://116498752665276",
        CanMove = false
    },
    ["Montagem Miau"] = {
        Rarity = "Limited",
        ID = "rbxassetid://82688373324001",
        CanMove = false
    },
    ["Mande Mande"] = {
        Rarity = "Limited",
        ID = "rbxassetid://133550127282509",
        CanMove = true
    },
    ["Volkswagen Funk"] = {
        Rarity = "Limited",
        ID = "rbxassetid://99220961735253",
        CanMove = true
    },
    Escape = {
        Rarity = "Limited",
        ID = "rbxassetid://75440868823174",
        CanMove = false
    },
    ["Sweet Rally"] = {
        Rarity = "Limited",
        ID = "rbxassetid://78799913034638",
        CanMove = true
    },
    Doodle = {
        Rarity = "Limited",
        ID = "rbxassetid://135093059816060",
        CanMove = false
    },
    Agonize = {
        Rarity = "Limited",
        ID = "rbxassetid://98248028489751",
        CanMove = false
    },
    ["Referee\'s Cart"] = {
        Rarity = "Limited",
        ID = "rbxassetid://104780087088092",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    Lowrider = {
        Rarity = "Limited",
        ID = "rbxassetid://89290305716080",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    ["Unc Walk"] = {
        Rarity = "Limited",
        ID = "rbxassetid://89500955156788",
        CanMove = true
    },
    ["Jack In The Box"] = {
        Rarity = "Limited",
        ID = "rbxassetid://134840864062854",
        CanMove = false
    },
    ["Floating Balloon"] = {
        Rarity = "Limited",
        ID = "rbxassetid://108360618246593",
        CanMove = true
    },
    BANG = {
        Rarity = "Limited",
        ID = "rbxassetid://122530880811850",
        CanMove = false
    },
    Ringing = {
        Rarity = "Limited",
        ID = "rbxassetid://72569282328688",
        CanMove = false
    },
    ["Wazzup!"] = {
        Rarity = "Limited",
        ID = "rbxassetid://85354035413379",
        CanMove = false
    },
    Killer = {
        Rarity = "Limited",
        ID = "rbxassetid://102618047587269",
        CanMove = false
    },
    ["Hot Chocolate"] = {
        Rarity = "Limited",
        ID = "rbxassetid://105262873875054",
        CanMove = false
    },
    ["Candle Meditation"] = {
        Rarity = "Limited",
        ID = "rbxassetid://95994808261366",
        CanMove = false
    },
    ["Leaves Jump"] = {
        Rarity = "Limited",
        ID = "rbxassetid://119826419510965",
        CanMove = false
    },
    ["Pumpkin Head"] = {
        Rarity = "Limited",
        ID = "rbxassetid://92999768727927",
        CanMove = false
    },
    Lantern = {
        Rarity = "Limited",
        ID = "rbxassetid://100321451052305",
        CanMove = false
    },
    ["Turkey Leg"] = {
        Rarity = "Limited",
        ID = "rbxassetid://131899524327599",
        CanMove = false
    },
    ["Chainsaw Maniac"] = {
        Rarity = "Limited",
        ID = "rbxassetid://96882892061596",
        CanMove = false
    },
    ["Tentacle Walk"] = {
        Rarity = "Limited",
        ID = "rbxassetid://140531479711983",
        CanMove = true,
        CannotPlayInRanked = true
    },
    ["Cyber Hoverboard"] = {
        Rarity = "Limited",
        ID = "rbxassetid://90286452810597",
        CanMove = true,
        CannotPlayInRanked = true
    },
    ["Turret Jump"] = {
        Rarity = "Limited",
        ID = "rbxassetid://84924871669675",
        CanMove = false,
        CannotPlayInRanked = true
    },
    ["Cyber Car"] = {
        Rarity = "Limited",
        ID = "rbxassetid://109718799061599",
        CanMove = true,
        CannotPlayInRanked = true
    },
    ["Dino Ride"] = {
        Rarity = "Limited",
        ID = "rbxassetid://114095871482112",
        CanMove = true
    },
    ["Drum Set"] = {
        Rarity = "Limited",
        ID = "rbxassetid://110608096505921",
        CanMove = false
    },
    ["Mic Drop"] = {
        Rarity = "Limited",
        ID = "rbxassetid://122042172572809",
        CanMove = false
    },
    ["Popstar Keytar"] = {
        Rarity = "Limited",
        ID = "rbxassetid://138589445272469",
        CanMove = false
    },
    ["King\'s Throne"] = {
        Rarity = "Limited",
        ID = "rbxassetid://127422239595618",
        CanMove = false
    },
    ["Trophy Lift"] = {
        Rarity = "Limited",
        ID = "rbxassetid://71623584638226",
        CanMove = false
    },
    ["Samurai Flip"] = {
        Rarity = "Limited",
        ID = "rbxassetid://119694557175566",
        CanMove = false
    },
    ["Eclipse Meditation"] = {
        Rarity = "Limited",
        ID = "rbxassetid://92314927586572",
        CanMove = false
    },
    ["Dragon Ride"] = {
        Rarity = "Limited",
        ID = "rbxassetid://138652730332623",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    Viki = {
        Rarity = "Limited",
        ID = "rbxassetid://86472542850898",
        CanMove = false,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    ["Cup of Tea"] = {
        Rarity = "Limited",
        ID = "rbxassetid://126294734826800",
        CanMove = false
    },
    ["Santa and Reindeers"] = {
        Rarity = "Limited",
        ID = "rbxassetid://105548777937469",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    ["Card Flip"] = {
        Rarity = "Limited",
        ID = "rbxassetid://92643244279011",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    ["Deck Of Cards"] = {
        Rarity = "Limited",
        ID = "rbxassetid://113576920013918",
        CanMove = false
    },
    ["Chrollo Vs Tatlis"] = {
        Rarity = "Limited",
        ID = "rbxassetid://82118573503401",
        CanMove = false
    },
    ["Long Tongue"] = {
        Rarity = "Limited",
        ID = "rbxassetid://115322654786693",
        CanMove = false
    },
    ["Toy Jet"] = {
        Rarity = "Limited",
        ID = "rbxassetid://118489792924402",
        CanMove = false
    },
    ["Playing Piano"] = {
        Rarity = "Limited",
        ID = "rbxassetid://135057964873371",
        CanMove = false
    },
    ["Playing Guitar"] = {
        Rarity = "Limited",
        ID = "rbxassetid://74434050003686",
        CanMove = false
    },
    ["Playing Violin"] = {
        Rarity = "Limited",
        ID = "rbxassetid://113612024165123",
        CanMove = false
    },
    ["Dust Off"] = {
        Rarity = "Limited",
        ID = "rbxassetid://113147819461868",
        CanMove = false
    },
    Sleepy = {
        Rarity = "Limited",
        ID = "rbxassetid://99016730864081",
        CanMove = false,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    ["Knee Slide"] = {
        Rarity = "Limited",
        ID = "rbxassetid://94024254896942",
        CanMove = true
    },
    ["Whale Ride"] = {
        Rarity = "Limited",
        ID = "rbxassetid://128577271578921",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true
    },
    ["Rainbow Barf"] = {
        Rarity = "Limited",
        ID = "rbxassetid://89596479274294",
        CanMove = false
    },
    Ascend = {
        Rarity = "Limited",
        ID = "rbxassetid://108324653602374",
        CanMove = false
    },
    ["Taking A Knee"] = {
        Rarity = "Limited",
        ID = "rbxassetid://116549013046837",
        CanMove = false
    },
    REF = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        DuoCallback = "REF Duo"
    },
    ["Horse Ride"] = {
        Rarity = "Limited",
        ID = "rbxassetid://115023879839177",
        CanMove = true
    },
    ["Goat Aura"] = {
        Rarity = "Limited",
        ID = "rbxassetid://77395883864129",
        CanMove = false
    },
    ["That\'s Tech"] = {
        Rarity = "Limited",
        ID = "rbxassetid://86677887959873",
        CanMove = false
    },
    Spin = {
        Rarity = "Limited",
        ID = "rbxassetid://92901589624363",
        CanMove = false
    },
    ["Shadow Boxing"] = {
        Rarity = "Limited",
        ID = "rbxassetid://94139233221700",
        CanMove = false
    },
    Chicken = {
        Rarity = "Limited",
        ID = "rbxassetid://131202043959276",
        CanMove = true
    },
    ["Bull Ride"] = {
        Rarity = "Limited",
        ID = "rbxassetid://130700017777819",
        CanMove = true
    },
    ["Hawk Pal"] = {
        Rarity = "Limited",
        ID = "rbxassetid://75566248844503",
        DontPlay = true,
        CanMove = true,
        DisableAirChecks = true
    },
    Moonwalk = {
        Rarity = "Limited",
        ID = "rbxassetid://132303138232655",
        CanMove = true
    },
    Lean = {
        Rarity = "Limited",
        ID = "rbxassetid://120771643658490",
        CanMove = false
    },
    ["Hee Hee"] = {
        Rarity = "Limited",
        ID = "rbxassetid://108305825368851",
        CanMove = false
    },
    ["Happy Birthday"] = {
        Rarity = "Limited",
        ID = "rbxassetid://137896305569676",
        CanMove = false
    },
    ["Alien Invasion"] = {
        Rarity = "Limited",
        ID = "rbxassetid://101369919081481",
        CanMove = true,
        DisableAirChecks = true,
        CannotPlayInRanked = true
    },
    Sunshine = {
        Rarity = "Limited",
        ID = "rbxassetid://119823474804796",
        CanMove = false
    },
    Fem = {
        Rarity = "Limited",
        ID = "rbxassetid://136936268660438",
        CanMove = false
    },
    ["Can\'t Laugh"] = {
        Rarity = "Limited",
        ID = "rbxassetid://108443762686690",
        CanMove = false
    },
    ["Big Bad Wolf"] = {
        Rarity = "Limited",
        ID = "rbxassetid://89375373576266",
        CanMove = true
    },
    ["Glitchy Moves"] = {
        Rarity = "Limited",
        ID = "rbxassetid://93839232050062",
        CanMove = false
    },
    ["Death Book"] = {
        Rarity = "Limited",
        ID = "rbxassetid://72498940285788",
        CanMove = false
    },
    ["Power Up"] = {
        Rarity = "Limited",
        ID = "rbxassetid://85213265828536",
        CanMove = false
    },
    ["Horse Relaxing"] = {
        Rarity = "Limited",
        ID = "rbxassetid://117034465146800",
        CanMove = false
    },
    Arrow = {
        Rarity = "Limited",
        ID = "rbxassetid://107811633842650",
        CanMove = true,
        CannotPlayInRanked = true
    },
    ["Moon Pose"] = {
        Rarity = "Limited",
        ID = "rbxassetid://73021372079578",
        CanMove = false
    },
    ["Frog Ride"] = {
        Rarity = "Limited",
        ID = "rbxassetid://105070000104784",
        CanMove = true
    },
    ["Chakra Sphere"] = {
        Rarity = "Limited",
        ID = "rbxassetid://134150236685958",
        CanMove = false
    },
    ["Zombie Walk"] = {
        Rarity = "Limited",
        ID = "rbxassetid://103217854949030",
        CanMove = true
    },
    ["Bat Aura"] = {
        Rarity = "Limited",
        ID = "rbxassetid://96065192209698",
        CanMove = false
    },
    ["Bat Wings"] = {
        Rarity = "Limited",
        ID = "rbxassetid://120589590830973",
        CanMove = true
    },
    ["Werewolf Howl"] = {
        Rarity = "Limited",
        ID = "rbxassetid://138780672658496",
        CanMove = false
    },
    Coffin = {
        Rarity = "Limited",
        ID = "rbxassetid://104896516819270",
        CanMove = false
    },
    ["Witch\'s Broom"] = {
        Rarity = "Limited",
        ID = "rbxassetid://94183424778464",
        CanMove = true
    },
    Bird = {
        Rarity = "Legendary",
        ID = "rbxassetid://119482432848199",
        CanMove = true
    },
    Clap = {
        Rarity = "Limited",
        ID = "rbxassetid://125235508647375",
        CanMove = false
    },
    Cold = {
        Rarity = "Limited",
        ID = "rbxassetid://129812191315583",
        CanMove = false
    },
    Cooking = {
        Rarity = "Rare",
        ID = "rbxassetid://97081094383461",
        CanMove = false
    },
    Sleeping = {
        Rarity = "Limited",
        ID = "rbxassetid://70564151129732",
        CanMove = false
    },
    Jabba = {
        Rarity = "Rare",
        ID = "rbxassetid://114263993875972",
        CanMove = false
    },
    ["Tatlis Vibe"] = {
        Rarity = "Legendary",
        ID = "rbxassetid://88278608912425",
        CanMove = false
    },
    Tylil = {
        Rarity = "Epic",
        ID = "rbxassetid://85642159100966",
        CanMove = true
    },
    ["Warm Up"] = {
        Rarity = "Limited",
        ID = "rbxassetid://84034938281066",
        CanMove = false
    },
    ["You\'re Welcome"] = {
        Rarity = "Rare",
        ID = "rbxassetid://105186962036328",
        CanMove = false
    },
    Chilling = {
        Rarity = "Rare",
        ID = "rbxassetid://97870402799892",
        CanMove = false
    },
    Stretch = {
        Rarity = "Rare",
        ID = "rbxassetid://140698008867727",
        CanMove = false
    },
    ["Yes!"] = {
        Rarity = "Rare",
        ID = "rbxassetid://100274163724704",
        CanMove = false
    },
    IDK = {
        Rarity = "Limited",
        ID = "rbxassetid://139350620875596",
        CanMove = false
    },
    Dizzy = {
        Rarity = "Rare",
        ID = "rbxassetid://89274920324854",
        CanMove = false
    },
    Gambler = {
        Rarity = "Limited",
        ID = "rbxassetid://124907814276627",
        CanMove = false
    },
    Crouch = {
        Rarity = "Rare",
        ID = "rbxassetid://103762842577337",
        CanMove = false
    },
    Yea = {
        Rarity = "Rare",
        ID = "rbxassetid://80302278608429",
        CanMove = false
    },
    Sweat = {
        Rarity = "Epic",
        ID = "rbxassetid://106552531129578",
        CanMove = false
    },
    L = {
        Rarity = "Limited",
        ID = "rbxassetid://92344979944911",
        CanMove = false
    },
    ["The Honored One"] = {
        Rarity = "Limited",
        ID = "rbxassetid://103046216738732",
        CanMove = false
    },
    Head = {
        Rarity = "Epic",
        ID = "rbxassetid://130530401866513",
        CanMove = false
    },
    ["Wib Wub"] = {
        Rarity = "Rare",
        ID = "rbxassetid://111197875491029",
        CanMove = false
    },
    Scared = {
        Rarity = "Epic",
        ID = "rbxassetid://82184640528800",
        CanMove = false
    },
    ["What did u say?"] = {
        Rarity = "Rare",
        ID = "rbxassetid://117472594365417",
        CanMove = false
    },
    ["Touch Glasses"] = {
        Rarity = "Limited",
        ID = "rbxassetid://119910943484302",
        CanMove = false
    },
    ["Super Bow"] = {
        Rarity = "Epic",
        ID = "rbxassetid://72584098858344",
        CanMove = false
    },
    ["Tired Walk"] = {
        Rarity = "Epic",
        ID = "rbxassetid://71949065191857",
        CanMove = true
    },
    ["Silly Walk"] = {
        Rarity = "Epic",
        ID = "rbxassetid://126788734146704",
        CanMove = true
    },
    ["Green!"] = {
        Rarity = "Rare",
        ID = "rbxassetid://116550074978028",
        CanMove = false
    },
    Griddy = {
        Rarity = "Epic",
        ID = "rbxassetid://95129605349553",
        CanMove = true
    },
    ["Woo Walk"] = {
        Rarity = "Epic",
        ID = "rbxassetid://80555759086154",
        CanMove = true
    },
    ["Shmoney Dance"] = {
        Rarity = "Epic",
        ID = "rbxassetid://94860654267205",
        CanMove = false
    },
    ["What you know about me"] = {
        Rarity = "Epic",
        ID = "rbxassetid://120313261055056",
        CanMove = true
    },
    Greet = {
        Rarity = "Rare",
        ID = "rbxassetid://106862162506879",
        CanMove = false
    },
    Floss = {
        Rarity = "Rare",
        ID = "rbxassetid://134662813621138",
        CanMove = false
    },
    ["Happy Walk"] = {
        Rarity = "Epic",
        ID = "rbxassetid://86579596332943",
        CanMove = true
    },
    ["Silly Dance"] = {
        Rarity = "Rare",
        ID = "rbxassetid://75586747144615",
        CanMove = false
    },
    ["Xavier Dance"] = {
        Rarity = "Legendary",
        ID = "rbxassetid://96501248224572",
        CanMove = false
    },
    ["Popular Dance"] = {
        Rarity = "Epic",
        ID = "rbxassetid://101771629475035",
        CanMove = false
    },
    ["Abnormal Run"] = {
        Rarity = "Limited",
        ID = "rbxassetid://99124630455009",
        CanMove = true
    },
    ["Pfresh Walk"] = {
        Rarity = "Legendary",
        ID = "rbxassetid://82397432654520",
        CanMove = true
    },
    ["Cool Walk"] = {
        Rarity = "Rare",
        ID = "rbxassetid://130648944420177",
        CanMove = true
    },
    ["Slap The Chest"] = {
        Rarity = "Epic",
        ID = "rbxassetid://89923960665463",
        CanMove = false
    },
    ["Bully Dance"] = {
        Rarity = "Legendary",
        ID = "rbxassetid://111853829664253",
        CanMove = false
    },
    ["Silly Dance 2"] = {
        Rarity = "Epic",
        ID = "rbxassetid://82773679333335",
        CanMove = false
    },
    Beggar = {
        Rarity = "Epic",
        ID = "rbxassetid://82762939519840",
        CanMove = false,
        CannotHoldBall = true
    },
    ["Crab Rave"] = {
        Rarity = "Mythic",
        ID = "rbxassetid://99933420003616",
        CanMove = false
    },
    ["The Power"] = {
        Rarity = "Mythic",
        ID = "rbxassetid://122637534823623",
        CanMove = false
    },
    Shiawase = {
        Rarity = "Mythic",
        ID = "rbxassetid://85499941026145",
        CanMove = true
    },
    O = {
        Rarity = "Legendary",
        ID = "rbxassetid://85505988485056",
        CanMove = false
    },
    spider = {
        Rarity = "Epic",
        ID = "rbxassetid://82807471376032",
        CanMove = true
    },
    Trex = {
        Rarity = "Epic",
        ID = "rbxassetid://109575983123542",
        CanMove = true
    },
    ["Gangnam Style"] = {
        Rarity = "Epic",
        ID = "rbxassetid://137646978495251",
        CanMove = false
    },
    Goofy = {
        Rarity = "Epic",
        ID = "rbxassetid://111048170836981",
        CanMove = false
    },
    ["Cat Dance"] = {
        Rarity = "Epic",
        ID = "rbxassetid://96247329551256",
        CanMove = false
    },
    ["Salsa Dance"] = {
        Rarity = "Epic",
        ID = "rbxassetid://134882105476385",
        CanMove = true
    },
    ["S6 Iron Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["S6 Bronze Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["S6 Silver Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["S6 Gold Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["S6 Diamond Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["S6 Platinum Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["S6 Master Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["S6 Champion Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["S6 Legend Badge"] = {
        Rarity = "Limited",
        ID = "rbxassetid://83961542273985",
        CanMove = false
    },
    ["Aura Monster"] = {
        Rarity = "Limited",
        ID = "rbxassetid://74539977377039",
        CanMove = true,
        Locked = "Temp"
    },
    ["Cursed Valentine"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        GlobalCooldown = 0.1,
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        Unreleased = true,
        Locked = true
    },
    ["Shadow Eye Battle"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        GlobalCooldown = 0.1,
        IsCutscene = true,
        ServerScript = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        Unreleased = true,
        Locked = true
    },
    ["Low Cortisol"] = {
        Rarity = "Limited",
        ID = "rbxassetid://122461335795197",
        CanMove = false,
        Unreleased = true
    },
    Looping = {
        Rarity = "Limited",
        ID = "rbxassetid://111847394396134",
        CanMove = true,
        Unreleased = true
    },
    ["Sign Of Peace"] = {
        Rarity = "Limited",
        ID = "rbxassetid://103345315120953",
        CanMove = false,
        Unreleased = true
    },
    ["Dark Horse Ride"] = {
        Rarity = "Limited",
        ID = "rbxassetid://115023879839177",
        CanMove = true,
        Unreleased = true
    },
    Teabag = {
        Rarity = "Limited",
        ID = "rbxassetid://126159722778325",
        CanMove = true,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Romantic Dance"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        CanMove = true,
        DuoCallback = "Romantic Dance Duo",
        CannotPlayOnScore = true,
        Unreleased = true,
        Locked = true
    },
    Floating = {
        Rarity = "Limited",
        ID = "rbxassetid://105226049685436",
        CanMove = true,
        Unreleased = true,
        Locked = "Temp"
    },
    Limousine = {
        Rarity = "Limited",
        ID = "rbxassetid://89290305716080",
        CanMove = true,
        DisableAirChecks = true,
        CannotHoldBall = true,
        CannotPlayInRanked = true,
        Unreleased = true,
        Locked = true
    },
    ["Love Skateboard"] = {
        Rarity = "Limited",
        ID = "rbxassetid://126713627031739",
        CanMove = true,
        Unreleased = true,
        Locked = true
    },
    ["Sneaky Block"] = {
        Rarity = "Limited",
        ID = "rbxassetid://85085420170795",
        DisableAirChecks = true,
        CanMove = true,
        Unreleased = true,
        Locked = true
    },
    ["Sneaky Shot"] = {
        Rarity = "Limited",
        ID = "rbxassetid://92462901193976",
        DisableAirChecks = true,
        CanMove = true,
        Unreleased = true,
        Locked = true
    },
    ["Sneaky Ragdoll"] = {
        Rarity = "Limited",
        ID = "rbxassetid://0",
        ServerScript = true,
        DisableAirChecks = true,
        Unreleased = true,
        Locked = true
    },
    ["Papaya Surfboard"] = {
        Rarity = "Limited",
        ID = "rbxassetid://107247692735361",
        DisableAirChecks = true,
        CanMove = true,
        Unreleased = true,
        Locked = "Temp"
    },
    ["AMG Skateboard"] = {
        Rarity = "Limited",
        ID = "rbxassetid://126713627031739",
        CanMove = true,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Cursed Skateboard"] = {
        Rarity = "Limited",
        ID = "rbxassetid://126713627031739",
        CanMove = true,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Arrow"] = {
        Rarity = "Limited",
        ID = "rbxassetid://107811633842650",
        CanMove = true,
        Unreleased = true,
        Locked = true
    },
    ["Emr4n\'s Car"] = {
        Rarity = "Limited",
        ID = "rbxassetid://126713627031739",
        CanMove = true,
        Unreleased = true,
        Locked = true
    },
    ["Skarp\'s Rage"] = {
        Rarity = "Limited",
        ID = "rbxassetid://125141898114991",
        CanMove = true,
        Unreleased = true,
        Locked = true
    }
};
v1.GoalEffects = {
    Default = {
        Rarity = "Epic"
    },
    Wind = {
        Rarity = "Rare"
    },
    HellFire = {
        Rarity = "Limited"
    },
    Symbiote = {
        Rarity = "Limited"
    },
    AURA = {
        Rarity = "Limited"
    },
    Cyber = {
        Rarity = "Limited"
    },
    IDOL = {
        Rarity = "Limited"
    },
    ["Sunburst Slam"] = {
        Rarity = "Limited"
    },
    Tsunami = {
        Rarity = "Limited"
    },
    Fireworks = {
        Rarity = "Limited"
    },
    Current = {
        Rarity = "Limited"
    },
    Garbage = {
        Rarity = "Limited"
    },
    Skulls = {
        Rarity = "Limited"
    },
    Beast = {
        Rarity = "Limited"
    },
    ["BASKETBALL GOD\'S GOAL"] = {
        Rarity = "Limited"
    },
    ["Emperor\'s Aura"] = {
        Rarity = "Limited"
    },
    Meteor = {
        Rarity = "Limited"
    },
    Wet = {
        Rarity = "Limited"
    },
    ["Lightning Storm"] = {
        Rarity = "Limited"
    },
    ["Perfect Explosion"] = {
        Rarity = "Limited"
    },
    ["Always In"] = {
        Rarity = "Epic"
    },
    ["SLIME!"] = {
        Rarity = "Rare"
    },
    ["Sand Explosion"] = {
        Rarity = "Rare"
    },
    Water = {
        Rarity = "Epic"
    },
    Ice = {
        Rarity = "Epic"
    },
    Venom = {
        Rarity = "Epic"
    },
    SLASH = {
        Rarity = "Limited"
    },
    Atomic = {
        Rarity = "Limited"
    },
    Glitch = {
        Rarity = "Epic"
    },
    Music = {
        Rarity = "Epic"
    },
    Smoke = {
        Rarity = "Rare"
    },
    Butterfly = {
        Rarity = "Rare"
    },
    Lightning = {
        Rarity = "Legendary"
    },
    Dark = {
        Rarity = "Legendary"
    },
    Boom = {
        Rarity = "Epic"
    },
    Constellation = {
        Rarity = "Epic"
    },
    Rocket = {
        Rarity = "Limited"
    },
    Timestop = {
        Rarity = "Limited"
    },
    Jackpot = {
        Rarity = "Limited"
    },
    Nature = {
        Rarity = "Limited"
    },
    ["Energy Beam"] = {
        Rarity = "Limited"
    },
    Rulebook = {
        Rarity = "Limited"
    },
    Lowrider = {
        Rarity = "Limited"
    },
    ["Rubber Duck"] = {
        Rarity = "Limited"
    },
    HAHA = {
        Rarity = "Limited"
    },
    ["Flying Knife"] = {
        Rarity = "Limited"
    },
    ["Wazzup!"] = {
        Rarity = "Limited"
    },
    Chainsaw = {
        Rarity = "Limited"
    },
    ["Floating Pumpkins"] = {
        Rarity = "Limited"
    },
    ["Candle Explosion"] = {
        Rarity = "Limited"
    },
    Butterflies = {
        Rarity = "Limited"
    },
    ["Shark Fins"] = {
        Rarity = "Limited"
    },
    ["UFO Goal"] = {
        Rarity = "Limited"
    },
    ["Cyber Tentacles"] = {
        Rarity = "Limited"
    },
    ["Dino Roar"] = {
        Rarity = "Limited"
    },
    Concert = {
        Rarity = "Limited"
    },
    ["Music Notes"] = {
        Rarity = "Limited"
    },
    Throne = {
        Rarity = "Limited"
    },
    Trophy = {
        Rarity = "Limited"
    },
    ["Dragon Summon"] = {
        Rarity = "Limited"
    },
    ["Eclipse Goal"] = {
        Rarity = "Limited"
    },
    ["77"] = {
        Rarity = "Limited"
    },
    ["Buzzer Beater"] = {
        Rarity = "Limited"
    },
    ["Card Explosion"] = {
        Rarity = "Limited"
    },
    ["Different Dimension"] = {
        Rarity = "Limited"
    },
    ["67"] = {
        Rarity = "Limited"
    },
    ["Laser Beam"] = {
        Rarity = "Limited"
    },
    Error = {
        Rarity = "Limited"
    },
    Nuke = {
        Rarity = "Limited"
    },
    L = {
        Rarity = "Limited"
    },
    ["Void Domain"] = {
        Rarity = "Limited"
    },
    ["Super Slam"] = {
        Rarity = "Limited"
    },
    ["Floating Eye"] = {
        Rarity = "Limited"
    },
    ["Fighter Jets"] = {
        Rarity = "Limited"
    },
    ["Whale Dance"] = {
        Rarity = "Limited"
    },
    ["Whale Drop"] = {
        Rarity = "Limited"
    },
    ["Anvil Drop"] = {
        Rarity = "Limited"
    },
    ["Piano Drop"] = {
        Rarity = "Limited"
    },
    ["Playing Piano"] = {
        Rarity = "Limited"
    },
    ["Playing Guitar"] = {
        Rarity = "Limited"
    },
    ["Playing Violin"] = {
        Rarity = "Limited"
    },
    ["Disco Ball"] = {
        Rarity = "Limited"
    },
    ["Spray Paint"] = {
        Rarity = "Limited"
    },
    Lotus = {
        Rarity = "Limited"
    },
    ["Wormhole Energy"] = {
        Rarity = "Limited"
    },
    ["Slow Dancer"] = {
        Rarity = "Limited"
    },
    Goat = {
        Rarity = "Limited"
    },
    ["Valentine\'s Aura"] = {
        Rarity = "Limited"
    },
    ["Coin Explosion"] = {
        Rarity = "Limited"
    },
    TNT = {
        Rarity = "Limited"
    },
    Siren = {
        Rarity = "Limited"
    },
    Bowling = {
        Rarity = "Limited"
    },
    ["Hee Hee"] = {
        Rarity = "Limited"
    },
    ["Pop Legend"] = {
        Rarity = "Limited"
    },
    ["Trophy Lift"] = {
        Rarity = "Limited"
    },
    ["Death Watching"] = {
        Rarity = "Limited"
    },
    ["Pixel Explosion"] = {
        Rarity = "Limited"
    },
    ["Perfect Goal"] = {
        Rarity = "Limited"
    },
    ["Za Warudo"] = {
        Rarity = "Limited"
    },
    Arrows = {
        Rarity = "Limited"
    },
    ["Purple Eye"] = {
        Rarity = "Limited"
    },
    ["Skeleton Arm"] = {
        Rarity = "Limited"
    },
    ["Bat Swarm"] = {
        Rarity = "Limited"
    },
    ["Ghost Tornado"] = {
        Rarity = "Limited"
    },
    ["S2 Bronze Burst"] = {
        Rarity = "Limited"
    },
    ["S2 Iron Burst"] = {
        Rarity = "Limited"
    },
    ["S2 Gold Burst"] = {
        Rarity = "Limited"
    },
    ["S2 Silver Burst"] = {
        Rarity = "Limited"
    },
    ["S2 Diamond Burst"] = {
        Rarity = "Limited"
    },
    ["S2 Platinum Burst"] = {
        Rarity = "Limited"
    },
    ["S2 Master Burst"] = {
        Rarity = "Limited"
    },
    ["S2 Champion Burst"] = {
        Rarity = "Limited"
    },
    ["S2 Legend Burst"] = {
        Rarity = "Limited"
    },
    ["S4 Bronze Crown"] = {
        Rarity = "Limited"
    },
    ["S4 Iron Crown"] = {
        Rarity = "Limited"
    },
    ["S4 Gold Crown"] = {
        Rarity = "Limited"
    },
    ["S4 Silver Crown"] = {
        Rarity = "Limited"
    },
    ["S4 Diamond Crown"] = {
        Rarity = "Limited"
    },
    ["S4 Platinum Crown"] = {
        Rarity = "Limited"
    },
    ["S4 Master Crown"] = {
        Rarity = "Limited"
    },
    ["S4 Champion Crown"] = {
        Rarity = "Limited"
    },
    ["S4 Legend Crown"] = {
        Rarity = "Limited"
    },
    ["S7 Bronze Orb"] = {
        Rarity = "Limited"
    },
    ["S7 Iron Orb"] = {
        Rarity = "Limited"
    },
    ["S7 Gold Orb"] = {
        Rarity = "Limited"
    },
    ["S7 Silver Orb"] = {
        Rarity = "Limited"
    },
    ["S7 Diamond Orb"] = {
        Rarity = "Limited"
    },
    ["S7 Platinum Orb"] = {
        Rarity = "Limited"
    },
    ["S7 Master Orb"] = {
        Rarity = "Limited"
    },
    ["S7 Champion Orb"] = {
        Rarity = "Limited"
    },
    ["S7 Legend Orb"] = {
        Rarity = "Limited"
    },
    Promotion = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["Get A Job"] = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["Cursed Beam"] = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["Cursed Card Explosion"] = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["Cursed Clock"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["All Star Crown"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    Eulogized = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    ["Current Orb"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    Retro = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    ["Glowing Tornado"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    ["Meowzen Aura"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Tatlis Domain"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Butler\'s Train"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Limousine = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Love Crown"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Papaya Triple Crown"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    ["AMG Silver Arrows"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    ["Sneaky Dog"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Sneaky Baby"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Sneaky Pointing"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    ["Emr4n\'s Domain"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Skarp Crown"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Shadow Domain"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    }
};
v1.ShotEffects = {
    Water = {
        Rarity = "Rare"
    },
    Fire = {
        Rarity = "Rare"
    },
    Joker = {
        Rarity = "Epic"
    },
    Lightning = {
        Rarity = "Epic"
    },
    ["Blue Glitch"] = {
        Rarity = "Legendary"
    },
    ["Pink Glitch"] = {
        Rarity = "Legendary"
    },
    Dragon = {
        Rarity = "Mythic"
    },
    Green = {
        Rarity = "Mythic"
    },
    Strongest = {
        Rarity = "Limited"
    },
    Chrollo = {
        Rarity = "Limited"
    },
    Cartoon = {
        Rarity = "Limited"
    },
    Music = {
        Rarity = "Limited"
    },
    ["S11 Bronze Burst"] = {
        Rarity = "Limited"
    },
    ["S11 Iron Burst"] = {
        Rarity = "Limited"
    },
    ["S11 Gold Burst"] = {
        Rarity = "Limited"
    },
    ["S11 Silver Burst"] = {
        Rarity = "Limited"
    },
    ["S11 Diamond Burst"] = {
        Rarity = "Limited"
    },
    ["S11 Platinum Burst"] = {
        Rarity = "Limited"
    },
    ["S11 Master Burst"] = {
        Rarity = "Limited"
    },
    ["S11 Champion Burst"] = {
        Rarity = "Limited"
    },
    ["S11 Legend Burst"] = {
        Rarity = "Limited"
    },
    ["The Royal"] = {
        Rarity = "Limited",
        Unreleased = true
    },
    Current = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["All Star"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    Love = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Eternal = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Papaya = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    AMG = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    Emr4n = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Contakt = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Butler = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Cursed = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Shadow = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Skarp = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    }
};
v1.Cards = {
    Samurai = {
        Rarity = "Limited"
    },
    Jackpot = {
        Rarity = "Limited"
    },
    ["Pink Demon"] = {
        Rarity = "Limited"
    },
    Vampire = {
        Rarity = "Limited"
    },
    Theatre = {
        Rarity = "Limited"
    },
    Perfection = {
        Rarity = "Limited"
    },
    Designer = {
        Rarity = "Limited"
    },
    Galaxy = {
        Rarity = "Limited"
    },
    King = {
        Rarity = "Limited"
    },
    ["Rich Vibes"] = {
        Rarity = "Limited"
    },
    ["GOLDEN MATCH"] = {
        Rarity = "Limited"
    },
    Sky = {
        Rarity = "Limited"
    },
    Halloween = {
        Rarity = "Limited"
    },
    Popstar = {
        Rarity = "Limited"
    },
    ["The King"] = {
        Rarity = "Limited"
    },
    Luka = {
        Rarity = "Limited"
    },
    Dealer = {
        Rarity = "Limited"
    },
    Fade = {
        Rarity = "Limited"
    },
    HAHA = {
        Rarity = "Limited"
    },
    ["Current."] = {
        Rarity = "Limited"
    },
    Brain = {
        Rarity = "Limited"
    },
    Void = {
        Rarity = "Limited"
    },
    ["Chrollo Vs Tatlis"] = {
        Rarity = "Limited"
    },
    Judgement = {
        Rarity = "Limited"
    },
    ["Red Rock"] = {
        Rarity = "Limited"
    },
    ["Punk Rock"] = {
        Rarity = "Limited"
    },
    ["EDM Retro"] = {
        Rarity = "Limited"
    },
    Illusion = {
        Rarity = "Limited"
    },
    Skyline = {
        Rarity = "Limited"
    },
    Whale = {
        Rarity = "Limited"
    },
    Star = {
        Rarity = "Limited"
    },
    ["Goat Life"] = {
        Rarity = "Limited"
    },
    Crown = {
        Rarity = "Limited"
    },
    ["Union Flag"] = {
        Rarity = "Limited"
    },
    Checkmate = {
        Rarity = "Limited"
    },
    ["King Of Pop"] = {
        Rarity = "Limited"
    },
    Malware = {
        Rarity = "Limited"
    },
    Alien = {
        Rarity = "Limited"
    },
    ["New York"] = {
        Rarity = "Limited"
    },
    ["Golden Eye"] = {
        Rarity = "Limited"
    },
    ["Indoor Fish"] = {
        Rarity = "Limited"
    },
    ["Emperor Eye"] = {
        Rarity = "Limited"
    },
    Souls = {
        Rarity = "Limited"
    },
    Glitchy = {
        Rarity = "Limited"
    },
    ["Scary Monster"] = {
        Rarity = "Limited"
    },
    ["1000 Pages"] = {
        Rarity = "Limited"
    },
    ["Perfection V2"] = {
        Rarity = "Limited"
    },
    Bizarre = {
        Rarity = "Limited"
    },
    ["Red Clouds"] = {
        Rarity = "Limited"
    },
    ["Spooky Face"] = {
        Rarity = "Limited"
    },
    Bats = {
        Rarity = "Limited"
    },
    ["Spooky Pal"] = {
        Rarity = "Limited"
    },
    Basic = {
        Rarity = "Rare"
    },
    Basketball = {
        Rarity = "Legendary"
    },
    ["Blue Graffiti"] = {
        Rarity = "Epic"
    },
    ["Cool Guy"] = {
        Rarity = "Legendary"
    },
    ["Dead Lightning"] = {
        Rarity = "Legendary"
    },
    Graffiti = {
        Rarity = "Epic"
    },
    ["Green Design"] = {
        Rarity = "Rare"
    },
    ["Green Graffiti"] = {
        Rarity = "Epic"
    },
    Lion = {
        Rarity = "Legendary"
    },
    ["Orange Paint"] = {
        Rarity = "Epic"
    },
    ["Purple Design"] = {
        Rarity = "Rare"
    },
    ["S13 Iron Card"] = {
        Rarity = "Limited"
    },
    ["S13 Bronze Card"] = {
        Rarity = "Limited"
    },
    ["S13 Silver Card"] = {
        Rarity = "Limited"
    },
    ["S13 Gold Card"] = {
        Rarity = "Limited"
    },
    ["S13 Platinum Card"] = {
        Rarity = "Limited"
    },
    ["S13 Diamond Card"] = {
        Rarity = "Limited"
    },
    ["S13 Master Card"] = {
        Rarity = "Limited"
    },
    ["S13 Champion Card"] = {
        Rarity = "Limited"
    },
    ["S13 Legend Card"] = {
        Rarity = "Limited"
    },
    Shrines = {
        Rarity = "Limited",
        Locked = true
    },
    Current = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["Triple T"] = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["Aura Monster"] = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["Sweet Butler"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Nom Nom Shark"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Otokonoko = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Dunking Cat"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Fallen Angel"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Obi = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Papaya = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    AMG = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    Contakt = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Skarp = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Sneaky Dog"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Sneaky Baby"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Sneaky Pointing"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    }
};
v1.Outfits = {};
v1.MVPCutscenes = {
    Ace = {
        Rarity = "Limited"
    },
    Copycat = {
        Rarity = "Limited"
    },
    Sniper = {
        Rarity = "Limited"
    }
};
v1.Cosmetics = {
    ["Witch Hat"] = {
        Rarity = "Rare",
        IconId = 136841376763731
    },
    ["Arm Band"] = {
        Rarity = "Rare",
        IconId = 111043095468543
    },
    Mech = {
        Rarity = "Rare",
        IconId = 110405186090855
    },
    ["Jetpack Backpack"] = {
        Rarity = "Rare",
        IconId = 117450060360453
    },
    ["Shark Fin Backpack"] = {
        Rarity = "Rare",
        IconId = 98504290829209
    },
    ["Demon Wings"] = {
        Rarity = "Epic",
        IconId = 71710521114045
    },
    Glitchy = {
        Rarity = "Epic",
        IconId = 118410124263440
    },
    ["MVP Chain"] = {
        Rarity = "Epic",
        IconId = 86681479130252
    },
    ["Paper Bag Mask"] = {
        Rarity = "Epic",
        IconId = 132258727033121
    },
    ["Chef Hat"] = {
        Rarity = "Epic",
        IconId = 103850505885641
    },
    ["Watcher Eye"] = {
        Rarity = "Legendary",
        IconId = 77047540419447
    },
    ["Ancient Vines"] = {
        Rarity = "Legendary",
        IconId = 77150975683272
    },
    ["Magma Arms"] = {
        Rarity = "Legendary",
        IconId = 97463270479483
    },
    ["Duffel Bag"] = {
        Rarity = "Legendary",
        IconId = 108221498868635
    },
    ["Glacier Arms"] = {
        Rarity = "Legendary",
        IconId = 87829664264587
    },
    ["Giant Tongue"] = {
        Rarity = "Mythic",
        IconId = 134174030930145
    },
    Backpack = {
        Rarity = "Limited",
        IconId = 86408632419349
    },
    Bear = {
        Rarity = "Limited",
        IconId = 120915370145073
    },
    ["Cat!"] = {
        Rarity = "Limited",
        IconId = 97339540781423
    },
    Winner = {
        Rarity = "Limited",
        IconId = 130657999338631
    },
    Unlimited = {
        Rarity = "Limited",
        IconId = 122644763153334
    },
    ["Oni\'s Wrath"] = {
        Rarity = "Limited",
        IconId = 76092434619806
    },
    ["Vampire Cape"] = {
        Rarity = "Limited",
        IconId = 92674446383696
    },
    ["Emperor Cape"] = {
        Rarity = "Limited",
        IconId = 72795349347722
    },
    ["Cherry Blossom Cape"] = {
        Rarity = "Limited",
        IconId = 113400243349500
    },
    Model = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Meteor Aura"] = {
        Rarity = "Limited",
        IconId = 92360371631965
    },
    ["Perfect Wings"] = {
        Rarity = "Limited",
        IconId = 109477220993026
    },
    Skateboard = {
        Rarity = "Limited",
        IconId = 97118708959273
    },
    ["Gold Cape"] = {
        Rarity = "Limited",
        IconId = 115578313757320
    },
    ["Demon Dog"] = {
        Rarity = "Limited",
        IconId = 140314367686265
    },
    ["Golden Backpack"] = {
        Rarity = "Limited",
        IconId = 72208773220903
    },
    ["Rulebook Backpack"] = {
        Rarity = "Limited",
        IconId = 72208773220903
    },
    ["Sun Man"] = {
        Rarity = "Limited",
        IconId = 117484811726099
    },
    ["Straw Hat"] = {
        Rarity = "Limited",
        IconId = 118964374726249
    },
    ["Pineapple Head"] = {
        Rarity = "Limited",
        IconId = 76364924359271
    },
    ["Current Cape"] = {
        Rarity = "Limited",
        IconId = 76514242283482
    },
    ["Phoenix Cape"] = {
        Rarity = "Limited",
        IconId = 129419937095218
    },
    ["Brother Duo"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Cyber Jacket"] = {
        Rarity = "Limited",
        IconId = 136654650736341
    },
    ["Psychic Jacket"] = {
        Rarity = "Limited",
        IconId = 121772979892295
    },
    Clouds = {
        Rarity = "Limited",
        IconId = 126859822859388
    },
    Tentacles = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Referee Cape"] = {
        Rarity = "Limited",
        IconId = 102456292697160
    },
    ["Referee Hat"] = {
        Rarity = "Limited",
        IconId = 99413547351572
    },
    ["Old Radio"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Duck Hat"] = {
        Rarity = "Limited",
        IconId = 110539605124247
    },
    ["Heart Balloon"] = {
        Rarity = "Limited",
        IconId = 135003838836271
    },
    ["Joker Cape"] = {
        Rarity = "Limited",
        IconId = 110807427693401
    },
    ["Wazzup! Mask"] = {
        Rarity = "Limited",
        IconId = 82323460324453
    },
    ["Ghost Mask"] = {
        Rarity = "Limited",
        IconId = 83110126797359
    },
    ["Prop Knife"] = {
        Rarity = "Limited",
        IconId = 136278597166425
    },
    Candles = {
        Rarity = "Limited",
        IconId = 118782334543221
    },
    Chainsaw = {
        Rarity = "Limited",
        IconId = 125051220071437
    },
    ["Pumpkin Head"] = {
        Rarity = "Limited",
        IconId = 116187318122117
    },
    ["Orange Butterfly Wings"] = {
        Rarity = "Limited",
        IconId = 85513594376320
    },
    ["Blue Butterfly Wings"] = {
        Rarity = "Limited",
        IconId = 131101844161925
    },
    ["Cyber Glasses"] = {
        Rarity = "Limited",
        IconId = 140606306228844
    },
    ["Cyber Helmet"] = {
        Rarity = "Limited",
        IconId = 112224892010990
    },
    ["Cyber Wings"] = {
        Rarity = "Limited",
        IconId = 136477290717167
    },
    ["Dino Backpack"] = {
        Rarity = "Limited",
        IconId = 104318386867137
    },
    ["Popstar Keytar"] = {
        Rarity = "Limited",
        IconId = 101263649820031
    },
    ["Popstar Guitar"] = {
        Rarity = "Limited",
        IconId = 94163465029214
    },
    ["Popstar Backpack"] = {
        Rarity = "Limited",
        IconId = 115124907270048
    },
    ["Hanging Shoes"] = {
        Rarity = "Limited",
        IconId = 73929945933671
    },
    ["King\'s Crown"] = {
        Rarity = "Limited",
        IconId = 90309673900739
    },
    ["Air\'s Trophy"] = {
        Rarity = "Limited",
        IconId = 101290351868927
    },
    ["Samurai Hat"] = {
        Rarity = "Limited",
        IconId = 137226640327483
    },
    ["Dual Katanas"] = {
        Rarity = "Limited",
        IconId = 73243283030247
    },
    ["Dragon Wrap"] = {
        Rarity = "Limited",
        IconId = 125007357910635
    },
    ["Luka\'s Chain"] = {
        Rarity = "Limited",
        IconId = 89747228123561
    },
    ["Luka\'s Shades"] = {
        Rarity = "Limited",
        IconId = 139362748121383
    },
    Viki = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Ace Backpack"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Arm Wraps"] = {
        Rarity = "Limited",
        IconId = 137493381899995
    },
    ["Crystal Arms"] = {
        Rarity = "Limited",
        IconId = 117572165302347
    },
    ["Dog Mascot"] = {
        Rarity = "Limited",
        IconId = 96499897265718
    },
    ["Chrollo Mascot"] = {
        Rarity = "Limited",
        IconId = 124496632096728
    },
    ["Hawk Mascot"] = {
        Rarity = "Limited",
        IconId = 76097946350775
    },
    ["Duck Mascot"] = {
        Rarity = "Limited",
        IconId = 134419901715051
    },
    ["BlueBee Mascot"] = {
        Rarity = "Limited",
        IconId = 79746681752621
    },
    ["Bull Mascot"] = {
        Rarity = "Limited",
        IconId = 106376771176107
    },
    ["Teddy Mascot"] = {
        Rarity = "Limited",
        IconId = 107879705212872
    },
    ["Jofu Mascot"] = {
        Rarity = "Limited",
        IconId = 121248555618586
    },
    ["Tatlis Mascot"] = {
        Rarity = "Limited",
        IconId = 98289327859040
    },
    ["0 IQ"] = {
        Rarity = "Limited",
        IconId = 137683053581522
    },
    ["Obsessed Octopus"] = {
        Rarity = "Limited",
        IconId = 81078207781943
    },
    ["Love Chain"] = {
        Rarity = "Limited",
        IconId = 78033986098730
    },
    ["Honored One Suit"] = {
        Rarity = "Limited",
        IconId = 103250127853478
    },
    ["Bunny Ears"] = {
        Rarity = "Limited",
        IconId = 115971250376631
    },
    ["Prince Hat"] = {
        Rarity = "Limited",
        IconId = 100485107383291
    },
    ["Inflatable Flamingo"] = {
        Rarity = "Limited",
        IconId = 85271997775494
    },
    ["Giant Mouth"] = {
        Rarity = "Limited",
        IconId = 103943755101630
    },
    ["Chicken Hat"] = {
        Rarity = "Limited",
        IconId = 124179710742367
    },
    ["Six Eyes"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Chrollo Plush"] = {
        Rarity = "Limited",
        IconId = 81156184210675
    },
    ["Tatlis Plush"] = {
        Rarity = "Limited",
        IconId = 83366608122488
    },
    ["Judgement Gavel"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Blossom Skull"] = {
        Rarity = "Limited",
        IconId = 136781133909683
    },
    ["Rose Grave"] = {
        Rarity = "Limited",
        IconId = 111324336733583
    },
    ["Koi Tide"] = {
        Rarity = "Limited",
        IconId = 103091923191806
    },
    ["Sea Of Dragon"] = {
        Rarity = "Limited",
        IconId = 95630792085696
    },
    ["Stone Bloom"] = {
        Rarity = "Limited",
        IconId = 140093025109767
    },
    ["Tiger Garden"] = {
        Rarity = "Limited",
        IconId = 101043416289132
    },
    ["Combat Vest"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Black Mask"] = {
        Rarity = "Limited",
        IconId = 138877119519298
    },
    ["White Mask"] = {
        Rarity = "Limited",
        IconId = 120583242392255
    },
    ["Gold Mask"] = {
        Rarity = "Limited",
        IconId = 130086474499114
    },
    ["Red Mask"] = {
        Rarity = "Limited",
        IconId = 113636731961547
    },
    ["Locked In Mask"] = {
        Rarity = "Limited",
        IconId = 125883091795055
    },
    ["Johnny\'s Beanie"] = {
        Rarity = "Limited",
        IconId = 0
    },
    Tusk = {
        Rarity = "Limited",
        IconId = 0
    },
    ["D4C Ears"] = {
        Rarity = "Limited",
        IconId = 134468637851005
    },
    ["Valentine Jacket"] = {
        Rarity = "Limited",
        IconId = 76467740576473
    },
    Menacing = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Golden Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Current. Suit"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Michael\'s Smooth Suit"] = {
        Rarity = "Limited",
        IconId = 84910795009227
    },
    ["Michael\'s Thrilling Suit"] = {
        Rarity = "Limited",
        IconId = 133473084966155
    },
    ["The Moonwalker"] = {
        Rarity = "Limited",
        IconId = 71177113477624
    },
    ["Thief Jacket"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Alien Head"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["New York Crown"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Golden Shades"] = {
        Rarity = "Limited",
        IconId = 111420883856270
    },
    ["Golden Sleeves"] = {
        Rarity = "Limited",
        IconId = 112984952909420
    },
    ["Requiem Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Glitchy Cubes"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Scary Monster Jacket"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Death Book"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Perfect Jacket"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Stardust Jacket"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Stardust Hat"] = {
        Rarity = "Limited",
        IconId = 0
    },
    Arrow = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Nine Tails"] = {
        Rarity = "Limited",
        IconId = 85320515660396
    },
    ["Ninja Cloak"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Evil Pumpkin Head"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Bat Wings"] = {
        Rarity = "Limited",
        IconId = 115673822992403
    },
    Killer = {
        Rarity = "Limited",
        IconId = 102508420607382
    },
    Reaper = {
        Rarity = "Limited",
        IconId = 85160660445044
    },
    ["Head Cover"] = {
        Rarity = "Limited",
        IconId = 132528541702622
    },
    ["Current Chain"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Sneaky Trails"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S1 Bronze Badge"] = {
        Rarity = "Limited",
        IconId = 125309372637808
    },
    ["S1 Silver Badge"] = {
        Rarity = "Limited",
        IconId = 81796243150515
    },
    ["S1 Gold Badge"] = {
        Rarity = "Limited",
        IconId = 140278250732459
    },
    ["S1 Iron Badge"] = {
        Rarity = "Limited",
        IconId = 99250399047951
    },
    ["S1 Diamond Badge"] = {
        Rarity = "Limited",
        IconId = 93076830728029
    },
    ["S1 Platinum Badge"] = {
        Rarity = "Limited",
        IconId = 81805445203153
    },
    ["S1 Champion Badge"] = {
        Rarity = "Limited",
        IconId = 109558650230755
    },
    ["S8 Bronze Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S8 Silver Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S8 Gold Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S8 Iron Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S8 Diamond Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S8 Platinum Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S8 Master Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S8 Champion Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S8 Legend Back Trophy"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Bronze Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Silver Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Gold Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Iron Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Diamond Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Platinum Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Master Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Champion Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S9 Legend Staff"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Bronze Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Silver Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Gold Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Iron Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Diamond Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Platinum Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Master Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Champion Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["S12 Legend Aura"] = {
        Rarity = "Limited",
        IconId = 0
    },
    ["Current. Aura"] = {
        Rarity = "Limited",
        IconId = 77918892981381
    },
    ["Seiryū Aura"] = {
        Rarity = "Limited",
        IconId = 122943661908211
    },
    ["Raikami Aura"] = {
        Rarity = "Limited",
        IconId = 99202537516370
    },
    ["Kumajin Aura"] = {
        Rarity = "Limited",
        IconId = 74234268854823
    },
    ["Taurajin Aura"] = {
        Rarity = "Limited",
        IconId = 98755337182985
    },
    ["Fukurōkai Aura"] = {
        Rarity = "Limited",
        IconId = 132985880210976
    },
    ["Leorai Aura"] = {
        Rarity = "Limited",
        IconId = 139405114480462
    },
    ["Raidenuma Aura"] = {
        Rarity = "Limited",
        IconId = 88579700158504
    },
    ["Orochii Aura"] = {
        Rarity = "Limited",
        IconId = 82328272845484
    },
    ["San Diego Orcas Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Madrid Warriors Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["BBZ Belt"] = {
        Rarity = "Limited",
        IconId = 98379527886894,
        Locked = true
    },
    ["Slaying Moon"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Dark Scythe"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Demon Slayer"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Fairy Wings"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Dark Fairy Wings"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Dark Cloak"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Demon Lord Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Black Shock Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Chrollo Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Perfection Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Mist Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Money Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["Shadow Katana"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Snow Katana"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Thunder Katana"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Chaos Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Vampire Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Storm Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Thunder Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Gold Eye Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true
    },
    ["White Eye Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Black Eye Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Skarp Eye Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["All Star Model"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Water Model"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Number Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Butler\'s Energy"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Love Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Love Scythe"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Papaya Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = "Temp"
    },
    ["AMG Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Cursed Energy"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Menacing"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Scythe"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Cloak"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Arm"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Vampire Aura"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Skateboard"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Arrow"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Cursed Model"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    Blackbear = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = "Temp"
    },
    ["Demon Blackbear"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    },
    ["Emr4n\'s Playtoy"] = {
        Rarity = "Limited",
        IconId = 0,
        Unreleased = true,
        Locked = true
    }
};
v1.ChatTags = {
    Sneaky = {
        Rarity = "Limited"
    },
    Legend = {
        Rarity = "Limited"
    },
    ["S1 Champion 3"] = {
        Rarity = "Limited"
    },
    ["S3 Iron"] = {
        Rarity = "Limited"
    },
    ["S3 Bronze"] = {
        Rarity = "Limited"
    },
    ["S3 Silver"] = {
        Rarity = "Limited"
    },
    ["S3 Gold"] = {
        Rarity = "Limited"
    },
    ["S3 Platinum"] = {
        Rarity = "Limited"
    },
    ["S3 Diamond"] = {
        Rarity = "Limited"
    },
    ["S3 Master"] = {
        Rarity = "Limited"
    },
    ["S3 Champion"] = {
        Rarity = "Limited"
    },
    ["S3 Legend"] = {
        Rarity = "Limited"
    },
    ["S5 Iron"] = {
        Rarity = "Limited"
    },
    ["S5 Bronze"] = {
        Rarity = "Limited"
    },
    ["S5 Silver"] = {
        Rarity = "Limited"
    },
    ["S5 Gold"] = {
        Rarity = "Limited"
    },
    ["S5 Platinum"] = {
        Rarity = "Limited"
    },
    ["S5 Diamond"] = {
        Rarity = "Limited"
    },
    ["S5 Master"] = {
        Rarity = "Limited"
    },
    ["S5 Champion"] = {
        Rarity = "Limited"
    },
    ["S5 Legend"] = {
        Rarity = "Limited"
    },
    ["S10 Iron"] = {
        Rarity = "Limited"
    },
    ["S10 Bronze"] = {
        Rarity = "Limited"
    },
    ["S10 Silver"] = {
        Rarity = "Limited"
    },
    ["S10 Gold"] = {
        Rarity = "Limited"
    },
    ["S10 Platinum"] = {
        Rarity = "Limited"
    },
    ["S10 Diamond"] = {
        Rarity = "Limited"
    },
    ["S10 Master"] = {
        Rarity = "Limited"
    },
    ["S10 Champion"] = {
        Rarity = "Limited"
    },
    ["S10 Legend"] = {
        Rarity = "Limited"
    },
    ["S14 Iron"] = {
        Rarity = "Limited"
    },
    ["S14 Bronze"] = {
        Rarity = "Limited"
    },
    ["S14 Silver"] = {
        Rarity = "Limited"
    },
    ["S14 Gold"] = {
        Rarity = "Limited"
    },
    ["S14 Platinum"] = {
        Rarity = "Limited"
    },
    ["S14 Diamond"] = {
        Rarity = "Limited"
    },
    ["S14 Master"] = {
        Rarity = "Limited"
    },
    ["S14 Champion"] = {
        Rarity = "Limited"
    },
    ["S14 Legend"] = {
        Rarity = "Limited"
    },
    ["Current. League"] = {
        Rarity = "Limited"
    },
    ["Seiryū League"] = {
        Rarity = "Limited"
    },
    ["Raikami League"] = {
        Rarity = "Limited"
    },
    ["Kumajin League"] = {
        Rarity = "Limited"
    },
    ["Taurajin League"] = {
        Rarity = "Limited"
    },
    ["Fukurōkai League"] = {
        Rarity = "Limited"
    },
    ["Leorai League"] = {
        Rarity = "Limited"
    },
    ["Raidenuma League"] = {
        Rarity = "Limited"
    },
    ["Orochii League"] = {
        Rarity = "Limited"
    },
    Clan1 = {
        Rarity = "Limited",
        Locked = true
    },
    Clan2 = {
        Rarity = "Limited",
        Locked = true
    },
    Clan3 = {
        Rarity = "Limited",
        Locked = true
    },
    ["General Title"] = {
        Rarity = "Limited"
    },
    ["Emperor Title"] = {
        Rarity = "Limited"
    },
    ["Tatlis Title"] = {
        Rarity = "Limited"
    },
    ["Chrollo Title"] = {
        Rarity = "Limited"
    },
    ["HonoredOne Title"] = {
        Rarity = "Limited"
    },
    ["ScaryMonster Title"] = {
        Rarity = "Limited"
    },
    ["Kira Title"] = {
        Rarity = "Limited"
    },
    ["Valentine Title"] = {
        Rarity = "Limited"
    },
    ["Johnny Title"] = {
        Rarity = "Limited"
    },
    ["Vampire Title"] = {
        Rarity = "Limited"
    },
    ["Ninja Title"] = {
        Rarity = "Limited"
    },
    Perfection = {
        Rarity = "Limited",
        Unreleased = true
    },
    Butterfly = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["King Of Pirates"] = {
        Rarity = "Limited",
        Unreleased = true
    },
    ["Head Of Testers"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Tester Manager"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Community Manager"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Prince = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Princess = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Conqueror = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    ["Contact Made"] = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Furina = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Butler = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Aurelius = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Papaya = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    AMG = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = "Temp"
    },
    Skarp = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Skarp2 = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    },
    Skarp3 = {
        Rarity = "Limited",
        Unreleased = true,
        Locked = true
    }
};

for i, v in require(game:GetService("ReplicatedStorage").Shared.Tables.HalloweenContent) do
    local v3 = i;

    for i2, v4 in v do
        if next(v4) ~= nil and v1[v3][i2] == nil then
            v1[v3][i2] = v4;
        end;
    end;
end;

return v1;