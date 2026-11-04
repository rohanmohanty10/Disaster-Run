 

 

local Players = game:GetService("Players");
local ContextActionService = game:GetService("ContextActionService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local FallenKingEvent = ChickenOrHero:WaitForChild("Game"):WaitForChild("FallenKingEvent");
local GearCatalog = require(ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearCatalog"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(255, 150, 50);
local Font_new_ret = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy);
local u1 = GearCatalog.Items.PumpkinBomb and GearCatalog.Items.PumpkinBomb.Sounds or {};
local Folder = Instance.new("Folder");
Folder.Name = "FallenKingBombFX";
Folder.Parent = workspace;

local function bare(p2) -- Line: 30
    p2.Anchored = true;
    p2.CanCollide = false;
    p2.CanQuery = false;
    p2.CanTouch = false;
    p2.CastShadow = false;
    p2.Transparency = 1;
end;

local function spot(p3, p4) -- Line: 37
    -- upvalues: Folder (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p3);
    Part.Parent = Folder;
    Debris:AddItem(Part, p4);

    return Part;
end;

local function sound(p5, p6, p7, p8) -- Line: 47
    -- upvalues: Debris (copy)
    if not p5 then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = p5;
    Sound.Volume = p7;
    Sound.PlaybackSpeed = p8 or 1;
    Sound.RollOffMinDistance = 12;
    Sound.RollOffMaxDistance = 150;
    Sound.Parent = p6;
    Sound:Play();
    Debris:AddItem(Sound, 4);
end;

local function pop(p9, p10, p11, p12, p13) -- Line: 64
    -- upvalues: Folder (copy), Debris (copy), Font_new_ret (copy), TweenService (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p9);
    Part.Parent = Folder;
    Debris:AddItem(Part, (p13 or 0.8) + 0.6);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Size = UDim2.fromOffset(220, 70);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 2, 0);
    BillboardGui.Parent = Part;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.FontFace = Font_new_ret;
    TextLabel.Text = p10;
    TextLabel.TextColor3 = p11;
    TextLabel.TextSize = p12 or 34;
    TextLabel.TextStrokeTransparency = 0.2;
    TextLabel.Parent = BillboardGui;
    TweenService:Create(BillboardGui, TweenInfo.new((p13 or 0.8) + 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        StudsOffsetWorldSpace = Vector3.new(0, 7, 0)
    }):Play();
    TweenService:Create(TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, p13 or 0.8), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
end;

local function burst(p14, p15) -- Line: 91
    -- upvalues: Folder (copy), Debris (copy), Color3_fromRGB_ret (copy), TweenService (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p14);
    Part.Parent = Folder;
    Debris:AddItem(Part, 2);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret, Color3.fromRGB(90, 40, 20));
    ParticleEmitter.Size = NumberSequence.new(1.5 * p15, 4 * p15);
    ParticleEmitter.Transparency = NumberSequence.new(0.1, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.8);
    ParticleEmitter.Speed = NumberRange.new(6, 14);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rate = 0;
    ParticleEmitter.LightEmission = 0.4;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit((math.floor(12 * p15)));
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret;
    PointLight.Range = 14 * p15;
    PointLight.Brightness = 4;
    PointLight.Parent = Part;
    TweenService:Create(PointLight, TweenInfo.new(0.4), {
        Brightness = 0
    }):Play();

    return Part;
end;

local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 248, 180), Color3.fromRGB(255, 132, 24));
local ColorSequence_new_ret2 = ColorSequence.new(Color3.fromRGB(255, 200, 255), Color3.fromRGB(176, 56, 255));
local ColorSequence_new_ret3 = ColorSequence.new(Color3.fromRGB(240, 252, 255), Color3.fromRGB(110, 190, 255));
local ColorSequence_new_ret4 = ColorSequence.new(Color3.fromRGB(215, 255, 232), Color3.fromRGB(50, 214, 140));

local function kingModel() -- Line: 122
    local FallenKingFight = workspace:FindFirstChild("FallenKingFight");

    if FallenKingFight then
        FallenKingFight = FallenKingFight:FindFirstChild("FallenKing");
    end;

    return FallenKingFight;
end;

