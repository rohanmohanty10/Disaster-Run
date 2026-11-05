  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;

return function(p1) -- Line: 6
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), TweenService (copy)
    local v2 = ReplicatedStorage["Client Assets"].Universal.ZoomEffect:Clone();
    v2.Parent = LocalPlayer.PlayerGui;
    local v3 = os.clock();
    local v4 = 1;

    repeat
        local u5 = v2:FindFirstChild((tostring(v4)));
        coroutine.wrap(function() -- Line: 15
            -- upvalues: TweenService (ref), u5 (copy)
            TweenService:Create(u5, TweenInfo.new(0.05), {
                ImageTransparency = 0
            }):Play();
            wait(0.05);
            TweenService:Create(u5, TweenInfo.new(0.075), {
                ImageTransparency = 1
            }):Play();
        end)();
        local v6 = v4 + 1;
        v4 = v6 > 3 and 1 or v6;
        wait(0.05);
    until p1 <= os.clock() - v3;

    v2:Destroy();
end;