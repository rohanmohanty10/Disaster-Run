 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
require(script.Parent.Parent.Parent.mainreplication);
require(script.Parent.Parent.Parent.TekrinnDialogue);
require(script.Parent.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.Util);
local _ = Players.LocalPlayer;

return function(p1: string) -- Line: 16
    -- upvalues: ReplicatedStorage (copy)
    local v2 = workspace.map.something[`GoldenZone{p1}`];
    local v3 = ReplicatedStorage.Resources.chigiri.goldenzone:Clone();
    v3:SetAttribute("IgnoresTheKid", true);
    v3:PivotTo(v2.CFrame * CFrame.Angles(0, 1.5707963267948966, 0) - Vector3.new(0, 15, 0));
    v3.Parent = workspace.Effects;
end;