local function flashKing(p16) -- Line: 126
    -- upvalues: Color3_fromRGB_ret (copy), TweenService (copy)
    local FallenKingFight = workspace:FindFirstChild("FallenKingFight");

    if FallenKingFight then
        FallenKingFight = FallenKingFight:FindFirstChild("FallenKing");
    end;

    if not FallenKingFight then
        return;
    end;

    local HitFlash = FallenKingFight:FindFirstChild("HitFlash");

    if not HitFlash then
        HitFlash = Instance.new("Highlight");
        HitFlash.Name = "HitFlash";
        HitFlash.DepthMode = Enum.HighlightDepthMode.Occluded;
        HitFlash.FillColor = Color3.new(1, 1, 1);
        HitFlash.FillTransparency = 1;
        HitFlash.OutlineTransparency = 1;
        HitFlash.Parent = FallenKingFight;
    end;

    local v17;

    if p16 then
        v17 = Color3_fromRGB_ret;
    else
        v17 = Color3.fromRGB(150, 210, 255);
    end;

    HitFlash.OutlineColor = v17;
    HitFlash.FillTransparency = p16 and 0.12 or 0.45;
    HitFlash.OutlineTransparency = 0;
    TweenService:Create(HitFlash, TweenInfo.new(p16 and 0.4 or 0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
end;

local function flashShrine(p18) -- Line: 150
    -- upvalues: TweenService (copy)
    local FallenKingFight = workspace:FindFirstChild("FallenKingFight");
    local v19 = nil;
    local v20 = nil;

    for _, v in not FallenKingFight and {} or FallenKingFight:GetChildren() do
        if v:IsA("Model") and v.Name == "Shrine" then
            local Magnitude = ((v:GetPivot().Position - p18) * Vector3.new(1, 0, 1)).Magnitude;

            if Magnitude < 14 and (not v19 or Magnitude < v19) then
                v20 = v;
                v19 = Magnitude;
            end;
        end;
    end;

    if not v20 then
        return;
    end;

    local HitFlash = v20:FindFirstChild("HitFlash");

    if not HitFlash then
        HitFlash = Instance.new("Highlight");
        HitFlash.Name = "HitFlash";
        HitFlash.DepthMode = Enum.HighlightDepthMode.Occluded;
        HitFlash.FillColor = Color3.fromRGB(220, 255, 230);
        HitFlash.OutlineColor = Color3.fromRGB(60, 230, 140);
        HitFlash.Parent = v20;
    end;

    HitFlash.FillTransparency = 0.3;
    HitFlash.OutlineTransparency = 0;
    TweenService:Create(HitFlash, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
end;

local function spark(p21) -- Line: 181
    -- upvalues: Folder (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p21);
    Part.Parent = Folder;
    Debris:AddItem(Part, 1.5);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(120, 200, 255));
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Size = NumberSequence.new(1.1, 0);
    ParticleEmitter.Lifetime = NumberRange.new(0.2, 0.4);
    ParticleEmitter.Speed = NumberRange.new(14, 26);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 6;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(18);

    return Part;
end;

local function commas(p22) -- Line: 197
    local math_floor_ret = math.floor(p22 + 0.5);
    local v23 = tostring(math_floor_ret);
    local v24;

    repeat
        v23, v24 = v23:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v24 == 0;

    return v23;
end;

local function damageNumber(p25) -- Line: 207
    -- upvalues: LocalPlayer (copy), ColorSequence_new_ret4 (copy), ColorSequence_new_ret3 (copy), ColorSequence_new_ret2 (copy), ColorSequence_new_ret (copy), Folder (copy), Debris (copy), Font_new_ret (copy), commas (copy), TweenService (copy)
    local v26 = p25.userId == LocalPlayer.UserId;
    local math_min_ret = math.min(p25.combo or 1, 64);
    local v27 = math_min_ret >= 8;
    local u28;

    if p25.shrine then
        u28 = ColorSequence_new_ret4;
    elseif p25.strike then
        u28 = ColorSequence_new_ret3;
    elseif v27 then
        u28 = ColorSequence_new_ret2;
    else
        u28 = ColorSequence_new_ret;
    end;

    local v29 = math_min_ret / 64 * 0.6 + 0.65;
    local v30 = (math.random() - 0.5) * 3;
    local v31 = 1 + math.random() * 1.5;
    local v32 = (math.random() - 0.5) * 3;
    local Vector3_new_ret = Vector3.new(v30, v31, v32);
    local v33 = p25.position + Vector3_new_ret;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(v33);
    Part.Parent = Folder;
    Debris:AddItem(Part, v29 + 1);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Size = UDim2.fromOffset(280, 120);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 260;
    BillboardGui.Parent = Part;
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Rotation = (math.random() - 0.5) * 16;
    Frame.Parent = BillboardGui;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 0.15;
    UIScale.Parent = Frame;
    local v34 = (v26 and 50 or 34) + math_min_ret / 64 * 26;

    local function label(p35, p36, p37, p38, p39) -- Line: 230
        -- upvalues: Font_new_ret (ref), Frame (copy), u28 (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BackgroundTransparency = 1;
        TextLabel.AnchorPoint = Vector2.new(0.5, 0);
        TextLabel.Position = UDim2.new(0.5, 0, 0, p37);
        TextLabel.Size = UDim2.new(1, 0, 0, p38);
        TextLabel.FontFace = Font_new_ret;
        TextLabel.Text = p35;
        TextLabel.TextSize = p36;
        TextLabel.TextColor3 = Color3.new(1, 1, 1);
        TextLabel.Parent = Frame;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Color = u28;
        UIGradient.Rotation = 90;
        UIGradient.Parent = TextLabel;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = p39;
        UIStroke.Color = Color3.fromRGB(30, 8, 4);
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke.Parent = TextLabel;

        return TextLabel, UIStroke;
    end;

    local v40;

    if p25.percent then
        v40 = tostring(p25.damage or 0) .. "%";
    else
        v40 = commas(p25.damage or 0);
    end;

    local v41, v42 = label(v40, v34, 6, v34 + 6, v26 and 3.5 or 2.5);
    local v43;

    if math_min_ret > 1 then
        v43 = ("x%d COMBO!"):format(math_min_ret);
    else
        v43 = p25.strike == "Dive" and "DIVE" or (p25.strike and "SLASH" or "");
    end;

    local v44, v45 = label(v43, math.floor(v34 * 0.42), v34 + 8, math.floor(v34 * 0.5), 2);
    TweenService:Create(UIScale, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = v27 and 1.35 or 1.18
    }):Play();
    task.delay(0.12, function() -- Line: 262
        -- upvalues: UIScale (copy), TweenService (ref)
        if UIScale.Parent then
            TweenService:Create(UIScale, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end;
    end);
    local TweenInfo_new_ret = TweenInfo.new(v29 + 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v46 = {};
    local v47 = (math.random() - 0.5) * 3;
    v46.StudsOffsetWorldSpace = Vector3.new(v47, 5, 0);
    TweenService:Create(BillboardGui, TweenInfo_new_ret, v46):Play();
    local TweenInfo_new_ret2 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, v29);

    for _, v in { v41, v44 } do
        TweenService:Create(v, TweenInfo_new_ret2, {
            TextTransparency = 1
        }):Play();
    end;

    for _, v in { v42, v45 } do
        TweenService:Create(v, TweenInfo_new_ret2, {
            Transparency = 1
        }):Play();
    end;
end;

local Color3_fromRGB_ret2 = Color3.fromRGB(255, 40, 40);

local function marker(p48, p49, p50, p51) -- Line: 281
    -- upvalues: Color3_fromRGB_ret2 (copy), Folder (copy), TweenService (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Shape = p50;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3_fromRGB_ret2;
    Part.Size = p49;
    Part.CFrame = p48;
    Part.Transparency = 0.85;
    Part.Parent = Folder;
    local u52 = Part:Clone();
    u52.Transparency = 0.55;
    local v53;

    if p50 == Enum.PartType.Cylinder then
        v53 = Vector3.new(p49.X, 0.1, 0.1);
    else
        v53 = Vector3.new(0.1, p49.Y, p49.Z);
    end;

    u52.Size = v53;
    u52.Parent = Folder;
    TweenService:Create(Part, TweenInfo.new(p51 * 0.6), {
        Transparency = 0.6
    }):Play();
    TweenService:Create(u52, TweenInfo.new(p51, Enum.EasingStyle.Linear), {
        Size = p49
    }):Play();
    task.delay(p51, function() -- Line: 298
        -- upvalues: Part (copy), TweenService (ref), u52 (copy), Debris (ref)
        Part.Transparency = 0.2;
        TweenService:Create(Part, TweenInfo.new(0.35), {
            Transparency = 1
        }):Play();
        u52:Destroy();
        Debris:AddItem(Part, 0.4);
    end);
end;

local Models = ChickenOrHero:WaitForChild("Weapons"):WaitForChild("Models");

local function fallingKnife(p54) -- Line: 310
    -- upvalues: Models (copy)
    local v55 = Models:FindFirstChild(p54 and "FallenAxes" or "FallenAxesBlue");

    if v55 then
        v55 = v55:FindFirstChild("Blade");
    end;

    if not v55 then
        return nil;
    end;

    local Model = Instance.new("Model");
    Model.Name = "RainKnife";
    local v56 = v55:Clone();

    for _, v in { v56, table.unpack(v56:GetDescendants()) } do
        if v:IsA("BasePart") then
            v.Anchored = true;
            v.CanCollide = false;
            v.CanQuery = false;
            v.CanTouch = false;
            v.CastShadow = false;
        elseif v:IsA("JointInstance") or (v:IsA("WeldConstraint") or v:IsA("Script")) then
            v:Destroy();
        end;
    end;

    v56.Parent = Model;
    Model.PrimaryPart = v56;
    pcall(Model.ScaleTo, Model, 2.6);

    return Model;
end;

local function knifeRain(u57, p58) -- Line: 332
    -- upvalues: Folder (copy), TweenService (copy), fallingKnife (copy), burst (copy), u1 (copy), Debris (copy)
    local v59 = tonumber(u57.radius) or 4;
    local math_clamp_ret = math.clamp(v59, 1, 20);
    local u60;

    if u57.red then
        u60 = Color3.fromRGB(255, 90, 90);
    else
        u60 = Color3.fromRGB(110, 170, 255);
    end;

    local v61;

    if u57.red then
        v61 = Color3.fromRGB(70, 0, 0);
    else
        v61 = Color3.fromRGB(0, 14, 70);
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Shape = Enum.PartType.Cylinder;
    Part.Material = Enum.Material.Neon;
    Part.Color = u60;
    Part.Size = Vector3.new(0.12, math_clamp_ret * 2, math_clamp_ret * 2);
    Part.CFrame = CFrame.new(u57.position + Vector3.new(0, 0.16, 0)) * CFrame.Angles(0, 0, 1.5707963267948966);
    Part.Transparency = 0.85;
    Part.Parent = Folder;
    TweenService:Create(Part, TweenInfo.new(p58, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 0.1,
        Color = v61
    }):Play();
    local u62 = fallingKnife(u57.red);
    local u63 = u57.position + Vector3.new(0, 2.86, 0);
    local u64 = math.random() * 3.141592653589793 * 2;

    if u62 then
        u62:PivotTo(CFrame.new(u63 + Vector3.new(0, 70, 0)) * CFrame.Angles(3.141592653589793, u64, 0));
        u62.Parent = Folder;
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Changed:Connect(function(p65) -- Line: 357
            -- upvalues: u62 (copy), u63 (copy), u64 (copy)
            if u62.Parent then
                u62:PivotTo(CFrame.new(u63 + Vector3.new(0, 70 * (1 - p65), 0)) * CFrame.Angles(3.141592653589793, u64 + p65 * 9, 0));
            end;
        end);
        local v66 = TweenService:Create(NumberValue, TweenInfo.new(p58, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Value = 1
        });
        v66.Completed:Once(function() -- Line: 363
            -- upvalues: NumberValue (copy)
            NumberValue:Destroy();
        end);
        v66:Play();
    end;

    task.delay(p58, function() -- Line: 368
        -- upvalues: burst (ref), u57 (copy), u1 (ref), Debris (ref), Part (copy), u60 (copy), TweenService (ref), u62 (copy)
        local v67 = burst(u57.position + Vector3.new(0, 0.6, 0), 0.55);
        local Burst = u1.Burst;

        if Burst then
            local Sound = Instance.new("Sound");
            Sound.SoundId = Burst;
            Sound.Volume = 0.55;
            Sound.PlaybackSpeed = 1.35;
            Sound.RollOffMinDistance = 12;
            Sound.RollOffMaxDistance = 150;
            Sound.Parent = v67;
            Sound:Play();
            Debris:AddItem(Sound, 4);
        end;

        Part.Color = u60;
        Part.Transparency = 0.2;
        TweenService:Create(Part, TweenInfo.new(0.35), {
            Transparency = 1
        }):Play();
        Debris:AddItem(Part, 0.4);

        if u62 then
            task.delay(0.7, function() -- Line: 377
                -- upvalues: u62 (ref), TweenService (ref), Debris (ref)
                for _, descendant in u62:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        TweenService:Create(descendant, TweenInfo.new(0.4), {
                            Transparency = 1
                        }):Play();
                    end;
                end;

                Debris:AddItem(u62, 0.45);
            end);
        end;
    end);
end;

local function roar(p68) -- Line: 388
    -- upvalues: Folder (copy), Debris (copy), TweenService (copy), LocalPlayer (copy)
    local position = p68.position;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(position);
    Part.Parent = Folder;
    Debris:AddItem(Part, 2);
    local Part2 = Instance.new("Part");
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;
    Part2.Transparency = 1;
    Part2.Shape = Enum.PartType.Cylinder;
    Part2.Material = Enum.Material.Neon;
    Part2.Color = Color3.fromRGB(170, 80, 255);
    Part2.Transparency = 0.3;
    Part2.Size = Vector3.new(0.2, 4, 4);
    Part2.CFrame = CFrame.new(p68.position - Vector3.new(0, 5, 0)) * CFrame.Angles(0, 0, 1.5707963267948966);
    Part2.Parent = Folder;
    TweenService:Create(Part2, TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.2, 140, 140),
        Transparency = 1
    }):Play();
    Debris:AddItem(Part2, 1.2);
    local Character = LocalPlayer.Character;
    local v69;

    if Character then
        v69 = Character:FindFirstChild("HumanoidRootPart");
    else
        v69 = Character;
    end;

    if v69 then
        local Magnitude = (v69.Position - p68.position).Magnitude;

        if Magnitude < 120 then
            Character:SetAttribute("CameraKickPower", (math.clamp(1.4 - Magnitude / 100, 0.4, 1.4)));
            Character:SetAttribute("CameraKickAt", os.clock());
        end;
    end;

    return Part;
end;

local function attack(u70) -- Line: 417
    -- upvalues: marker (copy), Folder (copy), TweenService (copy), burst (copy), Debris (copy), pop (copy), knifeRain (copy), roar (copy), u1 (copy)
    local v71 = tonumber(u70.seconds) or 1;
    local math_clamp_ret = math.clamp(v71, 0.2, 4);

    if u70.kind == "Ring" and typeof(u70.position) == "Vector3" then
        local v72 = tonumber(u70.radius) or 10;
        local math_clamp_ret2 = math.clamp(v72, 1, 60);
        marker(CFrame.new(u70.position + Vector3.new(0, 0.15, 0)) * CFrame.Angles(0, 0, 1.5707963267948966), Vector3.new(0.12, math_clamp_ret2 * 2, math_clamp_ret2 * 2), Enum.PartType.Cylinder, math_clamp_ret);

        if u70.axe then
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Transparency = 1;
            Part.Material = Enum.Material.Neon;
            Part.Color = Color3.fromRGB(170, 110, 255);
            Part.Transparency = 0.25;
            Part.Size = Vector3.new(0.6, 6, 4);
            local u73 = u70.position + Vector3.new(0, 3, 0);
            Part.CFrame = CFrame.new(u73 + Vector3.new(0, 45, 0));
            Part.Parent = Folder;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Changed:Connect(function(p74) -- Line: 435
                -- upvalues: Part (copy), u73 (copy)
                if Part.Parent then
                    Part.CFrame = CFrame.new(u73 + Vector3.new(0, 45 * (1 - p74), 0)) * CFrame.Angles(p74 * 18, 0, 0);
                end;
            end);
            local v75 = TweenService:Create(NumberValue, TweenInfo.new(math_clamp_ret, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Value = 1
            });
            v75.Completed:Once(function() -- Line: 441
                -- upvalues: NumberValue (copy), burst (ref), u70 (copy), TweenService (ref), Part (copy), Debris (ref)
                NumberValue:Destroy();
                burst(u70.position + Vector3.new(0, 1, 0), 0.7);
                TweenService:Create(Part, TweenInfo.new(0.4), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(Part, 0.45);
            end);
            v75:Play();
        end;
    elseif u70.kind == "Line" and (typeof(u70.from) == "Vector3" and typeof(u70.to) == "Vector3") then
        local v76 = u70.from + Vector3.new(0, 0.15, 0);
        local v77 = u70.to + Vector3.new(0, 0.15, 0);
        local Magnitude = (v77 - v76).Magnitude;

        if Magnitude > 0.5 then
            local v78 = tonumber(u70.width) or 6;
            local math_clamp_ret2 = math.clamp(v78, 1, 20);
            marker(CFrame.lookAt(v76:Lerp(v77, 0.5), v77), Vector3.new(math_clamp_ret2, 0.12, Magnitude), Enum.PartType.Block, math_clamp_ret);
        end;
    else
        if u70.kind == "Disarmed" and typeof(u70.position) == "Vector3" then
            pop(u70.position + Vector3.new(0, 10, 0), "DISARMED!  x2 DAMAGE", Color3.fromRGB(255, 240, 120), 48, (math.max(0.8, math_clamp_ret - 0.5)));

            return;
        end;

        if u70.kind == "Knife" and typeof(u70.position) == "Vector3" then
            knifeRain(u70, math_clamp_ret);

            return;
        end;

        if u70.kind == "Roar" and typeof(u70.position) == "Vector3" then
            roar(u70);

            return;
        end;

        if u70.kind == "Slam" and typeof(u70.position) == "Vector3" then
            local v79 = burst(u70.position + Vector3.new(0, 1, 0), 1.6);
            local Burst = u1.Burst;

            if not Burst then
                return;
            end;

            local Sound = Instance.new("Sound");
            Sound.SoundId = Burst;
            Sound.Volume = 0.9;
            Sound.PlaybackSpeed = 0.6;
            Sound.RollOffMinDistance = 12;
            Sound.RollOffMaxDistance = 150;
            Sound.Parent = v79;
            Sound:Play();
            Debris:AddItem(Sound, 4);
        end;
    end;
end;

local Color3_fromRGB_ret3 = Color3.fromRGB(170, 80, 255);

local function smoke(p80, p81) -- Line: 471
    -- upvalues: Folder (copy), Debris (copy), Color3_fromRGB_ret3 (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p80);
    Part.Parent = Folder;
    Debris:AddItem(Part, 2);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret3, Color3.fromRGB(40, 10, 60));
    ParticleEmitter.Size = NumberSequence.new(2 * p81, 5 * p81);
    ParticleEmitter.Transparency = NumberSequence.new(0.2, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1);
    ParticleEmitter.Speed = NumberRange.new(4, 10);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rate = 0;
    ParticleEmitter.LightEmission = 0.6;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit((math.floor(14 * p81)));

    return Part;
end;

local function shrine(p82) -- Line: 487
    -- upvalues: smoke (copy), u1 (copy), Debris (copy), marker (copy), burst (copy), pop (copy), Color3_fromRGB_ret3 (copy)
    if p82.kind == "Leap" or p82.kind == "Flash" then
        if typeof(p82.from) == "Vector3" then
            smoke(p82.from, 1.2);
        end;

        if typeof(p82.to) == "Vector3" then
            local v83 = smoke(p82.to, 1.4);
            local Burst = u1.Burst;

            if not Burst then
                return;
            end;

            local Sound = Instance.new("Sound");
            Sound.SoundId = Burst;
            Sound.Volume = 0.6;
            Sound.PlaybackSpeed = 0.7;
            Sound.RollOffMinDistance = 12;
            Sound.RollOffMaxDistance = 150;
            Sound.Parent = v83;
            Sound:Play();
            Debris:AddItem(Sound, 4);
        end;
    else
        if p82.kind == "FlashWarn" and typeof(p82.position) == "Vector3" then
            local v84 = tonumber(p82.radius) or 12;
            local math_clamp_ret = math.clamp(v84, 1, 40);
            local v85 = tonumber(p82.seconds) or 0.5;
            local math_clamp_ret2 = math.clamp(v85, 0.2, 2);
            marker(CFrame.new(p82.position + Vector3.new(0, 0.15, 0)) * CFrame.Angles(0, 0, 1.5707963267948966), Vector3.new(0.12, math_clamp_ret * 2, math_clamp_ret * 2), Enum.PartType.Cylinder, math_clamp_ret2);

            return;
        end;

        if p82.kind == "Rise" and typeof(p82.position) == "Vector3" then
            local v86 = burst(p82.position, 2);
            local Burst = u1.Burst;

            if not Burst then
                return;
            end;

            local Sound = Instance.new("Sound");
            Sound.SoundId = Burst;
            Sound.Volume = 1;
            Sound.PlaybackSpeed = 0.5;
            Sound.RollOffMinDistance = 12;
            Sound.RollOffMaxDistance = 150;
            Sound.Parent = v86;
            Sound:Play();
            Debris:AddItem(Sound, 4);

            return;
        end;

        if p82.kind == "Break" and typeof(p82.position) == "Vector3" then
            local v87 = smoke(p82.position, 2.4);
            local Burst = u1.Burst;

            if Burst then
                local Sound = Instance.new("Sound");
                Sound.SoundId = Burst;
                Sound.Volume = 1;
                Sound.PlaybackSpeed = 0.8;
                Sound.RollOffMinDistance = 12;
                Sound.RollOffMaxDistance = 150;
                Sound.Parent = v87;
                Sound:Play();
                Debris:AddItem(Sound, 4);
            end;

            pop(p82.position, "SHRINE DESTROYED", Color3_fromRGB_ret3, 34);

            return;
        end;

        if p82.kind == "Shatter" and typeof(p82.position) == "Vector3" then
            local v88 = smoke(p82.position, 3);
            local Burst = u1.Burst;

            if Burst then
                local Sound = Instance.new("Sound");
                Sound.SoundId = Burst;
                Sound.Volume = 1;
                Sound.PlaybackSpeed = 0.6;
                Sound.RollOffMinDistance = 12;
                Sound.RollOffMaxDistance = 150;
                Sound.Parent = v88;
                Sound:Play();
                Debris:AddItem(Sound, 4);
            end;

            pop(p82.position + Vector3.new(0, 6, 0), "STUNNED!", Color3.fromRGB(255, 240, 120), 46);

            return;
        end;

        if p82.kind == "Fizzle" and typeof(p82.position) == "Vector3" then
            burst(p82.position, 0.4);
        end;
    end;
end;

local function shrineBar(u89) -- Line: 518
    -- upvalues: Color3_fromRGB_ret3 (copy)
    if not (u89:IsA("Model") and (u89.Name == "Shrine" and not u89:FindFirstChild("HealthBar", true))) then
        return;
    end;

    local Pivot = u89:WaitForChild("Pivot", 5);

    if not Pivot then
        return;
    end;

    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "HealthBar";
    BillboardGui.Size = UDim2.fromOffset(120, 14);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 14, 0);
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 220;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.fromRGB(25, 12, 35);
    Frame.BorderSizePixel = 0;
    Frame.Parent = BillboardGui;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.fromScale(1, 1);
    Frame2.BackgroundColor3 = Color3_fromRGB_ret3;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;

    for _, v in { Frame, Frame2 } do
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 4);
        UICorner.Parent = v;
    end;

    u89:GetAttributeChangedSignal("Health"):Connect(function() -- Line: 547, Name: update
        -- upvalues: Frame2 (copy), u89 (copy)
        local UDim2_fromScale = UDim2.fromScale;
        local v90 = u89:GetAttribute("Health") or 1;
        Frame2.Size = UDim2_fromScale(math.clamp(v90, 0, 1), 1);
    end);
    local UDim2_fromScale = UDim2.fromScale;
    local v91 = u89:GetAttribute("Health") or 1;
    Frame2.Size = UDim2_fromScale(math.clamp(v91, 0, 1), 1);
    BillboardGui.Parent = Pivot;
