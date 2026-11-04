  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Assets = ReplicatedStorage.Assets;
local VfxManager = require(ReplicatedStorage.VfxManager);

return function(p1: string, p2: any, p3: any) -- Line: 5
    -- upvalues: Assets (copy), VfxManager (copy)
    return {
        Type = "GoalEffect",
        HeaderOffset = 18,
        Name = p1,
        ProductId = p2,
        GiftProductId = p3,
        Gradient = script.GoalEffectGradient,

        LoadVisual = function(p4: any, p5: userdata) -- Line: 13, Name: LoadVisual
            -- upvalues: Assets (ref), VfxManager (ref)
            local v6 = Assets.LimitedTemplates.GoalTemplate:Clone();
            v6:ScaleTo(0.8);
            v6:PivotTo(p5.Origin.CFrame);
            v6.Origin.Transparency = 1;
            v6.Parent = p5;
            local vfx = p5.ManualGoalEffect.vfx;
            task.spawn(function() -- Line: 22
                -- upvalues: VfxManager (ref), vfx (copy)
                while true do
                    VfxManager.Emit(vfx);
                    task.wait(VfxManager.MaxLifetime(vfx) + 1);
                end;
            end);
        end
    };
end;