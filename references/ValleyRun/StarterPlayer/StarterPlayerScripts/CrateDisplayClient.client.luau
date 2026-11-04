 

 

local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local ComingSoon = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Emotes"):WaitForChild("EmoteCatalog")).ComingSoon;
local u1 = {};
local u2 = {
    EmberCrate = Color3.fromRGB(255, 155, 67),
    CelestialCrate = Color3.fromRGB(164, 119, 255),
    BasicCrate = Color3.fromRGB(150, 205, 120),
    PremiumCrate = Color3.fromRGB(242, 191, 89),
    EmoteCrate = Color3.fromRGB(255, 120, 200),
    FreeReward = Color3.fromRGB(123, 232, 184),
    ShopModel = Color3.fromRGB(245, 202, 116)
};
local u3 = {
    FreeReward = "Model",
    ShopModel = "Shop",
    EmoteCrate = "Dance Treasure Crate",
    BasicCrate = "Crate",
    PremiumCrate = "Crate"
};
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local CrateCatalog = require(ChickenOrHero:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
local SkinCatalog = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("SkinCatalog"));
local Models = ChickenOrHero.Weapons:WaitForChild("Models");
local u4 = {
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local u5 = { {
        size = 7,
        spin = 70,
        fade = 0.35
    }, {
        size = 5,
        spin = -45,
        fade = 0.5
    } };
local CharacterClone = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("CharacterClone"));
local EmotePlayback = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmotePlayback"));
local Folder = Instance.new("Folder");
Folder.Name = "LocalCrateKnives";
Folder.Parent = workspace;

local function prizes(p6) -- Line: 47
    -- upvalues: CrateCatalog (copy), SkinCatalog (copy), Models (copy)
    local v7 = CrateCatalog.Crates[string.gsub(p6, "Crate$", "")];
    local v8 = {};

    for _, v in v7 and v7.Entries or {} do
        local v9;

        if type(v.Skin) == "string" then
            v9 = SkinCatalog.get(v.Skin);
        else
            v9 = false;
        end;

        if (v.Rarity == "Epic" or (v.Rarity == "Legendary" or v.Rarity == "Mythical")) and (v9 and Models:FindFirstChild(v9.Model)) then
            table.insert(v8, v.Skin);
        end;
    end;

    return #v8 > 0 and v8 and v8 or nil;
end;

local CFrame_Angles_ret = CFrame.Angles(-0.4363323129985824, -0.20943951023931956, -0.5585053606381855);
local u10 = { "LuaSourceContainer", "JointInstance", "WeldConstraint", "Sound", "ParticleEmitter", "Beam", "Trail", "Light", "Fire", "Smoke", "Sparkles" };

