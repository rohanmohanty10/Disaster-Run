 

 

local Humanoid = script.Parent:WaitForChild("Humanoid", 10);

if Humanoid then
    Humanoid.BreakJointsOnDeath = false;
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false);
end;