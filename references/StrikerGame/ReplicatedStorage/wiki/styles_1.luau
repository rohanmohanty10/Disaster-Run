 
 

game:GetService("ReplicatedStorage");
local u1 = {};

local function addStyle(p2: string, p3: table) -- Line: 27
    -- upvalues: u1 (copy)
    local v4 = {};

    for i, v in p3 do
        v4[i] = v;
    end;

    u1[p2] = v4;
end;

local v5 = {};

for i, v in {
    display_name = "Isagi",
    description = "To be reborn...",
    image = "rbxassetid://13345479603",
    icon = "rbxassetid://125768802107076",
    theme = "isagi/theme",
    oneshotmatchtheme = "isagi/isagi themeover",
    mastery = "nelisagi",
    customFlow = true,
    flowLength = 59.94,
    dub = true,
    TSpecial = "Meta-vision",
    AwakeningName = "Talented Learner",
    legacyStyle = "Release",
    color = Color3.fromRGB(145, 255, 0),
    movesets = { { "Direct Shot", "" }, "Naruhaya Footwork", { "MY DIRECT SHOT", "Awaken" }, { "Reflex Shot", "Awaken" }, { "MOVE IT.", "Awk(Steal)" } },
    wiki = {
        {
            name = "Talented Learner",
            description = "Shut up, Genius... I\'m about to get to the good part.",
            num = "G",
            tags = { "awaken" }
        },
        {
            name = "Falling Into Place",
            description = "THE PUZZLE PIECES ARE FORMING!",
            num = "G",
            tags = { "awaken", "overtime" }
        },
        {
            name = "Metavision",
            description = "Gain the ability to see the path of the ball, while also gaining an extremely tiny speed boost.",
            num = "T",
            tags = { "metavision", "movement" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Direct Shot",
            description = "A basic, but strong shot.",
            num = 1,
            tags = { "volley", "iframe", "cam_aim" },
            stats = {
                cooldown = 20,
                shotpower = 139.65
            }
        },
        {
            name = "Direct Backheel",
            description = "Upon being tackled by a Rin during Direct Shot, backheeling the ball forward.",
            num = 1,
            tags = { "cutscene", "counter", "flow", "stylespecific", "onball" },
            stats = {
                shotpower = 200
            }
        },
        {
            name = "Naruhaya Footwork",
            description = "By emulating Naruhaya\'s footwork technique, swiftly dash forward.",
            num = 2,
            tags = { "movement", "iframe" },
            stats = {
                cooldown = 24
            }
        },
        {
            name = "MY DIRECT SHOT",
            description = "A stronger shot.",
            num = 3,
            tags = { "flow", "cutscene", "volley" },
            stats = {
                cooldown = 60,
                shotpower = 200
            }
        },
        {
            name = "Desire",
            description = "Upon being passed to by a Bachira using Bon, fire off a strong direct shot.",
            num = 3,
            tags = { "flow", "cutscene", "stylespecific", "volley", "teammate" },
            stats = {
                shotpower = 200
            }
        },
        {
            name = "Lucky Goal",
            description = "When receiving a pass in the LUCK piece, score!",
            num = 3,
            tags = { "flow", "overtime", "autogoal", "offball", "volley" }
        },
        {
            name = "Reflex Shot",
            description = "While off-ball and awake, dash forward and steal the ball from anyone nearby—including teammates. Use again while holding the ball to fire a cutscene shot with up to two nearby teammates in range; pressing early does nothing if no teammate is nearby. Flop if the run ends without the ball or with no teammates in range.",
            num = 4,
            tags = { "flow", "cutscene", "volley", "steal", "offball", "teammate", "usetwice" },
            stats = {
                cooldown = 30,
                shotpower = 200
            }
        },
        {
            name = "MOVE IT",
            description = "Run up to your teammate and steal the ball from them.",
            num = 5,
            tags = { "flow", "cutscene", "teammate", "steal" },
            stats = {
                cooldown = 60,
                range = 25
            }
        },
        {
            name = "PASS THE BALL",
            description = "Run in front of a Barou teammate, commanding them to pass the ball. Cutscene variant of MOVE IT.",
            num = 5,
            tags = { "flow", "cutscene", "teammate", "stylespecific" }
        }
    }
} do
    v5[i] = v;
end;

u1.isagi = v5;
local v6 = {};

for i, v in {
    display_name = "NEL Isagi",
    description = "Controlling hope and despair...",
    image = "rbxassetid://134495620443679",
    mastery_of = "isagi",
    intercept_icon = "rbxassetid://130359709432756",
    icon = "rbxassetid://134317708186891",
    theme = "nelisagi/nelisagi awk music",
    oneshotmatchtheme = "nelisagi/nelisagi awk overtime",
    flowLength = 70,
    customFlow = true,
    dub = true,
    AwakeningName = "Ascended Metavision",
    TSpecial = "Super Senses",
    display_color = Color3.fromRGB(0, 0, 255),
    intercept_color = Color3.fromRGB(137, 174, 226),
    color = Color3.fromRGB(0, 0, 127),
    gkLineColor = ColorSequence.new(Color3.fromRGB(155, 19, 19), Color3.fromRGB(181, 199, 235)),
    intercepts = { 3 },
    movesets = { "Neo Direct Shot", "Raumdeuter", { "Meta-Burst Point", "Steal/Trap" }, { "Feint", "Counter" }, { "Rebirth", "Awk" } },
    wiki = {
        {
            name = "Ascended Metavision",
            description = "The puzzle pieces... I can see them all.",
            num = "G",
            tags = { "awaken", "onball" }
        },
        {
            name = "Into The Future",
            description = "If you wanted it, you should\'ve been here!",
            num = "G",
            tags = { "awaken", "volley", "offball" }
        },
        {
            name = "Omniscience",
            description = "Just sense it and move!",
            num = "G",
            tags = { "awaken", "overtime" }
        },
        {
            name = "Super Senses",
            description = "Activate territory-based speed and shot modifiers, and gain the ability to trace the ball\'s path.",
            num = "T",
            tags = { "buff", "movement" },
            stats = {
                cooldown = 45
            }
        },
        {
            name = "Neo Direct Shot",
            description = "A refined direct shot.",
            num = 1,
            tags = { "volley", "cam_aim", "counter", "onball" },
            stats = {
                cooldown = 20,
                shotpower = 145
            }
        },
        {
            name = "Lefty Shot",
            description = "Upon being tackled during Neo Direct Shot while awake, fire a powerful left-footed shot.",
            num = 1,
            tags = { "counter", "cutscene", "stylespecific", "onball" },
            stats = {
                cooldown = 50,
                shotpower = 191
            }
        },
        {
            name = "Neo Direct Volley",
            description = "When off-ball, volley an incoming pass directly with immense speed.",
            num = 1,
            tags = { "volley", "iframe", "cam_aim", "offball" },
            stats = {
                cooldown = 20,
                shotpower = 120
            }
        },
        {
            name = "Isagi x Hiori",
            description = "When volleying in the opposing penalty box off a Hiori flow pass, trigger a joint cutscene goal.",
            num = 1,
            tags = { "cutscene", "stylespecific", "offball", "teammate", "autogoal" }
        },
        {
            name = "Isagi x Hiori x Kaiser",
            description = "Variant of Isagi x Hiori. If a Kaiser teammate is nearby, they join the cutscene instead.",
            num = 1,
            tags = { "cutscene", "stylespecific", "offball", "teammate", "autogoal" }
        },
        {
            name = "Raumdeuter",
            description = "Dash forward swiftly. Visual and audio shift based on recent ball possession.",
            num = 2,
            tags = { "movement", "iframe" },
            stats = {
                cooldown = 33
            }
        },
        {
            name = "Meta-Burst Point",
            description = "Dash toward the ball holder and steal the ball from them.",
            num = 3,
            tags = { "steal", "offball", "usetwice" },
            stats = {
                cooldown = 40,
                range = 10
            }
        },
        {
            name = "Meta-Burst Point: Redirect",
            description = "Leap upward and intercept an incoming aerial ball, redirecting it backward.",
            num = 3,
            tags = { "trap", "offball" },
            stats = {
                cooldown = 40,
                shotpower = 75,
                range = 11.75
            }
        },
        {
            name = "Feint",
            description = "Bait a tackle. On success, ragdoll the attacker and gain a movement burst.",
            num = 4,
            tags = { "counter", "onball" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Feint: Shot Setup",
            description = "Feint to cancel your shot. On successful counter, the following Neo Direct Shot within a small time frame will have I-Frames.",
            num = 4,
            tags = { "counter", "onball", "buff" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Rebirth",
            description = "A powerful awakened shot.",
            num = 5,
            tags = { "flow", "cutscene", "volley" },
            stats = {
                cooldown = 45,
                shotpower = 180
            }
        },
        {
            name = "Twin Gun Volley",
            description = "When a moving ball and nearby players are detected, pull them into a cutscene and fire an overwhelming volley.",
            num = 5,
            tags = { "flow", "cutscene", "volley", "teammates", "endsflow" },
            stats = {
                cooldown = 40,
                shotpower = 212
            }
        }
    }
} do
    v6[i] = v;
end;

u1.nelisagi = v6;
local v7 = {};

for i, v in {
    display_name = "Nagi",
    description = "The most fired up in the world.",
    image = "rbxassetid://12787902578",
    icon = "rbxassetid://78365498916161",
    theme = "nagi/nagi theme",
    flowLength = 60,
    flowAnimLength = 7.083333492279053,
    customFlow = true,
    dub = true,
    AwakeningName = "Lazy Genius",
    legacyStyle = "Release",
    wiki_inaccessible = true,
    color = Color3.fromRGB(255, 255, 255),
    TSpecial = { "Fake Volley", "Variants" },
    intercepts = { { 2, 3 } },
    movesets = { { "Direct Heel Lift", "Hit" }, { "Control", "Near Ball" }, "Heavy", { "Zero Reset Turn", "Ball Only" }, { "Jumping Turn", "Awaken" } },
    wiki = {
        {
            name = "Lazy Genius",
            description = "The most fired up in the world.",
            num = "G",
            tags = { "awaken", "onball" }
        },
        {
            name = "XIII: DEATH",
            description = "Steal the ball from two nearby opponents in a cutscene.",
            num = "G",
            tags = { "awaken", "overtime", "offball" }
        },
        {
            name = "Trick: Fake Volley",
            description = "When off-ball, swing at a nearby ball to grab it.",
            num = "T",
            tags = { "offball" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Trick: Zero Reset Backdash",
            description = "During Zero Reset Turn, activate Trick to backdash instead of turning.",
            num = "T",
            tags = { "onball" },
            stats = {
                cooldown = 15
            }
        },
        {
            name = "Trick: Double Control",
            description = "During Control, use Trick to launch the ball upward and immediately follow up with a Control.",
            num = "T",
            tags = { "onball", "stylespecific" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Fake Volley",
            description = "Bait a tackle. On success, ragdoll the attacker and gain flow. Accumulate enough counters in position to trigger Five-Stage Volley.",
            num = 1,
            tags = { "counter", "onball" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Five-Stage Volley",
            description = "After enough successful Fake Volley counters in position, fire an automatic goal.",
            num = 1,
            tags = { "cutscene", "autogoal", "counter", "onball" }
        },
        {
            name = "Control",
            description = "Jump toward an incoming ball and control it. If near the Control Zone while awake, trigger Control Goal instead.",
            num = 2,
            tags = { "volley", "offball", "usetwice" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Control Goal",
            description = "When controlling the ball near the opposing Control Zone while awake, score automatically.",
            num = 2,
            tags = { "cutscene", "autogoal", "offball", "flow" }
        },
        {
            name = "Ground Control",
            description = "Dash toward an incoming ball along the ground and control it.",
            num = 2,
            tags = { "offball" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Control: Bicycle Kick",
            description = "After a successful Control, press Control again to bicycle kick the ball.",
            num = 2,
            tags = { "onball", "iframe" },
            stats = {
                cooldown = 25,
                shotpower = 130
            }
        },
        {
            name = "Heavy",
            description = "Wind up and fire a powerful shot. If used after a Double Control before hitting the ground, curve the ball.",
            num = 3,
            tags = { "onball", "iframe" },
            stats = {
                cooldown = 25,
                shotpower = 130
            }
        },
        {
            name = "Heavy: Curve",
            description = "Variant of Heavy triggered after a Double Control. Fires a curving shot at reduced power.",
            num = 3,
            tags = { "volley", "onball", "iframe" },
            stats = {
                shotpower = 115
            }
        },
        {
            name = "Roulette Volley",
            description = "When near a loose ball while awake, perform a spinning volley.",
            num = 3,
            tags = { "flow", "cutscene", "volley", "offball" },
            stats = {
                cooldown = 25,
                shotpower = 165,
                range = 30
            }
        },
        {
            name = "Zero Reset Turn",
            description = "Quickly turn and reposition while holding the ball.",
            num = 4,
            tags = { "onball", "iframe" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Jumping Turn",
            description = "A powerful awakened aerial shot.",
            num = 5,
            tags = { "flow", "cutscene", "endsflow", "onball" },
            stats = {
                shotpower = 170
            }
        }
    }
} do
    v7[i] = v;
end;

u1.nagi = v7;
local v8 = {};

for i, v in {
    display_name = "Shidou",
    description = "Here comes the dopamine.",
    image = "rbxassetid://98781706483642",
    female = "rbxassetid://124493801929820",
    icon = "rbxassetid://123604384147107",
    theme = "shidou/NEWthemes",
    rinnoplaytheme = "rin/lacrimosa",
    flowLength = 60,
    flowAnimLength = 8.767,
    customFlow = true,
    dub = true,
    AwakeningName = "Explosive Demon",
    legacyStyle = "Release",
    color = Color3.fromRGB(255, 0, 132),
    TSpecial = { "Pivot", "Variants" },
    intercepts = { 1, 3 },
    movesets = { { "Formless", "Air" }, "Backheel Shot", { "Draconic Rush", "Use Twice" }, { "Big Bang Drive", "Awaken" }, { "Dragon Drive", "Awaken" } },
    wiki = {
        {
            name = "Explosive Demon",
            description = "I feel like it\'s about to explode!",
            num = "G",
            tags = { "awaken", "volley" },
            stats = {
                range = 30
            }
        },
        {
            name = "Impossible? What\'s with that concept?",
            description = "My life is boiling over!",
            num = "G",
            tags = { "awaken", "overtime" }
        },
        {
            name = "Pivot",
            description = "Perform different variants of moves to confuse the opponent.",
            num = "T",
            tags = { "onball" }
        },
        {
            name = "Formless",
            description = "Perform a bicycle kick and shoot the ball opposite of where you are facing.",
            num = 1,
            tags = { "offball", "shot" },
            stats = {
                range = 25,
                shotpower = 175,
                cooldown = 20,
                speed = 1.5
            }
        },
        {
            name = "Formless: Drive",
            description = "Jump high and perform a volley shot after a windup.",
            num = 1,
            tags = { "offball", "shot", "iframe", "cam_aim" },
            stats = {
                cooldown = 20,
                range = 28,
                shotpower = 135,
                speed = 1.5
            }
        },
        {
            name = "Formless: Bicycle Kick",
            description = "Perform a flow shot variant of the bicycle kick.",
            num = 1,
            tags = { "flow", "offball", "volley", "cutscene", "shot" },
            stats = {
                shotpower = 170,
                speed = 1.5,
                range = 50,
                cooldown = 60
            }
        },
        {
            name = "Backheel Shot",
            description = "Trap the ball and shoot an unexpected shot.",
            num = 2,
            tags = { "volley", "shot", "iframe" },
            stats = {
                cooldown = 25,
                range = 15,
                shotpower = 115,
                speed = 1.5
            }
        },
        {
            name = "Backheel Shot: Pivot",
            description = "Suddenly switch swing direction and curve the ball to the left.",
            num = "2 + T",
            tags = { "onball", "shot", "iframe", "cam_aim" },
            stats = {
                cooldown = 25,
                shotpower = 100,
                speed = 1.5
            }
        },
        {
            name = "Backheel Shot: I’m Unstoppable!",
            description = "When in the highlighted area in the penalty box in flow, use backheel volley when passed to by a teammate to initiate an autogoal.",
            num = 2,
            tags = { "flow", "penalty", "endsflow", "offball", "cutscene", "autogoal", "teammate" }
        },
        {
            name = "Draconic Rush",
            description = "Dash forward with explosive speed and use twice to perform a diving header.",
            num = 3,
            tags = { "offball", "usetwice", "movement" },
            stats = {
                cooldown = 27
            }
        },
        {
            name = "Draconic Rush: Draconic Header",
            description = "Jump first and then use Draconic Rush to skip straight to the header.",
            num = 3,
            tags = { "offball", "shot" },
            stats = {
                cooldown = 27,
                shotpower = 130,
                speed = 1.5,
                range = 40
            }
        },
        {
            name = "Big Bang Drive",
            description = "With the ball above your head, perform a powerful bicycle kick in the direction you are looking.",
            num = 4,
            tags = { "flow", "volley", "offball", "cutscene", "shot" },
            stats = {
                cooldown = 65,
                shotpower = 200,
                range = 30,
                speed = 1.5
            }
        },
        {
            name = "Dragon Drive",
            description = "Perform a jumping volley shot that can’t be reacted to by the average player.",
            num = 5,
            tags = { "flow", "endsflow", "volley", "cutscene", "shot" },
            stats = {
                shotpower = 200,
                range = 30,
                speed = 1.5
            }
        },
        {
            name = "Dragon Drive: Carnival of The Genius and The Devil",
            description = "When receiving a Perfect Pass from Sae, use 50% of your flow bar to initiate a Dragon Drive, consuming 15% flow.",
            num = 5,
            tags = { "offball", "cutscene", "shot", "teammate", "stylespecific" },
            stats = {
                cooldown = 60,
                shotpower = 200,
                speed = 1.5,
                cooldown2 = 120
            }
        }
    }
} do
    v8[i] = v;
end;

u1.shidou = v8;
local v9 = {};

for i, v in {
    display_name = "Sae",
    description = "My singular interest is becoming the best in the world.",
    image = "rbxassetid://86876903947864",
    icon = "rbxassetid://87031389627015",
    oneshotmatchtheme = "sae/NEWOT/theme",
    fmtheme = "isagi/isagi themeover",
    theme = "sae/sae theme",
    percentchancetheme = "sae/Run Up",
    interruptiontheme = "sae/Run Up Interruption",
    rinnoplaytheme = "sae/Dominate",
    legacyStyle = "Release",
    flowLength = 60,
    flowAnimLength = 10.55,
    flowoneshotmatchLength = 5.416666666666667,
    customFlow = true,
    AwakeningName = "Leveled Genius",
    dub = true,
    color = Color3.fromRGB(255, 60, 135),
    TSpecial = { "Reflex", "Sub-Mode" },
    movesets = { { "Beautiful Destruction", "Variants" }, { "Rabona Nutmeg", "Counter" }, { "Drive Shot", "Ball" }, { "Magic Pass", "Auto-Pass" }, { "Cross Elastico", "Awaken" } },
    modeInfo = {
        text = "LOGIC",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0.333333, 0.498039)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.333333, 0.498039)) })
    },
    wiki = {
        {
            name = "Leveled Genius",
            description = "I\'m taking this game to the next level.",
            num = "G",
            tags = { "awaken", "onball" }
        },
        {
            name = "Singular Interest",
            description = "This is a one-shot match.",
            num = "G",
            tags = { "awaken", "overtime", "onball" }
        },
        {
            name = "Reflex",
            description = "Switch to an alternative mode to use different variations of your moves.",
            num = "T",
            tags = { "buff", "metavision", "resource" },
            stats = {
                cooldown = 3
            }
        },
        {
            name = "Beautiful Destruction",
            description = "Begin stepover dribbles and use the move again to perform a dash. Controllable with directional input. Cancellable into a hard feint by pressing S+1 in the middle of the stepovers.",
            num = 1,
            tags = { "onball", "usetwice", "dribble", "iframe" },
            stats = {
                cooldown = 35
            }
        },
        {
            name = "Beautiful Destruction ",
            description = "By holding A or D before usage, perform a quick on-ball pivot to the corresponding direction, and use twice to perform an overhead flick into a dash.",
            num = 1,
            tags = { "onball", "usetwice", "dribble", "iframe" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Beautiful Destruction: Reflex",
            description = "By holding A or D before usage and in reflex mode, perform a quick on-ball pivot into the corresponding direction, and use twice to do a quick dash into the opposite direction.",
            num = "T + 1",
            tags = { "onball", "usetwice", "iframe", "dribble" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Rabona Nutmeg",
            description = "Lure the enemy into a trap with a counter and stun them, then quickly move past them with blitzing speed.",
            num = 2,
            tags = { "onball", "counter", "iframe" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Rabona Nutmeg: Reflex",
            description = "When in reflex mode, quickly dash forward and collide with an opponent, stunning and moving past them.",
            num = "T + 2",
            tags = { "onball", "iframe" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Rabona Nutmeg: Half Baked.",
            description = "Stop the enemy in their tracks and steal the ball from the possession.",
            num = 2,
            tags = { "flow", "offball", "cutscene", "steal", "hit" },
            stats = {
                cooldown = 60,
                range = 20
            }
        },
        {
            name = "Rabona Nutmeg: Eyesore.",
            description = "Steal the ball from Isagi.",
            num = 2,
            tags = { "flow", "offball", "cutscene", "steal", "stylespecific", "hit" },
            stats = {
                cooldown = 60,
                range = 20
            }
        },
        {
            name = "Drive Shot",
            description = "Shoot a curve shot with infinite possibilities.",
            num = 3,
            tags = { "volley", "shot", "cam_aim" },
            stats = {
                cooldown = 30,
                shotpower = 127,
                speed = 1.5
            }
        },
        {
            name = "Drive Shot: Reflex",
            description = "Shoot a straight shot that travels in a high arc.",
            num = "T + 3",
            tags = { "volley", "shot", "iframe" },
            stats = {
                cooldown = 30,
                shotpower = 120,
                speed = 1.5
            }
        },
        {
            name = "Drive Shot: Such a Pain.",
            description = "Volley the ball into a near uncatchable straight shot.",
            num = 3,
            tags = { "flow", "offball", "volley", "cutscene", "shot" },
            stats = {
                shotpower = 185,
                speed = 1.5,
                range = 35,
                cooldown = 40
            }
        },
        {
            name = "Drive Shot: Impossible Angle",
            description = "Off the possession of the opponent, initiate an autogoal with yourself and the free ball in box.",
            num = 3,
            tags = { "flow", "penalty", "endsflow", "offball", "cutscene", "autogoal" },
            stats = {
                cooldown = 0
            }
        },
        {
            name = "Magic Pass",
            description = "Pass the ball to a teammate with either a grasscutter or a high arcing pass, dependent on distance between the passer and receiver.",
            num = 4,
            tags = { "volley", "iframe", "teammate" },
            stats = {
                cooldown = 30,
                range = 375,
                speed = 0.5,
                speed2 = 1
            }
        },
        {
            name = "Magic Pass: Reflex",
            description = "Same properties as Logic Magic Pass, but has predictive passing based on the receiver\'s movement direction.",
            num = "T + 4",
            tags = { "volley", "iframe", "teammate" },
            stats = {
                cooldown = 30,
                range = 375,
                speed = 0.5,
                speed2 = 1
            }
        },
        {
            name = "Magic Pass: Calculated",
            description = "Initiate a pass that is calculated to be just out of reach of the defender.",
            num = 4,
            tags = { "flow", "volley", "cutscene", "iframe", "teammate" },
            stats = {
                cooldown = 30,
                range = 375,
                speed = 0.5,
                speed2 = 1
            }
        },
        {
            name = "Magic Pass: Dragon Drive",
            description = "With 25% flow, use Magic Pass to pass to a Shidou, and if they receive with Dragon Drive and 50% flow, consume 15% flow and initiate a Dragon Drive chemical reaction.",
            num = 4,
            tags = { "volley", "iframe", "teammate", "stylespecific" },
            stats = {
                shotpower = 200,
                speed = 1.5,
                cooldown = 60,
                cooldown2 = 120,
                range = 375
            }
        },
        {
            name = "Cross Elastico",
            description = "Push the opponent back with your arm, nutmeg them, and then shoot a powerful shot.",
            num = 5,
            tags = { "flow", "endsflow", "onball", "cutscene", "shot", "hit" },
            stats = {
                cooldown = 200,
                shotpower = 205,
                speed = 1.5,
                range = 25
            }
        },
        {
            name = "Cross Elastico: Reflex",
            description = "Turn Cross Elastico into a counter, and if hit, flow will not end.",
            num = "T + 5",
            tags = { "flow", "onball", "cutscene", "counter", "shot" },
            stats = {
                cooldown = 200,
                shotpower = 205,
                range = 25,
                speed = 1.5
            }
        },
        {
            name = "Cross Elastico: You will never surpass me.",
            description = "When used on an opponent Rin, initiate a sibling fight.",
            num = 1,
            tags = { "flow", "onball", "cutscene", "shot", "stylespecific", "hit" },
            stats = {
                cooldown = 200,
                shotpower = 205,
                range = 25,
                speed = 1.5
            }
        }
    }
} do
    v9[i] = v;
end;

u1.sae = v9;
local v10 = {};

for i, v in {
    display_name = "Kaiser",
    description = "Do you believe in the impossible?",
    image = "rbxassetid://80091018575191",
    icon = "rbxassetid://133850793418662",
    theme = "kaiser/kaiser theme",
    flowLength = 68,
    flowAnimLength = 8.183333333333334,
    customFlow = true,
    dub = true,
    legacyStyle = "v1.3",
    AwakeningName = "Chosen Emperor",
    mastery = "masterykaiser",
    color = Color3.fromRGB(0, 76, 255),
    intercepts = { { "flow", 2 } },
    movesets = { { "Kaiser Impact", "" }, { "Kaiser Impact: Magnus", "" }, "Emperor\'s Path", { "Imperial Break", "Counter" }, { "Insta-Kill Flash", "Awake" } }
} do
    v10[i] = v;
end;

u1.kaiser = v10;
local v11 = {};

for i, v in {
    display_name = "Mastery Kaiser",
    description = "For me, nothing is impossible.",
    image = "rbxassetid://107006181015921",
    icon = "rbxassetid://133850793418662",
    theme = "kaiser/kaiser theme",
    flowLength = 68,
    flowAnimLength = 8.183333333333334,
    customFlow = true,
    dub = true,
    TSpecial = "Emperor",
    AwakeningName = "Chosen Emperor",
    mastery_of = "kaiser",
    color = Color3.fromRGB(0, 76, 255),
    gkLineColor = ColorSequence.new(Color3.fromRGB(255, 166, 201), Color3.fromRGB(0, 0, 205)),
    intercepts = { { "flow", 2 } },
    movesets = { { "Kaiser Impact", "" }, { "Restriction Charge", "" }, "Emperor\'s Path", { "Imperial Break", "Counter" }, { "Insta-Kill Flash", "Awake" } }
} do
    v11[i] = v;
end;

u1.masterykaiser = v11;
local v12 = {};

for i, v in {
    display_name = "Rin",
    description = "I\'ll turn those cheers into screams of anguish.",
    image = "rbxassetid://87707341775351",
    icon = "rbxassetid://139467378922230",
    theme = "rin/rin theme",
    customFlow = true,
    dub = true,
    flowLength = 45,
    TSpecial = "Obliterate",
    AwakeningName = "Destroyer Mode",
    legacyStyle = "v1.5",
    color = Color3.fromRGB(70, 0, 0),
    movesets = { "Occlusion Break", { "Fake Shot", "Counter" }, { "Curve Shot", "Ball" }, { "Kill.", "Awake (Hit)" }, { "Center Of Gravity", "Awake" } }
} do
    v12[i] = v;
end;

u1.rin = v12;
local v13 = {};

for i, v in {
    display_name = "Don Lorenzo",
    description = "Gimme money.",
    image = "rbxassetid://129811903663042",
    mastery = "masterylorenzo",
    icon = "rbxassetid://131294961813811",
    theme = "donlorenzo/donsong",
    flowLength = 60,
    flowAnimLength = 9.68,
    AwakeningName = "Give me... Money.",
    legacyStyle = "v1.6",
    dub = true,
    color = Color3.fromRGB(157, 0, 255),
    intercepts = { 3, { 4, 2 } },
    movesets = { "Zombie Dribble", { "Undead Crash", "Pass/Steal" }, "Defensive Stance", "Horrific Intercept", { "Ace Eater", "Awk(Target)" } }
} do
    v13[i] = v;
end;

u1.donlorenzo = v13;
local v14 = {};

for i, v in {
    display_name = "Don Lorenzo (Mastery)",
    description = "Aren\'t you worth absolutely zero?",
    image = "rbxassetid://17320120888",
    mastery_of = "donlorenzo",
    icon = "rbxassetid://131294961813811",
    TSpecial = "Price Check",
    AwakeningName = "Give me... Money.",
    customFlow = true,
    dub = true,
    legacyStyle = "v1.6",
    color = Color3.fromRGB(157, 0, 255),
    gkLineColor = ColorSequence.new(Color3.fromRGB(127, 0, 255), Color3.fromRGB(43, 0, 87)),
    intercepts = { 3, { 4, 2 } },
    movesets = { "Zombie Walk", { "Undead Crash", "Variants" }, "Defensive Stance", { "Horrific Intercept", "Variants" }, { "Ace Eater", "Awk(Target)" } },
    wiki = {
        {
            name = "Give me... Money.",
            description = "The “Ace Eater” has awoken...",
            num = "G",
            tags = { "awaken", "onball" }
        },
        {
            name = "Let’s devour them, Ubers.",
            description = "Counter-attack, OK?",
            num = "G",
            tags = { "awaken", "onball", "overtime" }
        },
        {
            name = "Chow Time!",
            description = "Delicious.",
            num = "G",
            tags = { "awaken", "cutscene", "volley" },
            stats = {
                range = 40
            }
        },
        {
            name = "Yoo-Hoo",
            description = "Deflect the ball in the box to save it, and then crush them.",
            num = "G",
            tags = { "awaken", "penalty", "offball" },
            stats = {
                range = 35
            }
        },
        {
            name = "Price Check",
            description = "Apply a mark to an enemy, slowing their movement speed",
            num = "T",
            tags = { "debuff" },
            stats = {
                cooldown = 30,
                range = 80
            }
        },
        {
            name = "Price Check: Horrific Intercept",
            description = "Intercept the ball while price checking an enemy and begin dribbling or pass to the nearest teammate depending on your directional input.",
            num = "T + 4",
            tags = { "offball", "trap", "iframe", "teammate" },
            stats = {
                cooldown = 25,
                range = 125,
                speed = 0.95
            }
        },
        {
            name = "Zombie Walk",
            description = "Walk towards the ball and trap it into your possession.",
            num = 1,
            tags = { "offball", "movement", "trap", "iframe" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Zombie Dribble",
            description = "Utilize your zombie-like movement to dribble the ball forward with small dashes.",
            num = 1,
            tags = { "onball", "movement", "iframe" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Undead Crash",
            description = "Use your flexible body to crash the ball toward a teammate. Reuse again to counter.",
            num = 2,
            tags = { "onball", "teammate" },
            stats = {
                cooldown = 30,
                range = 250,
                speed = 0.9
            }
        },
        {
            name = "Undead Crash: “Yo, Michael.”",
            description = "Steal the ball from the ace and devour them.",
            num = 2,
            tags = { "flow", "cutscene", "steal", "offball", "qte", "stylespecific", "teammate" },
            stats = {
                cooldown = 30,
                range = 40
            }
        },
        {
            name = "Undead Crash: “It\'s Feeding Time.”",
            description = "After using Ace Eater’s two dribbles and with a Barou on your team, Undead Crash to the Barou to initiate an Auto Goal with his Long Shot and two enemy players in his vicinity.",
            num = 2,
            tags = { "flow", "cutscene", "autogoal", "stylespecific", "teammate" },
            stats = {
                range = 50
            }
        },
        {
            name = "Defensive Stance",
            description = "Intercept a pass from the enemy or shut down their dribbling, getting knocked back if the shot is strong.",
            num = 3,
            tags = { "offball", "volley" },
            stats = {
                cooldown = 30,
                range = 25
            }
        },
        {
            name = "Horrific Intercept",
            description = "Lunge forward, trapping the ball into your possession.",
            num = 4,
            tags = { "offball", "trap", "cutscene" },
            stats = {
                cooldown = { 50, 35 }
            }
        },
        {
            name = "Ace Eater",
            description = "This versatile move has two dribbles, an air intercept, and a shot with short cooldowns in between each use.",
            num = 5,
            tags = { "flow", "cutscene", "steal", "iframe" },
            stats = {
                shotpower = 180,
                cooldown = { 1, 5, 5 }
            }
        }
    }
} do
    v14[i] = v;
end;

u1.masterylorenzo = v14;
local v15 = {};

for i, v in {
    display_name = "Aiku",
    description = "I am the final wall!",
    image = "rbxassetid://11750550406",
    mastery = "aiku2",
    female = "rbxassetid://97667614687659",
    icon = "rbxassetid://135329205633033",
    theme = "aiku/aikutheme",
    legacyStyle = "v1.7",
    customFlow = true,
    dub = true,
    AwakeningName = "Selfish Captain",
    color = Color3.fromRGB(85, 255, 0),
    intercepts = { { 3, 2 } },
    movesets = { "Serpent\'s Sway", { "Reflex Tackle", "Steal" }, "Venom Trap", { "Ultimate Defense", "Awk" }, { "Former Striker", "Awk(Ball)" } },
    wiki = {
        {
            name = "This sensation is... UNSTOPPABLE!",
            description = "My senses are in overdrive!",
            num = "G",
            tags = { "awaken", "offball", "movement" },
            stats = {
                range = 15
            }
        },
        {
            name = "While I\'m on patrol...",
            description = "You won\'t be stealing any goals, Li\'l burglar.",
            num = "G",
            tags = { "awaken", "offball", "steal" },
            stats = {
                range = 15
            }
        },
        {
            name = "All-or-Nothing",
            description = "I\'ve been waiting for a moment like this.",
            num = "G",
            tags = { "awaken", "penalty", "offball", "auto_save" },
            stats = {
                range = "15x15x15"
            }
        },
        {
            name = "Blooming Flower",
            description = "I won\'t play soccer for anyone else. I\'ll let this flower bloom for myself!",
            num = "G",
            tags = { "awaken", "overtime", "offball", "steal" },
            stats = {
                range = 15
            }
        },
        {
            name = "Burglar Radar",
            description = "When using this special, you will see a percentage displayed above opponents\' heads based on how many moves they have on cooldown. Also gives ball metavision while active. ",
            num = "T",
            tags = { "buff" }
        },
        {
            name = "Serpent\'s Sway",
            description = "Use on-ball to quickly dash backwards and perform a quick dash to the left or right, dependent on directional input. Use off-ball to perform a quick sprint forward for mobility. ",
            num = 1,
            tags = { "movement", "dribble", "iframe" },
            stats = {
                cooldown = 20
            }
        },
        {
            name = "Serpent\'s Sway: Serpentine Clear",
            description = "While holding space and using 1, perform a high jump and intercept the ball in mid-air. ",
            num = 1,
            tags = { "offball", "volley" },
            stats = {
                cooldown = 20,
                range = 20,
                shotpower = 65,
                speed = 1.25
            }
        },
        {
            name = "Serpent\'s Sway: Ultimate Defense",
            description = "Leap into the air and intercept the ball with a header, showcasing your superior height advantage.",
            num = 1,
            tags = { "flow", "offball", "trap", "cutscene" },
            stats = {
                shotpower = 100,
                cooldown = 30,
                range = 35,
                speed = 1.5
            }
        },
        {
            name = "Serpent\'s Sway: Try to Surpass me.",
            description = "An inbox variant of Ultimate Defense, block a shot and challenge your opponents. ",
            num = 1,
            tags = { "flow", "penalty", "offball", "volley", "cutscene" },
            stats = {
                cooldown = 20,
                shotpower = 20,
                speed = 1.5,
                range = 35
            }
        },
        {
            name = "Reflex Tackle",
            description = "Reach forward and steal the ball from the opponent, ignoring their I-frames. ",
            num = 2,
            tags = { "offball", "steal" },
            stats = {
                cooldown = 26,
                range = 6.5
            }
        },
        {
            name = "Reflex Tackle: Gamble",
            description = "Read the opponent\'s movements and steal the ball for your team. ",
            num = 2,
            tags = { "flow", "offball", "steal", "cutscene" },
            stats = {
                cooldown = 35,
                range = 20
            }
        },
        {
            name = "Venom Deflect",
            description = "Leap forward and trap the ball with the top of your foot, stopping the opponent\'s advance. If a teammate is in range, automatically deflect it toward their position. Can be used forward and to the sides based on directional input. ",
            num = 3,
            tags = { "offball", "trap" },
            stats = {
                cooldown = 35
            }
        },
        {
            name = "Snake\'s Grasp",
            description = "Dash forward and grab the enemy with your arm, sweeping the ball away and pushing them to the side. If the ball is grabbed with an opponent near the ball, zone them from the ball and knock them away. ",
            num = 4,
            tags = { "offball", "steal" },
            stats = {
                range = 9,
                cooldown = 20
            }
        },
        {
            name = "Snake\'s Grasp: Leash",
            description = "When in flow and using the move on an enemy from behind, trigger a cutscene steal that knocks the ball away.",
            num = 4,
            tags = { "offball", "steal", "cutscene" },
            stats = {
                cooldown = 20,
                range = 9,
                shotpower = 90,
                speed = 1.5
            }
        },
        {
            name = "Former Striker",
            description = "Show off your past and score.",
            num = 5,
            tags = { "flow", "cutscene", "shot" },
            stats = {
                cooldown = 105,
                shotpower = 160,
                range = 30,
                speed = 1.5
            }
        }
    }
} do
    v15[i] = v;
end;

u1.aiku = v15;
local v16 = {};

for i, v in {
    display_name = "Mastery Aiku",
    description = "This superhuman ability to see over the entire field!",
    image = "rbxassetid://125138551990612",
    mastery_of = "aiku",
    icon = "rbxassetid://135329205633033",
    theme = "aiku/aikutheme",
    customFlow = true,
    dub = true,
    TSpecial = "Burglar Radar",
    AwakeningName = "Selfish Captain",
    color = Color3.fromRGB(85, 255, 0),
    gkLineColor = ColorSequence.new(Color3.fromRGB(6, 64, 43), Color3.fromRGB(80, 200, 120)),
    intercepts = { { 3, 2 } },
    movesets = { "Serpent\'s Sway", { "Reflex Tackle", "Steal" }, { "Venom Deflect", "Variants" }, { "Snake\'s Grasp", "" }, { "Former Striker", "Awk(Ball)" } },
    wiki = {
        {
            name = "This sensation is... UNSTOPPABLE!",
            description = "My senses are in overdrive!",
            num = "G",
            tags = { "awaken", "offball", "movement" },
            stats = {
                range = 15
            }
        },
        {
            name = "While I\'m on patrol...",
            description = "You won\'t be stealing any goals, Li\'l burglar.",
            num = "G",
            tags = { "awaken", "offball", "steal" },
            stats = {
                range = 15
            }
        },
        {
            name = "All-or-Nothing",
            description = "I\'ve been waiting for a moment like this. ",
            num = "G",
            tags = { "awaken", "penalty", "offball", "auto_save" },
            stats = {
                range = "15x15x15"
            }
        },
        {
            name = "Serpent\'s Sway",
            description = "Quickly dash backwards and perform a quick dash to the left or right, dependent on directional input. ",
            num = 1,
            tags = { "onball", "dribble", "iframe" },
            stats = {
                cooldown = 20
            }
        },
        {
            name = "Reflex Tackle",
            description = "Reach forward and steal the ball from the opponent, ignoring their I-frames. ",
            num = 2,
            tags = { "offball", "steal" },
            stats = {
                cooldown = 18
            }
        },
        {
            name = "Venom Trap",
            description = "Leap forward and trap the ball with the top of your foot, stopping the opponent\'s advance.",
            num = 3,
            tags = { "offball", "trap" },
            stats = {
                cooldown = 35
            }
        },
        {
            name = "Ultimate Defense",
            description = "Leap into the air and intercept the ball with a header, showcasing your superior height advantage.",
            num = 4,
            tags = { "flow", "offball", "trap", "cutscene" },
            stats = {
                shotpower = 100,
                cooldown = 30,
                range = 35,
                speed = 1.5
            }
        },
        {
            name = "Former Striker",
            description = "Show off your past and score.",
            num = 5,
            tags = { "flow", "shot", "cutscene" },
            stats = {
                cooldown = 105,
                shotpower = 160,
                range = 30,
                speed = 1.5
            }
        }
    }
} do
    v16[i] = v;
end;

u1.aiku2 = v16;
local v17 = {};

for i, v in {
    display_name = "Barou",
    description = "I will devour that light and be the villain if I have to!",
    image = "rbxassetid://80658577250456",
    icon = "rbxassetid://117766075558925",
    theme = "barou/barouTheme",
    oneshotmatchtheme = "barou/barouovertime/music",
    flowLength = 68,
    legacyStyle = "v1.7",
    customFlow = true,
    TSpecial = "Apex Predator",
    AwakeningName = "True Predator",
    dub = true,
    color = Color3.fromRGB(170, 0, 0),
    movesets = { "Chop Dribble", { "Long Shot", "" }, "King\'s Path", { "DEVOUR.", "Awk" }, { "Predator Eye", "Awk(Steal)" } },
    wiki = {
        {
            name = "True Predator",
            description = "I refuse… to live in a future… like THAT!!",
            num = "G",
            tags = { "awaken", "onball" }
        },
        {
            name = "This… Twisted Path!",
            description = "I’m more than happy to play the villain who devours your light!!",
            num = "G",
            tags = { "awaken", "teammate", "steal" }
        },
        {
            name = "I was getting tired of waiting.",
            description = "I’ll devour everything in this match. ALL OF YOU!",
            num = "G",
            tags = { "awaken", "onball", "overtime" }
        },
        {
            name = "Barou, Barou, kyun!",
            description = "???",
            num = "G",
            tags = { "awaken", "onball" }
        },
        {
            name = "Apex Predator",
            description = "Use after King’s Path to initiate Chop Dribble. Refreshable up to 1 time.",
            num = "T",
            tags = { "onball", "counter" }
        },
        {
            name = "Chop Dribble",
            description = "Cut one way and then quickly dash the opposite direction. Controllable with directional input.",
            num = 1,
            tags = { "onball", "counter" }
        },
        {
            name = "Long Shot",
            description = "Wind up and shoot off a powerful shot.",
            num = 2,
            tags = { "iframe", "cam_aim" }
        },
        {
            name = "Long Shot: Stealth Shot",
            description = "Use blind spots given by enemy players to shoot a quieter and lower profile shot.",
            num = 2,
            tags = { "iframe", "cam_aim", "buff" }
        },
        {
            name = "Long Shot: Apex Predator",
            description = "Fire off a slightly curved variant of Long Shot.",
            num = "2 + T",
            tags = { "onball", "buff" }
        },
        {
            name = "Long Shot: Stealth Kill Shot",
            description = "Fire off a heavily curved and faster variant of Long Shot.",
            num = "2 + T",
            tags = { "onball", "buff" }
        },
        {
            name = "Long Shot: It’s Feeding Time",
            description = "After a Mastery Don Lorenzo uses Ace Eater’s two dribbles and uses Undead Crash to pass to Barou, initiate an Auto Goal with Long Shot and two enemy players in your vicinity in front of the penalty box.",
            num = 2,
            tags = { "cutscene", "autogoal" }
        },
        {
            name = "King’s Path",
            description = "Perform up to three dashes to break through the enemy defenses.",
            num = 3,
            tags = { "movement" }
        },
        {
            name = "DEVOUR.",
            description = "Run forward and grab the ball to then shoot a powerful shot. You can end this move early after one second.",
            num = 4,
            tags = { "awaken", "steal" }
        },
        {
            name = "DEVOUR.: YOUR LIGHT IS MINE!",
            description = "If you grab two opponents and run into the penalty box, initiate an autogoal variant of DEVOUR.",
            num = 4,
            tags = { "awaken", "cutscene", "steal", "autogoal", "endsflow" }
        },
        {
            name = "Predator Eye",
            description = "Quickly steal the ball from both opponents and teammates.",
            num = 5,
            tags = { "flow", "cutscene", "steal" }
        }
    }
} do
    v17[i] = v;
end;

u1.barou = v17;
local v18 = {};

for i, v in {
    display_name = "Gagamaru",
    description = "Today\'s my first time in goal.",
    image = "rbxassetid://121783778244908",
    icon = "rbxassetid://138969571828070",
    theme = "gagamaru/gagamaru theme",
    flowLength = 55,
    customFlow = true,
    legacyStyle = "v1.8",
    AwakeningName = "idk, beat a bear",
    dub = true,
    color = Color3.fromRGB(255, 255, 255),
    movesets = { "Scorpion", "Diving Header", { "Wild Instincts", "Off-Ball" }, { "Perfect Save", "Awaken" }, { "Shachihoko", "Awaken" } },
    intercepts = { 2 },
    wiki = {
        {
            name = "\"idk, beat a bear\"",
            description = "Steel yourself.",
            num = "G",
            tags = { "awaken", "gk", "penalty" }
        },
        {
            name = "Scorpion",
            description = "Lift your legs behind you, like a scorpion\'s stinger, to volley the ball.",
            num = 1,
            tags = { "offball", "volley", "cam_aim" },
            stats = {
                shotpower1 = 112,
                shotpower2 = 30
            }
        },
        {
            name = "Diving Header",
            description = "Dive forward and slam the ball with your head.",
            num = 2,
            tags = { "offball", "volley", "movement" },
            stats = {
                shotpower = 125,
                shotpowergk = 140
            }
        },
        {
            name = "Wild Instincts",
            description = "Dive sideways and attempt to catch the ball.",
            num = 3,
            tags = { "offball", "gk", "penalty" }
        },
        {
            name = "Perfect Save",
            description = "Dive toward the ball, catching it before throwing forward and high.",
            num = 4,
            tags = { "offball", "volley", "gk", "penalty" },
            stats = {
                shotpower = 180
            }
        },
        {
            name = "Shachihoko",
            description = "Just barely deflect the ball in time.",
            num = 5,
            tags = { "offball", "volley", "gk", "penalty", "qte", "endsflow" },
            stats = {
                shotpower = 110
            }
        }
    }
} do
    v18[i] = v;
end;

u1.gagamaru = v18;
local v19 = {};

for i, v in {
    display_name = "Bachira",
    description = "You can\'t win unless you\'re having fun.",
    image = "rbxassetid://14388807404",
    icon = "rbxassetid://140346997503645",
    theme = "bachira/bachira theme (1)",
    flowLength = 60,
    flowAnimLength = 18.883,
    dub = true,
    customFlow = true,
    legacyStyle = "v1.8",
    AwakeningName = "M-Monster..?",
    color = Color3.fromRGB(255, 234, 128),
    TSpecial = { "Monster Leap", "Off-Ball" },
    intercepts = { 3, "Tspecialer" },
    movesets = { { "Step Overs", "Ball" }, { "Monster Counter", "Counter" }, { "Bon!", "Variants" }, { "Monster Trance", "Use Twice" }, { "Bee Shot", "Awaken" } },
    wiki = {
        {
            name = "M-Monster..?",
            description = "I\'ll empty my mind and just play.",
            num = "G",
            tags = { "awaken", "onball" }
        },
        {
            name = "Freedom. Passion. ",
            description = "How long has it been?",
            num = 1,
            tags = { "awaken", "overtime", "onball" }
        },
        {
            name = "Monster Leap",
            description = "Leap up off the ground, trapping the ball and shooting it into the ground. ",
            num = "T",
            tags = { "offball", "trap", "iframe" },
            stats = {
                cooldown = 30,
                shotpower = 115,
                speed = 1.5,
                range = "20x18x20"
            }
        },
        {
            name = "My Monster Trance",
            description = "While in flow, press T while in possession of the ball to do your Monster Trance on an opponent. ",
            num = "T",
            tags = { "flow", "onball", "cutscene", "shot" },
            stats = {
                cooldown = 25,
                shotpower = 185,
                range = 50,
                speed = 1.5
            }
        },
        {
            name = "Step Overs",
            description = "Slowly advance forward doing stepover dribbles, and if tackled by an enemy, dash forward with a burst of speed. If not tackled, perform a short dash forward to escape danger. ",
            num = 1,
            tags = { "onball", "counter", "dribble", "iframe" },
            stats = {
                cooldown = 28
            }
        },
        {
            name = "Step Overs: Ginga Dribble",
            description = "During Step Overs, press T to activate a cutscene variant of the move, stunning the two opponents that are caught in range. ",
            num = "1 + T",
            tags = { "flow", "onball", "cutscene", "dribble", "iframe" },
            stats = {
                cooldown = 28,
                range = 60
            }
        },
        {
            name = "Monster Counter",
            description = "Prepare a counter, and if hit, dribble your way past the defense. ",
            num = 2,
            tags = { "onball", "counter", "iframe" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Bon!",
            description = "Shoot the ball with your right leg from behind your left, shooting an extremely short windup high arc shot. ",
            num = 3,
            tags = { "onball", "shot", "iframe" },
            stats = {
                cooldown = 20,
                shotpower = 125,
                speed = 1.5
            }
        },
        {
            name = "Bon!: Air",
            description = "Jump up in the air and volley the ball with a stylish spin. ",
            num = 3,
            tags = { "offball", "volley", "shot", "cam_aim" },
            stats = {
                cooldown = 20,
                shotpower = 132,
                range = 30,
                speed = 1.5
            }
        },
        {
            name = "Monster Trance",
            description = "Perform a quick fake shot to fake out enemies, and use twice to rainbow flick it over your head and quickly dash with it. ",
            num = 4,
            tags = { "onball", "counter", "dribble", "iframe" },
            stats = {
                cooldown = 25,
                shotpower = 50,
                speed = 1.5
            }
        },
        {
            name = "Bee Shot",
            description = "Question your ego, and shoot a powerful direct volley. ",
            num = 1,
            tags = { "flow", "volley", "cutscene", "shot" },
            stats = {
                cooldown = 90,
                shotpower = 175,
                range = 30,
                speed = 1.5
            }
        }
    }
} do
    v19[i] = v;
end;

u1.bachira = v19;
local v20 = {};

for i, v in {
    display_name = "Chigiri",
    description = "Once more... I will dream!",
    image = "rbxassetid://81965007793527",
    icon = "rbxassetid://95471093303788",
    theme = "chigiri/ChigiriTheme",
    flowLength = 60,
    flowAnimLength = 17.3,
    customFlow = true,
    dub = true,
    AwakeningName = "44 Panther",
    TSpecial = "Fast Lane",
    color = Color3.fromRGB(255, 69, 72),
    dependancies = { "aiku" },
    movesets = { { "Mach Cut-In", "Use Twice" }, { "Self Pass", "Use Twice" }, { "Non-Stop Dribble", "Off-Ball" }, { "Blitz", "Awaken" }, { "Golden Zone", "Awaken" } },
    wiki = {
        {
            name = "44 Panther",
            description = "I don’t care anymore... If it tears again, so be it.",
            num = "G",
            tags = { "awaken" }
        },
        {
            name = "Mach Cut-In",
            description = "Perform a side dash and dash forward in quick succession, then shoot the ball shortly after.",
            num = 1,
            tags = { "movement", "iframe", "usetwice" },
            stats = {
                shotpower = 126
            }
        },
        {
            name = "Self Pass",
            description = "Kick the ball forward and run after it.",
            num = 2,
            tags = { "onball", "movement", "usetwice" }
        },
        {
            name = "Non-Stop Dribble",
            description = "Run into the ball to keep it moving.",
            num = 3,
            tags = { "offball", "movement" }
        },
        {
            name = "Non-Stop Dribble: Outrun",
            description = "Steal the ball from the enemy and break through them.",
            num = 3,
            tags = { "offball", "flow", "steal", "cutscene" },
            stats = {
                range = 20
            }
        },
        {
            name = "Blitz",
            description = "Dash forward with extreme speed.",
            num = 4,
            tags = { "flow", "movement" }
        },
        {
            name = "Golden Zone",
            description = "Prepare to sprint and find your golden zone, shooting a near-uncatchable shot.",
            num = 5,
            tags = { "flow", "cutscene", "steal", "movement", "endsflow" }
        }
    }
} do
    v20[i] = v;
end;

u1.chigiri = v20;
local v21 = {};

for i, v in {
    display_name = "Yukimiya",
    description = "No matter how far I fall, I won\'t hand over this ego...",
    image = "rbxassetid://81458680590291",
    icon = "rbxassetid://99839152760437",
    theme = "yukimiya/yukisong",
    stealtheme = "yukimiya/yukistealsong",
    oneshotmatchtheme = "yukimiya/Overtime/BGM",
    flowLength = 65,
    flowAnimLength = 9.817,
    TSpecial = "Predator Eye",
    AwakeningName = "The Flow",
    dub = true,
    customFlow = true,
    color = Color3.fromRGB(255, 94, 0),
    movesets = { { "Gyro Shot", "Use Thrice" }, { "Drag Scissors", "Hit" }, { "Razor Break", "Use Thrice" }, { "Street Tag", "Counter" }, { "Street-Style Dribbling", "Awk" } },
    wiki = {
        {
            name = "Street Soccer-Style Dribbling",
            description = "Using people as obstacles to weave through, break their defense and score your winning goal. ",
            num = "G",
            tags = { "awaken", "onball", "hit" },
            stats = {
                range = 25
            }
        },
        {
            name = "Keep Clear. ",
            description = "I don\'t have much time left. ",
            num = "G",
            tags = { "awaken", "offball", "steal", "teammate", "hit" },
            stats = {
                range = 25
            }
        },
        {
            name = "The Flow. ",
            description = "Crank it up a gear! It\'s now or never, so find it!",
            num = "G",
            tags = { "awaken", "overtime", "onball" }
        },
        {
            name = "Predator Eye",
            description = "On usage, you will see the path your gyro should would take if you were to shoot it. It will quicken the release of Gyro Shot and double the parry frames on Street Tag. ",
            num = "T",
            tags = { "buff" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Gyro Shot ",
            description = "A curve shot with a twist. Time your use twice to activate a variant called Pierce Through, and if used when the ball is high enough, the ball will perform a sword screw. ",
            num = 1,
            tags = { "usethrice", "shot", "iframe", "qte" },
            stats = {
                cooldown = 26,
                shotpower = 120,
                speed = 1.215
            }
        },
        {
            name = "Gyro Shot: Pacifist",
            description = "While in flow, press T while in the windup of Gyro Shot to perform a snake-like shot. ",
            num = "1 + T",
            tags = { "flow", "onball", "cutscene", "shot", "cam_aim" },
            stats = {
                cooldown = 26,
                shotpower = 210,
                speed = 2.2
            }
        },
        {
            name = "Drag Scissors ",
            description = "Perform a fake and a cut in in quick succession, and then dash quickly to the side based on your directional input. If the counter frames of the fake are hit then the sprint will have a second set of counter frames.",
            num = 2,
            tags = { "onball", "dribble" },
            stats = {
                cooldown = 20
            }
        },
        {
            name = "Drag Scissors: Lane Splitter",
            description = "While in flow and after activating Street-Style Dribbling, gain a flow variant of Drag Scissors: Lane Splitter, a lightning-bolt shaped dribble that can dismantle the defense. ",
            num = 2,
            tags = { "flow", "onball", "dribble", "iframe" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Razor Break",
            description = "A move with 3 charges and can be used omnidirectionally (8 Directions). Can also cancel other moves in their windup. ",
            num = 3,
            tags = { "onball", "usethrice", "dribble" },
            stats = {
                cooldown = 17.5
            }
        },
        {
            name = "Razor Break: Full Breakthrough",
            description = "While in flow and after activating Street-Style Dribbling, gain a flow variant of Razor Break: Full Breakthrough, a buffed up version of Razor Break with a total of 4 charges and the ability to use 2 back-to-back. This move is also omnidirectional. ",
            num = 3,
            tags = { "flow", "onball", "usetwice" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Street Tag",
            description = "A counter where you weave past your attacker and break free. Also has a parry variant, which will stop time and have you quickly dash past them. ",
            num = 4,
            tags = { "onball", "counter", "iframe" },
            stats = {
                cooldown = 26
            }
        },
        {
            name = "Street-Style Dribbing",
            description = "Use this move to truly activate your flow, unlocking flow variants of Drag Scissors and Razor Break, and additionally unlocking your your classic Street Dribble and shot variant. ",
            num = 5,
            tags = { "flow", "onball", "cutscene", "buff" }
        },
        {
            name = "Street Dribble",
            description = "Perform a fake and cut in past your enemy while they are still confused. ",
            num = 5,
            tags = { "flow", "onball", "cutscene", "dribble", "hit" },
            stats = {
                cooldown = 18,
                range = 45
            }
        },
        {
            name = "Street Dribble: The Flow ",
            description = "Find your flow as you shoot a powerful shot, wrecking the enemy team\'s morale. ",
            num = 5,
            tags = { "flow", "endsflow", "onball", "cutscene", "shot" },
            stats = {
                shotpower = 200,
                speed = 1.5
            }
        }
    }
} do
    v21[i] = v;
end;

u1.yukimiya = v21;
local v22 = {};

for i, v in {
    display_name = "Kunigami",
    description = "Don\'t forget about this dark horse.",
    image = "rbxassetid://80296307964098",
    icon = "rbxassetid://120024252806064",
    theme = "kunigami/kunigami_theme",
    flowLength = 60,
    customFlow = true,
    dub = true,
    AwakeningName = "Fallen Hero",
    color = Color3.fromRGB(255, 131, 49),
    TSpecial = { "Revenge", "Stacks" },
    movesets = { { "Hero\'s Instinct", "Target" }, { "Lefty Shot", "Ball" }, { "Heroic Clash", "Steal" }, { "Justice Header", "Air" }, { "Demon\'s Contract", "Awk" } }
} do
    v22[i] = v;
end;

u1.kunigami = v22;
local v23 = {};

for i, v in {
    display_name = "Kurona",
    description = "Reliable planet.",
    image = "rbxassetid://13642243516",
    icon = "rbxassetid://108540474399836",
    theme = "kurona/FlowTheme",
    flowLength = 60,
    flowAnimLength = 13.433,
    customFlow = true,
    AwakeningName = "Orbiting Body",
    color = Color3.fromRGB(255, 0, 191),
    TSpecial = { "Support Shark", "Variants" },
    movesets = { { "Go-Go!", "Variants" }, { "Fetch", "Variants" }, "Guard Dog", { "Planet Hotline", "Support" }, { "Orbital Resonance", "Awaken" } }
} do
    v23[i] = v;
end;

u1.kurona = v23;
local v24 = {};

for i, v in {
    display_name = "Reo",
    description = "A chameleon that\'s lost sight of its own color.",
    image = "rbxassetid://129416388209725",
    icon = "rbxassetid://77067196897807",
    customFlow = true,
    AwakeningName = "Offensive Flow",
    TSpecial = "Stance Shift",
    color = Color3.fromRGB(170, 85, 255),
    intercepts = { { "flow", 2 } },
    movesets = { { "Twin Steps", "Ball Only" }, { "Cross Elastico", "Counter" }, "Draconic Shot", "99% Copy", { "???", "Awaken" } }
} do
    v24[i] = v;
end;

u1.reo = v24;
local v25 = {};

for i, v in {
    display_name = "Hiori",
    description = "Don\'t heap your expectations on me ever again.",
    image = "rbxassetid://101998395970720",
    icon = "rbxassetid://126872204462527",
    customFlow = true,
    AwakeningName = "\"ULTRA SADIST\"",
    color = Color3.new(0.333333, 1, 1),
    TSpecial = { "Cryo Frame", "Variants" },
    intercepts = { 2 },
    movesets = { { "Glacial Cut", "Directional" }, "Frost Guard", { "Link Up", "Use Again" }, { "Chilling Pass", "Auto-Pass" }, { "No-Look\nAlley\nCross", "Awaken" } }
} do
    v25[i] = v;
end;

u1.hiori = v25;
local v26 = {};

for i, v in {
    display_name = "Kiyora",
    description = "Until the last minute, nobody will know who I choose to side with.",
    image = "rbxassetid://101806046230992",
    icon = "rbxassetid://73053154225193",
    customFlow = true,
    AwakeningName = "Dead-Or-Alive",
    TSpecial = "Backspin",
    color = Color3.new(0, 0.333333, 0.498039),
    intercepts = { { 3, 2 } },
    movesets = { { "Windmill\nShot", "Variant" }, { "Dance\nBattle", "Hit (Pass)" }, "Side\nTrap", { "Twister\nPass", "Variant" }, { "Borderline", "Awaken" } }
} do
    v26[i] = v;
end;

u1.kiyora = v26;
local v27 = {};

for i, v in {
    display_name = "Otoya",
    description = "I\'ve seen it more times than my parents.",
    image = "rbxassetid://117819413347752",
    icon = "rbxassetid://86251341727263",
    customFlow = true,
    AwakeningName = "\"Sneaky Ninja\"",
    TSpecial = "Invisibility",
    dub = true,
    color = Color3.new(0.215686, 0.815686, 0.254902),
    movesets = { { "Kusarigama Slash", "Use Twice" }, { "Stealthy Steps", "Off-Ball" }, { "Tiki-Taka Style", "" }, { "Shadow Step", "Hit" }, { "Center of the World", "Volley (Awk)" } }
} do
    v27[i] = v;
end;

u1.otoya = v27;
local v28 = {};

for i, v in {
    display_name = "Karasu",
    description = "I\'ll change and become the second best.",
    image = "rbxassetid://140023279977526",
    icon = "rbxassetid://94004634980411",
    customFlow = true,
    AwakeningName = "\"Assassin Crow\"",
    TSpecial = "Wing-Arm Block",
    dub = true,
    color = Color3.new(0.333333, 0.309804, 0.67451),
    movesets = { { "Corvine Feint", "Parry" }, { "Raven Relay", "Auto-Pass" }, { "Dive-Bomb Assault", "" }, { "Silent Steal", "Air" }, { "New Goal Method", "Awaken" } }
} do
    v28[i] = v;
end;

u1.karasu = v28;
local v29 = {};

for i, v in {
    display_name = "what.",
    description = "For me, nothing is correct.",
    image = "rbxassetid://80091018575191",
    icon = "rbxassetid://133850793418662",
    theme = "kaiser/kaiser theme",
    flowLength = 68,
    flowAnimLength = 8.183333333333334,
    customFlow = true,
    dub = true,
    spec = true,
    legacyStyle = "v1.3",
    AwakeningName = "Chosen Emperor",
    color = Color3.fromRGB(0, 76, 255),
    movesets = { { "Kaiser Impact", "" }, { "Kaiser Impact: Magnus", "" }, "Emperor\'s Path", { "Imperial Break", "Counter" }, { "Insta-Kill Flash", "Awake" } }
} do
    v29[i] = v;
end;

u1.what = v29;
local v30 = {};

for i, v in {
    icon = "rbxassetid://125768802107076",
    theme = "isagi/theme",
    oneshotmatchtheme = "isagi/isagi themeover",
    customFlow = true,
    flowLength = 59.94,
    TSpecial = "Time Rewind",
    Awakening = "Talented Learner",
    spec = true,
    color = Color3.fromRGB(145, 255, 0),
    movesets = { { "Direct Shot", "Ball Only" }, "Naruhaya Footwork", { "MY DIRECT SHOT", "Awaken" }, { "Reflex Shot", "Awaken" }, { "MOVE IT.", "Awk(Steal)" } }
} do
    v30[i] = v;
end;

u1["nel/isagi"] = v30;
local v31 = {};

for i, v in {
    icon = "rbxassetid://0",
    theme = "dukeerisia/DanceDanceIfYouCan",
    flowLength = 120,
    flowAnimLength = 4.5,
    spec = true,
    rankLock = "tester",
    color = Color3.fromRGB(36, 36, 36),
    TSpecial = { "Perfect", "PASSIVE" },
    movesets = { { "Hyperspeed\nOverrush", "Ball Only" }, "Sonic Steal", { "Courage To Speedblitz", "Counter" }, { "Low Shot", "Use Again" } },
    modeInfo = {
        text = "ACCELERATE",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.176471, 0.176471, 0.176471)) })
    }
} do
    v31[i] = v;
end;

u1.zantetsu = v31;
local v32 = {};

for i, v in {
    icon = "rbxassetid://74301292343144",
    image = "rbxassetid://84856905464713",
    flowLength = 60,
    customFlow = true,
    spec = true,
    ignorecolor = true,
    theme = "cinder/ultimate/Theme",
    rinnoplaytheme = "cinder/ultimate/ThemeRNP",
    color = Color3.fromRGB(85, 0, 0),
    movesets = { { "Incendiary Dive", "Off-Ball" }, { "Blood Shot", "Ball Only" }, { "Flame Snare", "Trap" }, { "🤤", "VERA" }, { "Ember Overdrive", "Flow" } }
} do
    v32[i] = v;
end;

u1.cinder = v32;
local v33 = {};

for i, v in {
    icon = "rbxassetid://107533818251743",
    image = "rbxassetid://88648042162981",
    description = "\"Just a washed up Grade 9 Fixer\"",
    flowLength = 60,
    customFlow = true,
    spec = true,
    ignorecolor = true,
    theme = "roland/Flow/Themes/Base",
    oneshotmatchtheme = "roland/Flow/Themes/Overtime",
    rinnoplaytheme = "roland/Flow/Themes/RinNoPlay",
    AwakeningName = "The Black Silence",
    TSpecial = "Reception",
    color = Color3.fromRGB(210, 210, 210),
    movesets = { "Ranga Workshop: Wheels Industry", "Atelier Logic: Shotgun", "Zelkova Workshop: Ranga Counter", "Durandal: Sever", "???" }
} do
    v33[i] = v;
end;

u1.roland = v33;
local v34 = {};

for i, v in {
    icon = "rbxassetid://99227617916674",
    image = "rbxassetid://131709509472068",
    description = "You shall connect with the light around us, surrounding all of Lumen.",
    flowLength = 60,
    customFlow = true,
    spec = true,
    ignorecolor = true,
    TSpecial = "Absolute Radiance",
    AwakeningName = "Protagonist Syndrome",
    color = Color3.fromRGB(255, 196, 120),
    movesets = { { "Radiant Kick", "Ball Only" }, { "Blinding Dawn", "Dribble" }, { "Radiant Dawn", "Control" }, { "Strong Left", "Steal" }, { "Crazy Slots", "Flow" } },
    wiki = {
        {
            name = "Protagonist Syndrome",
            description = "Gods Below, don\'t bring your troubles to me.",
            num = "G",
            tags = { "awaken" }
        },
        {
            name = "Radiant Kick",
            description = "A radiant on-ball kick with iframes.",
            num = 1,
            tags = { "volley", "iframe", "onball" },
            stats = {
                cooldown = 12.5,
                shotpower = 147,
                range = 25
            }
        },
        {
            name = "Radiant Kick: Flow",
            description = "Teleport to a mid-air ball, float, and QTE a curved kick. Miss to ragdoll.",
            num = 1,
            tags = { "flow", "volley", "offball", "qte", "iframe" },
            stats = {
                cooldown = 25,
                shotpower = 180,
                range = 50
            }
        },
        {
            name = "Blinding Dawn",
            description = "Mobility off-ball or dribble on-ball with iframes.",
            num = 2,
            tags = { "movement", "dribble", "iframe" },
            stats = {
                cooldown = 20,
                range = 25
            }
        },
        {
            name = "Blinding Dawn Special",
            description = "In the opposing goal box during flow, trigger an autogoal cutscene without ending flow.",
            num = 2,
            tags = { "flow", "autogoal", "onball" },
            stats = {
                range = 33
            }
        },
        {
            name = "Radiant Dawn",
            description = "Leap, knock back nearby players, and grab an aerial ball. Stun on failure.",
            num = 3,
            tags = { "control", "iframe", "offball" },
            stats = {
                cooldown = 17.5,
                range = 33
            }
        },
        {
            name = "Strong Left",
            description = "Rush forward and punch. Steal and knock back ball carriers; ragdoll others. Whiff to ragdoll unless in flow.",
            num = 4,
            tags = { "steal", "ragdoll" },
            stats = {
                cooldown = 22.5,
                range = 8.4
            }
        },
        {
            name = "Crazy Slots",
            description = "Roll a random ultimate shot, then use it. Expires after 30 seconds.",
            num = 5,
            tags = { "flow", "volley", "iframe", "usetwice" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Absolute Radiance",
            description = "Off-ball QTE. Hit for speed and omnibypass tackles; miss for a heavy slow and full cooldowns.",
            num = "T",
            tags = { "offball", "qte", "buff" },
            stats = {
                cooldown = 60
            }
        }
    }
} do
    v34[i] = v;
end;

u1.dawnwalker = v34;
local v35 = {};

for i, v in {
    display_name = "Phainon",
    description = "Vessel of the Destruction",
    icon = "rbxassetid://81296683431564",
    awkicon = "rbxassetid://83672940049936",
    image = "rbxassetid://77354656760429",
    theme = "phainon/flow",
    flowLength = 60,
    flowAnimLength = 8,
    customFlow = true,
    spec = true,
    TSpecial = "Pyric Corpus",
    AwakeningName = "He Who Bears the World Must Burn",
    color = Color3.fromRGB(255, 200, 110),
    movesets = { { "Stride", "Mobility" }, { "Deliverance", "Ball" }, { "Let There Be Light", "Ball" }, { "Agony", "Counter" }, { "Tear Open the Sky!", "Flow" } },
    wiki = {
        {
            name = "He Who Bears the World Must Burn",
            description = "Requires 6+ Coreflames. Flow ends in a black hole that respawns all other players.",
            num = "G",
            tags = { "awaken", "flow" }
        },
        {
            name = "Pyric Corpus",
            description = "Coreflames from dribbles (+1), steals (+2), and goals (+3). Press T during Stride, Deliverance, or Let There Be Light with 3+ stacks for empowered variants.",
            num = "T",
            tags = { "buff", "resource" }
        },
        {
            name = "Stride",
            description = "Forward rush; on-ball slash knockback, off-ball clash then possession. Pyric: longer rush and hitbox.",
            num = 1,
            tags = { "movement", "hit" },
            stats = {
                cooldown = 18,
                range = 12
            }
        },
        {
            name = "Deliverance",
            description = "Fast vertical slash shot (~130 power). Pyric: feint then fast horizontal curve.",
            num = 2,
            tags = { "shot", "onball" },
            stats = {
                cooldown = 16,
                shotpower = 130
            }
        },
        {
            name = "Let There Be Light",
            description = "Lob then devastating slash (180+). Pyric: slightly slower, 200+ power.",
            num = 3,
            tags = { "shot", "onball" },
            stats = {
                cooldown = 22,
                shotpower = 180
            }
        },
        {
            name = "Agony",
            description = "2s counter; slide contact triggers upward slash and 2.5s stun.",
            num = 4,
            tags = { "counter" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "Tear Open the Sky!",
            description = "Aimed meteor barrage (200–250+). In-box autogoal with 3 Coreflames.",
            num = 5,
            tags = { "flow", "shot" },
            stats = {
                cooldown = 30,
                shotpower = 225,
                range = 80
            }
        }
    }
} do
    v35[i] = v;
end;

u1.phainon = v35;
local v36 = {};

for i, v in {
    icon = "rbxassetid://111360919287637",
    image = "rbxassetid://131384866594089",
    theme = "aizen/Flow/Theme",
    flowLength = 90,
    customFlow = true,
    flowAnimLength = 19,
    spec = true,
    TSpecial = "Bakudō #81: Dankū",
    AwakeningName = "Hōgyoku Infusion",
    color = Color3.fromRGB(150, 60, 255),
    movesets = { { "Deception", "Switch" }, { "Complete Hypnosis", "Too Weak" }, { "True Power", "Trick" }, { "Shatter, Kyokasuigetsu", "Variants" }, { "Hadō #90: Kurohitsugi", "Awaken" } },
    wiki = {
        {
            name = "Full Incantation: Kurohitsugi",
            description = "Opens Aizen\'s flow window. If someone else has the ball and they have a teammate available, plays the steal cutscene instead.",
            num = "G",
            tags = { "awaken", "flow", "cutscene", "steal", "teammate" }
        },
        {
            name = "Wall",
            description = "Defensive special.",
            num = "T",
            tags = { "defense" },
            stats = {
                cooldown = 20
            }
        },
        {
            name = "Deception",
            description = "On-ball: slow dribble that switches places with the aimed humanoid. Off-ball: instant position switch with the aimed humanoid.",
            num = 1,
            tags = { "movement", "utility" },
            stats = {
                cooldown = 14,
                range = 70
            }
        },
        {
            name = "Kyōka Suigetsu",
            description = "Off-ball. Aim at a player to disguise yourself as them.",
            num = 2,
            tags = { "offball", "utility" },
            stats = {
                cooldown = 26,
                duration = 12,
                range = 70
            }
        },
        {
            name = "Goryūtenmetsu",
            description = "On-ball: curving dragon shot. Off-ball: dash, secure the ball, and pass to the farthest ally while decoy dragon heads scatter to allies.",
            num = 3,
            tags = { "shot", "pass" },
            stats = {
                cooldown = 20,
                shotpower = 130
            }
        },
        {
            name = "Illusionary Presences",
            description = "On-ball: quick counter that flashsteps forward. Off-ball: flashstep to your aim; stealing the ball stalls time before the slash.",
            num = 4,
            tags = { "counter", "steal" },
            stats = {
                cooldown = 18,
                range = 9,
                duration = 2
            }
        }
    }
} do
    v36[i] = v;
end;

u1.aizen = v36;
local v37 = {};

for i, v in {
    theme = "milkytillys/Krone - Guilty Crown OST Instrumental Guitar Cover",
    oneshotmatchtheme = "milkytillys/Future Victory",
    flowLength = 60,
    flowAnimLength = 4.5,
    spec = true,
    color = Color3.fromRGB(49, 104, 255),
    movesets = { { "push toward front", "Ball Only" }, "Head and Shoulder to The Future", "MY DIRECT SHOT", "Sight to the Future", "IT\'S MINE" }
} do
    v37[i] = v;
end;

u1.milkytillys = v37;
local v38 = {};

for i, v in {
    icon = "rbxassetid://131345936869811",
    ignoreballHolder = true,
    theme = "dukeerisia/SinSmeltedScoriae",
    rinnoplaytheme = "andrewtheme",
    flowLength = 120,
    flowAnimLength = 4.5,
    spec = true,
    color = Color3.fromRGB(181, 255, 206),
    movesets = { { "Binding Tempest", "Ball Only" }, { "Strong Punch", "WHAHATTTT" } }
} do
    v38[i] = v;
end;

u1.dukeerisia = v38;
local v39 = {};

for i, v in {
    icon = "rbxassetid://121186744489483",
    flowLength = 60,
    flowAnimLength = 0,
    spec = true,
    customFlow = true,
    AwakeningName = "DIO\'S WORLD",
    TSpecial = "Time-Skip",
    color = Color3.fromRGB(255, 255, 127),
    movesets = { { "Vampiric Stepovers", "Use Again" }, { "ゴ", "Counter" }, { "Greatest High", "Steal" }, { "The Ultimate Stand", "Awaken" }, { "The World!", "Awaken" } }
} do
    v39[i] = v;
end;

u1.dio = v39;
local v40 = {};

for i, v in {
    display_name = "2011x",
    description = "THINKING OUTSIDE THE BOX? YOU DELIGHT ME, NEW FRIEND.",
    image = "rbxassetid://116801404548176",
    icon = "rbxassetid://108670181882053",
    flowLength = 60,
    customFlow = true,
    spec = true,
    AwakeningName = "TIME-ATTACK",
    TSpecial = "Curiosity",
    color = Color3.fromRGB(156, 0, 0),
    color_bar = {
        normal = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0)) })
    },
    movesets = { "Pursuit", { "Altisimus", "Ball Only" }, { "Charge", "Off-Ball" }, "Gods Trickery", { "Tartarus II", "Steal" } },
    wiki = {
        {
            name = "Pursuit",
            description = "Off-ball: sway, then dash and grab the ball holder. On-ball: dash through an opponent while keeping possession.",
            num = 1,
            tags = { "movement", "steal" },
            stats = {
                cooldown = 35,
                range = 12
            }
        },
        {
            name = "Altisimus",
            description = "Charge a heavy strike, then fire the ball where your camera is aiming.",
            num = 2,
            tags = { "shot" },
            stats = {
                cooldown = 22,
                shotpower = 140
            }
        },
        {
            name = "Charge",
            description = "Fly in the camera\'s direction. Catch an airborne loose ball for a trap cutscene, or choke an enemy before dropping them. In flow it can grab teammates too.",
            num = 3,
            tags = { "movement", "trap", "stun", "off-ball" },
            stats = {
                trap_cooldown = 22,
                stun_cooldown = 26,
                miss_cooldown = 4,
                range = 16
            }
        },
        {
            name = "Tartarus",
            description = "Rip the ball away and force the holder into a Tartarus cutscene. Will require awakening once that kit is added.",
            num = 5,
            tags = { "steal", "cutscene" },
            stats = {
                cooldown = 40,
                range = 50,
                miss_cooldown = 4
            }
        }
    }
} do
    v40[i] = v;
end;

u1["2011x"] = v40;
local v41 = {};

for i, v in {
    display_name = "exe",
    flowLength = 60,
    flowAnimLength = 21,
    customFlow = true,
    icon = "rbxassetid://137778801629262",
    spec = true,
    color = Color3.fromRGB(156, 0, 0),
    movesets = { { "Shortcut", "Ball Only" }, { "Exterminate", "Off-Ball" }, { "EXE Strike", "Ball Only" }, { "Open Metavision", "God Mode" } }
} do
    v41[i] = v;
end;

u1.exe = v41;
local v42 = {};

for i, v in {
    display_name = "exe",
    theme = "exe/awkSong",
    rinnoplaytheme = "exe/rnpexe",
    flowLength = 60,
    flowAnimLength = 21,
    spec = true,
    color = Color3.fromRGB(156, 0, 0),
    movesets = { { "Shortcut", "Ball Only" }, { "Exterminate", "Off-Ball" }, { "EXE Strike", "Ball Only" } }
} do
    v42[i] = v;
end;

u1.theexe = v42;
local v43 = {};

for i, v in {
    icon = "rbxassetid://135502598482684",
    description = "Godspeed.",
    theme = "wally/lowkitheme",
    flowLength = 60,
    customFlow = true,
    spec = true,
    flowAnimLength = 0,
    color = Color3.fromRGB(60, 252, 255),
    movesets = { { "Holding Back", "Ball Only" }, { "Too Slow", "Near Ball" }, "Lightspeed Dash", { "Lightspeed Kick", "Ball Only" }, { "Is This Okay?", "Near Ball" } }
} do
    v43[i] = v;
end;

u1.wally = v43;
local v44 = {};

for i, v in {
    icon = "rbxassetid://139359949585901",
    theme = "ronaldo/0508",
    flowLength = 60,
    flowAnimLength = 5.333,
    spec = true,
    color = Color3.fromRGB(212, 155, 116),
    movesets = { { "Flawless Pass", "Ball" }, { "CR7 Dribble", "Dribble" }, { "Bicycle Kick", "Ball" }, { "Skill Gap", "Awk(Steal)" }, { "Greatest Of All Time", "Awk" } }
} do
    v44[i] = v;
end;

u1.ronaldo = v44;
local v45 = {};

for i, v in {
    icon = "rbxassetid://114957950535562",
    flowLength = 80,
    customFlow = true,
    spec = true,
    AwakeingName = "Argentina\'s Best",
    color = Color3.fromRGB(21, 155, 212),
    TSpecial = { "Nutmeg Switch" },
    movesets = { { "Superstar", "Ball Only" }, { "Riptide", "Ball Only" }, { "Super Pass", "Auto-Pass" }, "Heads Up", { "Forced Nutmeg", "Steal" } }
} do
    v45[i] = v;
end;

u1.messi = v45;
local v46 = {};

for i, v in {
    icon = "rbxassetid://134265407252304",
    flowLength = 300,
    flowAnimLength = 1,
    AwakeningName = "Naruhaya Footwork Awakening",
    TSpecial = "Naruhaya Footwork T Special",
    customFlow = true,
    spec = true,
    tempable = true,
    theme = "nelisagi/OffBallTheme",
    color = Color3.new(0.823529, 0.737255, 0.564706),
    movesets = { "Naruhaya Footwork 1", "Naruhaya Footwork 2", "Naruhaya Footwork 3", "Naruhaya Footwork 4", "Naruhaya Brick" }
} do
    v46[i] = v;
end;

u1.naruhaya = v46;
local v47 = {};

for i, v in {
    icon = "rbxassetid://107923893707395",
    awkicon = "rbxassetid://123038867504471",
    flowLength = 67.02,
    flowAnimLength = 7.98,
    AwakeningName = "20 Series",
    spec = true,
    theme = "KJ/ult",
    customFlow = true,
    color = Color3.new(1, 0, 0),
    TSpecial = { "Variants", "Flow" },
    color_bar = {
        normal = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 0)) })
    },
    movesets = { { "Handball", "Shot" }, { "Signature Dribble", "Dribble" }, { "Just Passing By", "Steal" }, { "Important Matters", "Counter" } }
} do
    v47[i] = v;
end;

u1.KJ = v47;
local v48 = {};

for i, v in {
    icon = "rbxassetid://107923893707395",
    awkicon = "rbxassetid://123038867504471",
    flowLength = 67.02,
    flowAnimLength = 7.98,
    AwakeningName = "20 Series",
    spec = true,
    theme = "KJ/ult",
    customFlow = true,
    color = Color3.new(1, 0, 0),
    TSpecial = { "Variants", "Flow" },
    color_bar = {
        normal = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 0)) })
    },
    movesets = { { "Handball", "Shot" }, { "Signature Dribble", "Dribble" }, { "Just Passing By", "Steal" }, { "Important Matters", "Counter" } }
} do
    v48[i] = v;
