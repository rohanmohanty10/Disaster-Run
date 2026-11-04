 
 

local Players = game:GetService("Players");
game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.packets);
require(ReplicatedStorage.util.actionUtil);
Players.LocalPlayer:GetMouse();
local _ = workspace.CurrentCamera;
local script_Parent = script.Parent;

local function removeFromTable(p1, p2) -- Line: 18
    local table_find_ret = table.find(p1, p2);

    if table_find_ret then
        table.remove(p1, table_find_ret);
    end;

    return p1;
end;

local function getMove(p3, p4) -- Line: 26
    -- upvalues: script_Parent (copy)
    local Attribute = p3.character:GetAttribute("hasnelActive");
    local v5 = script_Parent:FindFirstChild(Attribute and "nelisagi" or "isagi");

    if not v5 then
        print("couldnt find inside baseclient", Attribute);

        return;
    end;

    local v6 = require(v5);

    if v6[`skill{tostring(p4)}`] then
        v6[`skill{tostring(p4)}`](p3);

        return true;
    end;

    print("couldnt find skill index");
end;

local v7 = {
    __index = {}
};

for i = 1, 5 do
    v7[`skill{i}`] = function(p8, ...) -- Line: 46
        -- upvalues: getMove (copy), i (copy)
        if getMove(p8, i, ...) then
            return;
        end;

        p8:senduse({ (`skill{i}`) });
    end;

    local _ = i;
end;

return v7;