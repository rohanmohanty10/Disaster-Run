 

 

local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local LocalHide = require(script.Parent:WaitForChild("LocalHide"));
local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(255, 140, 40);

local function sound(p2, p3, p4, p5, p6) -- Line: 30
    -- upvalues: Debris (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = p2;
    Sound.PlaybackSpeed = p4 or 1;
    Sound.Volume = p5 or 0.6;
    Sound.Looped = p6 == true;
    Sound.RollOffMaxDistance = 90;
    Sound.Parent = p3;
    Sound:Play();

    if not Sound.Looped then
        Debris:AddItem(Sound, 4);
    end;

    return Sound;
end;

local function puff(p7, p8, p9) -- Line: 44
    -- upvalues: Color3_fromRGB_ret (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p7);
    Part.Parent = workspace;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret, Color3.fromRGB(120, 70, 30));
    ParticleEmitter.Size = NumberSequence.new(1.6 * p8, 3.4 * p8);
    ParticleEmitter.Transparency = NumberSequence.new(0.2, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1);
    ParticleEmitter.Speed = NumberRange.new(3 * p8, 7 * p8);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 3;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(16);
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter2.Color = ColorSequence.new(p9);
    ParticleEmitter2.LightEmission = 0.7;
    ParticleEmitter2.Size = NumberSequence.new(0.35 * p8, 0);
    ParticleEmitter2.Lifetime = NumberRange.new(0.4, 0.8);
    ParticleEmitter2.Speed = NumberRange.new(8 * p8, 14 * p8);
    ParticleEmitter2.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter2.Acceleration = Vector3.new(0, -20 * p8, 0);
    ParticleEmitter2.Rate = 0;
    ParticleEmitter2.Parent = Part;
    ParticleEmitter2:Emit(18);
    Debris:AddItem(Part, 1.5);
end;

