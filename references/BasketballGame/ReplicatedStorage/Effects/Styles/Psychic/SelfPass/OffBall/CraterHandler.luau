 
 

local u1 = {};
require(script:WaitForChild("Modes"));
local Styles = require(script:WaitForChild("Styles"));
(function(p2, p3) -- Line: 8
    for _, v in ipairs(p3) do
        if v:IsA("ModuleScript") or v ~= "string" then
            p2[v.Name] = require(v);
        else
            p2[v.Name] = v;
        end;
    end;
end)(u1, script:WaitForChild("Presets"):GetChildren());

return {
    new = function(u4, u5, u6) -- Line: 24
        -- upvalues: Styles (copy)
        if not u6.PauseThread then
            task.spawn(function() -- Line: 27
                -- upvalues: Styles (ref), u4 (copy), u5 (copy), u6 (copy)
                local v7 = Styles[u4] and Styles[u4](u5, u6 or {});

                return v7;
            end);

            return;
        end;

        if u6.PauseThread ~= false then
            local v8 = Styles[u4] and Styles[u4](u5, u6 or {});

            return v8;
        end;

        task.spawn(function() -- Line: 35
            -- upvalues: Styles (ref), u4 (copy), u5 (copy), u6 (copy)
            local v9 = Styles[u4] and Styles[u4](u5, u6 or {});

            return v9;
        end);
    end,

    preset = function(p10, p11, p12) -- Line: 44
        -- upvalues: u1 (copy)
        local v13 = u1[p10] and u1[p10](p11, p12 or {});

        return v13;
    end
};