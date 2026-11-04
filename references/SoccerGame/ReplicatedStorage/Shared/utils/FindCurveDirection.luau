  

local Players = game:GetService("Players");
game:GetService("StarterPlayer");
local _ = Players.LocalPlayer;

return function(p1) -- Line: 6, Name: FindCurveDirection
    local _ = p1.Team;
    local CFrame = p1.Character.HumanoidRootPart.CFrame;
    local v2 = nil;
    local v3 = nil;

    for _, child in game.Workspace.Goals:GetChildren() do
        if child:IsA("BasePart") then
            local Magnitude = (child.Position - CFrame.p).Magnitude;

            if v2 == nil or Magnitude < v3 then
                v3 = Magnitude;
                v2 = child;
            end;
        end;
    end;

    local v4 = v2.CFrame.LookVector:Dot((v2.Position - CFrame.p).Unit);

    if v2.Name == "Home" then
        if v4 <= 0 then
            return -p1.Character.HumanoidRootPart.CFrame.RightVector;
        end;

        return p1.Character.HumanoidRootPart.CFrame.RightVector;
    end;

    if v4 >= 0 then
        return p1.Character.HumanoidRootPart.CFrame.RightVector;
    end;

    return -p1.Character.HumanoidRootPart.CFrame.RightVector;
end;