end;

u1.theKJ = v48;
local v49 = {};

for i, v in {
    display_name = "Dust dust dust sahur",
    description = "dere.",
    image = "rbxassetid://71952868779504",
    icon = "rbxassetid://76789855282392",
    theme = "rin/rin theme",
    customFlow = true,
    spec = true,
    flowLength = 60,
    TSpecial = "Trick",
    AwakeningName = "Everything Mode?",
    color = Color3.fromRGB(70, 0, 0),
    movesets = { "Occlusion Break", { "Fake Shot", "Counter" }, { "Curve Shot", "Ball" }, { "Kill.", "Awake (Hit)" }, { "Center Of Gravity", "Awake" } }
} do
    v49[i] = v;
end;

u1.dustsbscreation = v49;
local v50 = {};

for i, v in {
    display_name = "Cid",
    description = "The Lord of Shadows",
    icon = "rbxassetid://106145728146854",
    awkicon = "rbxassetid://94272480401299",
    image = "rbxassetid://136280818179838",
    spec = true,
    customFlow = true,
    flowLength = 60,
    flowAnimLength = 15,
    AwakeningName = "\"Assassin Crow\"",
    TSpecial = "Wing-Arm Block",
    color = Color3.fromRGB(150, 30, 250),
    movesets = { { "Corvine Feint", "Parry" }, { "Raven Relay", "Auto-Pass" }, { "Dive-Bomb Assault", "" }, { "Silent Steal", "Air" }, { "I\'m Atomic.", "Overtime" } }
} do
    v50[i] = v;