local function knifeCopy(p11) -- Line: 62
    -- upvalues: Models (copy), SkinCatalog (copy), u10 (copy), CFrame_Angles_ret (copy), Folder (copy), u4 (copy), u5 (copy)
    local v12 = Models:FindFirstChild(SkinCatalog.get(p11).Model);
    local v13;

    if v12 then
        v13 = v12:FindFirstChild("Blade") or v12:FindFirstChildWhichIsA("MeshPart", true);
    else
        v13 = v12;
    end;

    if not v13 then
        return nil;
    end;

    local v14 = v13:Clone();
    local v15 = {};

    for _, descendant in v14:GetDescendants() do
        local v16 = descendant;
        local v17 = false;

        for _, v in u10 do
            if v16:IsA(v) then
                v17 = true;
                break;
            end;
        end;

        if v17 then
            v16:Destroy();
        elseif v16:IsA("BasePart") then
            if v16.Transparency >= 1 then
                v16:Destroy();
            else
                v15[v16] = v14.CFrame:ToObjectSpace(v16.CFrame);
            end;
        end;
    end;

    local Model = Instance.new("Model");
    Model.Name = "CrateKnife";
    v14.Transparency = 0;
    v14.CFrame = v12:GetAttribute("PreviewRotation") or CFrame_Angles_ret;
    v14.Parent = Model;

    for i, v in v15 do
        if i.Parent then
            i.CFrame = v14.CFrame * v;
        end;
    end;

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CastShadow = false;
        end;
    end;

    local _, v18 = Model:GetBoundingBox();
    local math_max_ret = math.max(v18.X, v18.Y, v18.Z);

    if math_max_ret > 0 then
        local ScaleTo = Model.ScaleTo;
        local v19 = Model:GetScale() * 3.2 / math_max_ret;
        pcall(ScaleTo, Model, v19);
    end;

    local BoundingBox, v20 = Model:GetBoundingBox();
    local v21 = v20.X >= v20.Y and v20.X >= v20.Z and CFrame.Angles(0, 0, 1.2217304763960306) or (v20.Z > v20.Y and CFrame.Angles(-1.2217304763960306, 0, 0) or CFrame.Angles(0, 0, -0.3490658503988659));
    Model.Parent = Folder;
    local Part = Instance.new("Part");
    Part.Name = "CrateKnifeRays";
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    local v22 = u4[SkinCatalog.get(p11).Rarity] or u4.Legendary;
    local v23 = {};

    for i, v in u5 do
        local ParticleEmitter = Instance.new("ParticleEmitter");
        ParticleEmitter.Texture = "rbxassetid://129028976496842";
        ParticleEmitter.Color = ColorSequence.new(v22);
        ParticleEmitter.LightEmission = 0.7;
        ParticleEmitter.Orientation = Enum.ParticleOrientation.FacingCamera;
        ParticleEmitter.LockedToPart = true;
        ParticleEmitter.Speed = NumberRange.new(0);
        ParticleEmitter.Rotation = NumberRange.new(0, 360);
        ParticleEmitter.RotSpeed = NumberRange.new(v.spin);
        ParticleEmitter.Lifetime = NumberRange.new(2);
        ParticleEmitter.Rate = 1.5;
        ParticleEmitter.ZOffset = -2 - i * 0.1;
        ParticleEmitter.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.25, v.fade),
            NumberSequenceKeypoint.new(0.75, v.fade),
            NumberSequenceKeypoint.new(1, 1)
        });
        ParticleEmitter.Parent = Part;
        v23[i] = ParticleEmitter;
    end;

    Part.Parent = Folder;

    return {
        grown = 1,
        model = Model,
        offset = v21 * BoundingBox:ToObjectSpace(Model:GetPivot()),
        scale = Model:GetScale(),
        glow = Part,
        rays = v23
    };
end;

local function dropKnife(p24) -- Line: 164
    if p24.knife then
        p24.knife.model:Destroy();
        p24.knife.glow:Destroy();
        p24.knife = nil;
    end;
end;

local function hideDancer(p25) -- Line: 235
    -- upvalues: EmotePlayback (copy)
    local dancer = p25.dancer;

    if dancer and dancer.track then
        EmotePlayback.dispose(dancer.track);
        dancer.track = nil;
    end;

    if dancer then
        dancer.model.Parent = nil;
    end;

    p25.dancing = false;
end;

local function dropDancer(p26) -- Line: 246
    -- upvalues: EmotePlayback (copy)
    local dancer = p26.dancer;

    if dancer and dancer.track then
        EmotePlayback.dispose(dancer.track);
        dancer.track = nil;
    end;

    if dancer then
        dancer.model.Parent = nil;
    end;

    p26.dancing = false;

    if p26.dancer then
        p26.dancer.model:Destroy();
        p26.dancer = nil;
    end;
end;

