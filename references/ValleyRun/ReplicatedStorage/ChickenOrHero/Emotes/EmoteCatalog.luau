 

 

local RunService = game:GetService("RunService");
local u1 = game.PlaceId == 130574217370467 and true or RunService:IsStudio();
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local u2 = {
    Enabled = true,
    StudioPreview = false,
    Slots = 6,
    Welcome = "IdleSit",
    CheerVolume = 0.5
};
u2.ComingSoon = FFlags.LiveFlagsApply and not FFlags.EmotesEnabled;
u2.Entries = {};
u2.ProductGrants = {};
u2.Cheers = { 82217872102044, 72037374064818, 107586207514159 };
local u3 = {};

local function add(p4) -- Line: 83
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    if p4.Test and not u1 then
        return;
    end;

    table.insert(u2.Entries, p4);
    u3[p4.Id] = p4;

    if type(p4.ProductId) == "number" and p4.ProductId > 0 then
        u2.ProductGrants[p4.ProductId] = {
            Emote = p4.Id,
            UniverseId = p4.ProductUniverse or 10764627709
        };
    end;
end;

add({
    Id = "IdleSit",
    Name = "Idle Sit",
    Animation = 113589223418669,
    Free = true
});
add({
    Id = "Floss",
    Name = "Floss",
    Animation = 135794438436497,
    Rarity = "Legendary",
    ProductId = 3716725473,
    Sound = 1839246711
});
add({
    Id = "Dougie",
    Name = "Dougie",
    Animation = 106752267746032,
    Rarity = "Rare",
    ProductId = 3716725474
});
add({
    Id = "Laugh",
    Name = "Laugh",
    Animation = 103656291005575,
    Rarity = "Rare",
    ProductId = 3716725479
});
add({
    Id = "SixtySeven",
    Name = "67",
    Animation = 107966108194198,
    Rarity = "Legendary",
    ProductId = 3716725481,
    Sound = 136993926059617
});
add({
    Id = "OhARat",
    Name = "Oh A Rat",
    Animation = 119411523069713,
    ProductId = 3716725483
});
add({
    Id = "Distraction",
    Name = "Distraction",
    Animation = 73378658930952,
    ProductId = 3716725485
});
add({
    Id = "BoogieDown",
    Name = "Boogie Down",
    Animation = 126035321508144,
    ProductId = 3716758304
});
add({
    Id = "RatDance",
    Name = "Rat Dance",
    Animation = 138379175536974,
    ProductId = 3716758316,
    Sound = 130389993370002
});
add({
    Id = "Caffeinated",
    Name = "Caffeinated",
    Animation = 127953847094225,
    ProductId = 3716758320
});
add({
    Id = "CaliforniaGirls",
    Name = "California Girls",
    Animation = 97645369663983,
    ProductId = 3716758328
});
add({
    Id = "YaYaYing",
    Name = "Ya Ya Ying",
    Animation = 130592563611393,
    ProductId = 3716758330,
    Sound = 96870161130852
});
add({
    Id = "Marisa",
    Name = "Marisa",
    Animation = 82737660812096,
    ProductId = 3716758326
});
add({
    Id = "FastDancer",
    Name = "Fast Dancer",
    Animation = 106413842810227,
    ProductId = 3716758325
});
add({
    Id = "Skipping",
    Name = "Skipping",
    Animation = 80867008915942,
    ProductId = 3716758308
});
add({
    Id = "PenguinWalk",
    Name = "Penguin Walk",
    Animation = 130040247059644,
    ProductId = 3716758312
});
add({
    Id = "RussianWalk",
    Name = "Russian Walk",
    Animation = 118341339323195,
    ProductId = 3716758314
});
add({
    Id = "Marat",
    Animation = 129373077422368,
    ProductId = 3716758334,
    Name = "Marat",
    Sound = 114101202887660
});
add({
    Id = "EDanceSupreme",
    Animation = 99201384065683,
    ProductId = 3716758338,
    Name = "E Dance Supreme",
    Sound = 97931224477953
});
add({
    Id = "DaBabyDance",
    Animation = 90659268527894,
    ProductId = 3716758339,
    Name = "DaBaby Dance",
    Sound = 126599903550541
});
add({
    Id = "ScarecrowPose",
    Name = "Scarecrow Pose",
    Animation = 101508403734664,
    Rarity = "Common",
    ProductId = 3719091361,
    Halloween = true,
    Source = "Halloween Store"
});
add({
    Id = "SpookyTiptoe",
    Name = "Spooky Tiptoe",
    Animation = 137159596842395,
    Rarity = "Common",
    ProductId = 3719091382,
    Halloween = true,
    Source = "Halloween Store",
    Anchor = true
});
add({
    Id = "PumpkinCarve",
    Name = "Pumpkin Carve",
    Animation = 72579137020787,
    Rarity = "Rare",
    ProductId = 3719091398,
    Halloween = true,
    Source = "Halloween Store"
});
add({
    Id = "WerewolfTransform",
    Name = "Werewolf Transform",
    Animation = 71536364109344,
    Rarity = "Epic",
    ProductId = 3719091422,
    Halloween = true,
    Source = "Halloween Store"
});
add({
    Id = "PoltergeistThrow",
    Name = "Poltergeist Throw",
    Animation = 106764646141706,
    Rarity = "Legendary",
    ProductId = 3719091439,
    Halloween = true,
    Source = "Halloween Store"
});
add({
    Id = "ZombieShuffle",
    Name = "Zombie Shuffle",
    Animation = 93934524669636,
    CrateOnly = true,
    Source = "Halloween Emote Crate"
});
add({
    Id = "GhostFloat",
    Name = "Ghost Float",
    Animation = 73635891728406,
    CrateOnly = true,
    Source = "Halloween Emote Crate"
});
add({
    Id = "CandyToss",
    Name = "Candy Toss",
    Animation = 86910697012466,
    CrateOnly = true,
    Source = "Halloween Emote Crate"
});
add({
    Id = "WitchsBrew",
    Name = "Witch\'s Brew",
    Animation = 114167641111047,
    CrateOnly = true,
    Source = "Halloween Emote Crate"
});
add({
    Id = "JumpScare",
    Name = "Jump Scare",
    Animation = 98664407365289,
    CrateOnly = true,
    Source = "Halloween Emote Crate"
});
add({
    Id = "SpiritPossession",
    Name = "Spirit Possession",
    Animation = 107173589497856,
    CrateOnly = true,
    Source = "Halloween Emote Crate"
});
add({
    Id = "RiseFromTheGrave",
    Name = "Rise From the Grave",
    Animation = 125689222962574,
    CrateOnly = true,
    Source = "Halloween Emote Crate",
    Anchor = true
});
add({
    Id = "CardTrick",
    Name = "Card Trick",
    Animation = 98301371224226,
    Length = 4.4,
    Rarity = "Epic",
    CrateOnly = true,
    Looks = "CardTrickCards",
    Prop = "Equipped",
    HideProp = true,
    Source = "Ghost Key Trader",
    Pieces = { "Plane", "Plane.001", "Plane.002", "Plane.003" },
    PieceJoints = {
        Plane = {
            Part0 = "HumanoidRootPart",
            C0 = CFrame.new(-2.09509, -2.0586, -0.64536) * CFrame.Angles(0, -1.5707963267948966, 0)
        },
        ["Plane.001"] = {
            Part0 = "HumanoidRootPart",
            C0 = CFrame.new(-0.71005, -2.0586, -0.64536) * CFrame.Angles(0, -1.5707963267948966, 0)
        },
        ["Plane.002"] = {
            Part0 = "HumanoidRootPart",
            C0 = CFrame.new(0.65849, -2.0586, -0.64536) * CFrame.Angles(0, -1.5707963267948966, 0)
        },
        ["Plane.003"] = {
            Part0 = "HumanoidRootPart",
            C0 = CFrame.new(1.98038, -2.0586, -0.64536) * CFrame.Angles(0, -1.5707963267948966, 0)
        }
    }
});
add({
    Id = "SpinningBlades",
    Name = "Spinning Blades",
    Animation = 99483148329032,
    Length = 6.17,
    Rarity = "Legendary",
    CrateOnly = true,
    Prop = "FallenAxes",
    Source = "Fallen King reward"
});
add({
    Id = "ThroneOfBones",
    Name = "Throne of Bones",
    Intro = 140617499876462,
    IntroLength = 3.95,
    Animation = 91119323359923,
    Length = 1.97,
    Rarity = "Epic",
    CrateOnly = true,
    Looks = "ThroneOfBones",
    Prop = "Equipped",
    HideProp = true,
    Source = "Fallen King reward",
    Pieces = { "Handle" },
    PieceJoints = {
        Handle = {
            Part0 = "HumanoidRootPart",
            C0 = CFrame.new(-0.00015, -4.64685, -0.00049)
        }
    },
    HidePieces = CFrame.new(0, -12, 0)
});
add({
    Id = "IdleDance",
    Name = "Idle Dance",
    Animation = 87191424706052,
    Route = "Free",
    Level = 10
});
add({
    Id = "SnappySkipping",
    Animation = 79190069227299,
    Name = "Snappy Skipping",
    Route = "Free",
    Level = 6
});
add({
    Id = "AnimePose",
    Animation = 119074085014154,
    Name = "Anime Pose",
    Route = "Free",
    Level = 8
});
add({
    Id = "WavyGrooves",
    Animation = 84754352893268,
    Name = "Wavy Grooves",
    Route = "Free",
    Level = 20
});
add({
    Id = "Jumpstyle",
    Animation = 107294391174536,
    Name = "Jumpstyle",
    Route = "Free",
    Level = 22,
    Sound = 113432720432230,
    Volume = 0.15
});
add({
    Id = "WibblyWobbly",
    Animation = 96292591765828,
    Name = "Wibbly Wobbly",
    Route = "Premium",
    Level = 2
});
add({
    Id = "LoseIt",
    Animation = 121939811031038,
    Name = "Lose It",
    Route = "Premium",
    Level = 5
});
add({
    Id = "Skeleton",
    Animation = 97839334201302,
    Name = "Skeleton",
    Route = "Premium",
    Level = 7
});
add({
    Id = "Shuffle",
    Animation = 93781424615167,
    Name = "Shuffle",
    Route = "Premium",
    Level = 10,
    Sound = 121336825946792
});
add({
    Id = "BTSDance",
    Animation = 94028976523160,
    Name = "BTS Dance",
    Route = "Premium",
    Level = 11,
    Sound = 126904174816024
});
add({
    Id = "Flexer",
    Animation = 77003640625644,
    Name = "Flexer",
    Route = "Premium",
    Level = 14,
    Sound = 96810078470068
});
add({
    Id = "SkeletonGrooves",
    Animation = 80956693359862,
    Name = "Skeleton Grooves",
    Route = "Free",
    Level = 30,
    Sound = 122746160353348
});
add({
    Id = "Moongazer",
    Animation = 103041287514333,
    Name = "Moongazer",
    Route = "Premium",
    Level = 21,
    Sound = 111420025940035
});
add({
    Id = "ElectroShuffle",
    Animation = 132346968213290,
    Name = "Electro Shuffle",
    Route = "Premium",
    Level = 24
});
add({
    Id = "CatDance",
    Animation = 85881899973965,
    Name = "Cat Dance",
    Route = "Premium",
    Level = 28,
    Sound = 77484392307222
});
add({
    Id = "Touchdown",
    Name = "Touchdown",
    Animation = 116317927469580,
    Knife = "Football",
    Prop = "Football",
    Source = "Comes with the Football",
    Cheers = true
});
add({
    Id = "BallJuggle",
    Name = "Ball Juggle",
    Animation = 103312504890307,
    Knife = "Futbol",
    Prop = "Futbol",
    Source = "Comes with the Futbol",
    Cheers = true
});
add({
    Id = "SoulCall",
    Name = "Soul Call",
    Animation = 84993434682421,
    Knife = "Soulbinder",
    Prop = "Soulbinder",
    Source = "Comes with the Soulbinder"
});
add({
    Id = "ClownJuggle",
    Name = "Clown Juggle",
    Animation = 137966157839171,
    Length = 9.25,
    Knife = "GrinnerBlades",
    Prop = "GrinnerBlades",
    PropDual = true,
    HideProp = true,
    Source = "Comes with the Grinner Blades",
    Sound = 9046172743,
    Volume = 0.18,
    Pieces = { "Handle.L", "Handle.R" },
    PieceJoints = {
        ["Handle.L"] = {
            Part0 = "Left Arm",
            BladeLength = 3.4134,
            C0 = CFrame.new(0.008, -1, -0.0256),
            Blade = CFrame.new(0.015, 0, -0.9367) * CFrame.Angles(0, 3.141592653589793, 0)
        },
        ["Handle.R"] = {
            Part0 = "Right Arm",
            BladeLength = 3.4134,
            C0 = CFrame.new(-0.023, -1, -0.0256),
            Blade = CFrame.new(0.001, 0, -0.9367) * CFrame.Angles(0, 3.141592653589793, 0)
        }
    },
    ExtraSounds = {
        {
            Id = 110457906711483,
            Volume = 0.45,
            Delay = 2.3
        },
        {
            Id = 110457906711483,
            Volume = 0.45,
            Delay = 2.75
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 3.3
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 3.32
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 3.7
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 3.72
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 4.2
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 4.22
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 4.6
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 4.62
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 5.1
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 5.12
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 5.5
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 5.52
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 6
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 6.02
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 6.4
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 6.42
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 6.9
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 6.92
        },
        {
            Id = 9113133597,
            Volume = 0.2,
            Delay = 7.3
        },
        {
            Id = 9120773999,
            Volume = 0.35,
            Delay = 7.32
        },
        {
            Id = 9113133597,
            Volume = 0.25,
            Delay = 7.7
        },
        {
            Id = 9113133597,
            Volume = 0.25,
            Delay = 8
        },
        {
            Id = 107056835646946,
            Volume = 0.5,
            Delay = 8.15
        }
    }
});
add({
    Id = "KarambitSpin",
    Name = "Karambit Spin",
    Animation = 138332378029114,
    Kind = "Karambit",
    Prop = "Equipped",
    Source = "Comes with any karambit",
    Sound = 89022397344205,
    SoundEachLoop = true,
    SoundPerLoop = 2,
    Length = 5.7
});
add({
    Id = "ChainSnap",
    Name = "Chain Snap",
    Animation = 131102897545621,
    Length = 7.43,
    Kind = "Kusarigama",
    Prop = "Equipped",
    Source = "Comes with the Void Kusarigama and up",
    Sound = 78087679318858,
    VFX = "ChainSnap",
    Anchor = true,
    UnlockedBy = { "VoidKusarigama", "DualVoidKusarigamas", "UltimateVoidBlades" },
    ExtraSounds = { {
            Id = 137342137455996,
            Volume = 1,
            Delay = 1.5
        } }
});
add({
    Id = "TheImmortal",
    Name = "The Immortal",
    Animation = 136380202296200,
    Intro = 133973141485233,
    IntroLength = 3.883,
    Looks = "KitsuneMasks",
    Kind = "Kitsune",
    Prop = "Equipped",
    Source = "Comes with the Immortal Kitsune and up",
    Sound = 123519790356949,
    SoundDelay = 1,
    SoundEachLoop = true,
    Length = 12.967,
    VFX = "TheImmortal",
    Pieces = { "KITSUNE", " k2", "k3" },
    PlaysWith = { "UltimateVoidBlades" },
    UnlockedBy = { "ImmortalKitsune", "DualImmortalKitsune", "UltimateVoidBlades" }
});