local function way(p10, p11, p12, p13) -- Line: 79
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = p13;
    RaycastParams_new_ret.RespectCanCollide = true;
    local v14 = math.random() * 3.141592653589793 * 2;
    local v15 = {};
    local v16 = -1;
    local v17 = nil;

    for i = 0, 7 do
        local v18 = v14 + i * 3.141592653589793 / 4;
        local math_cos_ret = math.cos(v18);
        local math_sin_ret = math.sin(v18);
        local Vector3_new_ret = Vector3.new(math_cos_ret, 0, math_sin_ret);
        local v19 = workspace:Spherecast(p10, p11 * 0.8, Vector3_new_ret * p12, RaycastParams_new_ret);
        local v20;

        if v19 then
            v20 = v19.Distance;
        else
            v20 = p12;
        end;

        if p12 <= v20 then
            table.insert(v15, Vector3_new_ret);
        end;

        local v21;

        if v16 < v20 then
            v17 = Vector3_new_ret;
            v16 = v20;
            v21 = i;
        else
            v21 = i;
        end;
    end;

    if #v15 > 0 then
        return v15[math.random(#v15)], p12;
    end;

    return v17, math.max(0, v16 - p11 * 0.5);
end;

function v1.play(u22, u23, p24) -- Line: 104
    -- upvalues: way (copy), LocalHide (copy), puff (copy), Debris (copy), TweenService (copy), RunService (copy)
    local u25 = p24 or {};
    local u26 = u25.scale or 1;
    local u27 = u22:FindFirstChild("Torso") or (u22:FindFirstChild("UpperTorso") or u22:FindFirstChild("HumanoidRootPart"));
    local PumpkinHuntAssets = game:GetService("ReplicatedStorage"):FindFirstChild("PumpkinHuntAssets");
    local v28 = PumpkinHuntAssets and PumpkinHuntAssets:FindFirstChild("Pumpkin");

    if not (u27 and (u27:IsA("BasePart") and v28)) then
        return false;
    end;

    local v29 = v28:Clone();

    for _, descendant in v29:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") or descendant:IsA("Sound") then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.CastShadow = true;
        end;
    end;

    local u30;

    if v29:IsA("Model") then
        u30 = v29;
    else
        u30 = Instance.new("Model");
        v29.Parent = u30;
    end;

    local _, v31 = u30:GetBoundingBox();
    local u32 = u30:GetScale() * 3.2 * u26 / math.max(v31.X, v31.Y, v31.Z);
    local u33 = 3.2 * u26 / 2;
    u30.Name = "PumpkinRoll";
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { u22, u30 };
    RaycastParams_new_ret.RespectCanCollide = true;
    local Position = u27.Position;
    local v34 = workspace:Raycast(Position + Vector3.new(0, 1, 0), Vector3.new(-0, -12, -0), RaycastParams_new_ret);
    local v35;

    if v34 then
        v35 = v34.Position.Y;
    else
        v35 = Position.Y - 1.5 * u26;
    end;

    local Vector3_new_ret = Vector3.new(Position.X, v35 + u33, Position.Z);
    local u36, u37 = way(Vector3_new_ret, u33, 16 * u26, { u22, u30 });
    local v38 = (Vector3.new(0, 1, 0)):Cross(u36);
    local u39 = v38.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or v38.Unit;
    local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), u36);
    local u40 = u22:GetAttribute("BotUserId") ~= nil;

    if u40 then
        u22:SetAttribute("KillEffectHidden", true);
    end;

    local u41 = LocalHide.new();
    u41:model(u22);
    local v42 = u22 == game:GetService("Players").LocalPlayer.Character and workspace:FindFirstChild("FallenKingLocal");

    if v42 then
        v42 = v42:FindFirstChild("Lantern");
    end;

    if v42 then
        u41:model(v42);
    end;

    puff(Position, u26, u23);
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://9113511790";
    Sound.PlaybackSpeed = 0.9;
    Sound.Volume = 0.7;
    Sound.Looped = false;
    Sound.RollOffMaxDistance = 90;
    Sound.Parent = u27;
    Sound:Play();

    if not Sound.Looped then
        Debris:AddItem(Sound, 4);
    end;

    u30:ScaleTo(u32 * 0.2);
    u30:PivotTo(CFrame.new(Position) * CFrame_lookAt_ret);
    u30.Parent = u25.parent or workspace;
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = u23;
    Highlight.OutlineColor = u23;
    Highlight.FillTransparency = 0.25;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = u30;
    task.delay(0.5, function() -- Line: 169
        -- upvalues: Highlight (copy), TweenService (ref)
        if Highlight.Parent then
            TweenService:Create(Highlight, TweenInfo.new(0.6), {
                FillTransparency = 1,
                OutlineTransparency = 0.6
            }):Play();
        end;
    end);
    local u43 = nil;
    local os_clock_ret = os.clock();
    local u44 = nil;

    local function finish(p45) -- Line: 177
        -- upvalues: u44 (ref), u43 (ref), u30 (ref), puff (ref), u26 (copy), u23 (copy), Debris (ref), u41 (copy), u40 (copy), u22 (copy), u27 (copy), u25 (ref)
        if u44 then
            u44:Disconnect();
            u44 = nil;
        end;

        if u43 then
            u43:Destroy();
            u43 = nil;
        end;

        if p45 and u30.Parent then
            local Position2 = u30:GetPivot().Position;
            puff(Position2, u26, u23);
            local Attachment = Instance.new("Attachment");
            Attachment.WorldPosition = Position2;
            Attachment.Parent = workspace.Terrain;
            local Sound2 = Instance.new("Sound");
            Sound2.SoundId = "rbxassetid://9113263649";
            Sound2.PlaybackSpeed = 0.8;
            Sound2.Volume = 0.7;
            Sound2.Looped = false;
            Sound2.RollOffMaxDistance = 90;
            Sound2.Parent = Attachment;
            Sound2:Play();

            if not Sound2.Looped then
                Debris:AddItem(Sound2, 4);
            end;

            Debris:AddItem(Attachment, 4);
        end;

        u30:Destroy();
        u41:restore();

        if u40 then
            u22:SetAttribute("KillEffectHidden", nil);
        end;

        if u22.Parent and u27.Parent then
            puff(u27.Position, u26 * 0.6, u23);
        end;

        if u25.onDone then
            task.spawn(u25.onDone);
        end;
    end;

    u44 = RunService.RenderStepped:Connect(function() -- Line: 208
        -- upvalues: os_clock_ret (copy), u22 (copy), u30 (ref), finish (copy), u25 (ref), u32 (copy), Position (copy), CFrame_lookAt_ret (copy), Vector3_new_ret (copy), u43 (ref), Debris (ref), u37 (copy), u26 (copy), u36 (copy), u39 (ref), u33 (copy)
        local v46 = os.clock() - os_clock_ret;

        if not (u22.Parent and (u30.Parent and v46 < 2.67)) then
            finish(true);

            return;
        end;

        if u25.cancel and u25.cancel() then
            finish(true);

            return;
        end;

        local v47;

        if v46 < 0.22 then
            local v48 = v46 / 0.22;
            u30:ScaleTo(u32 * math.max(0.2, 0.2 + 0.8 * (1 + 2.2 * (v48 - 1) ^ 3 + 1.2 * (v48 - 1) ^ 2)));
            v47 = CFrame.new(Position) * CFrame_lookAt_ret;
        elseif v46 < 0.42000000000000004 then
            u30:ScaleTo(u32);
            local v49 = (v46 - 0.22) / 0.2;
            v47 = CFrame.new(Position:Lerp(Vector3_new_ret, v49 * v49)) * CFrame_lookAt_ret;
        else
            if not u43 then
                local v50 = u30.PrimaryPart or u30:FindFirstChildWhichIsA("BasePart");
                local Sound2 = Instance.new("Sound");
                Sound2.SoundId = "rbxassetid://9125881620";
                Sound2.PlaybackSpeed = 1.3;
                Sound2.Volume = 0.35;
                Sound2.Looped = true;
                Sound2.RollOffMaxDistance = 90;
                Sound2.Parent = v50;
                Sound2:Play();

                if not Sound2.Looped then
                    Debris:AddItem(Sound2, 4);
                end;

                u43 = Sound2;
            end;

            local math_min_ret = math.min(1, (v46 - 0.22 - 0.2) / 2.1);
            local v51 = 1 - (1 - math_min_ret) ^ 2;
            local v52 = u37 * v51;
            local math_sin_ret = math.sin(v51 * 3.141592653589793 * 3);
            local v53 = math.abs(math_sin_ret) * 0.6 * u26 * (1 - math_min_ret);
            v47 = CFrame.new(Vector3_new_ret + u36 * v52 + Vector3.new(0, 1, 0) * v53) * CFrame.fromAxisAngle(u39, v52 / u33) * CFrame_lookAt_ret;

            if u43 then
                u43.Volume = (1 - math_min_ret) * 0.35;
            end;
        end;

        u30:PivotTo(v47);
    end);

    return true;
end;

return v1;