local function dancerFor(p27) -- Line: 255
    -- upvalues: LocalPlayer (copy), EmotePlayback (copy), CharacterClone (copy)
    local Character = LocalPlayer.Character;

    if p27.dancer and p27.dancer.source == Character then
        return p27.dancer;
    end;

    local dancer = p27.dancer;

    if dancer and dancer.track then
        EmotePlayback.dispose(dancer.track);
        dancer.track = nil;
    end;

    if dancer then
        dancer.model.Parent = nil;
    end;

    p27.dancing = false;

    if p27.dancer then
        p27.dancer.model:Destroy();
        p27.dancer = nil;
    end;

    local v28, v29, v30 = CharacterClone.copy(Character);

    if not v28 then
        return nil;
    end;

    if not CharacterClone.dressed(v28) then
        v28:Destroy();

        return nil;
    end;

    local EquippedDagger = v28:FindFirstChild("EquippedDagger");

    if EquippedDagger then
        EquippedDagger:Destroy();
    end;

    v28.Name = "CrateDancer";
    local ScaleTo = v28.ScaleTo;
    local v31 = v28:GetScale() * 0.42;
    pcall(ScaleTo, v28, v31);
    local BoundingBox, v32 = v28:GetBoundingBox();
    p27.dancer = {
        grown = 1,
        model = v28,
        animator = v29:FindFirstChildOfClass("Animator"),
        source = Character,
        scale = v28:GetScale(),
        lift = v30.Position.Y - (BoundingBox.Position.Y - v32.Y / 2),
        height = v32.Y
    };

    return p27.dancer;
end;

local function restore(p33) -- Line: 347
    -- upvalues: EmotePlayback (copy)
    if p33.knife then
        p33.knife.model:Destroy();
        p33.knife.glow:Destroy();
        p33.knife = nil;
    end;

    p33.knifeTried = false;
    local dancer = p33.dancer;

    if dancer and dancer.track then
        EmotePlayback.dispose(dancer.track);
        dancer.track = nil;
    end;

    if dancer then
        dancer.model.Parent = nil;
    end;

    p33.dancing = false;
    p33.dancerTried = false;

    if p33.model.Parent then
        p33.model:PivotTo(p33.base);
    end;

    if p33.lid and (p33.lid.Parent and p33.body.Parent) then
        p33.lid.CFrame = p33.body.CFrame * p33.hingeOffset * p33.closedOffset;
    end;
end;

local function endsText(p34) -- Line: 376
    if p34 >= 86400 then
        return string.format("Leaves in %dd %dh", p34 // 86400, p34 % 86400 // 3600);
    end;

    if p34 >= 3600 then
        return string.format("Leaves in %dh %dm", p34 // 3600, p34 % 3600 // 60);
    end;

    return string.format("Leaves in %dm %ds", p34 // 60, p34 % 60);
end;

local Color3_new_ret = Color3.new(1, 1, 1);

local function frame(p35, p36, p37) -- Line: 385
    local Frame = Instance.new("Frame");
    Frame.Name = p36;
    Frame.BorderSizePixel = 0;

    for i, v in p37 do
        Frame[i] = v;
    end;

    Frame.Parent = p35;

    return Frame;
end;

local function round(p38, p39) -- Line: 395
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(p39 or 1, 0);
    UICorner.Parent = p38;
end;

local function leavingTimer(p40, p41) -- Line: 400
    -- upvalues: Color3_new_ret (copy), endsText (copy)
    local Sign = p40:FindFirstChild("Sign");
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "LeavingTimer";
    BillboardGui.Size = UDim2.fromScale(6.4, 1.25);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(-8, 0, 0);
    BillboardGui.MaxDistance = Sign and (Sign:IsA("BillboardGui") and Sign.MaxDistance) or 75;
    BillboardGui.LightInfluence = 0;
    local v42 = {
        BackgroundTransparency = 0.3,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(18, 20, 26)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Pill";
    Frame.BorderSizePixel = 0;

    for i, v in v42 do
        Frame[i] = v;
    end;

    Frame.Parent = BillboardGui;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;
    local v43 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.055, 0.5),
        Size = UDim2.fromScale(0.62, 0.62),
        SizeConstraint = Enum.SizeConstraint.RelativeYY
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Clock";
    Frame2.BorderSizePixel = 0;

    for i, v in v43 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(1, 0);
    UICorner2.Parent = Frame2;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_new_ret;
    UIStroke.Thickness = 2;
    UIStroke.Parent = Frame2;
    local v44 = {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 0.54),
        Size = UDim2.fromScale(0.13, 0.36),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Minute";
    Frame3.BorderSizePixel = 0;

    for i, v in v44 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    local UICorner3 = Instance.new("UICorner");
    UICorner3.CornerRadius = UDim.new(1, 0);
    UICorner3.Parent = Frame3;
    local v45 = {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.46, 0.5),
        Size = UDim2.fromScale(0.3, 0.13),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Hour";
    Frame4.BorderSizePixel = 0;

    for i, v in v45 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame2;
    local UICorner4 = Instance.new("UICorner");
    UICorner4.CornerRadius = UDim.new(1, 0);
    UICorner4.Parent = Frame4;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Countdown";
    TextLabel.AnchorPoint = Vector2.new(0, 0.5);
    TextLabel.Position = UDim2.fromScale(0.215, 0.5);
    TextLabel.Size = UDim2.fromScale(0.74, 0.56);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold);
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3_new_ret;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    local v46 = p41 - workspace:GetServerTimeNow();
    local math_floor_ret = math.floor(v46);
    TextLabel.Text = endsText((math.max(0, math_floor_ret)));
    TextLabel.Parent = Frame;
    BillboardGui.Parent = p40;
    Frame2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 453, Name: fit
        -- upvalues: UIStroke (copy), Frame2 (copy)
        UIStroke.Thickness = math.max(1, Frame2.AbsoluteSize.Y * 0.11);
    end);
    UIStroke.Thickness = math.max(1, Frame2.AbsoluteSize.Y * 0.11);

    return BillboardGui;
end;

local u47 = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("MapLocator")).interactables(10);

