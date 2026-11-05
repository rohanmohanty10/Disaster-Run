  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2, u3) -- Line: 3
    -- upvalues: TweenService (copy)
    local u4 = p1["Right Arm"];

    if p2 == true then
        u4 = p1["Left Arm"];
    end;

    u4.CanCollide = false;
    local v5 = u4:Clone();
    v5.Parent = u4;
    v5.CanCollide = true;
    v5.CFrame = u4.CFrame;
    v5.Anchored = false;
    TweenService:Create(u4, TweenInfo.new(0.1), {
        Transparency = 1
    }):Play();
    coroutine.wrap(function() -- Line: 16
        -- upvalues: u3 (copy), TweenService (ref), u4 (ref)
        wait(u3 + 1);
        TweenService:Create(u4, TweenInfo.new(0.5), {
            Transparency = 0
        }):Play();
    end)();
    local v6 = game.ReplicatedStorage["Client Assets"].BakEffects.Blood:Clone();
    v6.Parent = u4;
    v6.CFrame = p1.HumanoidRootPart.CFrame * CFrame.new(1.5, 0.5, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    local Weld = Instance.new("Weld");
    Weld.Part0 = p1.HumanoidRootPart;
    Weld.Part1 = v6;
    Weld.C0 = CFrame.new(1.5, 0.5, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    Weld.Parent = v6;
    game.Debris:AddItem(v5, u3);
    game.Debris:AddItem(v6, u3);
end;