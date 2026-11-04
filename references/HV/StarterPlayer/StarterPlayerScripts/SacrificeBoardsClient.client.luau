 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local CollectionService = game:GetService("CollectionService");
local LazySound = require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound"));
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local PumpkinHuntConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntConfig"));
local VerifiedName = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("VerifiedName"));
local u1 = { {
        id = "rbxassetid://9118749972",
        volume = 0.225,
        from = 25
    }, {
        id = "rbxassetid://9112824733",
        volume = 0.1125,
        from = 10
    }, {
        id = "rbxassetid://9118657619",
        volume = 0.125,
        from = 1
    } };
local u2 = { { "GuiObject", { "BackgroundTransparency" } }, { "TextLabel", { "TextTransparency", "TextStrokeTransparency" } }, { "TextButton", { "TextTransparency", "TextStrokeTransparency" } }, { "ImageLabel", { "ImageTransparency" } }, { "ImageButton", { "ImageTransparency" } }, { "ScrollingFrame", { "ScrollBarImageTransparency" } }, { "UIStroke", { "Transparency" } } };
local Color3_fromRGB_ret = Color3.fromRGB(164, 150, 134);
local u3 = { Color3.fromRGB(88, 88, 88), Color3.fromRGB(85, 85, 85), Color3.fromRGB(71, 71, 71) };
local u4 = nil;
local u5 = {
    status = "loading",
    live = false,
    entries = {}
};
local u6 = nil;
local u7 = {};
local u8 = nil;
local u9 = nil;
local u10 = {};
local u11 = true;

local function flat(p12) -- Line: 89
    return Vector3.new(p12.X, 0, p12.Z);
end;

local function numberText(p13) -- Line: 93
    if p13 >= 1000000000 then
        return ("%.1fB"):format(p13 / 1000000000);
    end;

    if p13 >= 1000000 then
        return ("%.1fM"):format(p13 / 1000000);
    end;

    if p13 >= 10000 then
        return ("%.1fK"):format(p13 / 1000);
    end;

    local math_floor_ret = math.floor(p13);

    return tostring(math_floor_ret);
end;