local function add(p48) -- Line: 460
    -- upvalues: ComingSoon (copy), u1 (copy), u2 (copy), u3 (copy), prizes (copy), CrateCatalog (copy), leavingTimer (copy)
    if ComingSoon and p48.Name == "EmoteCrate" then
        p48:Destroy();

        return;
    end;

    if u1[p48] or not u2[p48.Name] then
        return;
    end;

    local v49 = p48:FindFirstChild(u3[p48.Name] or "CrateModel");

    if not (v49 and (v49:IsA("Model") or v49:IsA("BasePart"))) then
        return;
    end;

    local v50 = (p48.Name == "EmberCrate" or p48.Name == "CelestialCrate") and true or p48.Name == "EmoteCrate";
    local v51;

    if v50 then
        v51 = v49:FindFirstChild("Body");
    else
        v51 = v50;
    end;

    local v52;

    if v50 then
        v52 = v49:FindFirstChild("Lid");
    else
        v52 = v50;
    end;

    local v53;

    if v51 then
        v53 = v51:FindFirstChild("LidHinge");
    else
        v53 = v51;
    end;

    if p48.Name == "BasicCrate" or p48.Name == "PremiumCrate" then
        v51 = v49:FindFirstChild("Bottom");
        v52 = v49:FindFirstChild("Top");

        if v51 and (v51:IsA("BasePart") and (v52 and v52:IsA("BasePart"))) then
            v50 = true;
            v53 = v51:FindFirstChild("LidHinge");

            if not v53 then
                local v54 = v52.CFrame * CFrame.fromMatrix(Vector3.new(-v52.Size.X / 2, -v52.Size.Y / 2, 0), Vector3.new(0, 0, 1), Vector3.new(0, 1, 0));
                v53 = Instance.new("Attachment");
                v53.Name = "LidHinge";
                v53.CFrame = v51.CFrame:ToObjectSpace(v54);
                v53.Parent = v51;
            end;
        end;
    end;

    if v50 and not (v51 and (v51:IsA("BasePart") and (v52 and (v52:IsA("BasePart") and (v53 and v53:IsA("Attachment")))))) then
        return;
    end;

    local v55 = v49:IsA("BasePart") and v49 and v49 or v49:FindFirstChildWhichIsA("BasePart", true);

    if not v55 then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "LocalCrateSparkles";
    Attachment.Parent = v55;

    if v50 then
        Attachment.Parent = v51;
        Attachment.Position = Vector3.new(0, v51.Size.Y * 0.45, 0);
    end;

    local PointLight = Instance.new("PointLight");
    PointLight.Color = u2[p48.Name];
    PointLight.Range = 12;
    PointLight.Brightness = 0;
    PointLight.Shadows = false;
    PointLight.Parent = Attachment;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Color = ColorSequence.new(u2[p48.Name]);
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Rate = 3;
    ParticleEmitter.Lifetime = NumberRange.new(1, 1.8);
    ParticleEmitter.Speed = NumberRange.new(0.8, 1.4);
    ParticleEmitter.SpreadAngle = Vector2.new(80, 80);
    ParticleEmitter.LightEmission = 0.9;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.25, 0.16), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(0.2, 0.15), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Attachment;
    local v56 = {
        active = false,
        lastCycleTime = 0,
        model = v49,
        base = v49:GetPivot(),
        attachment = Attachment,
        light = PointLight,
        sparks = ParticleEmitter,
        phase = ({
            EmberCrate = 0,
            CelestialCrate = 2,
            EmoteCrate = 3,
            FreeReward = 4,
            ShopModel = 6,
            BasicCrate = 1,
            PremiumCrate = 5
        })[p48.Name],
        amplitude = p48.Name == "ShopModel" and 0.65 or 1,
        body = v51,
        lid = v52
    };
    local v57;

    if v53 then
        v57 = v53.CFrame;
    else
        v57 = v53;
    end;

    v56.hingeOffset = v57;

    if v53 then
        v53 = v53.WorldCFrame:ToObjectSpace(v52.CFrame);
    end;

    v56.closedOffset = v53;
    local v58;

    if v50 then
        v58 = prizes(p48.Name) or nil;
    else
        v58 = nil;
    end;

    v56.prizes = v58;
    v56.emotes = p48.Name == "EmoteCrate";
    v56.hold = p48.Name == "EmoteCrate" and 4 or 0;
    u1[p48] = v56;
    local v59 = CrateCatalog.Crates[string.gsub(p48.Name, "Crate$", "")];

    if v59 then
        if v59.WorldModel == p48.Name then
            v59 = v59.EndsAt;
        else
            v59 = false;
        end;
    end;

    if type(v59) == "number" and workspace:GetServerTimeNow() < v59 then
        u1[p48].endsAt = v59;
        u1[p48].timer = leavingTimer(p48, v59);
    end;
