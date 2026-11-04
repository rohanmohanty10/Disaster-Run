 
 

local u1 = {};

function makeCommentator(p2: string, p3: string, p4: any, p5: table, p6: boolean?, p7: table?)
    -- upvalues: u1 (copy)
    u1[p2] = {
        Name = p3 or p2,
        Icon = p4,
        Dialogue = p5,
        Special = p6,
        whitelist = p7
    };
end;

makeCommentator("None", "No Commentator", "");
makeCommentator("Random", "Random Commentator", "");
makeCommentator("ChunkySeal", nil, "rbxassetid://102410115059881", {
    FlowUse = { {
            Dialogue = "Have you ever played Striker Game with your life on the line",
            SoundId = "rbxassetid://107456573019758",
            TimeLength = 5,
            Volume = 2
        }, {
            Dialogue = "Just don\'t lose the ball instantly and you\'ll be good",
            SoundId = "rbxassetid://125733228610344",
            TimeLength = 5,
            Volume = 2
        }, {
            Dialogue = "THE PUZZLE PIECES... THEY\'RE FORMING!",
            SoundId = "rbxassetid://102600414009596",
            TimeLength = 6,
            Volume = 2
        } },
    EnemyFlowUse = { {
            Dialogue = "Yo you lowkey MIGHT want to steal the ball from them I don\'t know...",
            SoundId = "rbxassetid://105652155201866",
            TimeLength = 6,
            Volume = 2
        }, {
            Dialogue = "I can GUARANTEE you that there\'s like a fifty percent chance they are gonna lose the ball, don\'t worry.",
            SoundId = "rbxassetid://86407509160861",
            TimeLength = 7,
            Volume = 2
        } },
    OwnScore = { {
            Dialogue = "Niceeee.",
            SoundId = "rbxassetid://77437927860321",
            TimeLength = 3,
            Volume = 2
        }, {
            Dialogue = "Clean shot.",
            SoundId = "rbxassetid://76829896149016",
            TimeLength = 3,
            Volume = 2
        } },
    Victory = { {
            Dialogue = "I think I personally carried but congrats you did well.",
            SoundId = "rbxassetid://124191679880364",
            TimeLength = 5,
            Volume = 2
        }, {
            Dialogue = "WE, yes ME and YOU, won.",
            SoundId = "rbxassetid://129852658396341",
            TimeLength = 6,
            Volume = 2
        }, {
            Dialogue = "Heh... I guess we sealed the deal... Get it?.. Get it? I\'m sorry.",
            SoundId = "rbxassetid://96936906654271",
            TimeLength = 8,
            Volume = 2
        } },
    FlowEnd = { {
            Dialogue = "I hope you AT LEAST scored one goal during that...",
            SoundId = "rbxassetid://110621483954506",
            TimeLength = 5,
            Volume = 2
        } },
    Tackler = { {
            Dialogue = "You got that.",
            SoundId = "rbxassetid://113955437119996",
            TimeLength = 3,
            Volume = 2
        }, {
            Dialogue = "Alright free steal.",
            SoundId = "rbxassetid://116230240507933",
            TimeLength = 3,
            Volume = 2
        }, {
            Dialogue = "That\'s free.",
            SoundId = "rbxassetid://140558393387772",
            TimeLength = 3,
            Volume = 2
        } },
    EnemyScore = { {
            Dialogue = "What a save!",
            SoundId = "rbxassetid://95121569238435",
            TimeLength = 3,
            Volume = 2
        }, {
            Dialogue = "GOAL!!.. Wait my bad wrong team.",
            SoundId = "rbxassetid://92782438428216",
            TimeLength = 5,
            Volume = 2
        } },
    Kickoff = { {
            Dialogue = "Just turn zero into one alright?",
            SoundId = "rbxassetid://82735693620176",
            TimeLength = 4,
            Volume = 2
        }, {
            Dialogue = "This is boutta be the easiest win of all time bro you got this.",
            SoundId = "rbxassetid://88560149623595",
            TimeLength = 5,
            Volume = 2
        }, {
            Dialogue = "Please don\'t get frame one-d...",
            SoundId = "rbxassetid://78250182724202",
            TimeLength = 4,
            Volume = 2
        } },
    Equip = { {
            Dialogue = "What\'s good gang, it\'s ChunkySeal back again.",
            SoundId = "rbxassetid://123533047884480",
            TimeLength = 5,
            Volume = 2
        }, {
            Dialogue = "Alright so guys in this video we are gonna be voice acting this Striker Game match.",
            SoundId = "rbxassetid://113102710290059",
            TimeLength = 6,
            Volume = 2
        } },
    Defeat = { {
            Dialogue = "You were just lagging right?",
            SoundId = "rbxassetid://128472065546701",
            TimeLength = 4,
            Volume = 2
        }, {
            Dialogue = "You know there\'s always space on the bench right?",
            SoundId = "rbxassetid://95973555467115",
            TimeLength = 5,
            Volume = 2
        } },
    Tackled = { {
            Dialogue = "Damn bro I would not let that one slide.",
            SoundId = "rbxassetid://122691935376711",
            TimeLength = 4,
            Volume = 2
        }, {
            Dialogue = "How did you lose that?",
            SoundId = "rbxassetid://100731396798215",
            TimeLength = 4,
            Volume = 2
        } },
    TeamGoal = { {
            Dialogue = "Nice one mate!",
            SoundId = "rbxassetid://127730174182173",
            TimeLength = 3,
            Volume = 2
        }, {
            Dialogue = "Thank goodness your teammates didn\'t brick that...",
            SoundId = "rbxassetid://102305755581376",
            TimeLength = 4,
            Volume = 2
        } }
});
makeCommentator("MaxGoneBed", nil, "rbxassetid://83977358881910", {
    Equip = { {
            Dialogue = "Hey do you want to hear a joke? Knock Knock... *sniffle* Hello? Hello, you there?",
            SoundId = "rbxassetid://88482197495413",
            Volume = 2,
            TimeLength = 10
        } },
    KickOff = { {
            Dialogue = "You see that round looking thing in the middle? Yeah, you have to-like-put that in the rectangle thing on the other side.",
            SoundId = "rbxassetid://139650502795957",
            Volume = 2,
            TimeLength = 8
        } },
    Tackled = { {
            Dialogue = "Yo, what the hell?! That was a frame one tackle! ... *cough cough* Yeah no, I cannot see your game right now dude I have no idea.",
            SoundId = "rbxassetid://73734378435406",
            Volume = 2,
            TimeLength = 10
        }, {
            Dialogue = "Nice one, DON-KEY.",
            SoundId = "rbxassetid://134618370138555",
            Volume = 2,
            TimeLength = 6
        } },
    Tackler = { {
            Dialogue = "Good stuff man! Now all you have to do.. is stall for time and flow farm.",
            SoundId = "rbxassetid://92140087458249",
            Volume = 2,
            TimeLength = 7
        }, {
            Dialogue = "OH AND HE GETS ABSOLUTELY TWO-FOOTED BY THIS UNIT!",
            SoundId = "rbxassetid://77671135455891",
            Volume = 2,
            TimeLength = 7
        } },
    OwnScore = { {
            Dialogue = "Phew, that was a close one-Would have been cooler if you did a lineup that bounced off the wall though... Oh wait, they removed that.",
            SoundId = "rbxassetid://100475613939826",
            Volume = 2,
            TimeLength = 10
        }, {
            Dialogue = "HHHHHHHHH MYYYYYY GODDDDD, THAT WAS A GOAL FOR THE AGES!! THIS WILL GO DOWN IN HISTORY!!",
            SoundId = "rbxassetid://124769966250384",
            Volume = 2,
            TimeLength = 8
        }, {
            Dialogue = "\"Hey uh, max is sleeping right now, but he wanted me to say good job twin!\" - RiggiWiggiSugzi",
            SoundId = "rbxassetid://100811934530949",
            Volume = 2,
            TimeLength = 7
        } },
    TeamScore = { {
            Dialogue = "Bro. Why didn\'t you steal your teammates ball? Like, just devour them next time dingus.",
            SoundId = "rbxassetid://109964385759318",
            Volume = 2,
            TimeLength = 8
        }, {
            Dialogue = "Uhh.. Hey man, I-i don\'t mean to interrupt, but like, you\'re not being carried right now, are you?",
            SoundId = "rbxassetid://102713997077185",
            Volume = 2,
            TimeLength = 8
        } },
    EnemyScore = { {
            Dialogue = "OHH NOO! THE SCORE IS 6-7!! ...Please tell me I got that right, that would be really awesome if I did because I have no clue what your score is.",
            SoundId = "rbxassetid://140522768100383",
            Volume = 2,
            TimeLength = 10
        }, {
            Dialogue = "How did you let them score on you? It\'s fine, just uh.. just lock in next time, twin. I believe in you.",
            SoundId = "rbxassetid://105141376847254",
            Volume = 2,
            TimeLength = 9
        } },
    FlowUse = { {
            Dialogue = "Yo football is not this serious my guy; You gotta relax dude.",
            SoundId = "rbxassetid://94327725728947",
            Volume = 2,
            TimeLength = 8
        }, {
            Dialogue = "Did you know sloths can hold their breath longer than dolphins? Yeah, I know right? The more you know.",
            SoundId = "rbxassetid://113636549865180",
            Volume = 2,
            TimeLength = 8
        } },
    FlowEnd = { {
            Dialogue = "...Well this is awkward... Did you.. score atleast?",
            SoundId = "rbxassetid://95180114249235",
            Volume = 2,
            TimeLength = 8
        }, {
            Dialogue = "Hey man, I don\'t know if you realized but your flow ended so... Just-just-just thought I\'d just tell you.",
            SoundId = "rbxassetid://125436868844108",
            Volume = 2,
            TimeLength = 8
        } },
    EnemyFlowUse = { {
            Dialogue = "RUN!!! RUN!!! SAVE YOURSELVES!! THIS GUY JUST POPPED FLOW!! RUN!!!",
            SoundId = "rbxassetid://130909876658456",
            Volume = 2,
            TimeLength = 8
        }, {
            Dialogue = "So uh... yeah I\'m gonna be honest bro, it\'s over, just give up now. It\'s wraps GGS.",
            SoundId = "rbxassetid://90456465412038",
            Volume = 2,
            TimeLength = 8
        }, {
            Dialogue = "Alright, so hear me out.. You HAVE to go and goaltend IMMEDIATELY! Okay?",
            SoundId = "rbxassetid://115791115864651",
            Volume = 2,
            TimeLength = 7
        } },
    EnemyFlowEnd = { {
            Dialogue = "His flow ended..? EVERYONE... CHARGEEEEE!!!",
            SoundId = "rbxassetid://87803068562457",
            Volume = 2,
            TimeLength = 7
        }, {
            Dialogue = "Pstt... Bro, it\'s your time to pop flow now.",
            SoundId = "rbxassetid://95545514624898",
            Volume = 2,
            TimeLength = 5
        }, {
            Dialogue = "Uhh.. widlewy his flow ended.",
            SoundId = "rbxassetid://130271200044967",
            Volume = 2,
            TimeLength = 5
        } },
    Victory = { {
            Dialogue = "Lovely jubly stuff my kind fellow, care to join me for a cuppa?",
            SoundId = "rbxassetid://107150332702965",
            Volume = 2,
            TimeLength = 8
        }, {
            Dialogue = "*whispers* subscribe to maxgonebed... *AHEM* WHO SAID THAT? WHO SAID THAT?! Woah that\'s crazy..",
            SoundId = "rbxassetid://95539526524091",
            Volume = 2,
            TimeLength = 8
        } },
    Defeat = { {
            Dialogue = "Yo, bro... I think it\'s time to uninstall ROBLOX.",
            SoundId = "rbxassetid://88234306426728",
            Volume = 2,
            TimeLength = 7
        }, {
            Dialogue = "Uhh.. have you ever thought about getting a... how do I say this... a J.O.B?",
            SoundId = "rbxassetid://134139304525138",
            Volume = 2,
            TimeLength = 7
        } },
    Brick = { {
            Dialogue = "*snickering* *clearing throat* Better luck next time, bro.",
            SoundId = "rbxassetid://126337753478457",
            Volume = 2,
            TimeLength = 7
        }, {
            Dialogue = "*laughter*",
            SoundId = "rbxassetid://91930221406020",
            Volume = 2,
            TimeLength = 7
        } }
});
makeCommentator("Balake", nil, "rbxassetid://87513220089590", {
    Equip = { {
            Dialogue = "The best commentator, at your service.",
            SoundId = "rbxassetid://111920236760735",
            Volume = 2
        }, {
            Dialogue = "Aww yeah, here we go!",
            SoundId = "rbxassetid://110384454274714",
            Volume = 2
        }, {
            Dialogue = "Dang, commentators are expensive! Hope you got me first cuz that’s all you’ll need.",
            SoundId = "rbxassetid://76846386205338",
            Volume = 2
        } },
    KickOff = { {
            Dialogue = "Let’s see.. 30 dribbling, 42 shot, 20 defense.. man your player stats suck! But I know you’re better than that, so show me something!!",
            SoundId = "rbxassetid://132011687324376",
            Volume = 2
        }, {
            Dialogue = "Ahh, Striker Game. The only soccer game game where the ball physics feel like I’m actually on earth.",
            SoundId = "rbxassetid://123472918784002",
            Volume = 2
        }, {
            Dialogue = "Alea iacta est. (The die is cast.)",
            SoundId = "rbxassetid://94265016232513",
            Volume = 2
        } },
    Tackled = { {
            Dialogue = "ey im WALKINN \'ERE!!!",
            SoundId = "rbxassetid://96129178740704",
            Volume = 2
        }, {
            Dialogue = "That was a frame 1 FRAME 1 CALM DOWN! YOU CALM THE HECK DOWN!!",
            SoundId = "rbxassetid://105978664985413",
            Volume = 2
        }, {
            Dialogue = "man you suck at air dribbling",
            SoundId = "rbxassetid://123030464579313",
            Volume = 2
        } },
    Tackler = { {
            Dialogue = "not this time genius....",
            SoundId = "rbxassetid://99639642119476",
            Volume = 2
        }, {
            Dialogue = "ITS MINE ITS MINE ITS MINE ITS MIIIINE!!!!",
            SoundId = "rbxassetid://139814572395348",
            Volume = 2
        }, {
            Dialogue = "*rabid dog noises*",
            SoundId = "rbxassetid://71853859331253",
            Volume = 2
        } },
    OwnScore = { {
            Dialogue = "That\'s why he\'s the goat!!! the goat!!",
            SoundId = "rbxassetid://102984641636860",
            Volume = 2
        }, {
            Dialogue = "SUPER GOLAZOO!!!",
            SoundId = "rbxassetid://134918964137180",
            Volume = 2
        }, {
            Dialogue = "Preem, choom! we\'re gonna get heaps of eddies from this one.",
            SoundId = "rbxassetid://80129201597659",
            Volume = 2
        } },
    TeamScore = { {
            Dialogue = "Man, cant this guy pass every once in a while?",
            SoundId = "rbxassetid://127050684301400",
            Volume = 2
        }, {
            Dialogue = "Would\'ve been better if it was you.",
            SoundId = "rbxassetid://105906025706043",
            Volume = 2
        } },
    EnemyScore = { {
            Dialogue = "Ohh no this is gonna tank our ratings...",
            SoundId = "rbxassetid://93621015293150",
            Volume = 2
        }, {
            Dialogue = "Don’t worry that’s the gk’s fault. Yeah even if it’s an AI.",
            SoundId = "rbxassetid://92113886145756",
            Volume = 2
        }, {
            Dialogue = "Ughh I’m so sick of this guy always scoring… oh and now he’s emoting like he has aura yeah real classy man real classy.",
            SoundId = "rbxassetid://73827124735946",
            Volume = 2
        } },
    FlowUse = { {
            Dialogue = "Isagi? you go left. Rin? you go right. Together, we are.. striker game...",
            SoundId = "rbxassetid://133801075411840",
            Volume = 2
        }, {
            Dialogue = "ohh yeah this is like me when i listen to phonk dude",
            SoundId = "rbxassetid://97393527171725",
            Volume = 2,
            TimeLength = 8
        }, {
            Dialogue = "領域展開 (Domain Expansion).",
            SoundId = "rbxassetid://78563166053050",
            Volume = 2
        } },
    FlowEnd = { {
            Dialogue = "Aww man, that was fun! wait you scored, right?",
            SoundId = "rbxassetid://107728800985911",
            Volume = 2
        }, {
            Dialogue = "Woahh.. you had so much aura back there dude!!",
            SoundId = "rbxassetid://82033968041094",
            Volume = 2
        }, {
            Dialogue = "No more flow moves?? How laaaame…",
            SoundId = "rbxassetid://131151274975451",
            Volume = 2
        } },
    EnemyFlowUse = { {
            Dialogue = "Oh, looks like we got a tough guy over here, huh?",
            SoundId = "rbxassetid://88155444836641",
            Volume = 2
        }, {
            Dialogue = "While you sit through this unskippable ad, you should totally subscribe to balakethatguy on YouTube....",
            SoundId = "rbxassetid://97987882918776",
            Volume = 2
        }, {
            Dialogue = "no way THAT guy just popped.. he can barely even dribble properly!",
            SoundId = "rbxassetid://86019827976935",
            Volume = 2
        } },
    EnemyFlowEnd = { {
            Dialogue = "geez man that felt like an eternity…",
            SoundId = "rbxassetid://105597653971778",
            Volume = 2
        }, {
            Dialogue = "aww widdle baby dosent have flow anymore!! time to get destroyed!!!",
            SoundId = "rbxassetid://113417044602480",
            Volume = 2
        }, {
            Dialogue = "what’s wrong? That all you’ve got?",
            SoundId = "rbxassetid://81494591725226",
            Volume = 2
        } },
    Victory = { {
            Dialogue = "we devoured them all... *maniacal laughing*",
            SoundId = "rbxassetid://107530296543817",
            Volume = 2
        }, {
            Dialogue = "yeah this game is litally so easy dude........",
            SoundId = "rbxassetid://113225709087844",
            Volume = 2
        }, {
            Dialogue = "Its only a matter of time before you become the #1 striker... What do think of that, Rin? This is my perfect victory! Thats right, I win!",
            SoundId = "rbxassetid://92031650575607",
            Volume = 2
        } },
    Defeat = { {
            Dialogue = "THIS GAME IS LITALLY TOO HAAARD...",
            SoundId = "rbxassetid://77810779694374",
            Volume = 2
        }, {
            Dialogue = "Ahh, I\'m back... DUDE YOU LOST? YOU WERE THE LAST ONE IN MY PARLAY IM BROKE NOW!!!",
            SoundId = "rbxassetid://109706107136366",
            Volume = 2
        }, {
            Dialogue = "hang up the cleats bro you are ODIN DIN DIN DONE!!",
            SoundId = "rbxassetid://139150028740013",
            Volume = 2
        } },
    Brick = { {
            Dialogue = "Guess whose winning the Ballon D\'or! NOT YOU HAHAHAA",
            SoundId = "rbxassetid://123101481455895",
            Volume = 2
        }, {
            Dialogue = "BAHAHAHA I didn\'t know they made strikers this bad!",
            SoundId = "rbxassetid://119002624140690",
            Volume = 2
        }, {
            Dialogue = "OHH MY GOODNESS VALENTINE THAT IS NOT THE SHOT.",
            SoundId = "rbxassetid://105182398051893",
            Volume = 2
        } }
});
makeCommentator("Little German Boy", nil, "rbxassetid://83511799086883", {
    FlowUse = { {
            Dialogue = "Maybe if you win this, Delta will add a Kaiser refresh, and a Rin refresh, and a Yu- wait... we actually got a Yuki refresh?",
            SoundId = "rbxassetid://124025962398602",
            TimeLength = 9,
            Volume = 2
        } },
    OwnScore = { {
            Dialogue = "The voice actor for Little German Boy isn\'t actually german!",
            SoundId = "rbxassetid://139141382716128",
            TimeLength = 3,
            Volume = 2
        }, {
            Dialogue = "Dap me up Scotty! Hee heee!",
            SoundId = "rbxassetid://118913248467811",
            TimeLength = 3,
            Volume = 2
        } },
    Victory = { {
            Dialogue = "Oh mein GOTT! My friend you won! Heeheheheheee!",
            SoundId = "rbxassetid://110143004694492",
            TimeLength = 4,
            Volume = 2
        } },
    Tackler = { {
            Dialogue = "Heeheeheehee! This is so much fun!",
            SoundId = "rbxassetid://92139992182751",
            TimeLength = 3,
            Volume = 2
        } },
    Kickoff = { {
            Dialogue = "Ooh I think the game is starting! Don\'t lose.",
            SoundId = "rbxassetid://76582498693884",
            TimeLength = 4,
            Volume = 2
        } },
    EnemyFlowEnd = { {
            Dialogue = "Oh my friend this is your chance! Heeheehee! Go Score!",
            SoundId = "rbxassetid://80264381628755",
            Volume = 2,
            TimeLength = 7
        } },
    Equip = { {
            Dialogue = "Oh guten Tag friend! Did you choose me to larp?",
            SoundId = "rbxassetid://118311780644130",
            TimeLength = 4,
            Volume = 2
        }, {
            Dialogue = "Little German Boy cannot say \'Mayonnaise.\' But he can say Schnitzel!",
            SoundId = "rbxassetid://135765223283371",
            TimeLength = 5,
            Volume = 2
        }, {
            Dialogue = "Ooh! Guten Tag!",
            SoundId = "rbxassetid://130888469804729",
            TimeLength = 3,
            Volume = 2
        } },
    Defeat = { {
            Dialogue = "You should quit Striker Game... NOW!",
            SoundId = "rbxassetid://125351199190621",
            TimeLength = 4,
            Volume = 2
        } },
    Tackled = { {
            Dialogue = "Good job! Good job! Good job! Good job! Good job!",
            SoundId = "rbxassetid://79526277470381",
            TimeLength = 3,
            Volume = 2
        } },
    TeamGoal = { {
            Dialogue = "Hey I think you should score instead of them! Go score man! Gosh!",
            SoundId = "rbxassetid://100423411709180",
            TimeLength = 6,
            Volume = 2
        } }
});
makeCommentator("Gebura", nil, "rbxassetid://18866560871", {
    Equip = { {
            Dialogue = "Well, seeing that you\'ve at least made it here, I guess you won\'t be a complete deadweight scared of a little blood.\nGebura of the Disciplinary Team. We should get along just fine... as long as you\'re not one of those sniveling annoyances.",
            SoundId = "rbxassetid://108429195717347",
            Volume = 2,
            TimeLength = 15
        } },
    KickOff = { {
            Dialogue = "Time for the Disciplinary Team, the best combat department of the Sephirot, to step forward. These monsters we\'re obligated to call \"Abnormalities\"... Let\'s show them how it\'s done.",
            SoundId = "rbxassetid://137595603225577",
            Volume = 2,
            TimeLength = 12
        }, {
            Dialogue = "There\'s good reason why my department has far fewer employees than any other. However, I want you to keep in mind that this also means only the best have gathered here.",
            SoundId = "rbxassetid://132861468638723",
            Volume = 2,
            TimeLength = 12
        } },
    Tackled = { {
            Dialogue = "... Don\'t stop here. We don\'t need a break... we can still fight.",
            SoundId = "rbxassetid://99208583849978",
            Volume = 2,
            TimeLength = 7
        } },
    OwnScore = { {
            Dialogue = "Good! Wipe them all out. But don\'t finish them off too fast. Make them suffer until they\'re nothing but eggs again.",
            SoundId = "rbxassetid://83957936470908",
            Volume = 2,
            TimeLength = 10
        } },
    TeamScore = { {
            Dialogue = "... Hod was right—a defensive maneuver yields far fewer casualties than a head-on assault.\nBut... aren\'t we being too nice to those Abnormalities with this kind of response?",
            SoundId = "rbxassetid://137997211790209",
            Volume = 2,
            TimeLength = 15
        } },
    EnemyScore = { {
            Dialogue = "There\'s no place for weaklings blubbering over a crisis of this level in the Disciplinary Team.\nDo the best you can, Manager. I can handle my body getting crushed and my employees killed... But at least make those deaths mean something.",
            SoundId = "rbxassetid://79025072533951",
            Volume = 2,
            TimeLength = 15
        } },
    Victory = { {
            Dialogue = "No matter how hard you\'ve stabbed and broken those monsters, they will recover sooner or later. Just like how my components are broken and fractured in battle... only to be soon replaced and repaired.\nWhat a perfect little place, just for me.",
            SoundId = "rbxassetid://86948369416231",
            Volume = 2,
            TimeLength = 20
        } },
    Defeat = { {
            Dialogue = "All of your employees are dead. Burn this moment into your memories, Manager. If you get another chance... you better have cast any semblance of mercy away.",
            SoundId = "rbxassetid://100405129669489",
            Volume = 2,
            TimeLength = 12
        } },
    Brick = { {
            Dialogue = "Get yourself out of the way if you\'ve got no more fight left in you.\nKeep zoning out... and you\'ll get an Execution Bullet to the face.",
            SoundId = "rbxassetid://73928472500843",
            Volume = 2,
            TimeLength = 12
        } }
}, true);
local v8 = { { "rbxassetid://132563693894903", "rbxassetid://93289827719760" }, { "rbxassetid://128892795587100", "rbxassetid://137133898813211" }, { "rbxassetid://77698995825032", "rbxassetid://132276029357174" }, { "rbxassetid://96503853775503", "rbxassetid://90992859025741" } };
makeCommentator("Evernight", nil, v8[3], {
    Equip = {
        {
            Dialogue = "The third month of Amphoreus is the month reserved for the Veil of Evernight... So, please place me into your memory using the name \"Evernight.\" If we can hide in the cracks of time, then we\'ll still have countless moments that belong to us ♭.",
            SoundId = "rbxassetid://120803277567435",
            Volume = 2,
            Icon = v8[3]
        }
    },
    KickOff = {
        {
            Dialogue = "Go on. Treat our guests nicely~",
            SoundId = "rbxassetid://93180998408231",
            Volume = 2,
            Icon = v8[2]
        },
        {
            Dialogue = "Be good now... It\'s your time to shine~",
            SoundId = "rbxassetid://98169560093662",
            Volume = 2,
            Icon = v8[2]
        }
    },
    Tackler = {
        {
            Dialogue = "Play nice~",
            SoundId = "rbxassetid://81232195869984",
            Volume = 2,
            Icon = v8[3]
        }
    },
    Tackled = {
        {
            Dialogue = "Talk about ruining the mood.",
            SoundId = "rbxassetid://101318545266321",
            Volume = 2,
            Icon = v8[1]
        }
    },
    Brick = {
        {
            Dialogue = "Come on. Stop messing around.",
            SoundId = "rbxassetid://84937494188882",
            Volume = 2,
            Icon = v8[4]
        }
    },
    OwnScore = {
        {
            Dialogue = "The night will soon fall... Shh. Good night.",
            SoundId = "rbxassetid://95873544490022",
            Volume = 2,
            Icon = v8[2]
        }
    },
    TeamScore = {
        {
            Dialogue = "Trust me, I\'ll keep your companions safe.",
            SoundId = "rbxassetid://123263206142425",
            Volume = 2,
            Icon = v8[2]
        }
    },
    EnemyScore = {
        {
            Dialogue = "Stop stressing... You have me, don\'t you?",
            SoundId = "rbxassetid://87174282570181",
            Volume = 2,
            Icon = v8[4]
        }
    },
    FlowUse = {
        {
            Dialogue = "The evernight draws near. Time for some sweet dreams ♭",
            SoundId = "rbxassetid://126339313866999",
            Volume = 2,
            Icon = v8[2]
        }
    },
    EnemyFlowUse = {
        {
            Dialogue = "Looks like we\'ve got some tough enemies to deal with, huh?",
            SoundId = "rbxassetid://79466306347634",
            Volume = 2,
            Icon = v8[3]
        }
    },
    FlowEnd = {
        {
            Dialogue = "When you gaze into the past, the past gazes back at you.",
            SoundId = "rbxassetid://74530879336867",
            Volume = 2,
            Icon = v8[1]
        }
    },
    EnemyFlowEnd = {
        {
            Dialogue = "When we get back, let\'s not leave March 7th out of the loop, alright?",
            SoundId = "rbxassetid://131757558223554",
            Volume = 2,
            Icon = v8[1]
        }
    },
    Victory = {
        {
            Dialogue = "Until we meet again, everyone~",
            SoundId = "rbxassetid://106838247368715",
            Volume = 2,
            Icon = v8[3]
        }
    },
    Defeat = {
        {
            Dialogue = "I don\'t want to let go yet.",
            SoundId = "rbxassetid://120330625057551",
            Volume = 2,
            Icon = v8[4]
        }
    }
}, true, { 2447122302 });
makeCommentator("Roland", nil, "rbxassetid://73297694571901", {
    Equip = { {
            Dialogue = "Just an ordinary Fixer who\'s hit rock bottom. What is this place? And who are you?",
            SoundId = "rbxassetid://131654374887330",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    KickOff = { {
            Dialogue = "…Listen, I may not look like it, but I used to be hot stuff, y\'know?",
            SoundId = "rbxassetid://93353042112988",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    Tackler = { {
            Dialogue = "Exhausted? Tired. Want rest? Hungry. Want out?",
            SoundId = "rbxassetid://122409701471094",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    Tackled = { {
            Dialogue = "Don\'t you think gaining freedom by devouring everything will leave a bitter taste in your mouth?",
            SoundId = "rbxassetid://91930348823360",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    Brick = { {
            Dialogue = ".Hmm… I might have just roasted myself here.",
            SoundId = "rbxassetid://77954348493506",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    OwnScore = { {
            Dialogue = "That\'s that, and this is this.",
            SoundId = "rbxassetid://84508080156398",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    TeamScore = { {
            Dialogue = "Right you are. That\'s that, and this is this.",
            SoundId = "rbxassetid://113132834391610",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    EnemyScore = { {
            Dialogue = "Don\'t let it bother you. The agony you\'re carrying right now is the only thing that matters.",
            SoundId = "rbxassetid://131420266842674",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    FlowUse = { {
            Dialogue = "There\'s next to no one in the City who dreams for themselves…",
            SoundId = "rbxassetid://94504976750480",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    EnemyFlowUse = { {
            Dialogue = "But I wanna take a break from it now. I\'ve had enough.",
            SoundId = "rbxassetid://130404938459983",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    FlowEnd = { {
            Dialogue = "I\'ve made enough people bleed for causes that aren\'t mine…",
            SoundId = "rbxassetid://108532849175011",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    EnemyFlowEnd = { {
            Dialogue = "A person\'s aims and wishes… don\'t stay the same forever, you know.",
            SoundId = "rbxassetid://93527083448750",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    Victory = { {
            Dialogue = "Talk about a cliffhanger… Always gotta tease me this way.",
            SoundId = "rbxassetid://116974834398855",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } },
    Defeat = { {
            Dialogue = "You just have to remember the pain and keep moving forward. Don\'t let what others say or might say about your pain get to you.",
            SoundId = "rbxassetid://76573804025095",
            Volume = 2,
            Icon = "rbxassetid://73297694571901"
        } }
}, true, { 2447122302, 568225745 });
makeCommentator("Origin", nil, "rbxassetid://91581176006200", {
    Equip = { {
            Dialogue = "I am Origin.",
            SoundId = "rbxassetid://138571098541640",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    KickOff = { {
            Dialogue = "From a broken cocoon, the butterfly dances away..",
            SoundId = "rbxassetid://70460053856138",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    Tackler = { {
            Dialogue = "You are incapable.",
            SoundId = "rbxassetid://124697857836833",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    Tackled = { {
            Dialogue = "What a short-lived journey..",
            SoundId = "rbxassetid://134365738614638",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    Brick = { {
            Dialogue = "💀💀💀💀",
            SoundId = "rbxassetid://85565035055763",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    TeamScore = { {
            Dialogue = "*Annoyed* Now, Return to nothing",
            SoundId = "rbxassetid://122135910168184",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    EnemyScore = { {
            Dialogue = "Tsk..",
            SoundId = "rbxassetid://135433354943610",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    FlowUse = { {
            Dialogue = "Together, You are one with me",
            SoundId = "rbxassetid://119840477990771",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    EnemyFlowUse = { {
            Dialogue = "Prove it.. The value of your very own existence",
            SoundId = "rbxassetid://86812178962029",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    FlowEnd = { {
            Dialogue = "Now, return to nothing",
            SoundId = "rbxassetid://104786738035305",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    EnemyFlowEnd = { {
            Dialogue = "Is that everything they\'re capable of?",
            SoundId = "rbxassetid://135717139417474",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    Victory = { {
            Dialogue = "This is it... the perfect vessel that I have been seeking all this time..",
            SoundId = "rbxassetid://124724689850143",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } },
    Defeat = { {
            Dialogue = "Tch..",
            SoundId = "rbxassetid://78529582165595",
            Volume = 2,
            Icon = "rbxassetid://91581176006200"
        } }
}, true, { 1481884758, 2447122302, 4166416054 });

return u1;