local function statusText(p14) -- Line: 106
    -- upvalues: u5 (ref)
    local status = u5.status;

    return status == "studio" and "STUDIO PREVIEW · THIS SERVER" or (status == "retrying" and (#p14 > 0 and "GLOBAL · UPDATE DELAYED" or "GLOBAL · TEMPORARILY UNAVAILABLE") or (status == "loading" and "GLOBAL · LOADING..." or (#p14 == 0 and "GLOBAL · NO SACRIFICES YET" or "GLOBAL · ALL TIME · TOP " .. 50)));
end;

local function paint(u15) -- Line: 115
    -- upvalues: u5 (ref), VerifiedName (copy), u7 (copy), Players (copy), u11 (ref)
    local MainFrame = u15.gui.MainFrame;
    local v16 = type(u5.entries) ~= "table" and {} or u5.entries;
    MainFrame.Title.Text = "MOST SACRIFICED";
    local status = u5.status;
    local v17;

    if status == "studio" then
        v17 = "STUDIO PREVIEW · THIS SERVER";
    elseif status == "retrying" then
        v17 = #v16 > 0 and "GLOBAL · UPDATE DELAYED" or "GLOBAL · TEMPORARILY UNAVAILABLE";
    else
        v17 = status == "loading" and "GLOBAL · LOADING..." or (#v16 == 0 and "GLOBAL · NO SACRIFICES YET" or "GLOBAL · ALL TIME · TOP " .. 50);
    end;

    MainFrame.Status.Text = v17;
    u15.generation = u15.generation + 1;
    local generation = u15.generation;

    for _, v in u15.rows do
        v:Destroy();
    end;

    table.clear(u15.rows);

    for i, v in v16 do
        if type(v) == "table" and (type(v.value) == "number" and type(v.userId) == "number") then
            local u18 = u15.template:Clone();
            u18.Name = "Rank_" .. i;
            u18.Visible = true;
            u18.LayoutOrder = i;
            local Frame = u18.Frame;
            Frame.Username.RichText = true;
            Frame.Username.Text = ("#%d  %s"):format(i, VerifiedName.format(v.name, v.verified, v.userId));
            local Stat = Frame.Stat;
            local value = v.value;
            local v19;

            if value >= 1000000000 then
                v19 = ("%.1fB"):format(value / 1000000000);
            elseif value >= 1000000 then
                v19 = ("%.1fM"):format(value / 1000000);
            elseif value >= 10000 then
                v19 = ("%.1fK"):format(value / 1000);
            else
                local math_floor_ret = math.floor(value);
                v19 = tostring(math_floor_ret);
            end;

            Stat.Text = v19 .. " COINS";
            Frame.PFP.Image = u7[v.userId] or "";
            u18.Parent = MainFrame.ScrollingFrame;
            table.insert(u15.rows, u18);

            if not u7[v.userId] and v.userId > 0 then
                task.spawn(function() -- Line: 142
                    -- upvalues: Players (ref), v (copy), u7 (ref), u11 (ref), u15 (copy), generation (copy), u18 (copy), Frame (copy)
                    local v20, v21, v22 = pcall(Players.GetUserThumbnailAsync, Players, v.userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);

                    if v20 and v22 then
                        u7[v.userId] = v21;

                        if u11 and (u15.generation == generation and u18.Parent) then
                            Frame.PFP.Image = v21;
                        end;
                    end;
                end);
            end;
        end;
    end;
end;

local function paintAll() -- Line: 161
    -- upvalues: u8 (ref), paint (copy)
    if u8 then
        for _, v in u8.boards do
            paint(v);
        end;
    end;
end;

local function read() -- Line: 169
    -- upvalues: HttpService (copy), u4 (ref), u5 (ref), u6 (ref), u8 (ref), paint (copy)
    local success, result = pcall(HttpService.JSONDecode, HttpService, u4.Value);

    if not success or type(result) ~= "table" then
        return;
    end;

    u5 = result;
    local v23 = HttpService:JSONEncode({ result.status, result.entries });

    if v23 ~= u6 then
        u6 = v23;

        if u8 then
            for _, v in u8.boards do
                paint(v);
            end;
        end;
    end;
end;

local function worldFolder() -- Line: 185
    -- upvalues: u9 (ref)
    if not u9 or u9.Parent ~= workspace then
        u9 = Instance.new("Folder");
        u9.Name = "SacrificeBoards";
        u9.Parent = workspace;
    end;

    return u9;
end;

local function makeBoard(p24, p25) -- Line: 195
    -- upvalues: Color3_fromRGB_ret (copy)
    local v26 = p24:Clone();
    v26.Name = p25 < 0 and "SacrificeBoardLeft" or "SacrificeBoardRight";
    v26.Anchored = true;
    v26.CanCollide = false;
    v26.CanTouch = false;
    local Transparency = v26.Transparency;
    local v27 = v26:FindFirstChildOfClass("SurfaceGui");
    local v28 = v27:Clone();
    v27:Destroy();
    v28.Name = "SacrificeBoard_" .. (p25 < 0 and "Left" or "Right");
    v28.Adornee = v26;
    v28.ResetOnSpawn = false;
    v28.Enabled = false;
    local SlotFrame = v28.MainFrame.ScrollingFrame.SlotFrame;
    SlotFrame.Visible = false;
    local Part = Instance.new("Part");
    Part.Name = v26.Name .. "Dust";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    local X = v26.Size.X;
    local math_max_ret = math.max(1.2, v26.Size.Z * 2);
    Part.Size = Vector3.new(X, 0.2, math_max_ret);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Dust";
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret);
    ParticleEmitter.LightInfluence = 1;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Box;
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume;
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top;
    ParticleEmitter.Lifetime = NumberRange.new(0.9, 1.5);
    ParticleEmitter.Speed = NumberRange.new(2, 5);
    ParticleEmitter.SpreadAngle = Vector2.new(45, 45);
    ParticleEmitter.Drag = 2;
    ParticleEmitter.Acceleration = Vector3.new(0, 1, 0);
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-40, 40);
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 3.2) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Parent = Part;

    return {
        generation = 0,
        hover = 0,
        side = p25,
        part = v26,
        shown = Transparency,
        gui = v28,
        template = SlotFrame,
        rows = {},
        base = Part,
        dust = ParticleEmitter,
        seed = Random.new():NextNumber(0, 1000)
    };
