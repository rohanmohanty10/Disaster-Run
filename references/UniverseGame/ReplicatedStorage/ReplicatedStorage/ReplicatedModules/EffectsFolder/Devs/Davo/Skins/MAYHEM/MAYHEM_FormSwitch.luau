  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1, p2) -- Line: 7
    -- upvalues: EffectsHandler (copy)
    for i = 1, 3 do
        EffectsHandler.CallEffect("Glitcher Blink", {
            Image = 2092248396,
            Size = 0,
            BonusSize = 30,
            Parent = p1.HumanoidRootPart,
            Color = p2,
            Delay = i + (i >= 3 and (i / 3 or 0) or 0)
        });
    end;

    local v3 = p1:FindFirstChild("Form Switch SFX", true);

    if v3 then
        v3:Play();
    end;
end;