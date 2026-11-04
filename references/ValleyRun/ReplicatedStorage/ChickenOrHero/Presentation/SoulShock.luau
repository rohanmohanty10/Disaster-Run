 

 

local RunService = game:GetService("RunService");
local PhysicsService = game:GetService("PhysicsService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local LocalHide = require(script.Parent:WaitForChild("LocalHide"));
local v1 = {};
local u2 = {
    Freeze = "rbxassetid://9125611419",
    Shatter = { "rbxassetid://9114855870", "rbxassetid://9114856215" }
};
local Color3_fromRGB_ret = Color3.fromRGB(45, 170, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(205, 240, 255);
local u3 = {
    Head = { "Head", 4 },
    Torso = { "Torso", 8 },
    ["Left Arm"] = { "LeftArm", 4 },
    ["Right Arm"] = { "RightArm", 4 },
    ["Left Leg"] = { "LeftLeg", 4 },
    ["Right Leg"] = { "RightLeg", 4 }
};
local success, result = pcall(PhysicsService.IsCollisionGroupRegistered, PhysicsService, "CoHRagdoll");
local u4 = success and result and "CoHRagdoll" or "Default";
local Ice = script:WaitForChild("Ice");

local function sound(p5, p6, p7, p8) -- Line: 48
    -- upvalues: Debris (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = p5;
    Sound.PlaybackSpeed = p7 or 1;
    Sound.Volume = p8 or 0.6;
    Sound.RollOffMinDistance = 8;
    Sound.RollOffMaxDistance = 90;
    Sound.Parent = p6;
    Sound:Play();
    Debris:AddItem(Sound, 4);

    return Sound;
end;

local function bare(p9) -- Line: 61
    -- upvalues: u4 (copy)
    p9.Anchored = true;
    p9.CanCollide = false;
    p9.CanQuery = false;
    p9.CanTouch = false;
    p9.Massless = false;
    p9.CastShadow = false;
    p9.CollisionGroup = u4;
end;

local function frost(p10, p11, p12, p13) -- Line: 68
    -- upvalues: u4 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Massless = false;
    Part.CastShadow = false;
    Part.CollisionGroup = u4;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p10);
    Part.Parent = workspace;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret2, Color3_fromRGB_ret);
    ParticleEmitter.Size = NumberSequence.new(1.2 * p11, 3 * p11);
    ParticleEmitter.Transparency = NumberSequence.new(0.35, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.9);
    ParticleEmitter.Speed = NumberRange.new(3 * p11, 7 * p11);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 3;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(p13);
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter2.Color = ColorSequence.new(Color3_fromRGB_ret2, p12);
    ParticleEmitter2.LightEmission = 0.8;
    ParticleEmitter2.Size = NumberSequence.new(0.45 * p11, 0);
    ParticleEmitter2.Lifetime = NumberRange.new(0.35, 0.7);
    ParticleEmitter2.Speed = NumberRange.new(8 * p11, 14 * p11);
    ParticleEmitter2.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter2.Acceleration = Vector3.new(0, -18 * p11, 0);
    ParticleEmitter2.Rate = 0;
    ParticleEmitter2.Parent = Part;
    ParticleEmitter2:Emit(p13);
    Debris:AddItem(Part, 1.5);
end;

local function soul(p14, p15, p16, p17) -- Line: 103
    -- upvalues: u4 (copy), Color3_fromRGB_ret2 (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Massless = false;
    Part.CastShadow = false;
    Part.CollisionGroup = u4;
    Part.Name = "Soul";
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = p14;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = p16;
    PointLight.Range = 6 * p15;
    PointLight.Brightness = 2;
    PointLight.Parent = Part;
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Size = UDim2.fromScale(0, 0);
    BillboardGui.LightInfluence = 0;
    BillboardGui.Brightness = 4;
    BillboardGui.Parent = Part;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(0.8, 0.8);
    ImageLabel.Image = "rbxassetid://118963012206090";
    ImageLabel.ImageColor3 = p16:Lerp(Color3_fromRGB_ret2, 0.35);
    ImageLabel.Parent = BillboardGui;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel2.Size = UDim2.fromScale(1, 1);
    ImageLabel2.Image = "rbxasset://textures/particles/sparkles_main.dds";
    ImageLabel2.ImageColor3 = Color3_fromRGB_ret2;
    ImageLabel2.Parent = BillboardGui;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.new(1, 1, 1), p16);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Brightness = 3;
    ParticleEmitter.LockedToPart = true;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 2.2 * p15), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.35, 0.5);
    ParticleEmitter.Rate = 14;
    ParticleEmitter.Speed = NumberRange.new(0);
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-90, 90);
    ParticleEmitter.ZOffset = 1;
    ParticleEmitter.Parent = Part;
    Part.Parent = p17;

    return {
        part = Part,
        board = BillboardGui,
        ghost = ImageLabel,
        flare = ImageLabel2,
        light = PointLight,
        stars = ParticleEmitter,
        size = 3 * p15
    };
