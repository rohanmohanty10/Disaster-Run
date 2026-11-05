 

 

local u1 = {};
local l__Heartbeat__1 = game:GetService("RunService").Heartbeat;
local u2 = {};
local u3 = {};
local u4 = {
    Instance = "Destroy",
    table = true,
    RBXScriptConnection = "Disconnect"
};
local u5 = {
    "Destroy",
    "Disconnect",
    "destroy",
    "disconnect"
};
local function u9(p6, p7) --[[ Line: 52 ]]
    -- upvalues: u5 (copy)
    if p6 == "Instance" then
        pcall(p7.Destroy, p7);
    elseif p6 == "RBXScriptConnection" then
        pcall(p7.Disconnect, p7);
    else
        for _, v8 in ipairs(u5) do
            if p7[v8] then
                pcall(p7[v8], v8);
                return;
            end;
        end;
    end;
end;
local function u16(u10, p11) --[[ Line: 67 ]]
    -- upvalues: u4 (copy), u2 (copy), u3 (copy), l__Heartbeat__1 (copy), u9 (copy)
    if u10 then
        local u12 = typeof(u10);
        local v13 = u4[typeof(u10)];
        assert(v13);
        local v14 = typeof(p11) == "number";
        assert(v14);
        if not u2[u10] then
            table.insert(u2, u10);
        end;
        u2[u10] = {
            lifeTime = p11,
            removalTime = tick() + p11,
            Cancel = function() --[[ Name: Cancel, Line 83 ]]
                -- upvalues: u3 (ref), u10 (copy), u2 (ref)
                u3[u10]:Disconnect();
                table.remove(u2, table.find(u2, u10));
                u2[u10] = nil;
            end,
            Instance = u10
        };
        local u15 = u2[u10];
        u3[u10] = l__Heartbeat__1:Connect(function() --[[ Line: 93 ]]
            -- upvalues: u15 (ref), u10 (copy), u12 (copy), u9 (ref), u2 (ref)
            if u15 and (tick() >= u15.removalTime or (not u10 or u12 == "Instance" and not u10.Parent)) then
                if u15.Destroyed then
                    u15.Destroyed();
                end;
                u15.Cancel();
                u9(u12, u10);
            end;
            u15 = u2[u10];
        end);
        return u2[u10];
    end;
end;
function u1.AddItem(_, p17, p18) --[[ Line: 112 ]]
    -- upvalues: u1 (copy), u16 (copy)
    if typeof(p17) == "table" then
        return u1:AddItems(p17, p18);
    end;
    local v19 = tonumber(p18) or 0.03333333333333333;
    if v19 >= 5 or typeof(p17) ~= "Instance" then
        return u16(p17, v19);
    end;
    local v20 = v19 < 0.001 and 0.001 or v19;
    game:GetService("Debris"):AddItem(p17, v20);
end;
function u1.AddItems(_, p21, p22) --[[ Line: 132 ]]
    -- upvalues: u16 (copy)
    local v23 = tonumber(p22) or 0.03333333333333333;
    for _, v24 in ipairs(p21) do
        if v23 >= 5 or typeof(v24) ~= "Instance" then
            u16(v24, v23);
        else
            v23 = v23 < 0.001 and 0.001 or v23;
            game:GetService("Debris"):AddItem(v24, v23);
        end;
    end;
end;
function u1.GetAllDebris(_) --[[ Line: 150 ]]
    -- upvalues: u2 (copy)
    return u2;
end;
u1.getAllDebris = u1.GetAllDebris;
function u1.GetDebris(_, p25) --[[ Line: 155 ]]
    -- upvalues: u2 (copy)
    return u2[p25];
end;
u1.getDebris = u1.GetDebris;
return u1;