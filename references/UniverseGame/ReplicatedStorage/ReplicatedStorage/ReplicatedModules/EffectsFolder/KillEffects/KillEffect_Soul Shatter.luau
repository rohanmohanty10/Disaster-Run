  

 

local u1 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

function CheckProperty(u2, u3)
    return pcall(function() -- Line: 3
        -- upvalues: u2 (copy), u3 (copy)
        local _ = u2[u3];
    end);
end;

local TweenService = game:GetService("TweenService");
game:GetService("ReplicatedStorage");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function EntityTransparency(p4) -- Line: 14
    -- upvalues: u1 (copy), TweenService (copy)
    local Entity = p4.Entity;
    local u5 = p4.Transparency or 1;
    local u6 = p4.Speed or 0.5;
    local u7 = p4.Duration or 1;
    local v8 = {};

    for _, child in pairs(Entity:GetChildren()) do
        if table.find(u1, child.Name) then
            v8[child] = child.Transparency;
        elseif child:IsA("Accessory") then
            local v9 = child:FindFirstChild("handle") or child:FindFirstChild("Handle");
            v8[v9] = v9.Transparency;
        end;
    end;

    local AccessoryFolder = Entity:FindFirstChild("AccessoryFolder");

    if AccessoryFolder then
        for _, descendant in pairs(AccessoryFolder:GetDescendants()) do
            if CheckProperty(descendant, "Transparency") and (CheckProperty(descendant, "Massless") and descendant.Transparency == 0) then
                v8[descendant] = descendant.Transparency;
            end;
        end;
    end;

    for _, descendant in pairs(Entity:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 41
                -- upvalues: descendant (copy), u6 (copy), u7 (copy)
                if descendant.Enabled then
                    descendant.Enabled = false;
                    task.wait(u6 + u7);
                    descendant.Enabled = true;
                end;
            end)();
        elseif descendant:IsA("Decal") then
            coroutine.wrap(function() -- Line: 49
                -- upvalues: descendant (copy), u6 (copy), u7 (copy)
                local _ = descendant.Transparency;
                descendant.Transparency = 1;
                task.wait(u6 + u7);
                descendant.Transparency = 0;
            end)();
        end;
    end;

    for i, _ in pairs(v8) do
        coroutine.wrap(function() -- Line: 59
            -- upvalues: TweenService (ref), i (copy), u6 (copy), u5 (copy), u7 (copy)
            TweenService:Create(i, TweenInfo.new(u6), {
                Transparency = u5
            }):Play();
            task.wait(u6 + u7);
            TweenService:Create(i, TweenInfo.new(0.25), {
                Transparency = 0
            }):Play();
        end)();
    end;
end;

