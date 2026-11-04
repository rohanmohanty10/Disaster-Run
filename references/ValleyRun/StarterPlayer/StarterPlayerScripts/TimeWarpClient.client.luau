 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local GearEvent = ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearEvent");
local CharacterClone = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("CharacterClone"));
local Color3_fromRGB_ret = Color3.fromRGB(120, 210, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(170, 110, 255);
local Folder = Instance.new("Folder");
Folder.Name = "TimeWarpFX";
Folder.Parent = workspace;
local u1 = {};

local function fade(u2, u3, p4) -- Line: 24
    -- upvalues: TweenService (copy)
    task.delay(p4 or 0, function() -- Line: 25
        -- upvalues: u2 (copy), TweenService (ref), u3 (copy)
        for _, v in u2 do
            if v.Parent then
                if v:IsA("BasePart") then
                    TweenService:Create(v, TweenInfo.new(u3), {
                        Transparency = 1
                    }):Play();
                elseif v:IsA("Highlight") then
                    TweenService:Create(v, TweenInfo.new(u3), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    }):Play();
                end;
            end;
        end;

        task.wait(u3 + 0.05);

        for _, v in u2 do
            v:Destroy();
        end;
    end);
end;

local function part(p5, p6, p7) -- Line: 42
    -- upvalues: Folder (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.Neon;
    Part.Size = p5;
    Part.CFrame = p6;
    Part.Color = p7;
    Part.Transparency = 1;
    Part.Parent = Folder;

    return Part;
end;

local function trail(p8) -- Line: 55
    -- upvalues: Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), Folder (copy), TweenService (copy)
    local v9 = #p8;
    local v10 = {};

    for i = 1, v9 - 1 do
        local v11 = p8[i] - Vector3.new(0, 2.9, 0);
        local v12 = p8[i + 1] - Vector3.new(0, 2.9, 0);
        local Magnitude = (v12 - v11).Magnitude;
        local v13;

        if Magnitude > 0.05 then
            local v14 = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret, i / v9);
            local Vector3_new_ret = Vector3.new(0.5, 0.12, Magnitude + 0.3);
            local CFrame_lookAt_ret = CFrame.lookAt((v11 + v12) / 2, v12);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Material = Enum.Material.Neon;
            Part.Size = Vector3_new_ret;
            Part.CFrame = CFrame_lookAt_ret;
            Part.Color = v14;
            Part.Transparency = 1;
            Part.Parent = Folder;
            table.insert(v10, Part);
            TweenService:Create(Part, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, (v9 - i) / v9 * 0.25), {
                Transparency = 0.15
            }):Play();
            v13 = i;
        else
            v13 = i;
        end;
    end;

    return v10;
end;

local function ghost(p15, p16) -- Line: 73
    -- upvalues: CharacterClone (copy), Color3_fromRGB_ret (copy), Folder (copy)
    local v17;

    if p15 then
        v17 = select(1, CharacterClone.copy(p15));
    else
        v17 = p15;
    end;

    if not v17 then
        return nil;
    end;

    for _, descendant in v17:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.CastShadow = false;
            descendant.Material = Enum.Material.ForceField;
            descendant.Color = Color3_fromRGB_ret;
            descendant.Transparency = descendant.Name == "HumanoidRootPart" and 1 or 0.05;
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            descendant:Destroy();
        end;
    end;

    local HumanoidRootPart = v17:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        v17.PrimaryPart = HumanoidRootPart;
        v17:PivotTo(CFrame.new(p16) * p15:GetPivot().Rotation);
    end;

    v17.Name = "TimeWarpGhost";
    v17.Parent = Folder;

    return v17;
end;

local function burst(p18, p19) -- Line: 98
    -- upvalues: Folder (copy), TweenService (copy)
    local CFrame_new_ret = CFrame.new(p18);
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.Neon;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame_new_ret;
    Part.Color = p19;
    Part.Transparency = 1;
    Part.Parent = Folder;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(p19, Color3.new(1, 1, 1));
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Transparency = NumberSequence.new(0, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 0.8);
    ParticleEmitter.Speed = NumberRange.new(8, 16);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(40);
    local v20 = CFrame.new(p18 - Vector3.new(0, 2.8, 0)) * CFrame.Angles(0, 0, 1.5707963267948966);
    local Part2 = Instance.new("Part");
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;
    Part2.Material = Enum.Material.Neon;
    Part2.Size = Vector3.new(0.2, 1, 1);
    Part2.CFrame = v20;
    Part2.Color = p19;
    Part2.Transparency = 1;
    Part2.Parent = Folder;
    Part2.Shape = Enum.PartType.Cylinder;
    Part2.Transparency = 0.2;
    TweenService:Create(Part2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.2, 12, 12),
        Transparency = 1
    }):Play();
    task.delay(1, function() -- Line: 117
        -- upvalues: Part (copy), Part2 (copy)
        Part:Destroy();
        Part2:Destroy();
    end);
end;

