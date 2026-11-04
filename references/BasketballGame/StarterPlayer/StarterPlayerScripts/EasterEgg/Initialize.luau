 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return {
    initialize = function() -- Line: 5, Name: initializeEasterEgg
        -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy)
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "EasterEgg";
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        local ImageButton = Instance.new("ImageButton");
        ImageButton.Size = UDim2.new(0, 100, 0, 100);
        ImageButton.AnchorPoint = Vector2.new(0, 1);
        ImageButton.Position = UDim2.new(0, 10, 1, -50);
        ImageButton.Name = "EasterEgg";
        ImageButton.Image = "rbxassetid://122272694136474";
        ImageButton.Parent = ScreenGui;
        ImageButton.Activated:Connect(function() -- Line: 18
            -- upvalues: ReplicatedStorage (ref)
            print("MANGO OBBY TIME");
            ReplicatedStorage.EasterEgg:FireServer();
        end);
    end
};