  

 

local LocalPlayer = game.Players.LocalPlayer;

return function() -- Line: 2
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.CFrame.Position + Vector3.new(0, 5, 0));
end;