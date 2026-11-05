  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local EffectsHandler = require(game:GetService("ReplicatedStorage").ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p2, p3) -- Line: 8
    -- upvalues: Trove (copy), ParticleHandler (copy), u1 (copy), EffectsHandler (copy)
    if not (p2 and (p3 and (p2:IsDescendantOf(workspace) and p3:IsDescendantOf(workspace)))) then
        return;
    end;

    if not p3:FindFirstChild("Torso") then
        return;
    end;

    local u4 = Trove.new();
    u4:AttachToInstance(p2);
    local u5 = nil;
    u5 = p3.AncestryChanged:Connect(function(p6, p7) -- Line: 21
        -- upvalues: u4 (copy), u5 (ref)
        if not p7 then
            u4:Clean();

            if u5 then
                u5:Disconnect();
            end;
        end;
    end);
    local v8 = ParticleHandler.GetUnusualHSVData({
        Character = p2
    });
    local u9 = u4:Add(u1.Assets.Abilities["Weather Report"].LightningCloud:Clone());
    ParticleHandler.Unusualify(u9, {
        HSVData = v8
    });

    if not p3:FindFirstChild("Torso") then
        u4:Clean();

        return;
    end;

    u9.PrimaryPart.Position = p3.Torso.CFrame.Position;
    u9.Parent = workspace.Effects;

    local function CleanupParticles() -- Line: 42
        -- upvalues: u9 (copy)
        if u9 and u9.Parent then
            for _, descendant in pairs(u9:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end;

    local v10 = task.delay(5, function() -- Line: 52
        -- upvalues: CleanupParticles (copy), u4 (copy)
        CleanupParticles();
        u4:Clean();
    end);
    task.wait(0.5);

    if not (p3 and (p3:FindFirstChild("Torso") and p3:IsDescendantOf(workspace))) then
        CleanupParticles();
        u4:Clean();

        return;
    end;

    for _, descendant in pairs(u9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and descendant.Enabled == false then
            descendant.Enabled = true;
        end;
    end;

    local v11 = EffectsHandler.GetEffect("Box Create Lightning");
    local v12 = {
        Length = 1,
        Speed = 3,
        Size = 3,
        Material = "Neon"
    };
    local v13 = {};
    local v14 = p3 and p3:FindFirstChild("Torso") and p3.Torso.CFrame * CFrame.new(0, 48, 0);
    local v15 = p3:FindFirstChild("Torso") and p3.Torso.CFrame * CFrame.new(0, 0, 0);
    v13[1], v13[2] = v14, v15;
    v12.CFrames = v13;
    v12.Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(245, 205, 48), Color3.fromRGB(253, 234, 141)), v8);
    v12.Curves = { 0, 0 };
    v12.ExplosionData = { 0.75, 12, Vector3.new(0, 50, 0), 0.3 };
    v11(p2, v12);
    task.wait(1);
    CleanupParticles();
    task.cancel(v10);
    task.delay(3, function() -- Line: 99
        -- upvalues: u9 (copy), u5 (ref)
        if u9 and u9.Parent then
            u9:Destroy();
        end;

        if u5 then
            u5:Disconnect();
        end;
    end);
end;