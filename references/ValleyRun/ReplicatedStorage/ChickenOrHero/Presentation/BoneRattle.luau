 

 

local RunService = game:GetService("RunService");
local PhysicsService = game:GetService("PhysicsService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local LocalHide = require(script.Parent:WaitForChild("LocalHide"));
local v1 = {};
local u2 = {
    Rattle = "rbxassetid://9120921325",
    Break = { "rbxassetid://9113542694", "rbxassetid://9113546532" }
};
local u3 = {
    Head = true,
    Torso = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true
};
local Color3_fromRGB_ret = Color3.fromRGB(235, 228, 210);
local success, result = pcall(PhysicsService.IsCollisionGroupRegistered, PhysicsService, "CoHRagdoll");
local u4 = success and result and "CoHRagdoll" or "Default";
local u5 = nil;

local function bones() -- Line: 39
    -- upvalues: u5 (ref), u3 (copy)
    if u5 then
        return u5;
    end;

    local Skeleton = game:GetService("ReplicatedStorage"):FindFirstChild("Skeleton");

    if not Skeleton then
        return nil;
    end;

    local v6 = {};

    for _, child in Skeleton:GetChildren() do
        if child:IsA("MeshPart") and child.Transparency < 1 then
            local v7 = child:FindFirstChildWhichIsA("WeldConstraint");

            if v7 then
                if v7.Part0 == child then
                    v7 = v7.Part1;
                else
                    v7 = v7.Part0;
                end;
            end;

            if v7 and u3[v7.Name] then
                local v8 = {
                    mesh = child,
                    limb = v7.Name,
                    offset = v7.CFrame:ToObjectSpace(child.CFrame)
                };
                table.insert(v6, v8);
            end;
        end;
    end;

    if #v6 <= 0 then
        v6 = nil;
    end;

    u5 = v6;

    return u5;
end;

local function sound(p9, p10, p11, p12) -- Line: 61
    -- upvalues: Debris (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = p9;
    Sound.PlaybackSpeed = p11 or 1;
    Sound.Volume = p12 or 0.6;
    Sound.RollOffMinDistance = 8;
    Sound.RollOffMaxDistance = 90;
    Sound.Parent = p10;
    Sound:Play();
    Debris:AddItem(Sound, 4);

    return Sound;
end;

local function dust(p13, p14, p15) -- Line: 74
    -- upvalues: Color3_fromRGB_ret (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p13);
    Part.Parent = workspace;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret, Color3.fromRGB(150, 145, 135));
    ParticleEmitter.Size = NumberSequence.new(1.4 * p14, 3 * p14);
    ParticleEmitter.Transparency = NumberSequence.new(0.3, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.9);
    ParticleEmitter.Speed = NumberRange.new(3 * p14, 6 * p14);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 3;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(14);
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter2.Color = ColorSequence.new(p15);
    ParticleEmitter2.LightEmission = 0.7;
    ParticleEmitter2.Size = NumberSequence.new(0.3 * p14, 0);
    ParticleEmitter2.Lifetime = NumberRange.new(0.4, 0.7);
    ParticleEmitter2.Speed = NumberRange.new(7 * p14, 12 * p14);
    ParticleEmitter2.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter2.Acceleration = Vector3.new(0, -20 * p14, 0);
    ParticleEmitter2.Rate = 0;
    ParticleEmitter2.Parent = Part;
    ParticleEmitter2:Emit(14);
    Debris:AddItem(Part, 1.5);
end;

local function twitch(p16) -- Line: 107
    local v17 = 0.08 * p16;

    return CFrame.new((math.random() * 2 - 1) * v17, (math.random() * 2 - 1) * v17, (math.random() * 2 - 1) * v17) * CFrame.Angles((math.random() * 2 - 1) * 0.16, (math.random() * 2 - 1) * 0.16, (math.random() * 2 - 1) * 0.16);
end;

function v1.play(u18, u19, p20) -- Line: 113
    -- upvalues: bones (copy), u4 (copy), LocalHide (copy), dust (copy), u2 (copy), Debris (copy), TweenService (copy), RunService (copy), twitch (copy)
    local u21 = p20 or {};
    local Torso = u18:FindFirstChild("Torso");
    local v22 = bones();

    if not (Torso and (Torso:IsA("BasePart") and v22)) then
        return false;
    end;

    local u23 = Torso.Size.Y / 2;
    local Model = Instance.new("Model");
    Model.Name = "BoneRattle";
    local u24 = {};

    for _, v in v22 do
        local v25 = u18:FindFirstChild(v.limb);

        if v25 and v25:IsA("BasePart") then
            local v26 = v.mesh:Clone();
            v26:ClearAllChildren();
            v26.Anchored = true;
            v26.CanCollide = false;
            v26.CanQuery = false;
            v26.CanTouch = false;
            v26.Massless = false;
            v26.CollisionGroup = u4;
            v26.Size = v.mesh.Size * u23;
            local offset = v.offset;
            v26.CFrame = v25.CFrame * (offset - offset.Position + offset.Position * u23);
            v26.Parent = Model;
            table.insert(u24, {
                part = v26,
                base = v26.CFrame
            });
        end;
    end;

    if #u24 == 0 then
        Model:Destroy();

        return false;
    end;

    local u27 = u18:GetAttribute("BotUserId") ~= nil;

    if u27 then
        u18:SetAttribute("KillEffectHidden", true);
    end;

    local u28 = LocalHide.new();
    u28:model(u18);
    local v29 = u18 == game:GetService("Players").LocalPlayer.Character and workspace:FindFirstChild("FallenKingLocal");

    if v29 then
        v29 = v29:FindFirstChild("Lantern");
    end;

    if v29 then
        u28:model(v29);
    end;

    dust(Torso.Position, u23, u19);
    local v30 = u2.Break[math.random(#u2.Break)];
    local Sound = Instance.new("Sound");
    Sound.SoundId = v30;
    Sound.PlaybackSpeed = 1;
    Sound.Volume = 0.8;
    Sound.RollOffMinDistance = 8;
    Sound.RollOffMaxDistance = 90;
    Sound.Parent = Torso;
    Sound:Play();
    Debris:AddItem(Sound, 4);
    local u31 = Model:FindFirstChild("Skeleton Head One") or u24[1].part;
    Model.PrimaryPart = u31;
    Model.Parent = u21.parent or workspace;
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = u19;
    Highlight.OutlineColor = u19;
    Highlight.FillTransparency = 0.2;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = Model;
    TweenService:Create(Highlight, TweenInfo.new(0.6), {
        FillTransparency = 1,
        OutlineTransparency = 0.7
    }):Play();
    local Rattle = u2.Rattle;
    local Sound2 = Instance.new("Sound");
    Sound2.SoundId = Rattle;
    Sound2.PlaybackSpeed = 1.05;
    Sound2.Volume = 0.75;
    Sound2.RollOffMinDistance = 8;
    Sound2.RollOffMaxDistance = 90;
    Sound2.Parent = u31;
    Sound2:Play();
    Debris:AddItem(Sound2, 4);
    local os_clock_ret = os.clock();
    local u32 = "shake";
    local u33 = nil;

    local function finish() -- Line: 176
        -- upvalues: u33 (ref), Model (copy), dust (ref), u23 (copy), u19 (copy), u28 (copy), u27 (copy), u18 (copy), Torso (copy), u21 (ref)
        if u33 then
            u33:Disconnect();
            u33 = nil;
        end;

        if Model.Parent then
            dust(Model:GetPivot().Position, u23 * 0.7, u19);
        end;

        Model:Destroy();
        u28:restore();

        if u27 then
            u18:SetAttribute("KillEffectHidden", nil);
        end;

        if u18.Parent and Torso.Parent then
            dust(Torso.Position, u23 * 0.6, u19);
        end;

        if u21.onDone then
            task.spawn(u21.onDone);
        end;
    end;

    u33 = RunService.RenderStepped:Connect(function() -- Line: 197
        -- upvalues: os_clock_ret (copy), u18 (copy), u31 (copy), u21 (ref), finish (copy), u32 (ref), u24 (copy), twitch (ref), u23 (copy), u2 (ref), Debris (ref), TweenService (ref)
        local v34 = os.clock() - os_clock_ret;

        if not (u18.Parent and (u31.Parent and not (u21.cancel and u21.cancel()))) then
            finish();

            return;
        end;

        if u32 == "shake" then
            if v34 < 0.8 then
                for _, v in u24 do
                    v.part.CFrame = v.base * twitch(u23);
                end;

                return;
            end;

            u32 = "fall";
            local v35 = u2.Break[math.random(#u2.Break)];
            local Sound3 = Instance.new("Sound");
            Sound3.SoundId = v35;
            Sound3.PlaybackSpeed = 0.9;
            Sound3.Volume = 0.8;
            Sound3.RollOffMinDistance = 8;
            Sound3.RollOffMaxDistance = 90;
            Sound3.Parent = u31;
            Sound3:Play();
            Debris:AddItem(Sound3, 4);

            for _, v in u24 do
                local part = v.part;
                part.CFrame = v.base;
                part.CanCollide = true;
                part.Anchored = false;
                local v36 = (math.random() * 2 - 1) * 5 * u23;
                local v37 = (4 + math.random() * 5) * u23;
                local v38 = (math.random() * 2 - 1) * 5 * u23;
                part.AssemblyLinearVelocity = Vector3.new(v36, v37, v38);
                local math_random_ret = math.random(-8, 8);
                local math_random_ret2 = math.random(-8, 8);
                part.AssemblyAngularVelocity = Vector3.new(math_random_ret, math_random_ret2, math.random(-8, 8));
            end;

            task.delay(0.35, function() -- Line: 226
                -- upvalues: u31 (ref), u2 (ref), Debris (ref)
                if u31.Parent then
                    local Rattle2 = u2.Rattle;
                    local Sound4 = Instance.new("Sound");
                    Sound4.SoundId = Rattle2;
                    Sound4.PlaybackSpeed = 0.9;
                    Sound4.Volume = 0.55;
                    Sound4.RollOffMinDistance = 8;
                    Sound4.RollOffMaxDistance = 90;
                    Sound4.Parent = u31;
                    Sound4:Play();
                    Debris:AddItem(Sound4, 4);
                end;
            end);

            return;
        end;

        if u32 ~= "fall" then
            if u32 ~= "again" then
                if v34 >= 3.2 then
                    finish();
                end;

                return;
            end;

            local v39 = v34 - 0.8 - 1.4;

            if v39 >= 0.6 then
                u32 = "fade";

                for _, v in u24 do
                    v.part.CFrame = v.base;
                    TweenService:Create(v.part, TweenInfo.new(0.4), {
                        Transparency = 1
                    }):Play();
                end;

                return;
            end;

            for _, v in u24 do
                v.part.CFrame = v.base * twitch(u23 * 0.8);
            end;

            local math_sin_ret = math.sin(v39 / 0.6 * 3.141592653589793 * 3);
            local v40 = math.abs(math_sin_ret) * 0.5 * u23;
            u31.CFrame = u31.CFrame + Vector3.new(0, v40, 0);

            return;
        end;

        if v34 < 2.2 then
            return;
        end;

        u32 = "again";

        for _, v in u24 do
            v.part.Anchored = true;
            v.part.CanCollide = false;
            v.base = v.part.CFrame;
        end;

        local Rattle2 = u2.Rattle;
        local Sound3 = Instance.new("Sound");
        Sound3.SoundId = Rattle2;
        Sound3.PlaybackSpeed = 1.15;
        Sound3.Volume = 0.7;
        Sound3.RollOffMinDistance = 8;
        Sound3.RollOffMaxDistance = 90;
        Sound3.Parent = u31;
        Sound3:Play();
        Debris:AddItem(Sound3, 4);
    end);

    return true;
end;

return v1;