end;

u1.cid = v50;
local v51 = {};

for i, v in {
    display_name = "Sonic",
    description = "An adventure is no fun if it\'s too easy.",
    image = "rbxassetid://131823246947065",
    icon = "rbxassetid://75450669107826",
    awkiconot = "rbxassetid://81736819264618",
    customFlow = true,
    AwakeningName = "ENDLESS POSIBILITIES",
    flowLength = 60,
    spec = true,
    color_bar = {
        normal = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
        overtime_flow = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) })
    },
    crowd = {
        flow = "sonic/Flow/OT/SFX/Crowd",
        overtimeflow = "sonic/Flow/OT/SFX/Crowd"
    },
    color = Color3.fromRGB(100, 190, 220),
    awkcolor = Color3.fromRGB(255, 255, 0),
    movesets = { { "Figure-8 Peelout", "Movement" }, { "Roundabout Juke", "Dribble" }, { "Homing Attack", "Trap" }, { "Whirlwind Shot", "Volley" }, { "The Fastest", "Awaken" } },
    TSpecial = { "Freestyle", "Variants" },
    wiki = {
        {
            name = "Figure-8 Peelout",
            description = "Rev up, sprint, then skid. Tap twice during the run to tackle.",
            num = 1,
            tags = { "movement", "steal" },
            stats = {
                cooldown = 30
            }
        },
        {
            name = "Spin-Dash",
            description = "Curl into a ball up to three times. The third launch knocks the ball loose. On-ball use grants iframes with endlag.",
            num = 1,
            tags = { "hit", "movement" },
            stats = {
                cooldown_hit = 2,
                cooldown_miss = 30,
                cooldown_full = 30
            }
        },
        {
            name = "Roundabout Juke",
            description = "Breakdance dribble with Fake Volley endlag on miss. Landing on an enemy removes endlag.",
            num = 2,
            tags = { "dribble", "counter" },
            stats = {
                cooldown_miss = 25,
                cooldown_hit = 25
            }
        },
        {
            name = "S Rank!",
            description = "After landing Roundabout Juke three times, fire an automatic goal.",
            num = 2,
            tags = { "autogoal", "counter" }
        },
        {
            name = "Homing Attack",
            description = "Home on the ball within 220 studs or dash 100 studs forward. Trap radius lingers through the animation.",
            num = 3,
            tags = { "trap", "mobility" },
            stats = {
                cooldown_hit = 45,
                cooldown_miss = 30,
                range = 220
            }
        },
        {
            name = "Whirlwind Shot",
            description = "Ground volley shot.",
            num = 4,
            tags = { "volley", "shot" },
            stats = {
                cooldown = 25,
                shotpower = 125
            }
        },
        {
            name = "Air Variant",
            description = "Leap in ball form and Sonic Eagle downward with knuckle-ball speed after the bounce.",
            num = 4,
            tags = { "volley", "shot", "air" },
            stats = {
                cooldown = 25,
                shotpower = 135
            }
        },
        {
            name = "Trick Action",
            description = "Directional burst with extra distance off the ball.",
            num = 4,
            tags = { "mobility" },
            stats = {
                cooldown = 25
            }
        },
        {
            name = "The Fastest",
            description = "yara yara phonk",
            num = 5,
            tags = { "flow", "cutscene", "shot" },
            stats = {
                cooldown = 40,
                shotpower = 300
            }
        },
        {
            name = "Personification of Freedom",
            description = "flow cool",
            num = "G",
            tags = { "awaken", "flow" },
            stats = {
                flow_length = 60,
                flow_anim = 6
            }
        },
        {
            name = "OT",
            description = "Overtime awakening variant.",
            num = 5,
            tags = { "awaken", "overtime" }
        },
        {
            name = "OT AUTO",
            description = "Overtime automatic goal variant.",
            num = 5,
            tags = { "awaken", "overtime", "autogoal" }
        },
        {
            name = "Freestyle",
            description = "Swap to Spin-Dash and Trick Action variants.",
            num = "T",
            tags = { "utility" },
            stats = {
                cooldown = 1.5
            }
        }
    }
} do
    v51[i] = v;