end;

local function showKnife(p60, p61, p62) -- Line: 173
    -- upvalues: knifeCopy (copy), u5 (copy)
    if p61 < 2.75 or p61 >= 5.1 then
        if p60.knife then
            p60.knife.model:Destroy();
            p60.knife.glow:Destroy();
            p60.knife = nil;
        end;

        p60.knifeTried = false;

        return;
    end;

    if not p60.knife then
        if p60.knifeTried then
            return;
        end;

        p60.knifeTried = true;
        local prizes2 = p60.prizes;
        local math_random_ret = math.random(#prizes2);

        if #prizes2 > 1 and prizes2[math_random_ret] == p60.lastKnife then
            math_random_ret = math_random_ret % #prizes2 + 1;
        end;

        p60.lastKnife = prizes2[math_random_ret];
        p60.knife = knifeCopy(prizes2[math_random_ret]);

        if not p60.knife then
            return;
        end;
    end;

    local v63 = 1;
    local v64 = 0;

    if p61 < 3.45 then
        local v65 = (p61 - 2.75) / 0.7;
        v63 = 1 - (1 - v65) ^ 3;
        v64 = 6.283185307179586 * v65 * v65 * (3 - 2 * v65);
    elseif p61 >= 4.6 then
        local math_clamp_ret = math.clamp((p61 - 4.6) / 0.5, 0, 1);
        v63 = 1 - math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
    end;

    local knife = p60.knife;
    local v66 = v63 * 0.75 + 0.25;

    if math.abs(v66 - knife.grown) > 0.01 then
        local v67;

        if knife.grown == 1 and v66 < 1 then
            v67 = not knife.shown;
        else
            v67 = false;
        end;

        knife.grown = v66;
        pcall(knife.model.ScaleTo, knife.model, knife.scale * v66);

        for i, v in knife.rays do
            v.Size = NumberSequence.new(u5[i].size * v66);
        end;

        if v67 then
            knife.shown = true;

            for _, v in knife.rays do
                v:Emit(1);
            end;
        end;
    end;

    local v68 = p60.body.Size.Y / 2 + 1.6 + 0.7 + math.sin(p62 * 2.4) * 0.12 * v63;
    local Position = (p60.body.CFrame * CFrame.new(0, v68 * v63, 0)).Position;
    knife.glow.CFrame = CFrame.new(Position);
    knife.model:PivotTo(CFrame.new(Position) * CFrame.Angles(0, p62 * 1.6, 0) * CFrame.Angles(v64, 0, math.sin(p62 * 2) * 0.12) * CFrame.new(knife.offset.Position * knife.grown) * knife.offset.Rotation);
end;

local u69 = {};
local u70 = true;

local function remove(p71) -- Line: 359
    -- upvalues: u1 (copy), restore (copy), EmotePlayback (copy)
    local v72 = u1[p71];

    if not v72 then
        return;
    end;

    restore(v72);
    local dancer = v72.dancer;

    if dancer and dancer.track then
        EmotePlayback.dispose(dancer.track);
        dancer.track = nil;
    end;

    if dancer then
        dancer.model.Parent = nil;
    end;

    v72.dancing = false;

    if v72.dancer then
        v72.dancer.model:Destroy();
        v72.dancer = nil;
    end;

    if v72.attachment.Parent then
        v72.attachment:Destroy();
    end;

    if v72.timer then
        v72.timer:Destroy();
    end;

    u1[p71] = nil;
end;

local function showDancer(p73, p74, p75, p76) -- Line: 290
    -- upvalues: EmotePlayback (copy), dancerFor (copy), CrateCatalog (copy), Folder (copy)
    local hold = p73.hold;

    if p74 < 2.75 or 5.1 + hold <= p74 then
        local dancer = p73.dancer;

        if dancer and dancer.track then
            EmotePlayback.dispose(dancer.track);
            dancer.track = nil;
        end;

        if dancer then
            dancer.model.Parent = nil;
        end;

        p73.dancing = false;
        p73.dancerTried = false;

        return;
    end;

    if not p73.dancing then
        if p73.dancerTried then
            return;
        end;

        p73.dancerTried = true;
        local v77 = dancerFor(p73);

        if not (v77 and v77.animator) then
            return;
        end;

        local v78 = CrateCatalog.poseEmote("Emote");

        if v78 == p73.lastEmote then
            v78 = CrateCatalog.poseEmote("Emote");
        end;

        p73.lastEmote = v78;

        if v78 then
            v78 = EmotePlayback.load(v77.animator, v78);
        end;

        v77.track = v78;

        if v77.track then
            v77.track:Play(0.1);
        end;

        v77.grown = 1;
        v77.model.Parent = Folder;
        p73.dancing = true;
    end;

    local v79 = 1;

    if p74 < 3.45 then
        v79 = 1 - (1 - (p74 - 2.75) / 0.7) ^ 3;
    elseif 4.6 + hold <= p74 then
        local math_clamp_ret = math.clamp((p74 - 4.6 - hold) / 0.5, 0, 1);
        v79 = 1 - math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
    end;

    local dancer = p73.dancer;
    local v80 = v79 * 0.7 + 0.3;

    if math.abs(v80 - dancer.grown) > 0.02 then
        dancer.grown = v80;
        pcall(dancer.model.ScaleTo, dancer.model, dancer.scale * v80);
    end;

    local Position = (p73.body.CFrame * CFrame.new(0, p73.body.Size.Y / 2, 0)).Position;
    local v81;

    if p74 < 3.45 then
        local v82 = math.clamp((p74 - 2.75) / 0.7, 0, 1) * 3.141592653589793;
        v81 = math.sin(v82) * 0.6;
    else
        v81 = 0;
    end;

    local v83 = Position + Vector3.new(0, dancer.lift * dancer.grown - (1 - v79) * dancer.height * dancer.grown + v81 + 0.05, 0);

    if p76 then
        p76 = (p76.Position - v83) * Vector3.new(1, 0, 1);
    end;

    if p76 and p76.Magnitude > 0.1 then
        dancer.model:PivotTo(CFrame.lookAt(v83, v83 + p76));

        return;
    end;

    dancer.model:PivotTo(CFrame.new(v83) * CFrame.Angles(0, p75 * 0.8, 0));
end;

for _, child in u47:GetChildren() do
    add(child);
end;

table.insert(u69, u47.ChildAdded:Connect(function(u84) -- Line: 566
    -- upvalues: u70 (ref), u47 (copy), add (copy)
    task.delay(1, function() -- Line: 567
        -- upvalues: u70 (ref), u84 (copy), u47 (ref), add (ref)
        if u70 and u84.Parent == u47 then
            add(u84);
        end;
    end);
end));
table.insert(u69, u47.ChildRemoved:Connect(remove));
table.insert(u69, u47.DescendantAdded:Connect(function(p85) -- Line: 575
    -- upvalues: u47 (copy), u2 (copy), u1 (copy), u70 (ref), add (copy)
    if not (p85:IsA("BasePart") or p85:IsA("Attachment")) then
        return;
    end;

    local Parent = p85.Parent;

    while Parent and Parent.Parent ~= u47 do
        Parent = Parent.Parent;
    end;

    if Parent and (u2[Parent.Name] and not u1[Parent]) then
        task.defer(function() -- Line: 584
            -- upvalues: u70 (ref), Parent (ref), u47 (ref), add (ref)
            if u70 and Parent.Parent == u47 then
                add(Parent);
            end;
        end);
    end;
end));
local u86 = 0;
local u87 = 0;
script.Destroying:Connect(function() -- Line: 592
    -- upvalues: u70 (ref), u69 (copy), u1 (copy), restore (copy), EmotePlayback (copy), Folder (copy)
    u70 = false;

    for _, v in u69 do
        v:Disconnect();
    end;

    local v88 = {};

    for i in u1 do
        table.insert(v88, i);
    end;

    for _, v in v88 do
        local v89 = u1[v];

        if v89 then
            restore(v89);
            local dancer = v89.dancer;

            if dancer and dancer.track then
                EmotePlayback.dispose(dancer.track);
                dancer.track = nil;
            end;

            if dancer then
                dancer.model.Parent = nil;
            end;

            v89.dancing = false;

            if v89.dancer then
                v89.dancer.model:Destroy();
                v89.dancer = nil;
            end;

            if v89.attachment.Parent then
                v89.attachment:Destroy();
            end;

            if v89.timer then
                v89.timer:Destroy();
            end;

            u1[v] = nil;
        end;
    end;

    Folder:Destroy();
end);

local function smooth(p90) -- Line: 606
    local math_clamp_ret = math.clamp(p90, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

local u91 = 0;
table.insert(u69, RunService.RenderStepped:Connect(function(p92) -- Line: 611
    -- upvalues: u86 (ref), u87 (ref), u91 (ref), u1 (copy), endsText (copy), LocalPlayer (copy), restore (copy), EmotePlayback (copy), showKnife (copy), showDancer (copy)
    u86 = u86 + p92;
    u87 = u87 + p92;
    u91 = u91 + p92;

    if u91 >= 1 then
        u91 = 0;
        local ServerTimeNow = workspace:GetServerTimeNow();

        for _, v in u1 do
            if v.timer then
                local math_floor_ret = math.floor(v.endsAt - ServerTimeNow);

                if math_floor_ret <= 0 then
                    v.timer:Destroy();
                    v.timer = nil;
                else
                    v.timer.Pill.Countdown.Text = endsText(math_floor_ret);
                end;
            end;
        end;
    end;

    if u87 < 0.03333333333333333 then
        return;
    end;

    u87 = 0;
    local Character = LocalPlayer.Character;
    local v93 = LocalPlayer:GetAttribute("InMatch") ~= true and (Character and Character:FindFirstChild("HumanoidRootPart")) or nil;

    for i, v in u1 do
        if v.model.Parent and (i.Parent and (not v.lid or v.lid.Parent and v.body.Parent)) then
            local v94;

            if v93 == nil then
                v94 = false;
            else
                v94 = (v93.Position - v.base.Position).Magnitude < 100;
            end;

            v.sparks.Enabled = v94;

            if v94 then
                local v95 = u86 + v.phase;
                local amplitude = v.amplitude;
                local hold = v.hold;
                local v96 = v95 % (8.4 + hold);
                local v97 = 0;
                local v98 = 0;
                local v99 = 0;

                if v.lid then
                    if v96 >= 2.2 and v96 < 2.65 then
                        local v100 = (v96 - 2.2) / 0.45;
                        v98 = math.sin(v100 * 34) * 0.045 * v100;
                        v99 = -0.07 * v100;
                    elseif v96 >= 2.65 and v96 < 3.35 then
                        local v101 = (v96 - 2.65) / 0.7;
                        v97 = 1 - (1 - v101) ^ 3;
                        v99 = math.sin(v101 * 3.141592653589793) * 0.12;
                    elseif v96 >= 3.35 and v96 < 4.9 + hold then
                        v97 = math.sin((v96 - 3.35) * 5) * 0.018 + 1;
                    elseif 4.9 + hold <= v96 and v96 < 5.65 + hold then
                        local math_clamp_ret = math.clamp((v96 - 4.9 - hold) / 0.75, 0, 1);
                        v97 = 1 - math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
                    elseif 5.65 + hold <= v96 and v96 < 6.15 + hold then
                        local v102 = (v96 - 5.65 - hold) / 0.5;
                        local math_sin_ret = math.sin(v102 * 3.141592653589793 * 2);
                        v97 = math.abs(math_sin_ret) * (1 - v102) * 0.07;
                        v99 = -math.sin(v102 * 3.141592653589793) * 0.06;
                    end;

                    if v.active and (v.lastCycleTime < 2.85 and v96 >= 2.85) then
                        v.sparks:Emit(18);
                    end;

                    v.lastCycleTime = v96;
                end;

                v.model:PivotTo(v.base * CFrame.new(0, (math.sin(v95 * 1.8) * 0.14 + 0.16) * amplitude + v99, 0) * CFrame.Angles(math.sin(v95 * 1.3) * 0.025 * amplitude, math.sin(v95 * 0.55) * 0.15 * amplitude, math.sin(v95 * 1.7) * 0.035 * amplitude + v98));

                if v.lid then
                    v.lid.CFrame = v.body.CFrame * v.hingeOffset * CFrame.Angles(v97 * 1.7802358370342162, 0, 0) * v.closedOffset;

                    if v.prizes then
                        showKnife(v, v96, v95);
                    elseif v.emotes then
                        showDancer(v, v96, v95, v93);
                    end;
                end;

                v.light.Brightness = (math.sin(v95 * 2) + 1) * 0.3 + 0.65 + v97 * 1.8;
                v.sparks.Rate = v97 * 9 + 3;
            elseif v.active then
                restore(v);
                v.light.Brightness = 0;
            end;

            v.active = v94;
        else
            local v103 = u1[i];

            if v103 then
                restore(v103);
                local dancer = v103.dancer;

                if dancer and dancer.track then
                    EmotePlayback.dispose(dancer.track);
                    dancer.track = nil;
                end;

                if dancer then
                    dancer.model.Parent = nil;
                end;

                v103.dancing = false;

                if v103.dancer then
                    v103.dancer.model:Destroy();
                    v103.dancer = nil;
                end;

                if v103.attachment.Parent then
                    v103.attachment:Destroy();
                end;

                if v103.timer then
                    v103.timer:Destroy();
                end;

                u1[i] = nil;
            end;
        end;
    end;
end));