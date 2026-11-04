 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local CombineConfig = require(Weapons:WaitForChild("CombineConfig"));
local MapLocator = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("MapLocator"));
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local DaggerConfig = require(Weapons:WaitForChild("DaggerConfig"));
local KnifeChains = require(Weapons:WaitForChild("KnifeChains"));
local ClientBotKnife = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("ClientBotKnife"));
local Animation = ChickenOrHero:WaitForChild("Animation");
local TackleAnimation = require(Animation:WaitForChild("TackleAnimation"));
local AnimationConfig = require(Animation:WaitForChild("AnimationConfig"));
local Emotes = ChickenOrHero:WaitForChild("Emotes");
local EmoteCatalog = require(Emotes:WaitForChild("EmoteCatalog"));
local EmotePlayback = require(Emotes:WaitForChild("EmotePlayback"));
local EmotePieces = require(Emotes:WaitForChild("EmotePieces"));
local CharacterClone = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("CharacterClone"));
local Audio = ChickenOrHero:WaitForChild("Audio");
local table_clone_ret = table.clone(require(Audio:WaitForChild("AudioConfig")));
table_clone_ret.MaxVoices = 6;
table_clone_ret.MaxOneShotSeconds = 4;
local u1 = require(Audio:WaitForChild("AudioPlayback")).new(SoundService:WaitForChild("GameAudio"), require(Audio:WaitForChild("AudioCatalog")), table_clone_ret);
local u2 = { {
        skin = "VoidKusarigama"
    }, {
        skin = "DualVoidKusarigamas",
        emotes = true
    }, {
        skin = "ImmortalKitsune"
    }, {
        skin = "DualImmortalKitsune",
        emotes = true
    }, {
        skin = "UltimateVoidBlades"
    } };
local u3 = {};
local u4 = { "ArmoryOpen", "BundleOfferOpen", "MergeInfoOpen", "FootballEventOpen", "EventKnivesOpen", "ProUnlockActive" };
local u5 = {};

local function connect(p6, p7) -- Line: 64
    -- upvalues: u5 (copy)
    local v8 = p6:Connect(p7);
    table.insert(u5, v8);

    return v8;
end;

local Folder = Instance.new("Folder");
Folder.Name = "MergeDisplayLocal";
Folder.Parent = workspace;
local u9 = nil;
local u10 = {};
local u11 = nil;
local u12 = nil;

local function ended() -- Line: 78
    -- upvalues: CombineConfig (copy)
    local v13;

    if type(CombineConfig.EndsAt) == "number" then
        v13 = os.time() >= CombineConfig.EndsAt;
    else
        v13 = false;
    end;

    return v13;
end;

local u14 = {
    [2] = "UPGRADED",
    [3] = "DUAL"
};