local function showClip(p5, p6, p7) -- Line: 323
    local Models = script.Parent.Parent.Weapons:FindFirstChild("Models");

    if Models then
        Models = Models:FindFirstChild(p5);
    end;

    if Models then
        Models = Models:GetAttribute(p6);
    end;

    if type(Models) == "string" then
        Models = Models:match("(%d+)$");
    end;

    local v8 = tonumber(Models);

    if v8 and v8 > 0 then
        return v8;
    end;

    return p7;
end;

add({
    Id = "FootballCatch",
    Name = "Football Catch",
    Prop = "Football",
    Source = "Team Football reward",
    Animation = showClip("Football", "CatchAnim", 127097952153712)
});
add({
    Id = "FutbolCatch",
    Name = "Fútbol Catch",
    Prop = "Futbol",
    Source = "Team Fútbol reward",
    Animation = showClip("Futbol", "IntroAnim", 118517126386166)
});

for i, v in require(script.Parent.Parent.Weapons:WaitForChild("CombineConfig")).UltimateEmotes do
    add({
        Ultimate = true,
        Prop = "Equipped",
        Source = "Comes with its Ultimate knife",
        Id = v.Id,
        Name = v.Name,
        Animation = v.Animation,
        Knife = i
    });
end;

add({
    Id = "PatientZero",
    Name = "Patient Zero",
    Animation = 80129376693769,
    Knife = "InfectedKnife",
    OutbreakMilestone = "Emote",
    Source = "The Outbreak · 100%"
});
add({
    Id = "KneelToTheKing",
    Name = "Kneel to the King",
    Intro = 78555274870288,
    IntroLength = 0.833,
    Animation = 135449859136754,
    Source = "The Fallen King · 100 souls"
});

