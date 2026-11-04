 
 

repeat
    task.wait();
until game:IsLoaded();

local Character = game:GetService("Players").LocalPlayer.Character;
local script_Parent = script.Parent;
local Humanoid = Character:WaitForChild("Humanoid");

local function ChangeMovement(p1) -- Line: 10
    -- upvalues: script_Parent (copy)
    for _, child in ipairs(p1:GetChildren()) do
        script_Parent:SetAttribute(child.Name .. "Multiplier", child.Value);
    end;
end;

Humanoid.Changed:Connect(function(p2) -- Line: 16
    -- upvalues: Humanoid (copy), ChangeMovement (copy)
    if p2 == "WalkSpeed" then
        if Humanoid.WalkSpeed >= 25 then
            ChangeMovement(script.Running);

            return;
        end;

        ChangeMovement(script.Walking);
    end;
end);