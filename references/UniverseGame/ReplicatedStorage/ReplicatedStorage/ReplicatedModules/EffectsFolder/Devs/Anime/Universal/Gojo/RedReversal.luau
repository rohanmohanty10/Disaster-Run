  

 

game:GetService("CollectionService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.KnitPath.Promise);
local u1 = require(ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("CameraShake");
local LocalPlayer = game.Players.LocalPlayer;

return function(p2, p3, p4) -- Line: 16
    -- upvalues: Trove (copy), LocalPlayer (copy), ReplicatedStorage (copy), u1 (copy), TweenService (copy)
    local wait = task.wait;
    local u5 = Trove.new();
    u5:AttachToInstance(p3);
    u5:Connect(p3.AncestryChanged, function(p6, p7) -- Line: 23
        -- upvalues: u5 (copy)
        if not p7 then
            u5:Destroy();
        end;
    end);
    local Magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;
    local u8 = u5:Clone(ReplicatedStorage["Client Assets"].Gojo.RedReversal);
    local v9 = {};
    local u10 = {};

    for _, descendant in pairs(u8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            table.insert(v9, descendant);
        end;
    end;

    u8.Parent = game.Workspace.Effects;
    local v11 = u5:Construct(Instance, "Weld");
    v11.Parent = p2;
    v11.Part0 = p2;
    v11.Part1 = u8;
    v11.C0 = v11.C0 * CFrame.new(0, -1.5, 0);
    u5:Add(v11);

    if Magnitude and Magnitude < 80 then
        u1(5, 8, 1.5, 0.1, Vector3.new(0.1, 0.1, 0.1), Vector3.new(1.5, 1.5, 1.5), true);
    end;

    local function addTween(p12, p13, p14, p15) -- Line: 42
        -- upvalues: u5 (copy), TweenService (ref), u10 (copy)
        local v16 = u5:Add(TweenService:Create(p12, p13, p14));
        table.insert(u10, v16);
        v16:Play();
    end;

    wait(0.5);
    local v17 = u5:Construct(Instance, "ColorCorrectionEffect");
    v17.Parent = game.Lighting;
    local v18 = u5:Add(TweenService:Create(LocalPlayer.PlayerGui.Extra.ViewportGui.ViewportFrame, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        LightColor = Color3.fromRGB(170, 0, 0),
        Ambient = Color3.fromRGB(170, 0, 0)
    }));
    table.insert(u10, v18);
    v18:Play();

    if Magnitude and Magnitude < 80 then
        local v19 = u5:Add(TweenService:Create(v17, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Brightness = 0.5,
            Contrast = 1,
            TintColor = Color3.fromRGB(170, 0, 0)
        }));
        table.insert(u10, v19);
        v19:Play();
    end;

    wait(0.2);
    local v20 = u5:Construct(Instance, "Part");
    v20.Shape = Enum.PartType.Cylinder;
    v20.Size = Vector3.new(800, 0, 0);
    v20.Position = u8.Position;
    v20.Orientation = Vector3.new(0, 0, 90);
    v20.Anchored = true;
    v20.Transparency = 1;
    v20.Color = Color3.new(1, 0, 0);
    v20.CanCollide = false;
    v20.Material = Enum.Material.Neon;
    v20.CastShadow = false;
    v20.Parent = workspace.Effects;
    wait(0.2);
    u8.Attachment:Destroy();
    u5:Remove(v11);
    u8.Anchored = true;
    local v21 = u5:Add(TweenService:Create(u8, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = Vector3.new(40, 40, 40),
        Transparency = 0,
        Color = Color3.new(1, 0, 0)
    }));
    table.insert(u10, v21);
    v21:Play();
    local v22 = u5:Add(TweenService:Create(v20, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(800, 10, 10),
        Transparency = 0.4
    }));
    table.insert(u10, v22);
    v22:Play();
    wait(0.1);
    local Magnitude2 = (LocalPlayer.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;

    if Magnitude2 and Magnitude2 < 80 then
        local v23 = u5:Add(TweenService:Create(v17, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Brightness = 1,
            Contrast = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }));
        table.insert(u10, v23);
        v23:Play();
    end;

    wait(0.1);
    local Magnitude3 = (LocalPlayer.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;

    if Magnitude3 and Magnitude3 < 80 then
        local v24 = u5:Add(TweenService:Create(v17, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }));
        table.insert(u10, v24);
        v24:Play();
    end;

    local v25 = u5:Add(TweenService:Create(v20, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Size = Vector3.new(10, 0, 0),
        Transparency = 1
    }));
    table.insert(u10, v25);
    v25:Play();
    wait(0.1);
    local Magnitude4 = (LocalPlayer.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;

    if Magnitude4 and Magnitude4 < 80 then
        u1("Explosion");
    end;

    p3.HumanoidRootPart.ReversalRedExplosion:Play();
    local v26 = u5:Add(TweenService:Create(u8, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = Vector3.new(200, 200, 200),
        Transparency = 1,
        Color = Color3.new(1, 1, 1)
    }));
    table.insert(u10, v26);
    v26:Play();
    task.spawn(function() -- Line: 92
        -- upvalues: u5 (copy), ReplicatedStorage (ref), u8 (copy), u10 (copy), TweenService (ref), wait (copy)
        for i = 1, 3 do
            local u27 = u5:Clone(ReplicatedStorage["Client Assets"].Gojo.Shock);
            u27.Parent = workspace.Effects;
            u27.CFrame = u8.CFrame;
            local v28 = math.random(0, 360);
            local v29 = math.random(0, 360);
            u27.Orientation = Vector3.new(v28, v29, math.random(0, 360));
            local v30 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v31 = {
                Size = Vector3.new(200, 200, 200),
                Transparency = 1
            };
            local Orientation = u27.Orientation;
            local v32 = math.random(-5, 5);
            local v33 = math.random(-5, 5);
            v31.Orientation = Orientation + Vector3.new(v32, v33, math.random(-5, 5));
            u10["wind" .. i] = TweenService:Create(u27, v30, v31);

            for _, v in pairs(u10) do
                if v.PlaybackState ~= Enum.PlaybackState.Playing and v.PlaybackState ~= Enum.PlaybackState.Completed then
                    v:Play();
                end;
            end;

            u5:Add(u27);
            task.delay(1, function() -- Line: 105
                -- upvalues: u5 (ref), u27 (copy)
                u5:Remove(u27);
            end);
            wait(0.1);
        end;
    end);
    wait(0.1);
    u5:Remove(v20);
    u5:Remove(v17);
    wait(1);
    u5:Remove(u8);
    wait(1);
    u5:Destroy();
end;