local function asset(p9) -- Line: 349
    if type(p9) == "number" and (p9 > 0 and p9 % 1 == 0) then
        return "rbxassetid://" .. string.format("%.0f", p9);
    end;

    if type(p9) ~= "string" then
        return nil;
    end;

    local v10 = p9:match("^rbxassetid://([1-9]%d*)$") or p9:match("^([1-9]%d*)$");

    if v10 then
        return "rbxassetid://" .. v10;
    end;

    return nil;
end;

local function whole(p11) -- Line: 358
    local v12;

    if type(p11) == "number" and p11 > 0 then
        v12 = p11 % 1 == 0;
    else
        v12 = false;
    end;

    return v12;
end;

function u2.get(p13) -- Line: 361
    -- upvalues: u3 (copy)
    return u3[p13];
end;

local u14 = nil;

function u2.knifeKind(p15) -- Line: 366
    -- upvalues: u14 (ref)
    u14 = u14 or require(script.Parent.Parent.Weapons.SkinCatalog);
    local v16;

    if type(p15) == "string" then
        v16 = u14.get(p15);
    else
        v16 = false;
    end;

    if v16 then
        v16 = script.Parent.Parent.Weapons.Models:FindFirstChild(v16.Model);
    end;

    if v16 then
        v16 = v16:GetAttribute("KnifeKind");
    end;

    return type(v16) == "string" and v16 and v16 or nil;
