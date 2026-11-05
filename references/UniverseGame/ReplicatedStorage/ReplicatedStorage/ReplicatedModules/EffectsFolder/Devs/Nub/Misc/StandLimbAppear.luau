  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Promise = require(PathShortcuts.KnitPath.Promise);

return function(p1, u2, p3) -- Line: 3
    -- upvalues: Promise (copy)
    local v4 = type(p1) == "table" and p1 and p1 or { p1 };
    local u5 = type(p3) == "table" and (p3 or {}) or {};
    local TweenService = game:GetService("TweenService");

    for _, v in ipairs(v4) do
        if v:IsA("BasePart") then
            TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Transparency = u2
            }):Play();
        end;

        for _, descendant in ipairs(v:GetDescendants()) do
            Promise.try(function() -- Line: 12
                -- upvalues: descendant (copy), u5 (ref), TweenService (copy), u2 (copy)
                if (descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal"))) and not (table.find(u5, descendant) or table.find(u5, descendant.Name)) then
                    TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Transparency = u2
                    }):Play();
                end;
            end):catch(warn);
        end;
    end;
end;