end;

local function layout(p29) -- Line: 262
    local model = p29.model;
    local bowl = p29.bowl;
    local BoundingBox, v30 = model:GetBoundingBox();
    local v31 = BoundingBox.Position.Y - v30.Y / 2;
    local LookVector = bowl.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

    if Vector3_new_ret.Magnitude < 0.1 then
        local LookVector2 = model:GetPivot().LookVector;
        Vector3_new_ret = Vector3.new(LookVector2.X, 0, LookVector2.Z);
    end;

    local v32 = Vector3_new_ret.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or Vector3_new_ret.Unit;
    local Unit = (-v32):Cross(Vector3.new(0, 1, 0)).Unit;
    local Position = bowl.Position;
    local Vector3_new_ret2 = Vector3.new(Position.X, 0, Position.Z);

    for _, v in p29.boards do
        local Y = v.part.Size.Y;
        local v33 = model:FindFirstChild(v.side < 0 and "SacrificeBoardLeft" or "SacrificeBoardRight", true);
        local v34;

        if v33 and v33:IsA("Attachment") then
            v34 = v33.WorldPosition;
        else
            local v35 = Vector3_new_ret2 + Unit * (10 * v.side) - v32 * 0;
            v34 = Vector3.new(v35.X, v31 + 1.25 + Y / 2, v35.Z);
        end;

        v.up = v34;
        v.depth = v34.Y - v31 + Y / 2 + 0.5;
        v.floor = Vector3.new(v34.X, v31 + 0.1, v34.Z);
        v.base.CFrame = CFrame.lookAt(v.floor, v.floor + v32);
    end;
end;

local function fadeBoard(p36, p37, p38) -- Line: 292
    -- upvalues: u2 (copy)
    p37.part.Transparency = p37.shown + (1 - p37.shown) * p38;
    p37.gui.Enabled = p38 < 1;

    for _, descendant in p37.gui:GetDescendants() do
        if descendant ~= p37.template and not descendant:IsDescendantOf(p37.template) then
            local v39 = p36.bases[descendant];
            local v40;

            if v39 then
                v40 = descendant;
            else
                v40 = descendant;
                v39 = {};

                for _, v in u2 do
                    if v40:IsA(v[1]) then
                        for _, v2 in v[2] do
                            v39[v2] = v40[v2];
                        end;
                    end;
                end;

                p36.bases[v40] = v39;
            end;

            for i, v in v39 do
                v40[i] = v + (1 - v) * p38;
            end;
        end;
    end;
end;

local function setVisible(p41, p42) -- Line: 318
    -- upvalues: fadeBoard (copy)
    local v43 = not p42 and -1 or p41.fade;

    if p41.shownKey == v43 then
        return;
    end;

    p41.shownKey = v43;

    for _, v in p41.boards do
        if p42 then
            fadeBoard(p41, v, p41.fade);
        else
            v.part.Transparency = 1;
            v.gui.Enabled = false;
        end;
    end;
end;

local function makeRumble(p44) -- Line: 336
    -- upvalues: u1 (copy), LazySound (copy)
    local Part = Instance.new("Part");
    Part.Name = "SacrificeBoardsRumble";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p44.bowl.Position);
    local v45 = {};

    for i, v in u1 do
        local Sound = Instance.new("Sound");
        Sound.Name = "Rumble" .. i;
        Sound:SetAttribute(LazySound.Attribute, v.id);
        Sound.Volume = 0;
        Sound.RollOffMinDistance = 30;
        Sound.RollOffMaxDistance = 150;
        Sound.Parent = Part;
        v45[i] = Sound;
    end;

    p44.rumbleSource = Part;
    p44.sounds = v45;
    p44.tweens = {};
    p44.rumbles = 0;