end;

u1.sonic = v51;
local v52 = {};

for i, v in {
    icon = "rbxassetid://88682362415628",
    flowLength = 60,
    customFlow = true,
    spec = true,
    AwakeningName = "Instinct That Surpasses Mind",
    TSpecial = "Form",
    color = Color3.fromRGB(255, 165, 0),
    movesets = { { "Super Kamehameha", "Movement" }, { "Meteor Rush\n/\nGod Bursting", "Variants" }, { "Dragon Throw", "Counter" }, { "Spirit Bomb", "Awaken" } }
} do
    v52[i] = v;
end;

u1.Goku = v52;
local v53 = {};

for i, v in {
    display_name = "Gremmy",
    description = "The greatest power of all, is the power of imagination.",
    image = "rbxassetid://116708913602779",
    icon = "rbxassetid://96129126914164",
    flowLength = 60,
    flowAnimLength = 21,
    AwakeningName = "Imaginative Prowess",
    TSpecial = "Visionary",
    spec = true,
    color = Color3.fromRGB(255, 222, 38),
    movesets = { "Pillar Surf", "Crumble", "Right-Side Muse", "This is America", "Weltraum" },
    wiki = {}
} do
    v53[i] = v;
end;

u1.gremmy = v53;
local v54 = {};

for i, v in {
    display_name = "Akuma",
    description = "Both heaven and Earth tremble before my might.",
    image = "rbxassetid://136590170267534",
    flowLength = 60,
    spec = true,
    ignoreballHolder = true,
    ignorecolor = true,
    TSpecial = "Demon Step",
    AwakeningName = "Consuming Flames",
    color = Color3.fromRGB(0, 0, 0),
    color_bar = {
        normal = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
    },
    movesets = { "Leg Breaker", "Rising Dragon", "Axe Kick", "Augimas", "Raging Demon" },
    wiki = {}
} do
    v54[i] = v;
