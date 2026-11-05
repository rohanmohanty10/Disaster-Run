  

 

game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local u1 = Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = Players.LocalPlayer;
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 23
    -- upvalues: u2 (copy), u1 (copy), EffectsHandler (copy), TableUtil (copy)
    local Character = p3.Character;

    if not Character then
        return;
    end;

    local v4 = p3.Attribute or "RockTrail";
    local v5 = p3.RockData or {};
    local v6 = p3.MinDistance or 2.5;
    local v7 = p3.Interval or 0.025;
    local v8 = p3.RootPart or Character:FindFirstChild("Torso");

    if not v8 then
        return;
    end;

    local Name = v8.Name;
    local v9 = v8.Position * Vector3.new(1, 0, 1);

    while Character and (Character:IsDescendantOf(game) and (Character:GetAttribute(v4) and Character:FindFirstChild(Name))) do
        if v6 < (v8.Position * Vector3.new(1, 0, 1) - v9).Magnitude and workspace:Raycast(v8.Position, Vector3.new(0, -6.5, 0), u2) then
            local v10 = v5.SideOffset or math.random(3, 4);

            if typeof(v10) == "NumberRange" then
                v10 = u1:NextNumber(v10.Min, v10.Max);
            end;

            EffectsHandler.CallEffect("Sharm Rock Trail", v8.CFrame, v10, TableUtil.Reconcile(v5, {
                MaxRange = 3,
                Frequency = 6,
                FadeIn = 0.1,
                FadeOut = 1,
                Duration = 1.5,
                CollisionGroup = "NoCollision",
                LookAtPosition = (v8.CFrame * CFrame.new(0, 5, 0)).Position
            }));
            v9 = v8.Position * Vector3.new(1, 0, 1);
        end;

        task.wait(v7);
    end;
end;