end;

local function setup(p46) -- Line: 361
    -- upvalues: u8 (ref), ChickenOrHero (copy), makeBoard (copy), layout (copy), makeRumble (copy), u9 (ref), PlayerGui (copy), paint (copy)
    if u8 and u8.model == p46 then
        return;
    end;

    if not p46:IsDescendantOf(workspace) then
        return;
    end;

    local Bowl = p46:FindFirstChild("Bowl", true);

    if not (Bowl and Bowl:IsA("BasePart")) then
        return;
    end;

    local SacrificeBoard = ChickenOrHero.Presentation:FindFirstChild("SacrificeBoard");

    if not (SacrificeBoard and (SacrificeBoard:IsA("BasePart") and SacrificeBoard:FindFirstChildOfClass("SurfaceGui"))) then
        warn("SacrificeBoardsClient: Presentation.SacrificeBoard (the board template) is missing, so no boards");

        return;
    end;

    local v47 = {
        state = "down",
        progress = 0,
        shownKey = nil,
        fade = 0,
        restore = false,
        nextDust = 0,
        broke = false,
        model = p46,
        bowl = Bowl,
        boards = { makeBoard(SacrificeBoard, -1), (makeBoard(SacrificeBoard, 1)) },
        bases = setmetatable({}, {
            __mode = "k"
        })
    };
    layout(v47);
    makeRumble(v47);

    if not u9 or u9.Parent ~= workspace then
        u9 = Instance.new("Folder");
        u9.Name = "SacrificeBoards";
        u9.Parent = workspace;
    end;

    local v48 = u9;
    v47.rumbleSource.Parent = v48;

    for _, v in v47.boards do
        v.part.CFrame = CFrame.new(v.up - Vector3.new(0, 1, 0) * v.depth);
        v.part.Parent = v48;
        v.base.Parent = v48;
        v.gui.Parent = PlayerGui;
    end;

    if v47.shownKey ~= -1 then
        v47.shownKey = -1;

        for _, v in v47.boards do
            v.part.Transparency = 1;
            v.gui.Enabled = false;
        end;
    end;

    u8 = v47;

    if u8 then
        for _, v in u8.boards do
            paint(v);
        end;
    end;
end;

local function teardown(p49) -- Line: 405
    -- upvalues: u8 (ref)
    if not (u8 and (not p49 or u8.model == p49)) then
        return;
    end;

    for _, v in u8.boards do
        v.gui:Destroy();
        v.part:Destroy();
        v.base:Destroy();
    end;

    for _, v in u8.tweens do
        v:Cancel();
    end;

    u8.rumbleSource:Destroy();
    u8 = nil;
end;

