  

 

local TweenService = game:GetService("TweenService");
local u1 = TweenInfo.new(0.35);

return function(p2, p3, p4) -- Line: 6
    -- upvalues: TweenService (copy), u1 (copy)
    local v5 = p2:Clone();
    v5.Anchored = true;
    v5.CFrame = p3;
    v5.Parent = workspace.Effects;
    TweenService:Create(v5, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = p4
    }):Play();
    task.wait(0.25);
    TweenService:Create(v5, u1, {
        Transparency = 1
    }):Play();

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, u1, {
                Transparency = 1
            }):Play();
        elseif table.find({ "ParticleEmitter", "Trail" }, descendant.ClassName) then
            descendant.Enabled = false;
        end;
    end;

    task.delay(1, v5.Destroy, v5);
end;