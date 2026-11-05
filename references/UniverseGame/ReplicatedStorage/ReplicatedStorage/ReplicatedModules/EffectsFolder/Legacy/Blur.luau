  

 

local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 4
    -- upvalues: LocalPlayer (copy), TweenService (copy)
    if p1 ~= LocalPlayer.Character then
        return;
    end;

    local BlurEffect = Instance.new("BlurEffect", game.Lighting);
    BlurEffect.Size = p2[1];
    BlurEffect.Enabled = true;
    wait(p2[2]);
    TweenService:Create(BlurEffect, TweenInfo.new(1), {
        Size = 0
    }):Play();
end;