local function chunk(p50) -- Line: 424
    -- upvalues: u10 (copy), u3 (copy), u9 (ref)
    if #u10 >= 40 then
        return;
    end;

    local Random_new_ret = Random.new();
    local Part = Instance.new("Part");
    Part.Name = "Rubble";
    local v51 = Random_new_ret:NextNumber(0.25, 0.6);
    local v52 = v51 * Random_new_ret:NextNumber(0.6, 1);
    Part.Size = Vector3.new(v51, v52, v51);
    Part.Material = Enum.Material.Slate;
    Part.Color = u3[Random_new_ret:NextInteger(1, #u3)];
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    local X = p50.part.Size.X;
    local v53 = p50.base.CFrame.RightVector * Random_new_ret:NextNumber(-X / 2, X / 2);
    local v54 = p50.base.CFrame.LookVector * Random_new_ret:NextNumber(-0.6, 0.6);
    local v55 = p50.floor + v53 + v54;
    Part.CFrame = CFrame.new(v55) * CFrame.Angles(Random_new_ret:NextNumber(0, 6.28), Random_new_ret:NextNumber(0, 6.28), 0);

    if not u9 or u9.Parent ~= workspace then
        u9 = Instance.new("Folder");
        u9.Name = "SacrificeBoards";
        u9.Parent = workspace;
    end;

    Part.Parent = u9;
    local v56 = {
        angle = Vector3.new(0, 0, 0),
        age = 0,
        part = Part,
        position = v55,
        velocity = (v53.Magnitude > 0.01 and v53.Unit or p50.base.CFrame.RightVector) * Random_new_ret:NextNumber(1, 5) + p50.base.CFrame.LookVector * Random_new_ret:NextNumber(-4, 4) + Vector3.new(0, 1, 0) * Random_new_ret:NextNumber(10, 18)
    };
    local v57 = Random_new_ret:NextNumber(-8, 8);
    local v58 = Random_new_ret:NextNumber(-8, 8);
    v56.spin = Vector3.new(v57, v58, Random_new_ret:NextNumber(-8, 8));
    v56.life = Random_new_ret:NextNumber(0.7, 1.1);
    table.insert(u10, v56);
end;

local function burst(p59, p60, p61) -- Line: 459
    -- upvalues: chunk (copy)
    for _, v in p59.boards do
        v.dust:Emit(p61);
        local v62 = v;

        for i = 1, p60 do
            chunk(v62);
            local _ = i;
        end;
    end;
end;

local function quiet(p63) -- Line: 468
    for _, v in p63.tweens do
        v:Cancel();
    end;

    table.clear(p63.tweens);
end;

local function rumble(p64, p65) -- Line: 475
    -- upvalues: u1 (copy), LazySound (copy)
    for _, v in p64.tweens do
        v:Cancel();
    end;

    table.clear(p64.tweens);
    p64.rumbles = p64.rumbles + 1;

    for i, v in u1 do
        local v66 = LazySound.arm(p64.sounds[i]);
        v66.Volume = v.volume * p65;
        v66.TimePosition = v.from;
        v66:Play();
    end;
end;

local function settle(u67, p68) -- Line: 487
    -- upvalues: TweenService (copy)
    for _, v in u67.tweens do
        v:Cancel();
    end;

    table.clear(u67.tweens);
    local rumbles = u67.rumbles;

    for _, v in u67.sounds do
        if v.IsPlaying then
            local v69 = TweenService:Create(v, TweenInfo.new(p68, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Volume = 0
            });
            v69.Completed:Once(function(p70) -- Line: 499
                -- upvalues: u67 (copy), rumbles (copy), v (copy)
                if p70 == Enum.PlaybackState.Completed and u67.rumbles == rumbles then
                    v:Stop();
                end;
            end);
            table.insert(u67.tweens, v69);
            v69:Play();
        end;
    end;
end;

local function blocked(p71) -- Line: 510
    -- upvalues: u5 (ref), LocalPlayer (copy)
    return u5.live ~= true and true or (LocalPlayer:GetAttribute("InMatch") == true and true or not p71.bowl:IsDescendantOf(workspace));
end;

local function altarOpen() -- Line: 517
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("PumpkinSacrificeOpen") == true;
end;

local u72 = os.clock() + 15;
LocalPlayer.CharacterAdded:Connect(function() -- Line: 525
    -- upvalues: u72 (ref)
    u72 = os.clock() + 15;
end);

local function distance(p73) -- Line: 529
    -- upvalues: u72 (ref), LocalPlayer (copy)
    if os.clock() < u72 then
        return (1 / 0);
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not (Character and Character:IsA("BasePart")) then
        return (1 / 0);
    end;

    local Position = Character.Position;
    local Vector3_new_ret = Vector3.new(Position.X, 0, Position.Z);
    local Position2 = p73.bowl.Position;

    return (Vector3_new_ret - Vector3.new(Position2.X, 0, Position2.Z)).Magnitude;
end;

local function lift(p74) -- Line: 544
    return 1 - (1 - math.clamp((p74 - 0.14285714285714285) / 0.8571428571428572, 0, 1)) ^ 2.4;
end;

local function step(p75, p76) -- Line: 549
    -- upvalues: u5 (ref), LocalPlayer (copy), settle (copy), distance (copy), layout (copy), burst (copy), rumble (copy), fadeBoard (copy)
    if (u5.live ~= true or LocalPlayer:GetAttribute("InMatch") == true) and true or not p75.bowl:IsDescendantOf(workspace) then
        if p75.state ~= "down" then
            p75.restore = p75.state == "up" and true or p75.state == "rising";
            p75.state = "down";
            p75.progress = 0;
            settle(p75, 0.4);
        end;

        p75.fade = 0;

        if p75.shownKey == -1 then
            return;
        end;

        p75.shownKey = -1;

        for _, v in p75.boards do
            v.part.Transparency = 1;
            v.gui.Enabled = false;
        end;

        return;
    end;

    if LocalPlayer:GetAttribute("PumpkinSacrificeOpen") == true then
        p75.fade = math.min(1, p75.fade + p76 / 0.35);
    else
        p75.fade = math.max(0, p75.fade - p76 / 0.5);
    end;

    local v77 = distance(p75) <= ((p75.state == "up" and true or p75.state == "rising") and 32 or 22);

    if p75.restore then
        p75.restore = false;

        if v77 then
            p75.state = "up";
            p75.progress = 1;

            for _, v in p75.boards do
                v.hover = 1;
                v.facing = nil;
            end;
        end;
    end;

    if v77 and (p75.state == "down" or p75.state == "sinking") then
        if p75.state == "down" then
            layout(p75);

            for _, v in p75.boards do
                v.hover = 0;
                v.facing = nil;
            end;

            p75.broke = false;
            p75.fading = false;
            burst(p75, 2, 6);
            rumble(p75, 1);
        end;

        p75.state = "rising";
    elseif not (v77 or p75.state ~= "up" and p75.state ~= "rising") then
        p75.state = "sinking";
        burst(p75, 3, 8);
        rumble(p75, 0.6);
        p75.fading = false;
    end;

    if p75.state == "rising" then
        p75.progress = math.min(1, p75.progress + p76 / 1.75);

        if not p75.broke and p75.progress >= 0.14285714285714285 then
            p75.broke = true;
            burst(p75, 6, 12);
        end;

        if not p75.fading and p75.progress >= 0.6571428571428573 then
            p75.fading = true;
            settle(p75, 1.6);
        end;

        if p75.progress >= 1 then
            p75.state = "up";
        end;
    elseif p75.state == "sinking" then
        p75.progress = math.max(0, p75.progress - p76 / 0.8);

        if p75.progress <= 0 then
            p75.state = "down";
            settle(p75, 1.6);
        end;
    end;

    if p75.state == "down" then
        if p75.shownKey == -1 then
            return;
        end;

        p75.shownKey = -1;

        for _, v in p75.boards do
            v.part.Transparency = 1;
            v.gui.Enabled = false;
        end;

        return;
    end;

    local fade = p75.fade;

    if p75.shownKey ~= fade then
        p75.shownKey = fade;

        for _, v in p75.boards do
            fadeBoard(p75, v, p75.fade);
        end;
    end;

    local v78 = p75.state == "rising" and true or p75.state == "sinking";
    local os_clock_ret = os.clock();

    if v78 and p75.nextDust <= os_clock_ret then
        p75.nextDust = os_clock_ret + 0.08;
        burst(p75, p75.progress < 0.8 and 1 or 0, 2);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
    end;

    local v79 = 1 - (1 - math.clamp((p75.progress - 0.14285714285714285) / 0.8571428571428572, 0, 1)) ^ 2.4;
    local ServerTimeNow = workspace:GetServerTimeNow();

    for _, v in p75.boards do
        local v80 = not v78 and 0 or math.clamp((1 - v79) * 1.6, 0.25, 1) * 0.22;

        if p75.state == "up" then
            v.hover = math.min(1, v.hover + p76 / 0.6);
        end;

        local v81 = math.sin(ServerTimeNow * 2 * 3.141592653589793 / 4.5) * 0.22 * v.hover;
        local v82 = v.up - Vector3.new(0, 1, 0) * (v.depth * (1 - v79)) + Vector3.new(0, 1, 0) * v81;

        if workspace_CurrentCamera and (Vector3.new(workspace_CurrentCamera.X, 0, workspace_CurrentCamera.Z) - Vector3.new(v82.X, 0, v82.Z)).Magnitude > 0.1 then
            local v83 = workspace_CurrentCamera - v82;
            local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(v83.X, 0, v83.Z)));

            if v.facing then
                CFrame_lookAt_ret = v.facing:Lerp(CFrame_lookAt_ret, 1 - math.exp(-4 * p76));
            end;

            v.facing = CFrame_lookAt_ret;
        end;

        local v84 = v.facing or CFrame.identity;
        local v85 = CFrame.new(v82) * v84;

        if v80 > 0 then
            local v86 = os_clock_ret * 9;
            local seed = v.seed;
            local v87 = v85.RightVector * math.noise(v86, seed, 0) * v80 * 2 + v85.LookVector * math.noise(v86, seed, 7) * v80;
            local v88 = v80 * 0.027925268031909273 / 0.22;
            v85 = CFrame.new(v87) * v85 * CFrame.Angles(math.noise(v86, seed, 13) * v88, 0, math.noise(v86, seed, 19) * v88 * 1.5);
        end;

        v.part.CFrame = v85;
    end;
