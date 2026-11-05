  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
Petal("Extensions");
local RunService = game:GetService("RunService");
local new = CFrame.new;
local new2 = Vector3.new;
local Vector4 = require(script.Vector4);

local function Lerp(p3, p4, p5) -- Line: 15
    return p3 + (p4 - p3) * p5;
end;

local function outBack(p6) -- Line: 19
    local v7 = p6 - 1;

    return 1 - v7 * v7 * v7 * v7;
end;

local function animateOutBack(p8, p9, p10) -- Line: 24
    local v11 = p10 - 1;

    return p8 + (p9 - p8) * (1 - v11 * v11 * v11 * v11);
end;

local function ConstrainTo360(p12) -- Line: 28
    return (p12 % 360 + 360) % 360;
end;

function StoreOriginalValues(p13)
    if not p13:GetAttribute("OriginalSize") and p13:IsA("ParticleEmitter") then
        p13:SetAttribute("OriginalSize", p13.Size);
        p13:SetAttribute("OriginalSpeed", p13.Speed);
        p13:SetAttribute("OriginalAcceleration", p13.Acceleration);
    end;
end;

function _ScaleParticle(p14, p15)
    local v16 = p14:GetAttribute("OriginalSize");
    local v17 = p14:GetAttribute("OriginalSpeed");
    local v18 = p14:GetAttribute("OriginalAcceleration");

    if not (v16 and (v17 and v18)) then
        StoreOriginalValues(p14);
        v16 = p14:GetAttribute("OriginalSize");
        v17 = p14:GetAttribute("OriginalSpeed");
        v18 = p14:GetAttribute("OriginalAcceleration");
    end;

    if typeof(v16) == "NumberSequence" then
        local v19 = {};

        for _, v in ipairs(v16.Keypoints) do
            table.insert(v19, NumberSequenceKeypoint.new(v.Time, v.Value * p15, v.Envelope * p15));
        end;

        p14.Size = NumberSequence.new(v19);
    end;

    p14.Speed = NumberRange.new(v17.Min * p15, v17.Max * p15);
    p14.Acceleration = v18 * p15;
end;

