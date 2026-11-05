  

 

local Parent = script.Parent;
local LocalPlayer = game.Players.LocalPlayer;
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = v1:WaitForChild("Humanoid", 5);
Parent:WaitForChild("Body", 1);
local Bell = Parent.Body.Bell;
local Riding = Parent.Body.Riding;
local v2 = os.time();

while Parent:IsDescendantOf(workspace) and v1:IsDescendantOf(workspace) do
    if Humanoid.MoveDirection.Magnitude > 0 and Humanoid.WalkSpeed > 0 then
        Riding.Playing = true;

        if os.time() - v2 >= 5 then
            Bell:Play();
            v2 = os.time();
        end;
    else
        Riding.Playing = false;
    end;

    task.wait(1);
end;