end;

local function shatter(p18, p19, p20, p21) -- Line: 160
    -- upvalues: u4 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    local v22 = {};

    for _, v in p18 do
        local part = v.part;
        local Size = part.Size;

        for i = 1, v.shards do
            local Instance_new_ret = Instance.new(math.random() < 0.5 and "WedgePart" or "Part");
            Instance_new_ret.Anchored = true;
            Instance_new_ret.CanCollide = false;
            Instance_new_ret.CanQuery = false;
            Instance_new_ret.CanTouch = false;
            Instance_new_ret.Massless = false;
            Instance_new_ret.CastShadow = false;
            Instance_new_ret.CollisionGroup = u4;
            Instance_new_ret.Material = Enum.Material.SmoothPlastic;
            Instance_new_ret.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, math.random() * 0.45);
            Instance_new_ret.Transparency = 0.1;
            Instance_new_ret.Reflectance = 0.15;
            local v23 = Size.X * (0.25 + math.random() * 0.25);
            local v24 = Size.Y * (0.18 + math.random() * 0.2);
            local v25 = Size.Z * (0.25 + math.random() * 0.25);
            Instance_new_ret.Size = Vector3.new(v23, v24, v25);
            local v26 = (math.random() - 0.5) * Size.X * 0.6;
            local v27 = (math.random() - 0.5) * Size.Y * 0.6;
            local v28 = (math.random() - 0.5) * Size.Z * 0.6;
            local Vector3_new_ret = Vector3.new(v26, v27, v28);
            Instance_new_ret.CFrame = part.CFrame * CFrame.new(Vector3_new_ret) * CFrame.Angles(math.random() * 3.141592653589793, math.random() * 3.141592653589793, math.random() * 3.141592653589793);
            Instance_new_ret.Anchored = false;
            Instance_new_ret.CanCollide = true;
            local v29 = Instance_new_ret.Position - p19;
            local v30 = (v29.Magnitude <= 0.001 and Vector3.new(0, 1, 0) or v29.Unit) * (8 + math.random() * 8) * p20;
            local v31 = (6 + math.random() * 6) * p20;
            Instance_new_ret.AssemblyLinearVelocity = v30 + Vector3.new(0, v31, 0);
            local math_random_ret = math.random(-12, 12);
            local math_random_ret2 = math.random(-12, 12);
            Instance_new_ret.AssemblyAngularVelocity = Vector3.new(math_random_ret, math_random_ret2, math.random(-12, 12));
            Instance_new_ret.Parent = p21;
            table.insert(v22, Instance_new_ret);
            local _ = i;
        end;

        part:Destroy();
    end;

    return v22;
end;

