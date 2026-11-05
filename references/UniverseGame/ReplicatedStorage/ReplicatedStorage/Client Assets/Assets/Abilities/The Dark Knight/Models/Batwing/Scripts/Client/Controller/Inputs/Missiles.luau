  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Players.LocalPlayer:GetMouse();
local Parent = script.Parent.Parent.Parent.Parent.Parent;
local PrimaryPart = Parent.PrimaryPart;
local Replicate = Parent.Scripts.Server.Replicate;
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return {
    Bind = Enum.KeyCode.R,

    Execute = function(p3, p4) -- Line: 22
        -- upvalues: u1 (copy), PrimaryPart (copy), u2 (copy), Replicate (copy)
        if p4 == Enum.UserInputState.Begin then
            local v5 = u1.Hit.Position + (u1.Hit.Position - PrimaryPart.Position).Unit * 1000;
            local v6 = workspace:Raycast(PrimaryPart.Position, (v5 - PrimaryPart.Position).Unit * 1000, u2);

            if v6 then
                v5 = v6.Position;
            end;

            Replicate:FireServer("Missiles", {
                Goal = v5
            });
        end;
    end
};