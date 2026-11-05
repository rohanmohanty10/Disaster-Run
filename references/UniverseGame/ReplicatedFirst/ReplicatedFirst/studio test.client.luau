  

 

local LocalPlayer = game.Players.LocalPlayer;

if game:GetService("RunService"):IsStudio() and LocalPlayer.UserId == 110231579 then
    LocalPlayer.CharacterAdded:Connect(function(p1) -- Line: 3
        -- upvalues: LocalPlayer (copy)
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-409, 10, -159);
    end);
end;