 
 

local TweenService = game:GetService("TweenService");

return function(p1, p2, p3) -- Line: 3
    -- upvalues: TweenService (copy)
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:SetAttribute("TimeScale", descendant.TimeScale);
            TweenService:Create(descendant, p2, {
                TimeScale = p3
            }):Play();
        end;
    end;
end;