local function levelOf(p15) -- Line: 84
    -- upvalues: CombineConfig (copy), u14 (copy)
    if CombineConfig.isFusion(p15) then
        return "ULTIMATE", CombineConfig.TierColors[#CombineConfig.TierColors];
    end;

    local _, v16 = CombineConfig.tierOf(p15);
    local v17 = v16 or 1;

    return u14[v17] or "", CombineConfig.TierColors[math.clamp(v17, 1, #CombineConfig.TierColors)];
end;

local function hideStand(p18) -- Line: 93
    -- upvalues: u9 (ref), u10 (copy)
    if not u9 then
        return;
    end;

    for _, descendant in u9:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = p18 and 1 or 0;
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            if p18 and u10[descendant] == nil then
                u10[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            elseif not p18 and u10[descendant] ~= nil then
                descendant.Transparency = u10[descendant];
                u10[descendant] = nil;
            end;
        end;
    end;
end;

local function board(p19) -- Line: 114
    -- upvalues: Folder (copy)
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "MergeLevel";
    BillboardGui.Size = UDim2.fromScale(8, 2.3);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 3.4, 0);
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 70;
    BillboardGui.ResetOnSpawn = false;
    BillboardGui.Adornee = p19;
    local UIScale = Instance.new("UIScale");
    UIScale.Parent = BillboardGui;

    local function label(p20, p21, p22, p23) -- Line: 125
        -- upvalues: BillboardGui (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p20;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.AnchorPoint = Vector2.new(0.5, 0);
        TextLabel.Position = UDim2.fromScale(0.5, p21);
        TextLabel.Size = UDim2.fromScale(1, p22);
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", p23);
        TextLabel.TextScaled = true;
        TextLabel.TextColor3 = Color3.new(1, 1, 1);
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = 0.12;
        UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
        UIStroke.Parent = TextLabel;
        TextLabel.Parent = BillboardGui;

        return TextLabel;
    end;

    local v24 = label("Level", 0, 0.42, Enum.FontWeight.Heavy);
    local v25 = label("Knife", 0.44, 0.5, Enum.FontWeight.ExtraBold);
    BillboardGui.Parent = Folder;

    return {
        gui = BillboardGui,
        level = v24,
        name = v25,
        scale = UIScale
    };
end;

local function showLevel(p26) -- Line: 147
    -- upvalues: u12 (ref), CombineConfig (copy), u14 (copy), SkinCatalog (copy), TweenService (copy)
    if not u12 then
        return;
    end;

    local v27, v28;

    if CombineConfig.isFusion(p26) then
        v27 = CombineConfig.TierColors[#CombineConfig.TierColors];
        v28 = "ULTIMATE";
    else
        local _, v29 = CombineConfig.tierOf(p26);
        local v30 = v29 or 1;
        v28 = u14[v30] or "";
        v27 = CombineConfig.TierColors[math.clamp(v30, 1, #CombineConfig.TierColors)];
    end;

    local v31 = SkinCatalog.get(p26);
    u12.board.level.Text = v28;
    u12.board.level.TextColor3 = v27;

    if v31 then
        p26 = v31.SourceName or (v31.Name or p26);
    end;

    u12.board.name.Text = p26;
    u12.board.scale.Scale = 0.75;
    TweenService:Create(u12.board.scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
end;

local function scaled(p32, p33) -- Line: 163
    return CFrame.new(p32.Position * p33) * p32.Rotation;
end;

local function scaleOn(p34, p35, p36, p37) -- Line: 167
    -- upvalues: u12 (ref)
    if p35 == 1 then
        return;
    end;

    local v38 = {};

    for _, descendant in u12.rig:GetDescendants() do
        if descendant:IsA("JointInstance") and (descendant.Part0 and (descendant.Part1 and not (p37 and p37[descendant]))) and descendant.Part0:IsDescendantOf(p36) ~= descendant.Part1:IsDescendantOf(p36) then
            table.insert(v38, descendant);
        end;
    end;

    p34:ScaleTo(p35);

    for _, v in v38 do
        local C0 = v.C0;
        v.C0 = CFrame.new(C0.Position * p35) * C0.Rotation;
        local C1 = v.C1;
        v.C1 = CFrame.new(C1.Position * p35) * C1.Rotation;
    end;
end;

local function scaleKnife(p39) -- Line: 189
    -- upvalues: u12 (ref), scaleOn (copy), KnifeChains (copy)
    if p39.weapon and u12.scale ~= 1 then
        local v40 = {};

        for _, v in not p39.chain and {} or p39.chain.pieces do
            v40[v.joint] = true;
        end;

        scaleOn(p39.weapon, u12.scale, p39.weapon, v40);

        if p39.chain then
            KnifeChains.rescale(p39.chain, u12.scale);
        end;
    end;
end;

local function cue(p41) -- Line: 203
    -- upvalues: u12 (ref), SkinCatalog (copy), u1 (copy)
    if not (u12 and u12.audible) then
        return;
    end;

    local v42 = SkinCatalog.get(u12.skin);
    u1:one("Knife_" .. (v42 and (p41 == "Hit" and v42.HitSoundProfile or (v42.SoundProfile or "BaseDagger")) or "BaseDagger") .. "_" .. p41, u12.root, 0.65);
end;

local function startEmote(p43) -- Line: 214
    -- upvalues: u12 (ref), EmotePlayback (copy), EmotePieces (copy), scaleOn (copy)
    local knife = u12.knife;
    u12.emoting = true;
    knife:show(true, knife.chain and "Right Arm" or nil);
    local v44 = {};
    local v45 = EmotePlayback.load(u12.animator, p43.Id);
    local v46 = p43.Intro and EmotePlayback.intro(u12.animator, p43.Id);

    if v46 then
        v46:Play(0.15);
    elseif v45 then
        v45:Play(0.15);
    end;

    table.insert(v44, v46);
    table.insert(v44, v45);
    u12.emote = {
        tracks = v44,
        id = p43.Id,
        loop = v45,
        intro = v46,
        sounds = {}
    };

    if p43.Pieces and knife.weapon then
        u12.emote.pieces = EmotePieces.build(u12.rig, p43, knife.weapon, knife.weapon);

        for _, v in u12.emote.pieces do
            for _, child in v:GetChildren() do
                if child:IsA("Model") then
                    scaleOn(child, u12.scale, child);
                elseif child:IsA("BasePart") and u12.scale ~= 1 then
                    child.Size = child.Size * u12.scale;
                    local PieceWeld = child:FindFirstChild("PieceWeld");

                    if PieceWeld then
                        local C0 = PieceWeld.C0;
                        local v47 = CFrame.new(C0.Position * u12.scale) * C0.Rotation;
                        local C1 = PieceWeld.C1;
                        local v48 = CFrame.new(C1.Position * u12.scale) * C1.Rotation;
                        PieceWeld.C0 = v47;
                        PieceWeld.C1 = v48;
                    end;
                end;
            end;
        end;
    end;

    u12.rig:SetAttribute("EmoteId", p43.Id);
end;

local function emoteSound(p49, p50) -- Line: 250
    -- upvalues: u12 (ref), EmoteCatalog (copy)
    if not (u12 and (u12.emote and u12.audible)) then
        return;
    end;

    local v51, v52, v53 = EmoteCatalog.soundIds(p49.Id);

    for i, v in v51 do
        if (not p50 or i == p50) and (p50 or not v53[i]) then
            local Sound = Instance.new("Sound");
            Sound.SoundId = v;
            Sound.Volume = v52[i];
            Sound.RollOffMaxDistance = 80;
            Sound.Parent = u12.root;
            Sound:Play();
            table.insert(u12.emote.sounds, Sound);
            Sound.Ended:Once(function() -- Line: 267
                -- upvalues: Sound (copy)
                Sound:Destroy();
            end);
        end;
    end;
end;

local function stopEmote() -- Line: 272
    -- upvalues: u12 (ref), EmotePlayback (copy), EmotePieces (copy)
    local v54 = u12 and u12.emote;

    if not v54 then
        return;
    end;

    u12.emote = nil;

    for _, v in v54.tracks do
        EmotePlayback.dispose(v);
    end;

    for _, v in v54.sounds do
        v:Destroy();
    end;

    if v54.pieces then
        EmotePieces.clear(v54.pieces);
    end;

    u12.rig:SetAttribute("EmoteId", nil);
    u12.emoting = false;
    u12.knife:show(false);
end;

local function stagesFor(u55) -- Line: 294
    -- upvalues: u12 (ref), showLevel (copy), DaggerConfig (copy), SkinCatalog (copy), u1 (copy), TackleAnimation (copy), EmoteCatalog (copy), u3 (copy), emoteSound (copy), startEmote (copy), stopEmote (copy)
    local function _() -- Line: 295
        -- upvalues: u12 (ref)
        return u12.rig;
    end;

    local v62 = {
        {
            name = "Stowed",
            seconds = 1.6,

            enter = function() -- Line: 302, Name: enter
                -- upvalues: u12 (ref), u55 (copy), showLevel (ref)
                u12.rig:SetAttribute("DaggerState", "Stowed");
                u12.rig:SetAttribute("DaggerSkin", u55.skin);
                u12.skin = u55.skin;
                showLevel(u55.skin);
            end
        },
        {
            name = "Draw",
            seconds = DaggerConfig.DrawDuration + 0.05,

            enter = function() -- Line: 312, Name: enter
                -- upvalues: u12 (ref)
                u12.rig:SetAttribute("DaggerDrawStartedAt", u12.clock);
                u12.rig:SetAttribute("DaggerState", "Drawing");
            end,

            cues = {
                { 0.08, function() -- Line: 316
                        -- upvalues: u12 (ref), SkinCatalog (ref), u1 (ref)
                        if u12 then
                            if not u12.audible then
                                return;
                            end;

                            local v56 = SkinCatalog.get(u12.skin);
                            u1:one("Knife_" .. (v56 and v56.SoundProfile or "BaseDagger") .. "_Equip", u12.root, 0.65);
                        end;
                    end }
            }
        },
        {
            name = "Ready",
            seconds = 1,

            enter = function() -- Line: 320, Name: enter
                -- upvalues: u12 (ref)
                u12.rig:SetAttribute("DaggerState", "Held");
            end
        },
        {
            name = "Windup",
            seconds = 0.55,

            enter = function() -- Line: 326, Name: enter
                -- upvalues: u12 (ref)
                u12.rig:SetAttribute("ReachPhase", "Windup");
            end,

            cues = {
                { 0.04, function() -- Line: 329
                        -- upvalues: u12 (ref), SkinCatalog (ref), u1 (ref)
                        if u12 then
                            if not u12.audible then
                                return;
                            end;

                            local v57 = SkinCatalog.get(u12.skin);
                            u1:one("Knife_" .. (v57 and v57.SoundProfile or "BaseDagger") .. "_Windup", u12.root, 0.65);
                        end;
                    end }
            }
        },
        {
            name = "Stab",
            seconds = 1.1,

            enter = function() -- Line: 336, Name: enter
                -- upvalues: u12 (ref)
                u12.rig:SetAttribute("ReachPhase", nil);
                u12.rig:SetAttribute("ReachStartedAt", u12.clock);
            end,

            cues = {
                { 0.04, function() -- Line: 340
                        -- upvalues: u12 (ref), SkinCatalog (ref), u1 (ref)
                        if u12 then
                            if not u12.audible then
                                return;
                            end;

                            local v58 = SkinCatalog.get(u12.skin);
                            u1:one("Knife_" .. (v58 and v58.SoundProfile or "BaseDagger") .. "_Swing", u12.root, 0.65);
                        end;
                    end },
                { 0.26, function() -- Line: 342
                        -- upvalues: u12 (ref), SkinCatalog (ref), u1 (ref)
                        if u12 then
                            if not u12.audible then
                                return;
                            end;

                            local v59 = SkinCatalog.get(u12.skin);
                            u1:one("Knife_" .. (v59 and (v59.HitSoundProfile or v59.SoundProfile or "BaseDagger") or "BaseDagger") .. "_Hit", u12.root, 0.65);
                        end;
                    end }
            }
        },
        {
            name = "Recover",
            seconds = 0.9
        },
        {
            name = "Dive",
            seconds = 1.25,

            enter = function() -- Line: 350, Name: enter
                -- upvalues: u12 (ref), TackleAnimation (ref)
                u12.rig:SetAttribute("TackleActive", true);
                TackleAnimation.play(u12.rig, "DaggerDive", 1.2);
            end,

            cues = {
                { 0.02, function() -- Line: 354
                        -- upvalues: u12 (ref), SkinCatalog (ref), u1 (ref)
                        if u12 then
                            if not u12.audible then
                                return;
                            end;

                            local v60 = SkinCatalog.get(u12.skin);
                            u1:one("Knife_" .. (v60 and v60.SoundProfile or "BaseDagger") .. "_Dive", u12.root, 0.65);
                        end;
                    end },
                { 0.32, function() -- Line: 356
                        -- upvalues: u12 (ref), SkinCatalog (ref), u1 (ref)
                        if u12 then
                            if not u12.audible then
                                return;
                            end;

                            local v61 = SkinCatalog.get(u12.skin);
                            u1:one("Knife_" .. (v61 and (v61.HitSoundProfile or v61.SoundProfile or "BaseDagger") or "BaseDagger") .. "_Hit", u12.root, 0.65);
                        end;
                    end }
            },

            exit = function() -- Line: 359, Name: exit
                -- upvalues: u12 (ref)
                u12.rig:SetAttribute("TackleActive", nil);
            end
        },
        {
            name = "Recover",
            seconds = 1.3
        }
    };

    if u55.emotes then
        for _, v in EmoteCatalog.bundle(u55.skin) do
            if EmoteCatalog.assetId(v.Id) and not u3[v.Id] then
                local v63;

                if v.Intro then
                    v63 = (v.IntroLength or 4) + 7;
                else
                    v63 = tonumber(v.Length) or 7.5;
                end;

                local v64 = {};
                local v65 = tonumber(v.SoundDelay) or 0;
                table.insert(v64, { v65, function() -- Line: 372
                        -- upvalues: emoteSound (ref), v (copy)
                        emoteSound(v);
                    end });
                local v66 = tonumber(v.Length);
                local u67;

                if v.SoundEachLoop and v66 then
                    local v68 = tonumber(v.SoundPerLoop) or 1;
                    local math_floor_ret = math.floor(v68);
                    local math_clamp_ret = math.clamp(math_floor_ret, 1, 8);
                    local v69 = (v.Intro and (v.IntroLength or 0) or 0) + v66 / math_clamp_ret + v65;
                    u67 = v;

                    while v69 < v63 - 0.5 do
                        table.insert(v64, { v69, function() -- Line: 381
                                -- upvalues: emoteSound (ref), u67 (copy)
                                emoteSound(u67);
                            end });
                        v69 = v69 + v66 / math_clamp_ret;
                    end;
                else
                    u67 = v;
                end;

                local _, _, v70 = EmoteCatalog.soundIds(u67.Id);

                for i, v2 in v70 do
                    local v71 = (u67.Intro and (u67.IntroLength or 0) or 0) + v2;
                    local u72 = i;

                    while v71 < v63 - 0.3 and #v64 < 24 do
                        table.insert(v64, { v71, function() -- Line: 393
                                -- upvalues: emoteSound (ref), u67 (copy), u72 (copy)
                                emoteSound(u67, u72);
                            end });

                        if not v66 or v66 <= 0.5 then
                            break;
                        end;

                        v71 = v71 + v66;
                    end;
                end;

                if u67.Intro then
                    local v73 = { math.max(0.1, (u67.IntroLength or 4) - 0.1), function() -- Line: 404
                            -- upvalues: u12 (ref)
                            local emote = u12.emote;

                            if emote and emote.loop then
                                emote.loop:Play(0.1);
                                emote.loop.TimePosition = 0;

                                if emote.intro then
                                    emote.intro:Stop(0.1);
                                end;
                            end;
                        end };
                    table.insert(v64, v73);
                end;

                table.insert(v62, {
                    name = "Emote",
                    seconds = v63,

                    enter = function() -- Line: 418, Name: enter
                        -- upvalues: u12 (ref), startEmote (ref), u67 (copy)
                        u12.rig:SetAttribute("DaggerState", "Stowed");
                        u12.knife:update(u12.clock, true);
                        startEmote(u67);
                    end,

                    cues = v64,
                    exit = stopEmote
                });
                table.insert(v62, {
                    name = "Recover",
                    seconds = 0.8
                });
            end;
        end;
    end;

    table.insert(v62, {
        name = "Sheathe",
        seconds = 1.2,

        enter = function() -- Line: 434, Name: enter
            -- upvalues: u12 (ref)
            u12.rig:SetAttribute("DaggerState", "Stowed");
        end,

        cues = {
            { 0.02, function() -- Line: 437
                    -- upvalues: u12 (ref), SkinCatalog (ref), u1 (ref)
                    if u12 then
                        if not u12.audible then
                            return;
                        end;

                        local v74 = SkinCatalog.get(u12.skin);
                        u1:one("Knife_" .. (v74 and v74.SoundProfile or "BaseDagger") .. "_Sheath", u12.root, 0.65);
                    end;
                end }
        }
    });

    return v62;
end;

local function teardown() -- Line: 444
    -- upvalues: u12 (ref), stopEmote (copy), TackleAnimation (copy)
    if not u12 then
        return;
    end;

    local v75 = u12;
    stopEmote();
    u12 = nil;

    if v75.knife then
        v75.knife:destroy();
        v75.knife:remove();
    end;

    if v75.idle then
        v75.idle:Stop(0);
        v75.idle:Destroy();
    end;

    TackleAnimation.release(v75.rig);
    v75.board.gui:Destroy();
    v75.rig:Destroy();
end;

local function build() -- Line: 465
    -- upvalues: teardown (copy), u9 (ref), CombineConfig (copy), hideStand (copy), u11 (ref), u2 (copy), Folder (copy), CollectionService (copy), AnimationConfig (copy), u12 (ref), ClientBotKnife (copy), board (copy)
    teardown();

    if u9 and u9.Parent then
        local v76;

        if type(CombineConfig.EndsAt) == "number" then
            v76 = os.time() >= CombineConfig.EndsAt;
        else
            v76 = false;
        end;

        if not v76 then
            local v77 = (u11 or u9):Clone();
            v77.Name = "MergeDisplay";

            for _, descendant in v77:GetDescendants() do
                if descendant:IsA("LuaSourceContainer") or (descendant:IsA("BillboardGui") or (descendant:IsA("SurfaceGui") or (descendant:IsA("Tool") or (descendant:IsA("ProximityPrompt") or descendant:IsA("Sound"))))) then
                    descendant:Destroy();
                end;
            end;

            local EquippedDagger = v77:FindFirstChild("EquippedDagger");

            if EquippedDagger then
                EquippedDagger:Destroy();
            end;

            for i in v77:GetAttributes() do
                v77:SetAttribute(i, nil);
            end;

            local v78 = v77:FindFirstChildOfClass("Humanoid");
            local HumanoidRootPart = v77:FindFirstChild("HumanoidRootPart");
            local Head = v77:FindFirstChild("Head");

            if not (v78 and (HumanoidRootPart and (Head and v78.RigType == Enum.HumanoidRigType.R6))) then
                v77:Destroy();

                return;
            end;

            v78.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            v78.AutoRotate = false;
            v78.BreakJointsOnDeath = false;
            v78.WalkSpeed = 0;
            v78.JumpPower = 0;
            v78.EvaluateStateMachine = false;
            local v79 = v78:FindFirstChildOfClass("Animator") or Instance.new("Animator");
            v79.Parent = v78;

            for _, descendant in v77:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = descendant == HumanoidRootPart;
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                    descendant.Massless = descendant ~= HumanoidRootPart;
                    descendant.LocalTransparencyModifier = 0;
                elseif descendant:IsA("Motor6D") then
                    descendant.Enabled = true;
                    descendant.Transform = CFrame.identity;
                end;
            end;

            v77.PrimaryPart = HumanoidRootPart;
            v77:ScaleTo(1);
            local v80 = u9:GetAttribute("DisplayScale") or u9:GetScale();
            v77:ScaleTo(v80);
            v77:PivotTo(u9:GetPivot());
            local v81 = u9:FindFirstChild("Left Leg");
            local v82 = v77:FindFirstChild("Left Leg");

            if v81 and v82 then
                local v83 = v81.Position.Y - v81.Size.Y * 0.5;
                v77:PivotTo(v77:GetPivot() + Vector3.new(0, v83 - (v82.Position.Y - v82.Size.Y * 0.5), 0));
            end;

            v77:SetAttribute("DaggerEquipped", true);
            v77:SetAttribute("DaggerState", "Stowed");
            v77:SetAttribute("DaggerSkin", u2[1].skin);
            v77.Parent = Folder;
            CollectionService:AddTag(v77, "EmoteVFXRig");
            hideStand(true);
            local Animation2 = Instance.new("Animation");
            Animation2.AnimationId = AnimationConfig.PublishedIds.Idle;
            local success, result = pcall(v79.LoadAnimation, v79, Animation2);
            Animation2:Destroy();

            if success and result then
                result.Looped = true;
                result.Priority = Enum.AnimationPriority.Idle;
                result:Play(0);
            else
                result = nil;
            end;

            u12 = {
                clock = 0,
                item = 0,
                stage = 0,
                elapsed = 0,
                still = 0,
                rig = v77,
                root = HumanoidRootPart,
                humanoid = v78,
                animator = v79,
                idle = result,
                knife = ClientBotKnife.new(v77),
                board = board(Head),
                scale = v80,
                stages = {},
                fired = {}
            };

            return;
        end;
    end;

    local v84;

    if u9 == nil or type(CombineConfig.EndsAt) ~= "number" then
        v84 = false;
    else
        v84 = os.time() >= CombineConfig.EndsAt;
    end;

    hideStand(v84);
end;

local function advance() -- Line: 570
    -- upvalues: u12 (ref), u2 (copy), stagesFor (copy)
    local v85 = u12.stages[u12.stage];

    if v85 and v85.exit then
        v85.exit();
    end;

    local v86 = u12;
    v86.stage = v86.stage + 1;

    if u12.stage > #u12.stages then
        u12.item = u12.item % #u2 + 1;
        u12.stages = stagesFor(u2[u12.item]);
        u12.stage = 1;
    end;

    u12.elapsed = 0;
    table.clear(u12.fired);
    local v87 = u12.stages[u12.stage];

    if v87.enter then
        v87.enter();
    end;
end;

local function rest() -- Line: 591
    -- upvalues: u12 (ref), TackleAnimation (copy)
    if not u12 or u12.stage == 0 then
        return;
    end;

    local v88 = u12.stages[u12.stage];

    if v88 and v88.exit then
        v88.exit();
    end;

    u12.knife:destroy();
    u12.knife:remove();
    TackleAnimation.release(u12.rig);

    for _, v in { "DaggerDrawStartedAt", "ReachPhase", "ReachStartedAt", "TackleActive" } do
        u12.rig:SetAttribute(v, nil);
    end;

    u12.rig:SetAttribute("DaggerState", "Stowed");
    u12.followed = nil;
    u12.followers = nil;
    u12.item = math.max(u12.item - 1, 0);
    u12.stages = {};
    u12.stage = 0;
    u12.elapsed = 0;
    table.clear(u12.fired);
end;

local function permitted() -- Line: 612
    -- upvalues: LocalPlayer (copy), u4 (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        return false;
    end;

    for _, v in u4 do
        if LocalPlayer:GetAttribute(v) == true then
            return false;
        end;
    end;

    return true;
end;

local v98 = RunService.Heartbeat:Connect(function(p89) -- Line: 624
    -- upvalues: u12 (ref), CombineConfig (copy), teardown (copy), hideStand (copy), LocalPlayer (copy), permitted (copy), rest (copy), advance (copy), scaleKnife (copy), KnifeChains (copy), u1 (copy)
    if not u12 then
        return;
    end;

    local v90;

    if type(CombineConfig.EndsAt) == "number" then
        v90 = os.time() >= CombineConfig.EndsAt;
    else
        v90 = false;
    end;

    if v90 then
        teardown();
        hideStand(true);

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v91 = workspace_CurrentCamera and (workspace_CurrentCamera.CFrame.Position - u12.root.Position).Magnitude or (1 / 0);
    local v92 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if v92 then
        v91 = math.min(v91, (v92.Position - u12.root.Position).Magnitude);
    end;

    local v93;

    if v91 <= 40 then
        v93 = permitted();
    else
        v93 = false;
    end;

    u12.audible = v93;

    if v91 > 30 or LocalPlayer:GetAttribute("InMatch") == true then
        local v94 = u12;
        v94.still = v94.still + p89;

        if u12.still >= 5 then
            rest();
        end;

        return;
    end;

    u12.still = 0;
    local math_min_ret = math.min(p89, 0.1);
    local v95 = u12;
    v95.clock = v95.clock + math_min_ret;

    if u12.stage == 0 then
        advance();
    end;

    local v96 = u12;
    v96.elapsed = v96.elapsed + math_min_ret;
    local v97 = u12.stages[u12.stage];

    for i, v in v97.cues or {} do
        if not u12.fired[i] and u12.elapsed >= v[1] then
            u12.fired[i] = true;
            v[2]();

            if not u12 then
                return;
            end;
        end;
    end;

    if u12.elapsed >= v97.seconds then
        advance();
    end;

    if u12.emoting then
        if u12.knife.controller then
            u12.knife.controller:update(u12.clock, false, false, false);
        end;
    else
        u12.knife:update(u12.clock, true);
    end;

    local weapon = u12.knife.weapon;

    if weapon ~= u12.followed then
        u12.followed = weapon;
        scaleKnife(u12.knife);

        if weapon then
            weapon = KnifeChains.followers(weapon, u12.rig);
        end;

        u12.followers = weapon;
    end;

    u1:update();
end);
table.insert(u5, v98);
local v99 = RunService.PreSimulation:Connect(function() -- Line: 684
    -- upvalues: u12 (ref), KnifeChains (copy)
    if u12 and u12.followers then
        KnifeChains.place(u12.followers);
    end;
end);
table.insert(u5, v99);
local u100 = 0;

local function dress(u101) -- Line: 693
    -- upvalues: u100 (ref), CharacterClone (copy), LocalPlayer (copy), Players (copy), u11 (ref), build (copy)
    u100 = u100 + 1;
    local u102 = u100;
    task.spawn(function() -- Line: 696
        -- upvalues: u101 (copy), CharacterClone (ref), u102 (copy), u100 (ref), LocalPlayer (ref), Players (ref), u11 (ref), build (ref)
        local Humanoid = u101:WaitForChild("Humanoid", 8);

        if not Humanoid then
            return;
        end;

        for i = 1, CharacterClone.RETRIES do
            local v103 = os.clock() + 8;

            while u102 == u100 and (not LocalPlayer:HasAppearanceLoaded() and os.clock() < v103) do
                task.wait(0.1);
            end;

            if u102 ~= u100 then
                return;
            end;

            local success, result = pcall(function() -- Line: 709
                -- upvalues: Humanoid (copy), Players (ref)
                local AppliedDescription = Humanoid:GetAppliedDescription();
                local v104 = Players:CreateHumanoidModelFromDescriptionAsync(AppliedDescription, Enum.HumanoidRigType.R6);
                AppliedDescription:Destroy();

                return v104;
            end);

            if u102 ~= u100 then
                if success and result then
                    result:Destroy();
                end;

                return;
            end;

            if success and CharacterClone.dressed(result) then
                if u11 then
                    u11:Destroy();
                end;

                u11 = result;
                build();

                return;
            end;

            if success and result then
                result:Destroy();
            end;

            if i < CharacterClone.RETRIES then
                task.wait(CharacterClone.RETRY_SECONDS);
            end;
        end;
    end);
end;

local function found(p105) -- Line: 740
    -- upvalues: u9 (ref), build (copy)
    if p105.Name == "MergeDisplays" and (p105:IsA("Model") and p105 ~= u9) then
        u9 = p105;
        build();
    end;
end;

local v106 = MapLocator.interactables(10);
local v107 = v106.ChildAdded:Connect(found);
table.insert(u5, v107);
local v109 = v106.ChildRemoved:Connect(function(p108) -- Line: 749
    -- upvalues: u9 (ref), teardown (copy), u10 (copy)
    if p108 == u9 then
        teardown();
        u9 = nil;
        table.clear(u10);
    end;
end);
table.insert(u5, v109);
local MergeDisplays = v106:FindFirstChild("MergeDisplays");

if MergeDisplays and (MergeDisplays.Name == "MergeDisplays" and (MergeDisplays:IsA("Model") and MergeDisplays ~= u9)) then
    u9 = MergeDisplays;
    build();
end;

local v110 = LocalPlayer.CharacterAdded:Connect(dress);
table.insert(u5, v110);

if LocalPlayer.Character then
    local Character = LocalPlayer.Character;
    u100 = u100 + 1;
    local u111 = u100;
    task.spawn(function() -- Line: 696
        -- upvalues: Character (copy), CharacterClone (copy), u111 (copy), u100 (ref), LocalPlayer (copy), Players (copy), u11 (ref), build (copy)
        local Humanoid = Character:WaitForChild("Humanoid", 8);

        if not Humanoid then
            return;
        end;

        for i = 1, CharacterClone.RETRIES do
            local v112 = os.clock() + 8;

            while u111 == u100 and (not LocalPlayer:HasAppearanceLoaded() and os.clock() < v112) do
                task.wait(0.1);
            end;

            if u111 ~= u100 then
                return;
            end;

            local success, result = pcall(function() -- Line: 709
                -- upvalues: Humanoid (copy), Players (ref)
                local AppliedDescription = Humanoid:GetAppliedDescription();
                local v113 = Players:CreateHumanoidModelFromDescriptionAsync(AppliedDescription, Enum.HumanoidRigType.R6);
                AppliedDescription:Destroy();

                return v113;
            end);

            if u111 ~= u100 then
                if success and result then
                    result:Destroy();
                end;

                return;
            end;

            if success and CharacterClone.dressed(result) then
                if u11 then
                    u11:Destroy();
                end;

                u11 = result;
                build();

                return;
            end;

            if success and result then
                result:Destroy();
            end;

            if i < CharacterClone.RETRIES then
                task.wait(CharacterClone.RETRY_SECONDS);
            end;
        end;
    end);
end;

script.Destroying:Connect(function() -- Line: 765
    -- upvalues: u100 (ref), u5 (copy), teardown (copy), hideStand (copy), u11 (ref), u1 (copy), Folder (copy)
    u100 = u100 + 1;

    for _, v in u5 do
        v:Disconnect();
    end;

    teardown();
    hideStand(false);

    if u11 then
        u11:Destroy();
    end;

    u1:destroy();
    Folder:Destroy();
end);