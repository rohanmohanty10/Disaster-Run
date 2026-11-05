  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    for _ = 1, 4 do
        local v3 = nil;
        local v4 = nil;

        if p2 == "Left" then
            local Angles = CFrame.Angles;
            local v5 = math.random(30, 45);
            local v6 = math.rad(v5);
            local v7 = math.random(-105, -75);
            v3 = Angles(3.141592653589793, v6, (math.rad(v7)));
            v4 = CFrame.Angles(-2.6179938779914944, 0, 0);
        elseif p2 == "Right" then
            local Angles = CFrame.Angles;
            local v8 = math.random(-45, -30);
            local v9 = math.rad(v8);
            local v10 = math.random(-105, -75);
            v3 = Angles(3.141592653589793, v9, (math.rad(v10)));
            v4 = CFrame.Angles(2.6179938779914944, 0, 0);
        end;

        local v11 = ReplicatedStorage["Client Assets"].Reaper.Slash:Clone();
        v11.CFrame = p1.CFrame:ToWorldSpace(v3);
        v11.Parent = workspace.Effects;
        TweenService:Create(v11, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
            Size = v11.Size * Vector3.new(0.01, 1.2, 1.2),
            CFrame = v11.CFrame:ToWorldSpace(v4)
        }):Play();
        TweenService:Create(v11, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        game.Debris:AddItem(v11, 0.4);
    end;
end;