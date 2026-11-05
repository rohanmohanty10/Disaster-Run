  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Promise);
local Trove = require(Knit.Util.Trove);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(u1, u2, p3, ...) -- Line: 7
    -- upvalues: Trove (copy), EffectsHandler (copy)
    local u4 = { ... };
    local u5 = (p3 or {}).Max or nil;
    local u6 = 0;
    local u7 = Trove.new();
    u7:AttachToInstance(u1);
    u7:Connect(u1.AncestryChanged, function() -- Line: 16
        -- upvalues: u1 (copy), u7 (copy)
        if not u1:IsDescendantOf(workspace) then
            u7:Destroy();
        end;
    end);
    u7:Connect(u1.Touched, function(p8) -- Line: 22
        -- upvalues: u1 (copy), EffectsHandler (ref), u2 (copy), u6 (ref), u5 (copy), u7 (copy), u4 (copy)
        if p8:IsDescendantOf(u1) then
            return;
        end;

        if not p8.CanCollide then
            return;
        end;

        if u1:FindFirstChildOfClass("Sound") then
            local v9 = u1:FindFirstChildOfClass("Sound");
            v9.Pitch = v9.Pitch * 0.75;
            u1:FindFirstChildOfClass("Sound"):Play();
        end;

        if EffectsHandler.GetEffect(u2) then
            u6 = u6 + 1;

            if u5 and u5 <= u6 then
                u7:Destroy();
            end;

            EffectsHandler.CallEffect(u2, unpack(u4));
        end;
    end);
end;