function ScaleParticle(p20, p21)
    for _, descendant in ipairs(p20:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            StoreOriginalValues(descendant);
            _ScaleParticle(descendant, p21);
        end;
    end;

    if p20:IsA("ParticleEmitter") then
        StoreOriginalValues(p20);
        _ScaleParticle(p20, p21);
    end;
end;

local function LerpColorSequence(p22, p23, p24) -- Line: 85
    local v25 = {};

    for i = 1, math.min(#p22.Keypoints, #p23.Keypoints) do
        local v26 = p22.Keypoints[i];
        local v27 = p23.Keypoints[i];
        local Time = v26.Time;
        local v28 = Time + (v27.Time - Time) * p24;
        local v29 = v26.Value:Lerp(v27.Value, p24);
        table.insert(v25, ColorSequenceKeypoint.new(v28, v29));
    end;

    return ColorSequence.new(v25);
end;

return function(p30) -- Line: 104
    -- upvalues: Trove (copy), u1 (copy), Vector4 (copy), u2 (copy), RunService (copy), LerpColorSequence (copy), new (copy), new2 (copy)
    local Reference = p30.Reference;
    local Character = p30.Character;
    local v31 = Random.new(p30.Seed);
    local HumanoidRootPart = Character.HumanoidRootPart;
    Character:FindFirstChildOfClass("Humanoid");
    local u32 = Trove.new();
    local u33 = {};
    local u34 = {};
    local u35 = {};
    local u36 = 1.25;

    local function Norm(p37) -- Line: 120
        return p37 == 1 and 1 or (p37 == 2 and -1 or 1);
    end;

    local u38 = u1("Part")({
        Name = "Base",
        Anchored = true,
        CanCollide = false,
        Transparency = 1,
        Size = Vector3.new(1, 1, 1)
    });
    local u39 = false;
    local u40 = false;
    local UI = script.UI;
    local u41 = script.Hover:Clone();
    local v42 = v31:NextInteger(1, 5);
    local u43 = v42 <= 3 and 3 or (v42 == 4 and 2 or 1);
    local u44 = nil;
    local u45 = nil;

    if u43 == 3 then
        local v46 = v31:NextNumber(0, 360);
        local v47 = ((v46 + (v31:NextInteger(1, 2) == 1 and 120 or -120)) % 360 + 360) % 360;
        u44 = Color3.fromHSV(v46 / 360, 0.588235 + v31:NextNumber(-0.1, 0.1), 0.9);
        u45 = Color3.fromHSV(v47 / 360, 0.588235 + v31:NextNumber(-0.1, 0.1), 0.9);
    elseif u43 == 1 then
        u44 = Color3.fromRGB(15, 15, 15);
        u45 = Color3.fromRGB(152, 152, 152);
    elseif u43 == 2 then
        u44 = Color3.fromRGB(152, 152, 152);
        u45 = Color3.fromRGB(15, 15, 15);
    end;

    for i = 1, 2 do
        for i2 = 1, 2 do
            for i3 = 1, 2 do
                for i4 = 1, 2 do
                    local v48 = Vector4.new(i == 1 and 1 or (i == 2 and -1 or 1), i2 == 1 and 1 or (i2 == 2 and -1 or 1), i3 == 1 and 1 or (i3 == 2 and -1 or 1), i4 == 1 and 1 or (i4 == 2 and -1 or 1));
                    local v49 = u1("Attachment")({
                        Name = `{v48.X} | {v48.Y} | {v48.Z} | {v48.W}`,
                        Parent = u38
                    });
                    u33[v48] = v49;
                    local v50 = UI:Clone();

                    if u43 == 1 then
                        v50.Dot.Image = "rbxassetid://11780694017";
                    elseif u43 == 2 then
                        v50.Dot.Image = "rbxassetid://18348269818";
                    end;

                    v50.Parent = v49;
                    v50.Adornee = v49;
                    table.insert(u35, { v50, v49 });
                end;
            end;
        end;
    end;

    for i, v in u33 do
        for i2, v2 in u33 do
            if i ~= i2 and (i - i2).Magnitude == 2 then
                local v51 = u1("Part");
                local v52 = {
                    Anchored = true,
                    CanCollide = false,
                    Material = "Neon",
                    Transparency = 1,
                    Parent = u38,
                    Name = i.X .. " | " .. i.Y .. " | " .. i.Z .. " | " .. i.W
                };
                local v53;

                if u43 == 1 then
                    v53 = Color3.fromRGB(15, 15, 15);
                elseif u43 == 2 then
                    v53 = Color3.fromRGB(152, 152, 152);
                else
                    v53 = Color3.fromRGB(152, 152, 152);
                end;

                v52.Color = v53;
                local v54 = { v51(v52), v, v2 };
                table.insert(u34, v54);
            end;
        end;
    end;

    u38.Parent = workspace.Effects;
    u41.Parent = workspace.Effects;
    u41.Position = Vector3.new(0, 10000, 0);
    local u55 = {};

    for _, child in Character:GetChildren() do
        if child:IsA("BasePart") and (child.Name == "Left Arm" or child.Name == "Right Arm") then
            local v56 = script.ArmEffect:Clone();
            v56.Parent = child;
            u1("Weld")({
                Parent = v56,
                Part0 = child,
                Part1 = v56
            });
            table.insert(u55, v56);

            for _, descendant in v56:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    local new3 = ColorSequence.new;
                    local v57;

                    if child.Name == "Left Arm" then
                        v57 = u44:Lerp(u45, 0.25);
                    else
                        v57 = u44:Lerp(u45, 0.85);
                    end;

                    descendant.Color = new3(v57);
                    descendant.Brightness = descendant.Brightness / 2;
                end;
            end;
        end;
    end;

    for i, _ in u33 do
        i.X = i.X * 5;
        i.Y = i.Y * 5;
        i.Z = i.Z * 5;
        i.W = i.W * 5;
    end;

    local u58 = 0;
    local u59 = 0.08;
    local u60 = 1;

    local function End() -- Line: 278
        -- upvalues: u41 (copy), u55 (copy), u34 (copy), u2 (ref), u35 (copy), u38 (copy), RunService (ref), u60 (ref), u36 (ref), u59 (ref)
        u41:Destroy();

        for i, v in u55 do
            if v and (v.Parent and v:FindFirstChildOfClass("Weld")) then
                v.Anchored = true;
                v:FindFirstChildOfClass("Weld"):Destroy();

                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            task.delay(1.5, function() -- Line: 294
                -- upvalues: u55 (ref), i (copy), v (copy)
                u55[i] = nil;
                v:Destroy();
            end);
        end;

        for i = 1, #u34 do
            u2.Tween(u34[i][1], 0.7, "Quad", "Out", {
                Transparency = 1
            });
        end;

        for i = 1, #u35 do
            u2.Tween(u35[i][1].Dot, 0.4, "Quad", "Out", {
                ImageTransparency = 1
            });
        end;

        u2.Tween(u38, 1, "Quad", "Out", {
            Position = u38.Position + Vector3.new(0, 1.5, 0)
        });
        local v61 = 0;

        while v61 < 50 do
            local v62 = v61 + RunService.Heartbeat:Wait() / 0.016666666666666666;
            v61 = math.min(v62, 50);
            local v63 = v61 / 50 - 1;
            u60 = 12 + 88 * (1 - v63 * v63 * v63 * v63);
            local v64 = v61 / 50 - 1;
            u36 = 1.25 + 5.75 * (1 - v64 * v64 * v64 * v64);
            local v65 = v61 / 50 - 1;
            u59 = 0.015 + -0.015 * (1 - v65 * v65 * v65 * v65);
        end;
    end;

    task.spawn(function() -- Line: 250, Name: Start
        -- upvalues: u34 (copy), u2 (ref), u35 (copy), u39 (ref), Reference (ref), RunService (ref), u60 (ref), u36 (ref), u59 (ref)
        task.delay(0.1, function() -- Line: 251
            -- upvalues: u34 (ref), u2 (ref), u35 (ref), u39 (ref)
            for i = 1, #u34 do
                u2.Tween(u34[i][1], 0.2, "Quad", "Out", {
                    Transparency = 0
                });
            end;

            for i = 1, #u35 do
                u2.Tween(u35[i][1].Dot, 0.2, "Quad", "Out", {
                    ImageTransparency = 0
                });
            end;

            task.delay(0.39, function() -- Line: 261
                -- upvalues: u39 (ref)
                u39 = true;
            end);
        end);
        local v66 = 0;

        while v66 < 25 and Reference do
            local v67 = v66 + RunService.Heartbeat:Wait() / 0.016666666666666666;
            v66 = math.min(v67, 25);
            local v68 = v66 / 25 - 1;
            u60 = 1000 + -988 * (1 - v68 * v68 * v68 * v68);
            local v69 = v66 / 25 - 1;
            u36 = 0 + 1.25 * (1 - v69 * v69 * v69 * v69);
            local v70 = v66 / 25 - 1;
            u59 = 0 + 0.08 * (1 - v70 * v70 * v70 * v70);
        end;
    end);
    u32:Add(function() -- Line: 326
        -- upvalues: u40 (ref), u34 (copy), u38 (copy), u33 (copy), u35 (copy)
        u40 = true;
        task.delay(1, function() -- Line: 328
            -- upvalues: u34 (ref), u38 (ref), u33 (ref), u35 (ref)
            for i = 1, #u34 do
                local v71 = u34[i];
                local v72 = v71[2];
                v71[1]:Destroy();
                v72:Destroy();
                table.clear(v71);
                u34[i] = nil;
            end;

            u38:Destroy();
            table.clear(u33);
            table.clear(u34);
            table.clear(u35);
        end);
    end);
    local _ = math.sin;
    local _ = math.cos;
    local u73 = "WZ";
    local u74 = RaycastParams.new();
    u74.FilterType = Enum.RaycastFilterType.Include;
    u74.FilterDescendantsInstances = { workspace.Map };
    local u75 = Color3.fromRGB(255, 255, 255);
    task.spawn(function() -- Line: 355
        -- upvalues: u40 (ref), RunService (ref), Character (copy), u41 (copy), HumanoidRootPart (copy), u74 (copy), u75 (copy), LerpColorSequence (ref), u2 (ref), u36 (ref), u73 (ref), u58 (ref), Reference (ref), u38 (copy), u33 (copy), u60 (ref), u34 (copy), u39 (ref), new (ref), u59 (ref), new2 (ref), u43 (copy), u44 (ref), u45 (ref), u35 (copy), u32 (copy), End (copy)
        local v76 = 0;

        while not u40 do
            local u77 = RunService.Heartbeat:Wait();
            v76 = v76 + u77;

            if not Character.Parent then
                break;
            end;

            if v76 >= 0.025 and (u41 and u41.Parent) then
                v76 = 0;
                local u78 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(-0, -20, -0), u74);

                if u78 and u78.Instance then
                    if u41.Recolour.Circle.Enabled then
                        for _, child in u41.Recolour:GetChildren() do
                            pcall(function() -- Line: 381
                                -- upvalues: u75 (ref), u78 (copy), child (copy), LerpColorSequence (ref), u77 (copy)
                                local v79 = u75:Lerp(u78.Instance.Color, 0.35);
                                child.Color = LerpColorSequence(child.Color, ColorSequence.new(v79), u77 * 15);
                            end);
                        end;
                    else
                        for _, descendant in u41:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end;

                    local Magnitude = (HumanoidRootPart.Position - u78.Position).Magnitude;
                    u2.Tween(u41, 0.05, "Quad", "InOut", {
                        Position = u78.Position + Vector3.new(0, 0.5, 0)
                    });
                    local v80 = 2.2 + -1.9500000000000002 * math.clamp(Magnitude / 20, 0, 1);
                    ScaleParticle(u41, v80);
                elseif u41.Recolour.Circle.Enabled then
                    for _, descendant in u41:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;
                end;
            end;

            local CFrame2 = HumanoidRootPart.CFrame;
            local v81 = CFrame2:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity).Z / 40;
            local v82 = u36;
            u36 = v82 + (math.clamp(v81, -3, 3) - v82) * (u77 * 30);

            if math.round(v81) == 0 then
                local v83 = u36;
                u36 = v83 + (0.75 - v83) * (u77 * 10);
                u73 = "WZ";
            else
                u73 = "WZ";
            end;

            u58 = u58 + 0.04 * (u77 * 60) * u36;

            if Reference then
                u38.CFrame = CFrame2;
            end;

            for i, v in u33 do
                local v84 = i["Rotate_" .. u73](i, u58, u58);
                local v85 = v84:Lerp(v84, 0.5):project3D(u60);
                v.WorldPosition = u38.Position + HumanoidRootPart.CFrame:Inverse():VectorToObjectSpace(v85);
            end;

            for i = 1, #u34 do
                local v86 = u34[i];
                v86[1].CFrame = new(v86[2].WorldPosition:Lerp(v86[3].WorldPosition, 0.5), v86[3].WorldPosition);
                v86[1].Size = new2(u59, u59, (v86[2].WorldPosition - v86[3].WorldPosition).Magnitude);

                if u43 == 3 then
                    v86[1].Color = u44:Lerp(u45, (v86[1].Position - u38.Position).Magnitude / 13);
                end;
            end;

            if u43 == 3 then
                for i = 1, #u35 do
                    local v87 = u35[i];
                    v87[1].Dot.ImageColor3 = u44:Lerp(u45, (v87[2].WorldPosition - u38.Position).Magnitude / 13);
                end;
            end;
        end;

        Reference = nil;
        task.delay(1, function() -- Line: 468
            -- upvalues: u32 (ref)
            u32:Destroy();
        end);
        End();
    end);
    u32:Connect(Reference.AncestryChanged, function() -- Line: 474
        -- upvalues: Reference (ref), u32 (copy), End (copy)
        if not Reference.Parent then
            Reference = nil;
            task.delay(1, function() -- Line: 477
                -- upvalues: u32 (ref)
                u32:Destroy();
            end);
            End();
        end;
    end);
end;