end;

local function caption(u92) -- Line: 556
    -- upvalues: Font_new_ret (copy), LocalPlayer (copy), TweenService (copy), Debris (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "FallenKingLine";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 30;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.3);
    TextLabel.Size = UDim2.new(0.8, 0, 0, 60);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(225, 200, 255);
    TextLabel.TextStrokeTransparency = 0.2;
    TextLabel.Text = "";
    TextLabel.Parent = ScreenGui;
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
    task.spawn(function() -- Line: 573
        -- upvalues: u92 (copy), TextLabel (copy), TweenService (ref), Debris (ref), ScreenGui (copy)
        for i = 1, #u92 do
            TextLabel.Text = string.sub(u92, 1, i);
            task.wait(string.sub(u92, i, i) == "." and 0.12 or 0.05);
            local _ = i;
        end;

        task.wait(2.2);
        TweenService:Create(TextLabel, TweenInfo.new(0.6), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        Debris:AddItem(ScreenGui, 0.7);
    end);
end;

local function characterOf(p93) -- Line: 584
    -- upvalues: Players (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p93 or 0);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    return PlayerByUserId;
end;

FallenKingEvent.OnClientEvent:Connect(function(p94, p95) -- Line: 589
    -- upvalues: attack (copy), shrine (copy), caption (copy), Folder (copy), Debris (copy), u1 (copy), spark (copy), burst (copy), flashKing (copy), flashShrine (copy), damageNumber (copy), pop (copy), Players (copy)
    if p94 == "Attack" and type(p95) == "table" then
        attack(p95);

        return;
    end;

    if p94 == "Shrine" and type(p95) == "table" then
        shrine(p95);

        return;
    end;

    if p94 == "Defeat" and (type(p95) == "table" and type(p95.line) == "string") then
        caption((string.sub(p95.line, 1, 80)));

        return;
    end;

    if p94 ~= "Stone" or (type(p95) ~= "table" or typeof(p95.position) ~= "Vector3") then
        if p94 ~= "Bomb" or type(p95) ~= "table" then
            return;
        end;

        if p95.kind ~= "Hit" or typeof(p95.position) ~= "Vector3" then
            if p95.kind == "Burst" and typeof(p95.position) == "Vector3" then
                local v96 = burst(p95.position, 0.6);
                local Burst = u1.Burst;

                if Burst then
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = Burst;
                    Sound.Volume = 0.5;
                    Sound.PlaybackSpeed = 1.2;
                    Sound.RollOffMinDistance = 12;
                    Sound.RollOffMaxDistance = 150;
                    Sound.Parent = v96;
                    Sound:Play();
                    Debris:AddItem(Sound, 4);
                end;

                if (p95.combo or 1) > 1 then
                    pop(p95.position, "COMBO LOST", Color3.fromRGB(200, 200, 210), 24);

                    return;
                end;
            else
                if p95.kind == "Deflect" and typeof(p95.position) == "Vector3" then
                    burst(p95.position, 0.5);
                    pop(p95.position, "SHIELDED", Color3.fromRGB(150, 200, 255), 26);

                    return;
                end;

                if p95.kind == "Catch" then
                    local PlayerByUserId = Players:GetPlayerByUserId(p95.userId or 0);

                    if PlayerByUserId then
                        PlayerByUserId = PlayerByUserId.Character;
                    end;

                    if PlayerByUserId then
                        PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
                    end;

                    if PlayerByUserId then
                        pop(PlayerByUserId.Position + Vector3.new(0, 3, 0), "x" .. tostring(p95.combo) .. " COMBO!", Color3.fromRGB(255, 220, 90), 32);

                        return;
                    end;
                elseif p95.kind == "Throw" then
                    local PlayerByUserId = Players:GetPlayerByUserId(p95.userId or 0);

                    if PlayerByUserId then
                        PlayerByUserId = PlayerByUserId.Character;
                    end;

                    if PlayerByUserId then
                        PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
                    end;

                    if PlayerByUserId then
                        local Throw = u1.Throw;
                        local v97 = math.min(p95.combo or 1, 64) / 128 + 1;

                        if not Throw then
                            return;
                        end;

                        local Sound = Instance.new("Sound");
                        Sound.SoundId = Throw;
                        Sound.Volume = 0.7;
                        Sound.PlaybackSpeed = v97 or 1;
                        Sound.RollOffMinDistance = 12;
                        Sound.RollOffMaxDistance = 150;
                        Sound.Parent = PlayerByUserId;
                        Sound:Play();
                        Debris:AddItem(Sound, 4);
                    end;
                end;
            end;

            return;
        end;

        if p95.strike then
            local Burst = u1.Burst;
            local v98 = spark(p95.position);

            if Burst then
                local Sound = Instance.new("Sound");
                Sound.SoundId = Burst;
                Sound.Volume = 0.35;
                Sound.PlaybackSpeed = 1.8;
                Sound.RollOffMinDistance = 12;
                Sound.RollOffMaxDistance = 150;
                Sound.Parent = v98;
                Sound:Play();
                Debris:AddItem(Sound, 4);
            end;
        else
            local v99 = burst(p95.position, math.min(p95.combo or 1, 64) / 32 + 1);
            local Burst = u1.Burst;

            if Burst then
                local Sound = Instance.new("Sound");
                Sound.SoundId = Burst;
                Sound.Volume = 1;
                Sound.PlaybackSpeed = 0.9;
                Sound.RollOffMinDistance = 12;
                Sound.RollOffMaxDistance = 150;
                Sound.Parent = v99;
                Sound:Play();
                Debris:AddItem(Sound, 4);
            end;
        end;

        if p95.shrine then
            flashShrine(p95.position);
        else
            flashKing(not p95.strike or (p95.combo or 1) >= 8);
        end;

        damageNumber(p95);

        return;
    end;

    local position = p95.position;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(position);
    Part.Parent = Folder;
    Debris:AddItem(Part, 3);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(170, 170, 178));
    ParticleEmitter.Size = NumberSequence.new(4, 10);
    ParticleEmitter.Transparency = NumberSequence.new(0.2, 1);
    ParticleEmitter.Lifetime = NumberRange.new(1, 1.6);
    ParticleEmitter.Speed = NumberRange.new(4, 12);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(40);
    local Burst = u1.Burst;

    if not Burst then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = Burst;
    Sound.Volume = 1;
    Sound.PlaybackSpeed = 0.45;
    Sound.RollOffMinDistance = 12;
    Sound.RollOffMaxDistance = 150;
    Sound.Parent = Part;
    Sound:Play();
    Debris:AddItem(Sound, 4);
end);

