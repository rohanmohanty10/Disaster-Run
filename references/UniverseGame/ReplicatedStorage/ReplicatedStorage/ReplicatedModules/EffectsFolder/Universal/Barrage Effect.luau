  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Players = game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
game:GetService("Debris");
local StatsHandler = require(game.ReplicatedStorage.ReplicatedModules.StatsHandler);
local BezierCreator = require(game.ReplicatedStorage.ReplicatedModules.BezierCreator);

local function FindConnectedParts(p2, p3, p4) -- Line: 12
    -- upvalues: FindConnectedParts (copy)
    local v5 = p4 or {};
    local v6 = {};

    for _, descendant in ipairs(p2:GetDescendants()) do
        if (descendant:IsA("Weld") or (descendant:IsA("WeldConstraint") or descendant:IsA("ManualWeld"))) and (descendant.Part0 == p3 or descendant.Part1 == p3) then
            local v7;

            if descendant.Part0 == p3 then
                v7 = descendant.Part1;
            else
                v7 = descendant.Part0;
            end;

            if v7 and not table.find(v5, v7) then
                if descendant.Parent ~= p3 and descendant.Parent ~= v7 then
                    descendant.Parent = p3;
                end;

                table.insert(v6, v7);

                for _, v in ipairs(FindConnectedParts(p2, v7, { p3, unpack(v6), unpack(v5) })) do
                    table.insert(v6, v);
                end;
            end;
        end;
    end;

    return v6;
end;

local function ReparentParts(p8, p9) -- Line: 36
    for _, v in ipairs(p8) do
        v.Parent = p9;
    end;
end;

