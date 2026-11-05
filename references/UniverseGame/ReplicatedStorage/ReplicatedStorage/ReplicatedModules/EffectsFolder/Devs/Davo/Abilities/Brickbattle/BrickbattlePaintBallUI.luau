  

 

local LocalPlayer = game.Players.LocalPlayer;
game:GetService("CollectionService");
game:GetService("TweenService");
game:GetService("StarterGui");
local u1 = game.ReplicatedStorage["Client Assets"];

return function(p2) -- Line: 7
    -- upvalues: LocalPlayer (copy), u1 (copy)
    if LocalPlayer.PlayerGui:FindFirstChild("PaintballUI") then
        LocalPlayer.PlayerGui.PaintballUI.AddSplatter:Fire(p2);

        return;
    end;

    local v3 = u1.Brickbattle.PaintballUI:Clone();
    v3:SetAttribute("SplatterColor", p2);
    v3.Parent = LocalPlayer.PlayerGui;
    v3.Enabled = true;
    v3.Handler.Disabled = false;
end;