function v1.play(u32, u33, p34) -- Line: 199
    -- upvalues: u3 (copy), Ice (copy), u4 (copy), Color3_fromRGB_ret2 (copy), TweenService (copy), Color3_fromRGB_ret (copy), LocalHide (copy), soul (copy), frost (copy), u2 (copy), Debris (copy), RunService (copy), shatter (copy)
    local u35 = p34 or {};
    local Torso = u32:FindFirstChild("Torso");

    if not (Torso and Torso:IsA("BasePart")) then
        return false;
    end;

    local u36 = Torso.Size.Y / 2;
    local Model = Instance.new("Model");
    Model.Name = "SoulShock";
    local u37 = {};

    for i, v in u3 do
        local v38 = u32:FindFirstChild(i);
        local v39 = Ice:FindFirstChild(v[1]);

        if v38 and (v38:IsA("BasePart") and v39) then
            local v40 = v39:Clone();
            v40.Anchored = true;
            v40.CanCollide = false;
            v40.CanQuery = false;
            v40.CanTouch = false;
            v40.Massless = false;
            v40.CastShadow = false;
            v40.CollisionGroup = u4;
            v40.Material = Enum.Material.SmoothPlastic;
            v40.Color = Color3_fromRGB_ret2;
            v40.Transparency = 0;
            v40.Reflectance = 0.15;
            local v41;

            if i == "Head" then
                v41 = Vector3.new(1.25, 1.25, 1.25) * u36;
            else
                v41 = v38.Size * 1.04;
            end;

            v40.Size = v41;
            v40.CFrame = v38.CFrame;
            v40.Parent = Model;
            TweenService:Create(v40, TweenInfo.new(0.15), {
                Color = Color3_fromRGB_ret
            }):Play();
            table.insert(u37, {
                part = v40,
                base = v40.CFrame,
                shards = v[2]
            });
        end;
    end;

    if #u37 == 0 then
        Model:Destroy();

        return false;
    end;

    local u42 = u32:GetAttribute("BotUserId") ~= nil;

    if u42 then
        u32:SetAttribute("KillEffectHidden", true);
    end;

    local u43 = LocalHide.new();
    u43:model(u32);
    local v44 = u32 == game:GetService("Players").LocalPlayer.Character and workspace:FindFirstChild("FallenKingLocal");

    if v44 then
        v44 = v44:FindFirstChild("Lantern");
    end;

    if v44 then
        u43:model(v44);
    end;

    local CFrame2 = Torso.CFrame;
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3_fromRGB_ret2;
    Highlight.OutlineTransparency = 0.3;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = Model;
    Model.Parent = u35.parent or workspace;
    local u45 = soul(CFrame2, u36, u33, Model);
    frost(CFrame2.Position, u36, u33, 10);
    local Freeze = u2.Freeze;
    local part = u45.part;
    local Sound = Instance.new("Sound");
    Sound.SoundId = Freeze;
    Sound.PlaybackSpeed = 1.1;
    Sound.Volume = 0.7;
    Sound.RollOffMinDistance = 8;
    Sound.RollOffMaxDistance = 90;
    Sound.Parent = part;
    Sound:Play();
    Debris:AddItem(Sound, 4);
    local os_clock_ret = os.clock();
    local u46 = "frozen";
    local u47 = nil;
    local u48 = nil;

    local function finish() -- Line: 264
        -- upvalues: u48 (ref), Model (copy), u43 (copy), u42 (copy), u32 (copy), u35 (ref)
        if u48 then
            u48:Disconnect();
            u48 = nil;
        end;

        Model:Destroy();
        u43:restore();

        if u42 then
            u32:SetAttribute("KillEffectHidden", nil);
        end;

        if u35.onDone then
            task.spawn(u35.onDone);
        end;
    end;

    u48 = RunService.RenderStepped:Connect(function() -- Line: 278
        -- upvalues: os_clock_ret (copy), u32 (copy), Model (copy), u35 (ref), finish (copy), u46 (ref), u45 (copy), u36 (copy), u37 (copy), Highlight (copy), u47 (ref), shatter (ref), CFrame2 (copy), frost (ref), u33 (copy), u2 (ref), Debris (ref), TweenService (ref)
        local v49 = os.clock() - os_clock_ret;

        if not (u32.Parent and (Model.Parent and not (u35.cancel and u35.cancel()))) then
            finish();

            return;
        end;

        if u46 ~= "frozen" then
            if u46 ~= "burst" then
                if v49 >= 2.05 then
                    finish();
                end;

                return;
            end;

            u45.flare.Rotation = v49 * 90;

            if v49 < 1.55 then
                return;
            end;

            u46 = "fade";

            for _, v in u47 do
                if v.Parent then
                    TweenService:Create(v, TweenInfo.new(0.5), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            return;
        end;

        local math_min_ret = math.min(1, v49 / 0.2);
        local v50 = math.sin(v49 * 14) * 0.08 + 1;
        local v51 = u45.size * math_min_ret * v50;
        u45.board.Size = UDim2.fromScale(v51, v51);
        u45.flare.Rotation = v49 * 90;

        if v49 < 1 then
            local v52 = 0.05 * u36 * math.clamp((v49 - 0.3) / 0.7, 0, 1);

            for _, v in u37 do
                local part2 = v.part;
                local base = v.base;
                local v53 = (math.random() * 2 - 1) * v52;
                local v54 = (math.random() * 2 - 1) * v52;
                local v55 = (math.random() * 2 - 1) * v52;
                part2.CFrame = base + Vector3.new(v53, v54, v55);
            end;

            return;
        end;

        u46 = "burst";
        Highlight:Destroy();
        u47 = shatter(u37, CFrame2.Position, u36, Model);
        frost(CFrame2.Position, u36 * 1.2, u33, 22);
        local v56 = u2.Shatter[math.random(#u2.Shatter)];
        local part2 = u45.part;
        local Sound2 = Instance.new("Sound");
        Sound2.SoundId = v56;
        Sound2.PlaybackSpeed = 1;
        Sound2.Volume = 0.9;
        Sound2.RollOffMinDistance = 8;
        Sound2.RollOffMaxDistance = 90;
        Sound2.Parent = part2;
        Sound2:Play();
        Debris:AddItem(Sound2, 4);
        TweenService:Create(u45.part, TweenInfo.new(1.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = CFrame2 + Vector3.new(0, 3.5 * u36, 0)
        }):Play();
        local TweenInfo_new_ret = TweenInfo.new(1.05);
        TweenService:Create(u45.ghost, TweenInfo_new_ret, {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(u45.flare, TweenInfo_new_ret, {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(u45.light, TweenInfo_new_ret, {
            Brightness = 0
        }):Play();
        u45.stars.Enabled = false;
    end);

    return true;
end;

return v1;