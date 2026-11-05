  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
require(Core.ReplicatedLibraries.Utility.TableUtil);
local Trove = require(Core.ReplicatedLibraries.Classes.Trove);
require(Core.ReplicatedLibraries.Classes.Promise);
require(Core.ReplicatedServices.StateService);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 12
    -- upvalues: u1 (copy), Trove (copy)
    local v3 = p2 or {};
    local v4 = setmetatable({}, u1);
    v4.Character = v3.Character or nil;
    v4.Player = v3.Player or game.Players:GetPlayerFromCharacter(v4.Character);
    local v5;

    if v4.Character == nil then
        v5 = false;
    else
        v5 = v4.Character:FindFirstChildWhichIsA("Humanoid");
    end;

    v4.Humanoid = v5;
    local v6;

    if v4.Character == nil then
        v6 = false;
    else
        v6 = v4.Character:FindFirstChild("HumanoidRootPart");
    end;

    v4.RootPart = v6;
    v4.Collector = Trove.new();
    v4._Moves = {};
    v4._Tags = {};

    return v4;
end;

function u1.GetTag(p7, p8) -- Line: 30
    return p7._Tags[p8] == true;
end;

function u1.SetTag(p9, p10, p11) -- Line: 34
    local _ = p9._Tags[p10];
    p9._Tags[p10] = p11 == true and true or nil;
end;

function u1.GetMoves(p12, p13) -- Line: 41
    local v14 = p13 or {};
    local v15 = {};
    local v16 = v14.Name or nil;
    local v17 = v14.IncludeTags or (v14.Tags or nil);
    local v18 = v14.ExcludeTags or nil;
    local v19 = v14.Mode or "All";
    local v20;

    if v14.Valid == nil then
        v20 = nil;
    else
        v20 = v14.Valid;
    end;

    local v21;

    if v14.Enabled == nil then
        v21 = v20 or nil;
    else
        v21 = v14.Enabled;
    end;

    local v22;

    if v14.Check == nil then
        v22 = v20 or nil;
    else
        v22 = v14.Check;
    end;

    for _, v in pairs(p12._Moves) do
        local v23 = true;

        if (v16 == nil or v.Name == v16) and (v21 == nil or v.Enabled == v21) then
            local _ = v22 == nil;

            if v17 == nil then
                if v18 ~= nil then
                    for _, v2 in pairs(v18) do
                        if v:GetTag(v2) then
                            v23 = false;
                        end;
                    end;
                end;

                if v23 ~= false then
                    table.insert(v15, v);
                end;
            else
                local v24 = v19 == "All";

                for i in pairs(v.Tags) do
                    if table.find(v17, i) or (p12._Tags[i] or p12.Character:GetAttribute(i)) then
                        if v19 == "One" then
                            v24 = true;
                            break;
                        end;
                    elseif v19 == "All" then
                        v24 = false;
                        break;
                    end;
                end;

                if v24 ~= false then
                    if v18 ~= nil then
                        for _, v2 in pairs(v18) do
                            if v:GetTag(v2) then
                                v23 = false;
                            end;
                        end;
                    end;

                    if v23 ~= false then
                        table.insert(v15, v);
                    end;
                end;
            end;
        end;
    end;

    table.sort(v15, function(p25, p26) -- Line: 111
        return (p25.Priority or 0) > (p26.Priority or 0);
    end);

    return v15;
end;

function u1.GetFirstMove(p27, p28) -- Line: 118
    return p27:GetMoves(p28)[1];
end;

function u1.GetLastMove(p29, p30) -- Line: 122
    local v31 = p29:GetMoves(p30);

    return v31[#v31];
end;

function u1.AddMove(p32, p33, p34) -- Line: 127
    if table.find(p32._Moves, p33) ~= nil then
        return;
    end;

    if p34 ~= true then
        p33:SetController(p32, true);
    end;

    table.insert(p32._Moves, p33);
end;

function u1.RemoveMove(p35, p36, p37) -- Line: 137
    local v38 = table.find(p35._Moves, p36);

    if v38 then
        table.remove(p35._Moves, v38);

        if p37 ~= true then
            p36:SetController(nil, true);
        end;
    end;
end;

function u1.Destroy(p39) -- Line: 147
    if p39.Collector ~= nil then
        p39.Collector:Destroy();
    end;

    if p39._Moves ~= nil then
        for _, v in pairs(p39._Moves) do
            if not table.isfrozen(v) then
                v:SetController(nil, true);
            end;
        end;
    end;

    table.clear(p39);
    table.freeze(p39);
end;

return u1;