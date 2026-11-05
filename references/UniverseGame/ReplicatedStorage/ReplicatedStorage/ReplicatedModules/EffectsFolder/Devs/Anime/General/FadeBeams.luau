  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
Random.new();

local function FadeBeams(u1, p2) -- Line: 9
    -- upvalues: EffectsHandler (copy), FadeBeams (copy)
    local u3 = p2 or {};

    if not u1 then
        return;
    end;

    local u4 = u3.Time or 0.25;
    local u5 = u3.TweenTextureSpeed or false;
    task.delay(u3.Delay or 0, function() -- Line: 20
        -- upvalues: u1 (copy), u3 (ref), u5 (copy), EffectsHandler (ref), u4 (copy), FadeBeams (ref)
        if typeof(u1) == "Instance" and not u1:IsDescendantOf(game) then
            return;
        end;

        for _, v in typeof(u1) == "table" and u1 or u1:GetDescendants() do
            if v:IsA("Beam") then
                local v6;

                if u3.FadeIn then
                    v6 = v.Transparency;
                    v.Transparency = NumberSequence.new(1);
                else
                    v6 = nil;
                end;

                v.Enabled = true;
                local v7 = {
                    Transparency = u3.TransparencyOverride and NumberSequence.new(u3.TransparencyOverride) or (v6 or NumberSequence.new(1))
                };

                if u5 then
                    v7.TextureSpeed = 0;
                end;

                EffectsHandler.CallEffect("Boat Tween", v, {
                    StepType = "RenderStepped",
                    Time = u4,
                    EasingStyle = u3.FadeIn and "EntranceExpressive" or "ExitExpressive",
                    EasingDirection = u3.FadeIn and "In" or "Out",
                    Goal = v7
                });
            end;
        end;

        if u3.RecursiveCall then
            FadeBeams(u1, u3.RecursiveCall);
        end;
    end);
end;

return FadeBeams;