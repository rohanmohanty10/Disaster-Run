  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
Petal("Util");
Petal("New");
local v2 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = v2.Rng;
local u3 = UDim2.new(1, 0, 0.1, 0);
local u4 = UDim2.new(1, 0, 0.12, 0);

local function MakeUI(u5) -- Line: 30
    -- upvalues: AssetHandler (copy), Players (copy), Trove (copy), Fusion (copy), u3 (copy), u4 (copy)
    local u6 = AssetHandler.CloneAsset("Misc/TeleportUI", AssetHandler.GetAbilityData(Players.LocalPlayer));

    if not u6 then
        return nil;
    end;

    local u7 = Trove.new();
    u7:AttachToInstance(u5);
    local Assets = u6:FindFirstChild("Assets");
    local v8 = workspace.Map.DeltaTeleports:GetChildren();
    local v9 = Fusion.Value(true);
    local v14 = Fusion.ForValues(v8, function(u10) -- Line: 42
        -- upvalues: Assets (copy), Fusion (ref), u3 (ref), u5 (copy), u4 (ref)
        local v11 = Assets:FindFirstChild("Location"):Clone();
        local u12 = Fusion.Value(u3);
        local u13 = Fusion.Value(1);
        Fusion.Hydrate(v11.Button)({
            Text = u10.Name,
            Name = u10.Name,

            [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 51
                -- upvalues: u5 (ref), u10 (copy)
                u5:FireServer(u10);
            end,

            [Fusion.OnEvent("MouseEnter")] = function() -- Line: 54
                -- upvalues: u12 (copy), u4 (ref), u13 (copy)
                u12:set(u4);
                u13:set(2);
            end,

            [Fusion.OnEvent("MouseLeave")] = function() -- Line: 58
                -- upvalues: u12 (copy), u3 (ref), u13 (copy)
                u12:set(u3);
                u13:set(1);
            end
        });
        Fusion.Hydrate(v11.UIStroke)({
            Thickness = Fusion.Spring(u13, 25, 0.575)
        });
        Fusion.Hydrate(v11)({
            Visible = true,
            Size = Fusion.Spring(u12, 30, 0.575)
        });

        return v11;
    end, Fusion.cleanup);
    Fusion.Hydrate(u6)({
        Name = "Delta_TeleportUI",
        Visible = v9,
        Parent = Players.LocalPlayer.PlayerGui.UI.Gameplay
    });
    Fusion.Hydrate(u6.Close)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 83
            -- upvalues: u5 (copy), u7 (copy)
            u5:FireServer(nil);
            u7:Destroy();
        end
    });
    Fusion.Hydrate(u6.Holder)({
        [Fusion.Children] = v14
    });
    u7:Add(u6);
    task.spawn(function() -- Line: 95
        -- upvalues: u6 (copy)
        local Neon = u6:FindFirstChild("Tri"):FindFirstChild("Neon");

        while u6 and u6.Parent do
            local v15 = task.wait();

            if not (u6 and u6.Parent) then
                break;
            end;

            local UIGradient = Neon.UIGradient;
            UIGradient.Rotation = UIGradient.Rotation + v15 * 220;
        end;
    end);

    return u6;
end;

return function(p16) -- Line: 112
    -- upvalues: Players (copy), MakeUI (copy)
    if Players.LocalPlayer.PlayerGui.UI.Gameplay:FindFirstChild("Delta_TeleportUI") then
        Players.LocalPlayer.PlayerGui.UI.Gameplay:FindFirstChild("Delta_TeleportUI"):Destroy();
    end;

    MakeUI(p16);
end;