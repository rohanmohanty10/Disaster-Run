  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
local u2 = Petal("Extensions");

return function(p3) -- Line: 13
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), u2 (copy), u1 (copy), ParticleHandler (copy), RunService (copy)
    local TargetCharacter = p3.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local v4 = AssetHandler.GetAsset(p3.Name .. "/Tornado", {
        AbilityName = "KillEffects"
    });
    local v5 = AssetHandler.GetAsset(p3.Name .. "/Tinsel", {
        AbilityName = "KillEffects"
    });

    for _, descendant in pairs(TargetCharacter:GetDescendants()) do
        if descendant:IsA("JointInstance") then
            descendant:Destroy();
        end;
    end;

    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(p3.Name .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local u6 = v4:Clone();
    u6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -TargetCharacter:GetExtentsSize().Y / 2 + 0.15, 0);
    u6.Parent = workspace.Effects;
    u6.Size = u6.Size * 0.1;

    for _, descendant in u6:GetDescendants() do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            task.delay(u2.Rng(0.3, 0.4), function() -- Line: 44
                -- upvalues: u1 (ref), descendant (copy), u2 (ref), Width0 (copy), Width1 (copy)
                u1.Tween(descendant, u2.Rng(0.3, 0.7) + Width0 / 30, "Sine", "In", {
                    Width0 = Width0,
                    Width1 = Width1
                });
            end);
            task.delay(3.5, function() -- Line: 48
                -- upvalues: u1 (ref), descendant (copy), u2 (ref)
                u1.Tween(descendant, u2.Rng(0.3, 0.7), "Sine", "Out", {
                    Width0 = 0,
                    Width1 = 0
                });
            end);
        end;
    end;

    u1.Tween(u6, 0.4, "Quad", "In", {
        Size = u6.Size * 10
    });
    ParticleHandler.EnableAllParticles(u6, true);
    task.delay(3.5, function() -- Line: 57
        -- upvalues: ParticleHandler (ref), u6 (copy), u1 (ref)
        ParticleHandler.EnableParticles(u6, false);
        u1.Tween(u6, 0.3, "Quad", "Out", {
            Size = u6.Size * 0.3
        });
        task.delay(2, function() -- Line: 60
            -- upvalues: u6 (ref)
            u6:Destroy();
        end);
    end);
    local v7 = {};
    local v8 = {};
    local v9 = {};
    local v10 = 0;

    for i = 1, 5 do
        local u11 = v5:Clone();
        u11.Parent = workspace.Effects;
        u11.CFrame = u6.CFrame;
        v7[i] = {
            u11,
            i * 2.5 + 7,
            u2.Rng(3, 7),
            (u2.Rng(-3.141592653589793, 3.141592653589793))
        };
        task.defer(function() -- Line: 82
            -- upvalues: ParticleHandler (ref), u11 (copy)
            ParticleHandler.EnableAllParticles(u11, true);
        end);
    end;

    for _, child in TargetCharacter:GetChildren() do
        local v12;

        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
            v12 = true;
        else
            v12 = child:IsA("Accessory") and child:FindFirstChildWhichIsA("BasePart");
        end;

        if v12 then
            if child:IsA("Accessory") then
                local child = child:FindFirstChildWhichIsA("BasePart") or child;
            end;

            local v13 = {
                child,
                u2.Rng(10, 18),
                u2.Rng(2, 9),
                u2.Rng(-6.283185307179586, 6.283185307179586),
                child.Position
            };
            table.insert(v8, v13);
        end;
    end;

    for _, child in u6:GetChildren() do
        if child:IsA("Attachment") and (child.Name == "BEAM1" or child.Name == "BEAM2") then
            local v14 = string.match(child.Name, "%d");

            if v14 then
                local v15 = tonumber(v14);
                child:SetAttribute("_BasePosition", child.Position);

                if v9[v15] then
                    table.insert(v9[v15], child);
                else
                    v9[v15] = { child };
                end;
            end;
        end;
    end;

    while v10 < 3.5 do
        local v16 = RunService.Heartbeat:Wait();

        for i = 1, 5 do
            local v17 = v7[i];
            local v18 = v17[1];
            local v19 = v17[2];
            local v20 = v17[3];
            local v21 = v17[4];

            if i % 2 == 0 then
                v20 = v20 * -1;
            end;

            local v22 = math.noise(os.clock() * 0.5 + i);
            local v23 = math.noise(os.clock() * 0.3 + i * 2);
            local v24 = math.noise(os.clock() * 0.5 - i);
            local Position = u6.Position;
            local v25 = v21 + os.clock() * v20;
            local v26 = math.cos(v25) * v19 + v22 * 20;
            local v27 = (i + 20) * (v10 - i / 2) / 3.5 + math.abs(v23 * 3.5);
            local v28 = v21 + os.clock() * v20;
            local v29 = math.sin(v28) * v19 + v24 * 20;
            v18.Position = Position + Vector3.new(v26, v27, v29);
        end;

        for i = 1, #v8 do
            local v30 = v8[i];

            if v30 then
                local v31 = v30[1];
                local v32 = v30[2];
                local v33 = v30[3];
                local v34 = v30[4];
                local v35 = v30[5];

                if v31 and v31.Parent then
                    if i % 2 == 0 then
                        v33 = v33 * -1;
                    end;

                    local v36 = math.noise(os.clock() * 0.5 + i);
                    local v37 = math.noise(os.clock() * 0.3 + i * 2);
                    local v38 = math.noise(os.clock() * 0.5 - i);
                    local v39 = v10 / 3.5;
                    v31.Velocity = Vector3.new(0, 0, 0);
                    local v40 = v34 + os.clock() * v33;
                    local v41 = math.cos(v40) * (v32 * v39) + v36 * 2;
                    local v42 = v39 * 20 + math.abs(v37 * 2);
                    local v43 = v34 + os.clock() * v33;
                    local v44 = math.sin(v43) * (v32 * v39) + v38 * 2;
                    v31.Position = v35 + Vector3.new(v41, v42, v44);
                else
                    v8[i] = nil;
                end;
            end;
        end;

        for i, v in v9 do
            for i2 = 1, #v do
                local v45 = v[i2];
                local v46 = v[i2]:GetAttribute("_BasePosition");
                local v47 = (os.clock() + 0.30543261909900765 * (i - 1)) * 3;
                local v48 = math.sin(v47) * 2.5;
                v45.Position = v46 - Vector3.new(0, v48);
            end;
        end;

        v10 = v10 + v16;
    end;

    for i = 1, 5 do
        local u49 = v7[i][1];
        ParticleHandler.EnableAllParticles(u49, false);
        task.delay(2, function() -- Line: 187
            -- upvalues: u49 (copy)
            u49:Destroy();
        end);
    end;

    table.clear(v7);
    table.clear(v8);
end;