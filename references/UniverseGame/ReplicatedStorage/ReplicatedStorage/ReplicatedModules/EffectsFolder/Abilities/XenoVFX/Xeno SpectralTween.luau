  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 3
    -- upvalues: TweenService (copy)
    if not (p1 and p1:IsDescendantOf(workspace)) then
        return;
    end;

    TweenService:Create(p1, TweenInfo.new(0.25), {
        CFrame = p2
    }):Play();
end;