end;

function u2.owned(p17, p18) -- Line: 373
    -- upvalues: u3 (copy), u2 (copy)
    local v19 = u3[p17];

    if v19 == nil or v19.Ultimate then
        return false;
    end;

    if v19.Free == true or p18 ~= nil and (p18.emotes ~= nil and p18.emotes[p17] == true) then
        return true;
    end;

    if v19.OutbreakMilestone and not require(script.Parent.Parent.Game.OutbreakConfig).reached(v19.OutbreakMilestone, workspace:GetServerTimeNow()) then
        return false;
    end;

    if p18 then
        p18 = p18.owned;
    end;

    if type(p18) ~= "table" then
        return false;
    end;

    if v19.Knife and p18[v19.Knife] == true then
        return true;
    end;

    if v19.UnlockedBy then
        for _, v in v19.UnlockedBy do
            if p18[v] == true then
                return true;
            end;
        end;

        return false;
    end;

    for _, v in v19.PlaysWith or {} do
        if p18[v] == true then
            return true;
        end;
    end;

    if v19.Kind then
        for i, v in p18 do
            if v == true and u2.knifeKind(i) == v19.Kind then
                return true;
            end;
        end;
    end;

    return false;
end;

function u2.ultimate(p20) -- Line: 421
    -- upvalues: u2 (copy)
    for _, v in u2.Entries do
        if v.Ultimate and v.Knife == p20 then
            return v.Id;
        end;
    end;

    return nil;