local function tint(p21) -- Line: 124
    -- upvalues: Lighting (copy), TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "TimeWarpTint";
    ColorCorrectionEffect.TintColor = Color3.fromRGB(190, 220, 255);
    ColorCorrectionEffect.Saturation = -0.5;
    ColorCorrectionEffect.Parent = Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(p21), {
        Saturation = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    task.delay(p21 + 0.05, function() -- Line: 131
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect:Destroy();
    end);
end;

local function begin(p22) -- Line: 136
    -- upvalues: u1 (copy), TweenService (copy), trail (copy), ghost (copy), Color3_fromRGB_ret (copy), Folder (copy), LocalPlayer (copy), tint (copy)
    local character = p22.character;

    if typeof(character) ~= "Instance" or (type(p22.trail) ~= "table" or typeof(p22.destination) ~= "Vector3") then
        return;
    end;

    local actorId = p22.actorId;
    local v23 = u1[actorId];

    if v23 then
        local objects = v23.objects;
        local u24 = 0.2;
        task.delay(0, function() -- Line: 25
            -- upvalues: objects (copy), TweenService (ref), u24 (copy)
            for _, v in objects do
                if v.Parent then
                    if v:IsA("BasePart") then
                        TweenService:Create(v, TweenInfo.new(u24), {
                            Transparency = 1
                        }):Play();
                    elseif v:IsA("Highlight") then
                        TweenService:Create(v, TweenInfo.new(u24), {
                            FillTransparency = 1,
                            OutlineTransparency = 1
                        }):Play();
                    end;
                end;
            end;

            task.wait(u24 + 0.05);

            for _, v in objects do
                v:Destroy();
            end;
        end);
    end;

    local u25 = trail(p22.trail);
    local v26 = ghost(character, p22.destination);

    if v26 then
        table.insert(u25, v26);

        for _, descendant in v26:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                table.insert(u25, descendant);
            end;
        end;
    end;

    local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local Sound = Instance.new("Sound");
        Sound.Name = "TimeWarpSound";
        Sound.SoundId = "rbxassetid://75931884914551";
        Sound.Volume = 0.8;
        Sound.RollOffMinDistance = 10;
        Sound.RollOffMaxDistance = 90;
        Sound.Parent = HumanoidRootPart;
        Sound.Ended:Once(function() -- Line: 166
            -- upvalues: Sound (copy)
            Sound:Destroy();
        end);
        task.delay(3, function() -- Line: 169
            -- upvalues: Sound (copy)
            if Sound.Parent then
                Sound:Destroy();
            end;
        end);
        Sound:Play();
    end;

    local Highlight = Instance.new("Highlight");
    local Color3_new_ret = Color3.new(1, 1, 1);
    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.OutlineColor = Color3_new_ret;
    Highlight.FillTransparency = 0.4;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Adornee = character;
    Highlight.Parent = Folder;
    table.insert(u25, Highlight);
    TweenService:Create(Highlight, TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        FillTransparency = 0.8
    }):Play();
    u1[actorId] = {
        objects = u25,
        glow = Highlight
    };

    if actorId == LocalPlayer.UserId then
        tint((tonumber(p22.windup) or 0.35) + 1.1);
    end;

    task.delay((tonumber(p22.windup) or 0.35) + 2.5, function() -- Line: 189
        -- upvalues: u1 (ref), actorId (copy), u25 (copy), TweenService (ref)
        if u1[actorId] and u1[actorId].objects == u25 then
            u1[actorId] = nil;
            local u27 = u25;
            local u28 = 0.3;
            task.delay(0, function() -- Line: 25
                -- upvalues: u27 (copy), TweenService (ref), u28 (copy)
                for _, v in u27 do
                    if v.Parent then
                        if v:IsA("BasePart") then
                            TweenService:Create(v, TweenInfo.new(u28), {
                                Transparency = 1
                            }):Play();
                        elseif v:IsA("Highlight") then
                            TweenService:Create(v, TweenInfo.new(u28), {
                                FillTransparency = 1,
                                OutlineTransparency = 1
                            }):Play();
                        end;
                    end;
                end;

                task.wait(u28 + 0.05);

                for _, v in u27 do
                    v:Destroy();
                end;
            end);
        end;
    end);
end;

local function arrive(p29) -- Line: 197
    -- upvalues: u1 (copy), burst (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), TweenService (copy)
    local actorId = p29.actorId;
    local v30 = u1[actorId];

    if typeof(p29.from) == "Vector3" then
        burst(p29.from, Color3_fromRGB_ret2);
    end;

    if typeof(p29.position) == "Vector3" then
        burst(p29.position, Color3_fromRGB_ret);
    end;

    if v30 then
        u1[actorId] = nil;
        v30.glow:Destroy();
        local objects = v30.objects;
        local u31 = 0.6;
        task.delay(0.1, function() -- Line: 25
            -- upvalues: objects (copy), TweenService (ref), u31 (copy)
            for _, v in objects do
                if v.Parent then
                    if v:IsA("BasePart") then
                        TweenService:Create(v, TweenInfo.new(u31), {
                            Transparency = 1
                        }):Play();
                    elseif v:IsA("Highlight") then
                        TweenService:Create(v, TweenInfo.new(u31), {
                            FillTransparency = 1,
                            OutlineTransparency = 1
                        }):Play();
                    end;
                end;
            end;

            task.wait(u31 + 0.05);

            for _, v in objects do
                v:Destroy();
            end;
        end);
    end;
end;

GearEvent.OnClientEvent:Connect(function(p32, p33) -- Line: 213
    -- upvalues: begin (copy), arrive (copy)
    if p32 ~= "FX" or type(p33) ~= "table" then
        return;
    end;

    if p33.kind == "TimeWarp" then
        begin(p33);

        return;
    end;

    if p33.kind == "TimeWarpArrive" then
        arrive(p33);
    end;
end);