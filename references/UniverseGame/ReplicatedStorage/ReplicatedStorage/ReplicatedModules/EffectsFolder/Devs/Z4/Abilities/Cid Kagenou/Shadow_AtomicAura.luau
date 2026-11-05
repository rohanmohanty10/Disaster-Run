  

 

local TweenService = game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedModules.EffectsHandler);

return function(p1, p2) -- Line: 11
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), TweenService (copy)
    if not p1 or (typeof(p1) ~= "Instance" or not p1:IsA("BasePart")) then
        return;
    end;

    local Parent = p1.Parent;

    if not (Parent:IsA("Model") and Parent:GetAttribute("AtomicAura")) then
        return;
    end;

    local v3 = game.Players:GetPlayerFromCharacter(Parent);
    local v4 = p2 or {
        AbilityName = "Cid Kagenou"
    };
    local v5 = v4.InTime or 0.5;
    local v6 = AssetHandler.GetAsset(v4.Recovery and "Particles/Atomic/Recovery" or "Particles/Atomic/Aura", v4);
    local v7 = CFrame.new(0, 3, 0);
    local v8 = ParticleHandler.GetUnusualHSVData({
        Character = Parent,
        Player = v3
    });
    local v9 = v4.Wind and AssetHandler.CloneAsset("Particles/AtomicSword/Wind", v4);

    if v9 then
        ParticleHandler.Unusualify(v9, {
            Character = Parent,
            Player = v3
        });

        if v8 and v8.Chroma then
            ParticleHandler.Chromaify(v9, {
                Character = Parent,
                Player = v3
            });
        end;

        v9.Parent = workspace.Effects;
        ParticleHandler.EnableParticle(v9, true);
        ParticleHandler.AttachTo(v9, {
            Part = p1,
            Offset = v7
        });
    end;

    local v10 = AssetHandler.GetAsset("Particles/Atomic/Decals", v4);
    local v11 = {};

    for _, v in v4.Limbs or { "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" } do
        local v12 = Parent:FindFirstChild(v);

        if v12 then
            local v13 = next;
            local v14, v15 = v10:GetChildren();

            for _, v2 in v13, v14, v15 do
                if v2:IsA("Decal") then
                    local v16 = v2:Clone();
                    v16.Parent = v12;
                    table.insert(v11, v16);
                end;
            end;
        else
            print("limb not found");
        end;
    end;

    if v6 then
        local u17 = v6:Clone();
        ParticleHandler.Unusualify(u17, {
            Character = Parent,
            Player = v3
        });
        u17.Parent = workspace.Effects;
        task.spawn(EffectsHandler.CallEffect, "Emit Particle V3", {
            Path = "Particles/Atomic/Summon",
            AttachTo = {
                Part = p1,
                Offset = v7
            },
            Player = v3,
            AbilityName = v4.AbilityName,
            SkinName = v4.SkinName
        });
        local v18 = ParticleHandler.AttachTo(u17, {
            Part = p1,
            Offset = v7
        });

        if v8 and v8.Chroma then
            ParticleHandler.Chromaify(u17, {
                Character = Parent,
                Player = v3
            });
        end;

        ParticleHandler.EnableAllParticles(u17, true);

        for _, child in u17:GetChildren() do
            if child:IsA("Attachment") and child:GetAttribute("UpAttachment") then
                TweenService:Create(child, TweenInfo.new(v5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    CFrame = child.CFrame * CFrame.new(0, 0, -12)
                }):Play();
            end;
        end;

        repeat
            if v9 then
                v9.Orientation = v9.Orientation + Vector3.new(0, 1, 0);
            end;

            task.wait(0.1);
        until not (Parent:GetAttribute("AtomicAura") and (p1 and Parent));

        if v9 then
            ParticleHandler.EnableParticle(v9, false);
            ParticleHandler.DestroyEmit(v9);
        end;

        for _, child in u17:GetChildren() do
            if child:IsA("Attachment") and child:GetAttribute("UpAttachment") then
                TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    CFrame = child.CFrame * CFrame.new(0, 0, 12)
                }):Play();
            end;
        end;

        v18:Destroy();
        u17.Anchored = true;
        task.delay(0.5, function() -- Line: 138
            -- upvalues: ParticleHandler (ref), u17 (ref)
            ParticleHandler.EnableAllParticles(u17, false);
        end);

        for _, v in v11 do
            v:Destroy();
        end;

        task.delay(4, u17.Destroy, u17);
    end;
end;