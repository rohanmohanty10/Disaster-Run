  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Petal = _G.Petal;
Petal("New");
local TweenCallback = Petal("Util").TweenCallback;

return function(p1) -- Line: 11
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), TweenCallback (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local CFrame2 = HumanoidRootPart.CFrame;
    local v2 = AssetHandler.GetAsset("Life Creation/Animations", {
        AbilityName = "KillEffects"
    });
    local u3 = AssetHandler.CloneAsset("Life Creation/Model", {
        AbilityName = "KillEffects"
    });
    u3:SetPrimaryPartCFrame(CFrame2);
    u3.HumanoidRootPart.Anchored = true;
    u3.Parent = workspace.Effects;

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.CollisionGroup = "FX";
        end;
    end;

    local u4 = {};

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Name ~= "Part" then
            if descendant.Name == "Leaves" then
                u4[descendant] = descendant.Size;
                descendant.Size = Vector3.new(0, 0, 0);
            end;

            descendant.Transparency = 1;
        end;
    end;

    local u5 = u3.Humanoid:LoadAnimation(v2.Folded);
    u5:Play();
    u5.Stopped:Wait();
    u3.Humanoid:LoadAnimation(v2.Grow):Play();
    u3.HumanoidRootPart.TreeCreateSFX:Play();
    local v6 = {
        IncludeRingDebris = true,
        IncludeFlyingDebris = true,
        IncludeShockwave = true,
        RDData = {
            Amount = 20,
            Radius = 10,
            Size = Vector3.new(2.5, 2.5, 2.5),
            OutwardTime = 0.3,
            GrowTime = 0,
            Lifetime = 10,
            _CFrame = HumanoidRootPart.CFrame
        }
    };
    local v7 = {
        Amount = 10,
        Height = 75,
        Length = 0.1,
        _CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -10, 0),
        PivotInstance = HumanoidRootPart
    };
    local v8 = math.random(1, 2);
    local v9 = math.random(1, 2);
    v7.Size = Vector3.new(v8, v9, math.random(1, 2));
    v6.FDData = v7;
    v6.Shockwave = {
        GrowthTime = 1,
        Size = Vector3.new(100, 0.5, 100),
        TransparencyTime = 0.5,
        Transparency = 1,
        _CFrame = HumanoidRootPart.CFrame
    };
    EffectsHandler.CallEffect("GE Tree Effect", TargetCharacter, u3, { CFrame2 });
    EffectsHandler.CallEffect("Box Slam Effect", TargetCharacter, v6);
    EffectsHandler.CallEffect("SK_VANISH", {
        Transparency = 1,
        Character = TargetCharacter
    });
    task.delay(0.2, function() -- Line: 92
        -- upvalues: u5 (copy), u3 (copy), TweenCallback (ref), u4 (copy)
        u5:Stop();

        if u3.Part and u3.Part:FindFirstChild("Weld") then
            u3.Part.Weld:Destroy();
        end;

        u3.Part.Anchored = true;
        TweenCallback(u3.Part, {
            CFrame = u3.Part.CFrame * CFrame.new(0, 27, 0)
        }, function() -- Line: 101
            -- upvalues: u4 (ref), TweenCallback (ref)
            for i, v in u4 do
                TweenCallback(i, {
                    Size = v
                }, nil, 0.2);
            end;
        end, 0.8);

        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("BasePart") and (descendant.Name ~= "RootPart" and (descendant.Name ~= "HumanoidRootPart" and descendant.Name ~= "Part")) then
                descendant.Transparency = 0;
            end;
        end;
    end);
    task.delay(10, function() -- Line: 114
        -- upvalues: u3 (copy), TweenCallback (ref)
        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("Weld") or descendant:IsA("Motor6D") then
                descendant:Destroy();
            end;

            if (descendant:IsA("BasePart") or descendant:IsA("MeshPart")) and descendant.Name ~= "HumanoidRootPart" then
                descendant.Anchored = false;
                descendant.CanCollide = true;
                TweenCallback(descendant, {
                    Transparency = 1,
                    Size = descendant.Size * 0.1
                }, function() -- Line: 125
                    -- upvalues: descendant (copy)
                    descendant:Destroy();
                end, 1.35);
            end;
        end;

        task.delay(13, u3.Destroy, u3);
    end);
end;