local function labelBomb(u100) -- Line: 659
    -- upvalues: Font_new_ret (copy)
    if u100.Name ~= "BossBomb" or u100:FindFirstChild("ComboLabel") then
        return;
    end;

    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "ComboLabel";
    BillboardGui.Size = UDim2.fromOffset(80, 30);
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0);
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 160;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 220, 90);
    TextLabel.TextStrokeTransparency = 0.2;
    TextLabel.Parent = BillboardGui;
    u100:GetAttributeChangedSignal("Combo"):Connect(function() -- Line: 677, Name: update
        -- upvalues: u100 (copy), BillboardGui (copy), TextLabel (copy)
        local v101 = u100:GetAttribute("Combo") or 1;
        BillboardGui.Enabled = v101 > 1;
        TextLabel.Text = "x" .. v101;
    end);
    local v102 = u100:GetAttribute("Combo") or 1;
    BillboardGui.Enabled = v102 > 1;
    TextLabel.Text = "x" .. v102;
    BillboardGui.Parent = u100;
end;

local function watchFight(p103) -- Line: 686
    -- upvalues: labelBomb (copy), shrineBar (copy)
    if p103.Name ~= "FallenKingFight" then
        return;
    end;

    for _, descendant in p103:GetDescendants() do
        labelBomb(descendant);
    end;

    p103.DescendantAdded:Connect(labelBomb);

    for _, child in p103:GetChildren() do
        task.spawn(shrineBar, child);
    end;

    p103.ChildAdded:Connect(function(p104) -- Line: 697
        -- upvalues: shrineBar (ref)
        task.spawn(shrineBar, p104);
    end);
