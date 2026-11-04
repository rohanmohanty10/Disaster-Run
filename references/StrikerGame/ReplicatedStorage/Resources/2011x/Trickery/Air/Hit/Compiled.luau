 

 

local TweenService = game:GetService("TweenService");

local function pulse(p1, u2) -- Line: 3
    -- upvalues: TweenService (copy)
    local Label = p1.Label;

    if not Label then
        return;
    end;

    Label.ImageColor3 = Color3.fromRGB(163, 0, 0);
    Label.ImageTransparency = 1;
    u2:Add(TweenService:Create(Label, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0.3
    }), "Cancel"):Play();
    u2:Add(task.delay(0.05, function() -- Line: 12
        -- upvalues: u2 (copy), TweenService (ref), Label (copy)
        u2:Add(TweenService:Create(Label, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }), "Cancel"):Play();
    end));
end;

return {
    { 0, function(p3, p4, p5, p6) -- Line: 19
            -- upvalues: pulse (copy)
            shared.vfx.emit(p3.FlashSteps);
            pulse(p5, p6);
        end },
    { 38, function(p7, p8, p9, p10) -- Line: 25
            -- upvalues: TweenService (copy), pulse (copy)
            shared.vfx.emit(p7.Hit);

            for _, v in p8 do
                v.FillTransparency = -3;
                p10:Add(TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                    FillTransparency = 1
                }), "Cancel"):Play();
            end;

            pulse(p9, p10);
        end },
    { 59, function(p11, p12, p13, p14) -- Line: 35
            shared.vfx.emit(p11.Throw);
        end }
};