end;

function u2.bundle(p21) -- Line: 430
    -- upvalues: u2 (copy)
    local v22 = u2.knifeKind(p21);
    local v23 = {};

    for _, v in u2.Entries do
        local v24;

        if v.UnlockedBy then
            v24 = table.find(v.UnlockedBy, p21) ~= nil;
        elseif v.Knife == p21 then
            v24 = true;
        elseif v.Kind == nil then
            v24 = false;
        else
            v24 = v.Kind == v22;
        end;

        if v24 then
            table.insert(v23, v);
        end;
    end;

    return v23;
end;

function u2.playsWith(p25, p26) -- Line: 444
    -- upvalues: u3 (copy), u2 (copy)
    local v27 = u3[p25];

    if v27 and v27.Kind then
        return u2.knifeKind(p26) == v27.Kind and true or table.find(v27.PlaysWith or {}, p26) ~= nil;
    end;

    return v27 ~= nil;
end;

function u2.holdsIdle(p28, p29) -- Line: 452
    -- upvalues: u3 (copy), u2 (copy)
    local v30 = u3[p28];
    local v31;

    if v30 == nil or (v30.Kind == nil or u2.knifeKind(p29) == v30.Kind) then
        v31 = false;
    else
        v31 = u2.playsWith(p28, p29);
    end;

    return v31;