end;

for _, child in workspace:GetChildren() do
    watchFight(child);
end;

workspace.ChildAdded:Connect(watchFight);

local function throw(p105, p106) -- Line: 707
    -- upvalues: FallenKingEvent (copy)
    if p106 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        FallenKingEvent:FireServer("Throw", workspace_CurrentCamera.CFrame.LookVector);
    end;

    return Enum.ContextActionResult.Sink;
end;

local UserInputService = game:GetService("UserInputService");
local Skin = require(ChickenOrHero:WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local EquipmentHudLayoutLegacy = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("EquipmentHudLayoutLegacy"));
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local u107 = nil;

local function cardColors(p108) -- Line: 728
    -- upvalues: Skin (copy)
    return ColorSequence.new({ ColorSequenceKeypoint.new(0, Skin.Palette.surface), ColorSequenceKeypoint.new(0.55, Skin.Palette.surface), ColorSequenceKeypoint.new(1, p108:Lerp(Color3.new(0, 0, 0), 0.4)) });
end;

local function makeCard() -- Line: 735
    -- upvalues: Panels (copy), LocalPlayer (copy), Color3_fromRGB_ret (copy), EquipmentHudLayoutLegacy (copy), cardColors (copy), Skin (copy), FallenKingEvent (copy), u107 (ref)
    local v109 = Panels.screen(LocalPlayer, "FallenKingBombCard", 63);
    local v110 = Panels.button(v109, "Throw", "", 0, 0, 226, 88, Panels.Ink);
    v110.AnchorPoint = Vector2.new(0.5, 1);
    v110.Position = UDim2.new(0.5, 0, 1, -110);
    v110.AutoButtonColor = false;
    v110.Visible = false;
    Panels.stroke(v110, Color3_fromRGB_ret, 0.25);
    v110.BackgroundColor3 = Color3.new(1, 1, 1);
    v110.BackgroundTransparency = 0.12;
    v110.Corner.CornerRadius = UDim.new(0, 12);
    local SkinStroke = v110:FindFirstChild("SkinStroke");

    if SkinStroke then
        SkinStroke.Enabled = false;
    end;

    EquipmentHudLayoutLegacy.register(v110, Panels.make("UIScale", v110, "Scale", {}), 0);
    Panels.make("UIGradient", v110, "Gradient", {
        Rotation = 25,
        Color = cardColors(Color3_fromRGB_ret)
    });
    local v111 = Panels.make("ImageLabel", v110, "Icon", {
        BackgroundTransparency = 1,
        Image = "rbxassetid://137429553653286",
        Position = UDim2.fromOffset(8, 7),
        Size = UDim2.fromOffset(66, 66),
        ScaleType = Enum.ScaleType.Fit
    });
    local v112 = Panels.text(v110, "Title", "PUMPKIN BOMB", 80, 11, 138, 35, 15, Panels.Paper);
    v112.Font = Enum.Font.GothamBold;
    local v113 = Panels.text(v110, "Hint", "", 81, 48, 137, 18, 11, Color3_fromRGB_ret);
    v113.Font = Enum.Font.GothamBold;
    local v114 = Panels.text(v110, "Combo", "", 8, 6, 48, 17, 11, Panels.Paper);
    v114.Font = Enum.Font.GothamBold;
    v114.TextStrokeTransparency = 0.3;
    local v115 = Panels.make("Frame", v110, "Track", {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(12, 77),
        Size = UDim2.fromOffset(202, 4),
        BackgroundColor3 = Skin.Palette.track
    });
    Panels.corner(v115, 4);
    local v116 = Panels.make("Frame", v115, "Fill", {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Color3_fromRGB_ret
    });
    Panels.corner(v116, 4);
    v110.Activated:Connect(function() -- Line: 776
        -- upvalues: FallenKingEvent (ref)
        if Enum.UserInputState.Begin ~= Enum.UserInputState.Begin then
            local _ = Enum.ContextActionResult.Pass;

            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            FallenKingEvent:FireServer("Throw", workspace_CurrentCamera.CFrame.LookVector);
        end;

        local _ = Enum.ContextActionResult.Sink;
    end);
    u107 = {
        button = v110,
        border = v110:FindFirstChild("Outline"),
        icon = v111,
        title = v112,
        how = v113,
        combo = v114,
        fill = v116
    };