local function BuildArm(p10, p11) -- Line: 42
    -- upvalues: FindConnectedParts (copy)
    local v12 = FindConnectedParts(p10, p11);
    local Model = Instance.new("Model");
    Model.Name = "Container";

    for _, v in ipairs(v12) do
        v.Parent = Model;
    end;

    Model.Parent = p11;

    for _, descendant in ipairs(p11:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.CanCollide = false;
        end;
    end;

    p11.CanCollide = false;
    p11.Anchored = true;

    return p11;
end;

local _ = task.wait;
local u13 = {};

return function(p14, p15, p16, p17) -- Line: 64
    -- upvalues: StatsHandler (copy), Players (copy), u13 (copy), u1 (copy), BuildArm (copy), TweenService (copy), BezierCreator (copy), CollectionService (copy)
    local v18 = p16 or p15;
    local v19 = StatsHandler.GetStats(p15, v18);
    local RelativePart = p17.RelativePart;

    if not RelativePart then
        if p14 then
            RelativePart = p14:FindFirstChild("HumanoidRootPart");
        else
            RelativePart = p14;
        end;
    end;

    if not RelativePart then
        return;
    end;

    local v20 = p17.Offset or 0;
    Players:GetPlayerFromCharacter(p14);

    if not p14:FindFirstChild("Humanoid") then
        p14 = p14.Parent;
    end;

    local v21 = "Stand";

    if p14:GetAttribute("CurrentAbility") then
        v21 = p14:GetAttribute("CurrentAbility") .. "_" .. v21;
    end;

    local v22 = p14:FindFirstChild(v21);

    if not (v22 and v22:IsDescendantOf(workspace)) then
        return;
    end;

    local v23 = v22:Clone();

    if not u13[p15] then
        u13[p15] = {};
    end;

    if not u13[p15][v18] then
        u13[p15][v18] = {};
    end;

    local v24 = game.Players:GetPlayerFromCharacter(p14) or p14;
    local v25 = not (v24 and (v24:FindFirstChild("Data") and (v24.Data:FindFirstChild("Skin") and v24.Data.Skin:GetAttribute("UnusualHueId")))) and "0" or tostring(v24.Data.Skin:GetAttribute("UnusualHueId"));

    if not u13[p15][v18][v25] then
        u13[p15][v18][v25] = {};
    end;

    local u26 = u13[p15][v18][v25]["Left Arm"];
    local u27 = u13[p15][v18][v25]["Right Arm"];
    local BaseArm = u1.Universal.BaseArm;

    local function AddDefaultAttachments(p28) -- Line: 106
        -- upvalues: BaseArm (copy)
        BaseArm.CoreAttachment:Clone().Parent = p28;
    end;

    local function RemoveVFX(p29) -- Line: 110
        for _, descendant in ipairs(p29:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Destroy();
            end;
        end;
    end;

    if not u26 then
        u26 = BuildArm(v23, v23["Stand Left Arm"]):Clone();
        RemoveVFX(u26);
        BaseArm.CoreAttachment:Clone().Parent = u26;
        u13[p15][v18][v25]["Left Arm"] = u26;
    end;

    if not u27 then
        u27 = BuildArm(v23, v23["Stand Right Arm"]):Clone();
        RemoveVFX(u27);
        BaseArm.CoreAttachment:Clone().Parent = u27;
        u13[p15][v18][v25]["Right Arm"] = u27;
    end;

    v23:Destroy();

    if not (u26 and u27) then
        return;
    end;

    local v30 = v19.Metadata or {};
    local u31 = { u26.Color or Color3.new(1, 1, 1), u27.Color or Color3.new(1, 1, 1) };

    if v30.BarrageColors then
        u31 = v30.BarrageColors;
    end;

    local u32 = -3.5 + v20;
    local u33 = -5 + v20;
    local u34 = -11 + v20;
    local u35 = 0;
    local u36 = 0;

    local function EnableTrailEffects(p37) -- Line: 158
        -- upvalues: u31 (copy)
        local TrailAttachment = p37.CoreAttachment:FindFirstChild("TrailAttachment");

        if TrailAttachment then
            local v38 = math.random(#u31);

            for _, child in pairs(TrailAttachment:GetChildren()) do
                if child:IsA("Trail") then
                    child.Color = ColorSequence.new(u31[v38]);
                    child.Enabled = true;
                end;
            end;

            local TrailEffect = p37.CoreAttachment:FindFirstChild("TrailEffect");

            if TrailEffect then
                TrailEffect.Specs.Color = ColorSequence.new(u31[v38]);
                task.spawn(function() -- Line: 175
                    -- upvalues: TrailEffect (copy)
                    TrailEffect.Specs.Enabled = true;
                    task.wait(0.2);
                    TrailEffect.Specs.Enabled = false;
                end);
            end;
        end;
    end;

    local function TweenArm(u39, u40) -- Line: 186
        -- upvalues: TweenService (ref), BezierCreator (ref)
        task.delay(0.3, function() -- Line: 187
            -- upvalues: TweenService (ref), u39 (copy)
            TweenService:Create(u39, TweenInfo.new(0.1), {
                Transparency = 1
            }):Play();

            for _, descendant in pairs(u39.Container:GetDescendants()) do
                if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                    TweenService:Create(descendant, TweenInfo.new(0.1), {
                        Size = Vector3.new()
                    }):Play();
                elseif descendant:IsA("SpecialMesh") then
                    TweenService:Create(descendant, TweenInfo.new(0.1), {
                        Scale = Vector3.new()
                    }):Play();
                end;
            end;
        end);
        task.spawn(function() -- Line: 199
            -- upvalues: BezierCreator (ref), u40 (copy), u39 (copy)
            local v41 = BezierCreator(u40[1], u40[2], u40[3], 20);

            if not v41 then
                return;
            end;

            local v42 = 0;

            for i = 1, #v41 do
                if v41[i + 1] then
                    local v43 = v41[i];
                    local v44 = v41[i + 1];
                    local _ = (v44 - v43).Magnitude;
                    u39:PivotTo(CFrame.new(v43, v44) * CFrame.Angles(1.5707963267948966, 0, 0));
                end;

                repeat
                    v42 = v42 + task.wait();
                until v42 >= 0.016666666666666666;

                v42 = v42 - 0.016666666666666666;
            end;

            task.wait(0.365);
            u39:Destroy();
        end);
    end;

    local u57 = { function() -- Line: 227
            -- upvalues: RelativePart (copy), u32 (copy), u33 (copy), u34 (copy), u26 (ref), EnableTrailEffects (copy), TweenArm (copy)
            local v45 = RelativePart.CFrame * CFrame.new(-2, 0, u32);
            local v46 = RelativePart.CFrame * CFrame.new(-5, 1.5, u33);
            local v47 = RelativePart.CFrame * CFrame.new(0, -1.5, u34);
            local v48 = u26:Clone();
            v48.CFrame = RelativePart.CFrame;
            v48.Parent = workspace.Effects;
            EnableTrailEffects(v48);
            TweenArm(v48, { v45, v46, v47 });
        end, function() -- Line: 240
            -- upvalues: RelativePart (copy), u32 (copy), u33 (copy), u34 (copy), u26 (ref), EnableTrailEffects (copy), TweenArm (copy)
            local v49 = RelativePart.CFrame * CFrame.new(-1, 0, u32);
            local v50 = RelativePart.CFrame * CFrame.new(-4, 5, u33);
            local v51 = RelativePart.CFrame * CFrame.new(0, 0, u34);
            local v52 = u26:Clone();
            v52.CFrame = RelativePart.CFrame;
            v52.Parent = workspace.Effects;
            EnableTrailEffects(v52);
            TweenArm(v52, { v49, v50, v51 });
        end, function() -- Line: 253
            -- upvalues: RelativePart (copy), u32 (copy), u33 (copy), u34 (copy), u26 (ref), EnableTrailEffects (copy), TweenArm (copy)
            local v53 = RelativePart.CFrame * CFrame.new(-2, 0, u32);
            local v54 = RelativePart.CFrame * CFrame.new(-5, -2, u33);
            local v55 = RelativePart.CFrame * CFrame.new(0, 0, u34);
            local v56 = u26:Clone();
            v56.CFrame = RelativePart.CFrame;
            v56.Parent = workspace.Effects;
            EnableTrailEffects(v56);
            TweenArm(v56, { v53, v54, v55 });
        end };
    local u70 = { function() -- Line: 268
            -- upvalues: RelativePart (copy), u32 (copy), u33 (copy), u34 (copy), u27 (ref), EnableTrailEffects (copy), TweenArm (copy)
            local v58 = RelativePart.CFrame * CFrame.new(2, 0, u32);
            local v59 = RelativePart.CFrame * CFrame.new(5, 1.5, u33);
            local v60 = RelativePart.CFrame * CFrame.new(0, -1, u34);
            local v61 = u27:Clone();
            v61.CFrame = RelativePart.CFrame;
            v61.Parent = workspace.Effects;
            EnableTrailEffects(v61);
            TweenArm(v61, { v58, v59, v60 });
        end, function() -- Line: 281
            -- upvalues: RelativePart (copy), u32 (copy), u33 (copy), u34 (copy), u27 (ref), EnableTrailEffects (copy), TweenArm (copy)
            local v62 = RelativePart.CFrame * CFrame.new(1, 0, u32);
            local v63 = RelativePart.CFrame * CFrame.new(4, 5, u33);
            local v64 = RelativePart.CFrame * CFrame.new(0, 0, u34);
            local v65 = u27:Clone();
            v65.CFrame = RelativePart.CFrame;
            v65.Parent = workspace.Effects;
            EnableTrailEffects(v65);
            TweenArm(v65, { v62, v63, v64 });
        end, function() -- Line: 294
            -- upvalues: RelativePart (copy), u32 (copy), u33 (copy), u34 (copy), u27 (ref), EnableTrailEffects (copy), TweenArm (copy)
            local v66 = RelativePart.CFrame * CFrame.new(2, 0, u32);
            local v67 = RelativePart.CFrame * CFrame.new(5, -2, u33);
            local v68 = RelativePart.CFrame * CFrame.new(0, 0, u34);
            local v69 = u27:Clone();
            v69.CFrame = RelativePart.CFrame;
            v69.Parent = workspace.Effects;
            EnableTrailEffects(v69);
            TweenArm(v69, { v66, v67, v68 });
        end };
    local u71 = true;

    if v24 and v24:IsA("Player") then
        local u72 = nil;
        u72 = v24.CharacterRemoving:Connect(function() -- Line: 313
            -- upvalues: u72 (ref), u71 (ref)
            u72:Disconnect();

            if u71 then
                u71 = false;
            end;
        end);
    end;

    local v73 = u1.BarrageParticle:Clone();
    v73.CFrame = RelativePart.CFrame * CFrame.new(0, 0, -4 + v20) * CFrame.Angles(-1.5707963267948966, 0, 0);
    v73.Anchored = true;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = RelativePart;
    WeldConstraint.Part1 = v73;
    WeldConstraint.Parent = v73;
    v73.Anchored = false;
    v73.Parent = workspace.Effects;

    for _, descendant in pairs(v73:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;

            if descendant.Color == ColorSequence.new(Color3.fromRGB(255, 255, 255)) then
                local v74 = math.random(#u31);
                descendant.Color = ColorSequence.new(u31[v74]);
            end;
        end;
    end;

    while true do
        task.wait(0.06);
        local u75 = math.random(1, 3);
        local u76 = math.random(1, 3);

        if u35 == u75 then
            u75 = math.random(1, 3);
        end;

        if u36 == u76 then
            u76 = math.random(1, 3);
        end;

        task.spawn(function() -- Line: 355
            -- upvalues: u35 (ref), u75 (ref), u57 (copy)
            u35 = u75;
            u57[u75]();
        end);
        task.spawn(function() -- Line: 360
            -- upvalues: u36 (ref), u76 (ref), u70 (copy)
            task.wait(0.0325);
            u36 = u76;
            u70[u76]();
        end);

        if not u71 or (not CollectionService:HasTag(p14, "Barraging") or (p14.Humanoid.Health <= 0 or p14 == nil)) then
            for _, descendant in pairs(v73:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(1.5, v73.Destroy, v73);

            return;
        end;
    end;
end;