end;

function u2.prop(p32, p33) -- Line: 458
    -- upvalues: u3 (copy), u2 (copy), u14 (ref)
    local v34 = u3[p32];

    if not (v34 and v34.Prop) then
        return nil;
    end;

    if not v34.Kind or u2.playsWith(p32, p33) then
        if v34.PropDual then
            if u2.dualWield(p33) then
                return p33;
            end;

            return false, "Equip a dual-wielded knife to use this emote.";
        end;

        if v34.Prop == "Equipped" then
            return p33;
        end;

        return v34.Prop;
    end;

    u14 = u14 or require(script.Parent.Parent.Weapons.SkinCatalog);
    local v35 = { "a " .. string.lower(v34.Kind) };

    for _, v in v34.PlaysWith or {} do
        local v36 = u14.get(v);
        local v37;

        if v36 then
            v37 = v36.SourceName or v;
        else
            v37 = v;
        end;

        table.insert(v35, "the " .. v37);
    end;

    return false, "Equip " .. table.concat(v35, " or ") .. " to use this emote.";
end;

function u2.dualWield(p38) -- Line: 481
    -- upvalues: u14 (ref)
    if type(p38) ~= "string" then
        return false;
    end;

    u14 = u14 or require(script.Parent.Parent.Weapons.SkinCatalog);
    local v39 = u14.get(p38);

    if v39 then
        v39 = script.Parent.Parent.Weapons.Models:FindFirstChild(v39.Model or p38);
    end;

    local v40;

    if v39 == nil then
        v40 = false;
    else
        v40 = v39:GetAttribute("IsDualWield") == true;
    end;

    return v40;
end;

function u2.assetId(p41) -- Line: 490
    -- upvalues: u3 (copy), asset (copy)
    local v42 = u3[p41];

    if not v42 then
        return nil;
    end;

    local v43 = asset(v42.Animation);

    if v43 then
        return v43;
    end;

    local Assets = script.Parent:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild(p41);
    end;

    return Assets and (Assets:IsA("Animation") and asset(Assets.AnimationId)) or nil;
end;