end;

local function u117() -- Line: 782
    -- upvalues: u107 (ref), TweenService (copy)
    local button = u107.button;
    TweenService:Create(button, TweenInfo.new(0.08), {
        Rotation = -3
    }):Play();
    task.delay(0.08, function() -- Line: 785
        -- upvalues: button (copy), TweenService (ref)
        if button.Parent then
            TweenService:Create(button, TweenInfo.new(0.22, Enum.EasingStyle.Back), {
                Rotation = 0
            }):Play();
        end;
    end);
end;

local u118 = false;
game:GetService("RunService").Heartbeat:Connect(function() -- Line: 792
    -- upvalues: LocalPlayer (copy), UserInputService (copy), Session (copy), u107 (ref), makeCard (copy), EquipmentHudLayoutLegacy (copy), u118 (ref), u117 (copy)
    local Attribute = LocalPlayer:GetAttribute("BossBomb");
    local v119 = UserInputService.PreferredInput == Enum.PreferredInput.Touch;
    local v120;

    if Session:GetAttribute("BossActive") == true and (LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("CutsceneActive") == nil) then
        v120 = LocalPlayer:GetAttribute("RunState") ~= "Caught";
    else
        v120 = false;
    end;

    if v120 then
        v120 = Attribute ~= nil and true or not v119;
    end;

    if not u107 then
        if not v120 then
            return;
        end;

        makeCard();
    end;

    local v121;

    if v120 then
        v121 = Attribute ~= nil;
    else
        v121 = v120;
    end;

    if u107.button.Visible ~= v120 then
        u107.button.Visible = v120;
        EquipmentHudLayoutLegacy.update(LocalPlayer.PlayerGui);
    end;

    if not v120 then
        u118 = false;

        return;
    end;

    u107.how.Text = not v121 and "COLLECT A PUMPKIN" or (UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and "X" or (v119 and "TAP" or "E")) .. "  ·  THROW IT!";
    u107.combo.Text = (not v121 or Attribute <= 1) and "" or "×" .. Attribute;
    u107.fill.Size = UDim2.fromScale(v121 and 1 or 0, 1);
    local border = u107.border;
    local v122;

    if v121 then
        local v123 = os.clock() * 6;
        v122 = math.sin(v123) * 0.15 + 0.25;
    else
        v122 = 0.65;
    end;

    border.Transparency = v122;
    u107.title.TextTransparency = v121 and 0 or 0.3;
    u107.icon.ImageTransparency = v121 and 0 or 0.45;

    if v121 and not u118 then
        u117();
    end;

    u118 = v121;
end);
LocalPlayer:GetAttributeChangedSignal("BossBomb"):Connect(function() -- Line: 827, Name: refresh
    -- upvalues: LocalPlayer (copy), ContextActionService (copy), throw (copy)
    if LocalPlayer:GetAttribute("BossBomb") then
        ContextActionService:BindActionAtPriority("FallenKingThrow", throw, false, 3000, Enum.KeyCode.E, Enum.KeyCode.ButtonX);

        return;
    end;

    ContextActionService:UnbindAction("FallenKingThrow");
end);

