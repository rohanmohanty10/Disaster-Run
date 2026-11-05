  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 2
    -- upvalues: TweenService (copy)
    local v2 = game.ReplicatedStorage["Client Assets"].Ball:Clone();
    v2.Parent = game.Workspace.Effects;
    v2.Position = p1.Position;
    game.Debris:AddItem(v2, 2.5);
    TweenService:Create(v2, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = Vector3.new(10, 10, 10)
    }):Play();
    wait(1);
    TweenService:Create(v2, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
        Size = Vector3.new(0, 0, 0)
    }):Play();
end;