function u2.soundId(p44) -- Line: 503
    -- upvalues: u3 (copy), asset (copy)
    local v45 = u3[p44];

    if v45 then
        v45 = asset(v45.Sound);
    end;

    return v45;
end;

function u2.soundIds(p46) -- Line: 509
    -- upvalues: u3 (copy), asset (copy)
    local v47 = u3[p46];
    local v48 = {};
    local v49 = {};
    local v50 = {};
    local v51;

    if v47 then
        v51 = asset(v47.Sound);
    else
        v51 = v47;
    end;

    if v51 then
        local v52 = tonumber(v47.Volume) or 0.25;
        table.insert(v48, v51);
        table.insert(v49, v52);

        for _, v in v47.ExtraSounds or {} do
            local v53;

            if type(v) == "table" then
                v53 = v.Id;
            else
                v53 = v;
            end;

            local v54 = asset(v53);

            if v54 then
                table.insert(v48, v54);
                local v55;

                if type(v) == "table" then
                    v55 = tonumber(v.Volume) or v52;
                else
                    v55 = v52;
                end;

                table.insert(v49, v55);
                local v56;

                if type(v) == "table" then
                    v56 = tonumber(v.Delay) or nil;
                else
                    v56 = nil;
                end;

                v50[#v48] = v56;
            end;
        end;
    end;

    return v48, v49, v50;
end;

function u2.introId(p57) -- Line: 529
    -- upvalues: u3 (copy), asset (copy)
    local v58 = u3[p57];

    if v58 then
        v58 = asset(v58.Intro);
    end;

    return v58;
end;

function u2.available(p59) -- Line: 533
    -- upvalues: u2 (copy), RunService (copy)
    if u2.ComingSoon then
        return false;
    end;

    if u2.assetId(p59) then
        return true;
    end;

    local Clips = script.Parent:FindFirstChild("Clips");
    local v60 = u2.StudioPreview and RunService:IsStudio();

    if v60 then
        if Clips == nil then
            v60 = false;
        else
            v60 = Clips:FindFirstChild(p59) ~= nil;
        end;
    end;

    return v60;
end;

u2.Cards = {
    Common = "Coins",
    Rare = "Coins",
    Epic = "Gems",
    Legendary = "Robux"
};
u2.CardPrices = {
    Coins = { "coins", 350 },
    Gems = { "gems", 125 }
};
local u61 = {};

for _, v in require(script.Parent.Parent.Crates.CrateCatalog).Crates do
    for _, v2 in v.Entries do
        if v2.Emote then
            u61[v2.Emote] = u61[v2.Emote] or v2.Rarity;
        end;
    end;
end;

function u2.rarity(p62) -- Line: 555
    -- upvalues: u3 (copy), u61 (copy)
    local v63 = u3[p62];
    local v64;

    if v63 then
        v64 = v63.Rarity or u61[p62] or nil;
    else
        v64 = nil;
    end;

    return v64;
end;

function u2.inCrate(p65) -- Line: 560
    -- upvalues: u61 (copy)
    return u61[p65] ~= nil;
end;

function u2.card(p66) -- Line: 565
    -- upvalues: u3 (copy), u2 (copy)
    local v67 = u3[p66];
    local v68;

    if v67 and not (v67.CrateOnly or v67.Halloween) then
        v68 = u2.Cards[u2.rarity(p66)];
    else
        v68 = nil;
    end;

    if v68 == "Robux" then
        local ProductId = v67.ProductId;
        local v69;

        if type(ProductId) == "number" and ProductId > 0 then
            v69 = ProductId % 1 == 0;
        else
            v69 = false;
        end;

        if not v69 then
            return nil;
        end;
    end;

    return v68;
end;

function u2.price(p70) -- Line: 575
    -- upvalues: u2 (copy)
    local v71 = u2.CardPrices[u2.card(p70) or ""];

    if v71 then
        return v71[1], v71[2];
    end;

    return nil;
end;

function u2.sold(p72) -- Line: 583
    -- upvalues: u2 (copy)
    return u2.card(p72) ~= nil;
end;

return u2;