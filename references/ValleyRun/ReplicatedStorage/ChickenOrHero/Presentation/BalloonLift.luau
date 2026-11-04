 

 

local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local LocalHide = require(script.Parent:WaitForChild("LocalHide"));
local v1 = {};
local u2 = {
    Color3.fromRGB(255, 70, 90),
    Color3.fromRGB(255, 214, 90),
    Color3.fromRGB(110, 205, 255),
    Color3.fromRGB(122, 255, 169),
    Color3.fromRGB(205, 130, 255)
};
local u3 = {
    Inflate = "rbxassetid://9125994773",
    Honk = "rbxassetid://134513873559475",
    Pop = "rbxassetid://9113263649"
};
local u4 = { "Torso", "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart" };
local u5 = { { "Right Arm", Vector3.new(0, -1, 0), Vector3.new(0.9, 3.4, 0) }, { "Left Arm", Vector3.new(0, -1, 0), Vector3.new(-0.9, 3.4, 0) }, { "Torso", Vector3.new(1, 1, 0), Vector3.new(2, 2.9, 0.4) }, { "Torso", Vector3.new(-1, 1, 0), Vector3.new(-2, 2.9, -0.4) }, { "Head", Vector3.new(0, 0.5, 0), Vector3.new(0, 4.1, 0) } };

