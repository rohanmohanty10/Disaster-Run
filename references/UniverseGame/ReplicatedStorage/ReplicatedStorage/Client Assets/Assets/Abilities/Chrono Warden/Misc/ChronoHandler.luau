  

 

local PathShortcuts = require(game.ServerScriptService.ServerLibrary.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
require(Knit.Util.Promise);
require(Knit.Util.TableUtil);
local StatsHandler = require(PathShortcuts.ReplicatedModules.StatsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
game:GetService("Players");
local RunService = game:GetService("RunService");
local Output = Knit.Remotes.Output;

local function Lerp(p1, p2, p3) -- Line: 17
    return p1 + (p2 - p1) * p3;
end;

return function(u4) -- Line: 21
    -- upvalues: Trove (copy), AssetHandler (copy), StatsHandler (copy), ParticleHandler (copy), RunService (copy), Output (copy)
    if not u4.Parent then
        warn("No character");

        return;
    end;

    local u5 = Trove.new();
    local v6 = AssetHandler.GetAbilityData(u4);
    local v7 = AssetHandler.GetAsset("Particles/Aura1", v6);
    local v8 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };
    local u9 = 0;
    local u10 = game:GetService("Players"):GetPlayerFromCharacter(u4);

    if u10 then
        pcall(function() -- Line: 41
            -- upvalues: u10 (copy), StatsHandler (ref), u9 (ref)
            local v11 = u10:FindFirstChild("Data"):FindFirstChild("Skin"):GetAttribute("SkinName");
            u9 = StatsHandler.GetStats("Chrono Warden", v11).Stats.Aura.HueShift or 0;
        end);
    end;

    for _, child in pairs(u4:GetChildren()) do
        if table.find(v8, child.Name) then
            for _, child2 in pairs(v7:GetChildren()) do
                local v12 = child2:Clone();
                v12.Color = ParticleHandler.HSVShift(v12.Color, {
                    HueShift = u9
                });
                v12.Parent = child;
            end;
        end;
    end;

    u5:Connect(u4.AncestryChanged, function() -- Line: 65
        -- upvalues: u4 (copy), u5 (copy)
        if not u4.Parent then
            u5:Destroy();
        end;
    end);
    local u13 = 0;
    u5:Connect(RunService.Heartbeat, function() -- Line: 73
        -- upvalues: u13 (ref), Output (ref), u4 (copy)
        if os.clock() - u13 > 5 then
            u13 = os.clock();
            Output:FireAllClients("FX", "ChronoWarden_Passive", u4);
        end;
    end);
end;