if LocalPlayer:GetAttribute("BossBomb") then
    ContextActionService:BindActionAtPriority("FallenKingThrow", throw, false, 3000, Enum.KeyCode.E, Enum.KeyCode.ButtonX);
else
    ContextActionService:UnbindAction("FallenKingThrow");
end;

local RunService = game:GetService("RunService");
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 214, 92);
local u124 = false;
local u125 = nil;
local u126 = nil;
local u127 = (-1 / 0);

local function hideGuide() -- Line: 854
    -- upvalues: u125 (ref)
    if u125 then
        u125.folder:Destroy();
        u125 = nil;
    end;
end;

local function freeBomb(p128, p129) -- Line: 863
    local v130;

    if p128.Parent == p129 and p128.Name == "BossBomb" then
        v130 = p128:IsA("BasePart") and p128.Anchored and p128:GetAttribute("Combo") == nil;
    else
        v130 = false;
    end;

    return v130;
end;

local function nearestBomb(p131, p132) -- Line: 872
    -- upvalues: u125 (ref)
    local v133 = (1 / 0);
    local v134 = nil;

    for _, child in p131:GetChildren() do
        local v135;

        if child.Parent == p131 and child.Name == "BossBomb" then
            v135 = child:IsA("BasePart") and child.Anchored and child:GetAttribute("Combo") == nil;
        else
            v135 = false;
        end;

        if v135 then
            local Magnitude = (child.Position - p132).Magnitude;

            if Magnitude < v133 then
                v134 = child;
                v133 = Magnitude;
            end;
        end;
    end;

    local v136 = u125 and u125.target;

    if v134 and (v136 and v136 ~= v134) then
        local v137;

        if v136.Parent == p131 and v136.Name == "BossBomb" then
            v137 = v136:IsA("BasePart") and v136.Anchored and v136:GetAttribute("Combo") == nil;
        else
            v137 = false;
        end;

        if v137 and (v136.Position - p132).Magnitude - v133 < 4 then
            return v136;
        end;
    end;

    return v134;
