  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local v1 = {};
require(Core.ReplicatedLibraries.Utility.TableUtil);
require(Core.ReplicatedLibraries.Utility.CommonUtil);

local function CreateGroup(p2) -- Line: 15
    local v3 = {
        Parent = p2,
        Values = {}
    };

    if p2 then
        table.insert(p2.Values, v3);
    end;

    return v3;
end;

function v1.CalculateStackCheck(p4) -- Line: 26
    local v5 = {
        Parent = nil,
        Values = {}
    };
    local v6 = {
        Parent = v5,
        Values = {}
    };

    if v5 then
        table.insert(v5.Values, v6);
    end;

    for i in string.gmatch(p4, "([@%w%s%$_%(%))]+)") do
        local v7 = string.sub(i, 1, 1);
        local v8 = false;
        local v9, i;

        if string.sub(i, 1, 1) == "(" then
            v9 = {
                Parent = v6,
                Values = {}
            };

            if v6 then
                table.insert(v6.Values, v9);
            end;

            i = string.sub(i, 2);
        else
            v9 = v6;
        end;

        if string.sub(i, #i, #i) == ")" then
            i = string.sub(i, 1, #i - 1);
            v8 = true;
        end;

        if v7 == "/" then
            local Parent = v9.Parent;

            if Parent then
                v9 = {
                    Parent = Parent,
                    Values = {}
                };

                if Parent then
                    table.insert(Parent.Values, v9);
                end;

                table.insert(v9.Values, i);
            end;
        else
            table.insert(v9.Values, i);
        end;

        if v8 then
            v6 = v9.Parent or v9;
        else
            v6 = v9;
        end;
    end;

    return v5;
end;

return v1;