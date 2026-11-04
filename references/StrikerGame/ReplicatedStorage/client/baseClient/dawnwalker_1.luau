 
 

game:GetService("ReplicatedStorage");
local v1 = {
    __index = {}
};
local script_Parent = script.Parent;

local function get_copied_content(u2: any, u3: number) -- Line: 8
    -- upvalues: script_Parent (copy)
    local character = u2.character;
    local v4 = `copiedskill{u3}`;

    if typeof(character:GetAttribute(v4)) ~= "string" then
        return nil;
    end;

    local Attribute = u2.character:GetAttribute((`copiedskill{u3}`));
    local table_unpack_ret, u5 = table.unpack(Attribute:split("|"));
    local v6 = script_Parent:FindFirstChild(table_unpack_ret);

    if not v6 then
        return nil;
    end;

    local v7 = require(v6)[`skill{u5}`];

    if v7 then
        v7((setmetatable({}, {
            __index = function(p8, p9) -- Line: 27, Name: __index
                -- upvalues: u5 (copy), u3 (copy), u2 (copy)
                if p9 ~= "senduse" then
                    return u2[p9];
                end;

                local u10 = `skill{u5}`;

                return function(p11: any, p12: table, ...) -- Line: 30
                    -- upvalues: u10 (copy), u3 (ref), u2 (ref)
                    if typeof(p12) == "table" and (typeof(p12[1]) == "string" and p12[1]:find(u10, 1, true)) then
                        p12[1] = p12[1]:gsub(u10, (`skill{u3}`));
                    end;

                    return u2:senduse(p12, ...);
                end;
            end,

            __newindex = function(p13, p14, p15) -- Line: 42, Name: __newindex
                -- upvalues: u2 (copy)
                u2[p14] = p15;
            end
        })));

        return true;
    end;

    u2:senduse({ (`skill{u3}`) });

    return true;
end;

function v1.skill5(p16) -- Line: 51
    -- upvalues: get_copied_content (copy)
    if get_copied_content(p16, 5) then
        return;
    end;

    p16:senduse({ "skill5" });
end;

return v1;