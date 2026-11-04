 

 

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

return function() -- Line: 16
    local goldenzone = workspace.Effects:FindFirstChild("goldenzone");

    if goldenzone then
        goldenzone.Name = "fadinggoldenzone";

        for _, descendant in goldenzone:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, goldenzone.Destroy, goldenzone);
    end;
end;