local function sound(p6, p7, p8, p9) -- Line: 47
    -- upvalues: u3 (copy), Debris (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = u3[p6];
    Sound.PlaybackSpeed = p8 or 1;
    Sound.Volume = p9 or 0.5;
    Sound.RollOffMaxDistance = 90;
    Sound.Parent = p7;
    Sound.Ended:Once(function() -- Line: 54
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    Debris:AddItem(Sound, 5);
    Sound:Play();
end;

local function confetti(p10, p11, p12) -- Line: 60
    -- upvalues: u2 (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p10);
    Part.Parent = workspace;

    for _, v in { p11, Color3.new(1, 1, 1), u2[math.random(#u2)] } do
        local ParticleEmitter = Instance.new("ParticleEmitter");
        ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
        ParticleEmitter.Color = ColorSequence.new(v);
        ParticleEmitter.LightEmission = 0.5;
        ParticleEmitter.Size = NumberSequence.new(0.3 * p12, 0);
        ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.9);
        ParticleEmitter.Speed = NumberRange.new(5 * p12, 11 * p12);
        ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
        ParticleEmitter.Acceleration = Vector3.new(0, -18 * p12, 0);
        ParticleEmitter.Drag = 2;
        ParticleEmitter.Rate = 0;
        ParticleEmitter.Parent = Part;
        ParticleEmitter:Emit(8);
    end;

    Debris:AddItem(Part, 1.2);
end;

local function flash(p13, p14) -- Line: 84
    -- upvalues: TweenService (copy), Debris (copy)
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = p14;
    Highlight.OutlineColor = p14;
    Highlight.FillTransparency = 0.15;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p13;
    task.delay(0.6, function() -- Line: 92
        -- upvalues: Highlight (copy), TweenService (ref)
        if Highlight.Parent then
            TweenService:Create(Highlight, TweenInfo.new(0.5), {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
        end;
    end);
    Debris:AddItem(Highlight, 1.2);
end;

local function hanging(p15, p16, p17) -- Line: 100
    local v18 = {
        Torso = p15,
        HumanoidRootPart = p15,
        Head = p15 * CFrame.new(0, 1.5 * p17, 0) * CFrame.Angles(0, math.sin(p16 * 7) * 0.35, 0)
    };

    for _, v in { 1, -1 } do
        local v19 = math.sin(p16 * 10 + v) * 0.25;
        v18[v == 1 and "Right Arm" or "Left Arm"] = p15 * CFrame.new(v * 1.5 * p17, p17, 0) * CFrame.Angles(0, 0, v * (2.8415926535897933 + v19)) * CFrame.new(0, -p17, 0);
        v18[v == 1 and "Right Leg" or "Left Leg"] = p15 * CFrame.new(v * 0.5 * p17, -p17, 0) * CFrame.Angles(math.sin(p16 * 12 + v * 2) * 0.6, 0, v * 0.15) * CFrame.new(0, -p17, 0);
    end;

    return v18;
end;

function v1.play(u20, p21, p22) -- Line: 113
    -- upvalues: u4 (copy), LocalHide (copy), flash (copy), u5 (copy), u2 (copy), sound (copy), RunService (copy), confetti (copy), hanging (copy)
    local u23 = p22 or {};
    local u24 = u23.scale or 1;
    local u25 = (u23.height or 5) * u24;
    local u26 = 90 * u24;
    local Torso = u20:FindFirstChild("Torso");

    if not (Torso and Torso:IsA("BasePart")) then
        return false;
    end;

    local Archivable = u20.Archivable;
    u20.Archivable = true;
    local success, result = pcall(u20.Clone, u20);
    u20.Archivable = Archivable;

    if not (success and result) then
        return false;
    end;

    for _, descendant in result:GetDescendants() do
        if not (not (descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or (descendant:IsA("Constraint") or (descendant:IsA("Sound") or (descendant:IsA("ForceField") or (descendant:IsA("Highlight") or (descendant:IsA("BillboardGui") or (descendant:IsA("Animator") or descendant:IsA("Model") and descendant ~= result)))))))) and descendant:GetAttribute("EmotePiece") ~= true or descendant:IsA("JointInstance") and descendant:FindFirstAncestorOfClass("Accessory")) then
            descendant:Destroy();
        end;
    end;

    local u27 = {};

    for _, v in u4 do
        local v28 = result:FindFirstChild(v);

        if v28 and v28:IsA("BasePart") then
            u27[v] = {
                part = v28,
                from = v28.CFrame
            };
        end;
    end;

    if not u27.Torso then
        result:Destroy();

        return false;
    end;

    for _, child in result:GetChildren() do
        if child:IsA("BasePart") and not u27[child.Name] then
            child:Destroy();
        end;
    end;

    for _, descendant in result:GetDescendants() do
        if descendant:IsA("BasePart") then
            local v29;

            if u27[descendant.Name] == nil then
                v29 = false;
            else
                v29 = descendant.Parent == result;
            end;

            descendant.Anchored = v29;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.LocalTransparencyModifier = 0;
        end;
    end;

    if u27.HumanoidRootPart then
        u27.HumanoidRootPart.part.Transparency = 1;
    end;

    local v30 = result:FindFirstChildOfClass("Humanoid");

    if v30 then
        v30.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        v30.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
        v30.PlatformStand = true;
        v30.EvaluateStateMachine = false;
    end;

    result.Name = "BalloonLift";
    result.Parent = u23.parent or workspace;
    local u31 = u20:GetAttribute("BotUserId") ~= nil;

    if u31 then
        u20:SetAttribute("KillEffectHidden", true);
    end;

    local u32 = LocalHide.new();
    u32:model(u20);
    flash(result, p21);
    local CFrame2 = Torso.CFrame;
    local v33 = CFrame2.LookVector * Vector3.new(1, 0, 1);
    local v34 = v33.Magnitude <= 0.05 and Vector3.new(0, 0, 1) or v33.Unit;
    local u35 = CFrame2.Position.Y - 1.2 * u24;
    local Vector3_new_ret = Vector3.new(CFrame2.Position.X, u35 + 3 * u24, CFrame2.Position.Z);
    local CFrame_lookAt_ret = CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + v34);
    local u36 = {};

    for i, v in u5 do
        local Part = Instance.new("Part");
        Part.Name = "Balloon";
        Part.Shape = Enum.PartType.Ball;
        Part.Size = Vector3.new(1.7, 1.7, 1.7) * u24;
        Part.Color = u2[i];
        Part.Material = Enum.Material.SmoothPlastic;
        Part.Reflectance = 0.15;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        local Attachment = Instance.new("Attachment");
        Attachment.Position = Vector3.new(0, -0.85 * u24, 0);
        Attachment.Parent = Part;
        local v37;

        if u27[v[1]] then
            v37 = u27[v[1]].part;
        else
            v37 = u27.Torso.part;
        end;

        local Attachment2 = Instance.new("Attachment");
        Attachment2.Position = v[2] * u24;
        Attachment2.Parent = v37;
        local RopeConstraint = Instance.new("RopeConstraint");
        RopeConstraint.Attachment0 = Attachment;
        RopeConstraint.Attachment1 = Attachment2;
        RopeConstraint.Visible = true;
        RopeConstraint.Thickness = 0.05 * u24;
        RopeConstraint.Color = BrickColor.new("Institutional white");
        RopeConstraint.Length = 6 * u24;
        RopeConstraint.Parent = Part;
        Part.CFrame = CFrame.new((Vector3.new(v37.Position.X, u35, v37.Position.Z)));
        Part.Parent = result;
        u36[i] = {
            popped = false,
            part = Part,
            tie = v,
            cord = RopeConstraint,
            phase = math.random() * 6
        };
    end;

    sound("Inflate", u27.Torso.part, 0.75, 0.45);
    local os_clock_ret = os.clock();
    local u38 = false;
    local u39 = (#u5 - 1) * 0.08 + 1.6;
    local math_sqrt_ret = math.sqrt(2 * u25 / u26);
    local u40 = nil;

    local function finish() -- Line: 234
        -- upvalues: u40 (ref), result (copy), u32 (copy), u31 (copy), u20 (copy), u23 (ref)
        if u40 then
            u40:Disconnect();
            u40 = nil;
        end;

        result:Destroy();
        u32:restore();

        if u31 then
            u20:SetAttribute("KillEffectHidden", nil);
        end;

        if u23.onDone then
            task.spawn(u23.onDone);
        end;
    end;

    u40 = RunService.RenderStepped:Connect(function() -- Line: 248
        -- upvalues: os_clock_ret (copy), u20 (copy), result (copy), u39 (copy), math_sqrt_ret (copy), finish (copy), u23 (ref), u36 (copy), confetti (ref), u24 (copy), sound (ref), Torso (copy), u25 (copy), u26 (copy), CFrame_lookAt_ret (copy), hanging (ref), u27 (copy), u38 (ref), u35 (copy)
        local v41 = os.clock() - os_clock_ret;

        if not (u20.Parent and (result.Parent and u39 + math_sqrt_ret + 0.15 >= v41)) then
            finish();

            return;
        end;

        if u23.cancel and u23.cancel() then
            for _, v in u36 do
                if not v.popped and v.part.Parent then
                    v.popped = true;
                    confetti(v.part.Position, v.part.Color, u24);
                end;
            end;

            sound("Pop", Torso, 1, 0.6);
            finish();

            return;
        end;

        local math_max_ret = math.max(0, v41 - 0.3);
        local math_min_ret = math.min(math_max_ret / 1.3, 1);
        local math_max_ret2 = math.max(0, v41 - u39);
        local math_max_ret3 = math.max(0, u25 * (1 - (1 - math_min_ret) ^ 2) - 0.5 * u26 * math_max_ret2 * math_max_ret2);
        local v42 = CFrame_lookAt_ret * CFrame.new(0, math_max_ret3, 0) * CFrame.Angles(0, math_max_ret * 0.5, math.sin(math_max_ret * 4) * 0.12);
        local v43 = hanging(v42, math_max_ret, u24);
        local math_clamp_ret = math.clamp(math_max_ret / 0.35, 0, 1);
        local v44 = math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
        local math_clamp_ret2 = math.clamp(math_max_ret2 / math_sqrt_ret, 0, 1);

        for i, v in u27 do
            local v45 = v.from:Lerp(v43[i] or v42, v44);

            if math_clamp_ret2 > 0 then
                local v46 = u20:FindFirstChild(i);
                local v47;

                if v46 and v46:IsA("BasePart") then
                    v47 = v46.CFrame;
                else
                    v47 = v.from;
                end;

                v45 = v45:Lerp(v47, math_clamp_ret2 * math_clamp_ret2);
            end;

            v.part.CFrame = v45;
        end;

        if not u38 and v41 >= 0.3 then
            u38 = true;
            sound("Honk", u27.Torso.part, 1, 0.55);
        end;

        for i, v in u36 do
            if not v.popped then
                if 1.6 + (i - 1) * 0.08 <= v41 then
                    v.popped = true;
                    confetti(v.part.Position, v.part.Color, u24);
                    sound("Pop", u27.Torso.part, 0.9 + math.random() * 0.3, 0.6);
                    v.part:Destroy();
                else
                    local v48;

                    if u27[v.tie[1]] then
                        v48 = u27[v.tie[1]].part;
                    else
                        v48 = u27.Torso.part;
                    end;

                    local v49 = v48.CFrame:PointToWorldSpace(v.tie[2] * u24);
                    local v50 = (1 - (1 - math.clamp(v41 / 0.3, 0, 1)) ^ 3) * 0.75 + 0.25;
                    v.part.Size = Vector3.new(1.7, 1.7, 1.7) * u24 * v50;
                    local v51 = v42:VectorToWorldSpace(v.tie[3] * u24);
                    local v52 = math.sin(v41 * 3 + v.phase) * 0.15 * u24;
                    local v53 = v51 + Vector3.new(0, v52, 0);
                    local Vector3_new_ret2 = Vector3.new(v49.X, u35, v49.Z);
                    v.part.CFrame = CFrame.new(Vector3_new_ret2:Lerp(v49 + v53, v50));
                    v.cord.Length = (v.part.Position - v49).Magnitude;
                end;
            end;
        end;
    end);

    return true;
end;

return v1;