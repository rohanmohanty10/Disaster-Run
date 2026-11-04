 
 

local TweenService = game:GetService("TweenService");

local function timescale(p1, p2, p3) -- Line: 3
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            TweenService:Create(descendant, TweenInfo_new_ret, {
                TimeScale = p2
            }):Play();
        end;
    end;
end;

return {
    { 0, function(p4, p5) -- Line: 14
            -- upvalues: timescale (copy)
            shared.vfx.emit(p4.hit);
            shared.vfx.emit(p4.haha);
            timescale(p4.hit, 0.1, 0.35);
        end },
    { 38, function(p6, p7) -- Line: 21
            -- upvalues: timescale (copy)
            timescale(p6.hit, 1, 0.01);
            shared.vfx.emit(p6.parry);
        end }
};