local function ViewportEffect(p10, p11) -- Line: 67
    -- upvalues: AssetHandler (copy), TweenService (copy)
    local u12 = p11 or {};
    local u13 = u12.Duration or 5;
    local u14 = u12.Speed or 0.25;
    local v15 = u12.Lifetime or u14;
    local v16 = u12.Brightness or 1;
    local v17 = u12.Transparency or 0;
    local v18 = u12.Color or Color3.fromRGB(255, 255, 255);
    local v19 = u12.BackgroundColor or Color3.fromRGB(0, 0, 0);
    local ExtraTween = u12.ExtraTween;
    local u20 = { "Model", "LocalScript", "Script", "Sound", "HumanoidRootPart", "Folder" };
    local v21 = AssetHandler.GetAsset("Soul Shatter/HighlightEffect", {
        AbilityName = "KillEffects"
    }).ViewportFrame:Clone();
    local Moyai = v21.WorldModel.Moyai;
    v21.Parent = game:GetService("Players").LocalPlayer.PlayerGui.Extra;
    v21.CurrentCamera = workspace.Camera;
    v21.LightDirection = game:GetService("Lighting"):GetSunDirection();
    local u22 = os.clock();

    local function CreateViewport(p23, p24) -- Line: 88
        -- upvalues: Moyai (copy), u20 (copy), u12 (copy), u22 (copy), u13 (copy), u14 (copy)
        local Model = Instance.new("Model");
        Model.Parent = Moyai;

        local function ImportObject(u25) -- Line: 92
            -- upvalues: Model (copy), u20 (ref), u12 (ref), u22 (ref), u13 (ref), u14 (ref)
            local u26 = u25:Clone();
            u26.Parent = Model;

            for _, child in pairs(u26:GetChildren()) do
                if table.find(u20, child.ClassName) then
                    child:Destroy();
                end;
            end;

            if u26:IsA("Humanoid") then
                u26.DisplayDistanceType = "None";
                u26.HealthDisplayType = "AlwaysOff";
            end;

            for _, child in pairs(u26:GetChildren()) do
                if child:IsA("Motor6D") or child:IsA("Weld") then
                    child:Destroy();
                end;
            end;

            if u26:IsA("Accessory") then
                u26 = u26:FindFirstChild("handle") or u26:FindFirstChild("Handle");
                u25 = u25:FindFirstChild("handle") or u25:FindFirstChild("Handle");
            end;

            if CheckProperty(u26, "Transparency") and u12.ObjectTransparency then
                u26.Transparency = u12.ObjectTransparency;
            end;

            local u27 = nil;

            local function UpdateCFrame() -- Line: 128
                -- upvalues: u25 (ref), u22 (ref), u13 (ref), u14 (ref), u27 (ref), u26 (ref)
                if u25 and os.clock() - u22 < u13 + u14 then
                    u26.CFrame = u25.CFrame;

                    return;
                end;

                u27:Disconnect();
            end;

            if CheckProperty(u26, "Position") then
                u26.Anchored = true;
                u27 = game:GetService("RunService").RenderStepped:Connect(UpdateCFrame);
            end;
        end;

        if p24 == "Group" then
            for _, child in pairs(p23:GetChildren()) do
                if not (table.find(u20, child.ClassName) or table.find(u20, child.Name)) then
                    ImportObject(child);
                end;
            end;

            return;
        end;

        if p24 == "Single" then
            local Parent = p23.Parent;

            if Parent and Parent:FindFirstChild("Humanoid") then
                local v28 = { "Humanoid", "Shirt", "Pants" };

                for i = 1, #v28 do
                    local v29 = Parent:FindFirstChild(v28[i]);

                    if v29 then
                        v29:Clone().Parent = Model;
                    end;
                end;
            end;

            ImportObject(p23);
        end;
    end;

    for i, v in pairs(p10) do
        for i2 = 1, #v do
            CreateViewport(v[i2], i);
        end;
    end;

    v21.ImageColor3 = v18;
    v21.BackgroundColor3 = v19;
    TweenService:Create(v21, TweenInfo.new(u14, Enum.EasingStyle.Linear), {
        BackgroundTransparency = v16,
        ImageTransparency = v17
    }):Play();
    task.wait(u14);

    if ExtraTween then
        TweenService:Create(v21, TweenInfo.new(table.unpack(ExtraTween.Info)), ExtraTween.Properties):Play();
    end;

    task.wait(u13);
    TweenService:Create(v21, TweenInfo.new(v15, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1,
        ImageTransparency = 1
    }):Play();
    task.wait(v15);
    v21:Destroy();
end;

return function(p30) -- Line: 192
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), EntityTransparency (copy), ViewportEffect (copy), TweenService (copy)
    local TargetCharacter = p30.TargetCharacter;
    local u31 = AssetHandler.CloneAsset("Soul Shatter/UT_Heart", {
        AbilityName = "KillEffects"
    });
    u31.Root.CFrame = TargetCharacter.HumanoidRootPart.CFrame;
    u31.Parent = workspace.Effects;
    task.delay(3.15, function() -- Line: 197
        -- upvalues: u31 (copy)
        u31:Destroy();
    end);
    task.wait(0.05);
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(TargetCharacter.HumanoidRootPart.Position)
    });
    task.spawn(EntityTransparency, {
        Transparency = 0.85,
        Speed = 0.5,
        Duration = 2,
        Entity = TargetCharacter
    });
    task.spawn(ViewportEffect, {
        Group = { u31.Root }
    }, {
        Duration = 2.5,
        Speed = 0.5,
        Lifetime = 0.03,
        Brightness = 1,
        Transparency = 0
    });
    task.wait(0.5);
    local CFrame2 = u31.Root.CFrame;

    for i = 1, 15 do
        local v32 = Random.new():NextNumber(-0.5, 0.5);
        TweenService:Create(u31.Root, TweenInfo.new(0.05, Enum.EasingStyle.Elastic), {
            CFrame = CFrame2 * CFrame.new(i % 2 == 0 and -0.5 or 0.5, v32, 0)
        }):Play();
        task.wait(0.05);
    end;

    TweenService:Create(u31.Root, TweenInfo.new(0.05, Enum.EasingStyle.Elastic), {
        CFrame = CFrame2
    }):Play();
    task.wait(0.55);
    u31.Root.Left.Anchored = true;
    u31.Root.Right.Anchored = true;
    TweenService:Create(u31.Root.Left, TweenInfo.new(0.75, Enum.EasingStyle.Exponential), {
        CFrame = u31.Root.Left.CFrame * CFrame.new(-1, 0.5, 0)
    }):Play();
    TweenService:Create(u31.Root.Right, TweenInfo.new(0.75, Enum.EasingStyle.Exponential), {
        CFrame = u31.Root.Right.CFrame * CFrame.new(1, -0.5, 0)
    }):Play();
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Soul Shatter/SoulShatterEmit",
        AbilityName = "KillEffects",
        AutoSerialize = true,
        Origin = CFrame2
    });
end;