end;

u1.akuma = v54;
local v55 = {};

for i, v in {
    display_name = "akashi",
    description = "I don\'t show any mercy to those who oppose me, not even my own parents.",
    image = "rbxassetid://139904773121524",
    icon = "rbxassetid://87495136882415",
    flowLength = 60,
    spec = true,
    customFlow = true,
    AwakeningName = "Demonstration of Superiority",
    color = Color3.fromRGB(255, 80, 132),
    color_bar = {
        normal = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 132)) })
    },
    modeInfo = {
        text = "LOGIC",
        color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0.333333, 0.498039)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.333333, 0.498039)) })
    },
    TSpecial = { "Reflex", "Sub-Mode" },
    movesets = { { "Beautiful Destruction", "Variants" }, { "Rabona Nutmeg", "Counter" }, { "Drive Shot", "Ball" }, { "Magic Pass", "Auto-Pass" }, { "Cross Elastico", "Awaken" } },
    wiki = {}
} do
    v55[i] = v;
end;

u1.akashi = v55;

for _, v in ipairs({ "niko", "tokimitsu", "raichi", "igaguri", "nanase", "kuon", "imamura", "iemon", "kira", "aryu", "sendou", "wanima", "noa", "ness", "grim", "loki", "pablo", "adam", "lavinho", "blake", "mizuki" }) do
    if not u1[v] then
        u1[v] = {
            flowLength = 6.7,
            AwakeningName = "Infinity Gauntlet",
            TSpecial = "Move That Kills Everyone",
            spec = true,
            color = Color3.new(),
            movesets = { { "Sunkissed Technique", "Aura Farm" }, { "Fluke Tennis", "Unc Tech" }, { "Scent Of Pie", "Flight" }, { "Bye Bye", "Mog" }, { "Hollow Purple", "Awaken" } }
        };
    end;
end;

local script_Legacy = require(script.Legacy);
u1.legacyisagi = script_Legacy.isagi;
u1.legacysae = script_Legacy.sae;
u1.legacynagi = script_Legacy.nagi;
u1.legacyshidou = script_Legacy.shidou;
u1.legacykaiser = script_Legacy.kaiser;

for _, child in script.MasteryData:GetChildren() do
    local v56 = u1[child.Name];

    if v56 then
        v56.mastery_info = require(child);
    end;
end;

return u1;