end;

local function showGuide(p138, p139) -- Line: 891
    -- upvalues: u125 (ref), Color3_fromRGB_ret4 (copy), Folder (copy)
    if not u125 then
        local Folder2 = Instance.new("Folder");
        Folder2.Name = "PumpkinGuide";
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Transparency = 1;
        Part.Name = "Host";
        Part.Size = Vector3.new(0.2, 0.2, 0.2);
        Part.Parent = Folder2;
        local Attachment = Instance.new("Attachment");
        Attachment.Name = "From";
        Attachment.Position = Vector3.new(0, -2.6, 0);
        Attachment.Parent = Part;
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Name = "To";
        Attachment2.Parent = Part;
        local Beam = Instance.new("Beam");
        Beam.Name = "Guide";
        Beam.Attachment0 = Attachment;
        Beam.Attachment1 = Attachment2;
        Beam.Color = ColorSequence.new(Color3_fromRGB_ret4);
        Beam.LightEmission = 0;
        Beam.LightInfluence = 0;
        Beam.Width0 = 3.2;
        Beam.Width1 = 3.2;
        Beam.FaceCamera = true;
        Beam.Segments = 1;
        Beam.Texture = "rbxassetid://129313102318934";
        Beam.TextureMode = Enum.TextureMode.Wrap;
        Beam.TextureLength = 3.2;
        Beam.TextureSpeed = 1.6;
        Beam.Transparency = NumberSequence.new(0);
        Beam.Parent = Part;
        Folder2.Parent = Folder;
        u125 = {
            folder = Folder2,
            host = Part,
            to = Attachment2
        };
    end;

    u125.target = p139;
    u125.host.CFrame = CFrame.new(p138.Position);
    u125.to.WorldPosition = p139.Position;
end;

local function guideFrame() -- Line: 933
    -- upvalues: LocalPlayer (copy), u124 (ref), Session (copy), nearestBomb (copy), showGuide (copy), u125 (ref)
    if LocalPlayer:GetAttribute("BossBomb") ~= nil then
        u124 = true;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local FallenKingFight = workspace:FindFirstChild("FallenKingFight");
    local v140 = not u124;

    if v140 then
        if Character then
            if FallenKingFight then
                if Session:GetAttribute("BossActive") == true and (LocalPlayer:GetAttribute("InMatch") == true and (LocalPlayer:GetAttribute("CutsceneActive") == nil and LocalPlayer:GetAttribute("RunState") ~= "Caught")) then
                    FallenKingFight = nearestBomb(FallenKingFight, Character.Position);
                else
                    FallenKingFight = false;
                end;
            end;
        else
            FallenKingFight = Character;
        end;
    else
        FallenKingFight = v140;
    end;

    if FallenKingFight then
        showGuide(Character, FallenKingFight);

        return;
    end;

    if u125 then
        u125.folder:Destroy();
        u125 = nil;
    end;
end;

local function guideOn() -- Line: 956
    -- upvalues: u124 (ref), Session (copy), u126 (ref), RunService (copy), guideFrame (copy), u125 (ref), u127 (ref)
    local v141 = not u124 and Session:GetAttribute("BossActive") == true;

    if v141 and not u126 then
        u126 = RunService.RenderStepped:Connect(function() -- Line: 959
            -- upvalues: guideFrame (ref), u125 (ref), u127 (ref)
            local success, result = pcall(guideFrame);

            if not success then
                if u125 then
                    u125.folder:Destroy();
                    u125 = nil;
                end;

                if os.clock() - u127 > 5 then
                    u127 = os.clock();
                    warn("[FallenKingBombClient] the pumpkin guide failed:", result);
                end;
            end;
        end);
    elseif not v141 and u126 then
        u126:Disconnect();
        u126 = nil;
    end;

    if not v141 and u125 then
        u125.folder:Destroy();
        u125 = nil;
    end;
end;

Session:GetAttributeChangedSignal("BossActive"):Connect(guideOn);
LocalPlayer:GetAttributeChangedSignal("BossBomb"):Connect(function() -- Line: 979
    -- upvalues: LocalPlayer (copy), u124 (ref), guideOn (copy)
    if LocalPlayer:GetAttribute("BossBomb") ~= nil then
        u124 = true;
        guideOn();
    end;
end);
LocalPlayer.CharacterAdded:Connect(hideGuide);
LocalPlayer.CharacterRemoving:Connect(hideGuide);
script.Destroying:Connect(function() -- Line: 988
    -- upvalues: u124 (ref), guideOn (copy)
    u124 = true;
    guideOn();
end);
guideOn();