end;

local function stepChunks(p89) -- Line: 661
    -- upvalues: u10 (copy)
    for i = #u10, 1, -1 do
        local v90 = u10[i];
        v90.age = v90.age + p89;
        local v91;

        if v90.age >= v90.life or not v90.part.Parent then
            v90.part:Destroy();
            table.remove(u10, i);
            v91 = i;
        else
            v90.velocity = v90.velocity - Vector3.new(0, 60, 0) * p89;
            v90.position = v90.position + v90.velocity * p89;
            v90.angle = v90.angle + v90.spin * p89;
            v90.part.CFrame = CFrame.new(v90.position) * CFrame.Angles(v90.angle.X, v90.angle.Y, v90.angle.Z);
            local math_clamp_ret = math.clamp((v90.age / v90.life - 0.6) / 0.4, 0, 1);
            v90.part.Transparency = math_clamp_ret;
            v91 = i;
        end;
    end;
end;

local u93 = RunService.RenderStepped:Connect(function(p92) -- Line: 679
    -- upvalues: u8 (ref), step (copy), teardown (copy), u10 (copy), stepChunks (copy)
    if u8 then
        local success, result = pcall(step, u8, p92);

        if not success then
            warn("SacrificeBoardsClient: " .. tostring(result));
            teardown();
        end;
    end;

    if #u10 > 0 then
        stepChunks(p92);
    end;
end);
script.Destroying:Connect(function() -- Line: 692
    -- upvalues: u11 (ref), u93 (copy), teardown (copy), u10 (copy)
    u11 = false;
    u93:Disconnect();
    teardown();

    for _, v in u10 do
        v.part:Destroy();
    end;

    table.clear(u10);
end);
CollectionService:GetInstanceRemovedSignal(PumpkinHuntConfig.Tag):Connect(teardown);

while true do
    if not u11 then
        return;
    end;

    if not u4 then
        local SacrificeBoard = ChickenOrHero.Game:FindFirstChild("SacrificeBoard");

        if SacrificeBoard and SacrificeBoard:IsA("StringValue") then
            u4 = SacrificeBoard;
            u4.Changed:Connect(read);
            read();
        end;
    end;

    if u8 and not u8.model:IsDescendantOf(workspace) then
        teardown();
    end;

    if not (u8 or (not u4 or u5.live ~= true)) then
        for _, v in CollectionService:GetTagged(PumpkinHuntConfig.Tag) do
            if v:IsDescendantOf(workspace) then
                setup(v);
                break;
            end;
        end;
    end;

    task.wait(1);
end;