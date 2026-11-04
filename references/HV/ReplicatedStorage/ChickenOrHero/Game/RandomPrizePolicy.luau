 

 

local Players = game:GetService("Players");
local PolicyService = game:GetService("PolicyService");
local RunService = game:GetService("RunService");
local u1 = {
    TestAttribute = "NoRandomPrizesTest",
    Changed = Instance.new("BindableEvent")
};
local u2 = setmetatable({}, {
    __mode = "k"
});
local u3 = false;

local function testSwitch(p4) -- Line: 25
    if game.PlaceId ~= 130574217370467 then
        return nil;
    end;

    local Attribute = p4:GetAttribute("NoRandomPrizesTest");

    if type(Attribute) == "boolean" then
        return Attribute;
    end;

    return nil;
end;

function u1.restricted(p5) -- Line: 33
    -- upvalues: Players (copy), u2 (copy)
    local v6 = p5 or Players.LocalPlayer;

    if typeof(v6) ~= "Instance" or not v6:IsA("Player") then
        return false;
    end;

    local v7;

    if game.PlaceId == 130574217370467 then
        v7 = v6:GetAttribute("NoRandomPrizesTest");

        if type(v7) ~= "boolean" then
            v7 = nil;
        end;
    else
        v7 = nil;
    end;

    if v7 == nil then
        return u2[v6] == true;
    end;

    return v7;
end;

local u8 = setmetatable({}, {
    __mode = "k"
});

local function settle(p9) -- Line: 46
    -- upvalues: u1 (copy), u8 (copy)
    local v10 = u1.restricted(p9);

    if (u8[p9] or false) ~= v10 then
        u8[p9] = v10;
        u1.Changed:Fire(p9, v10);
    end;
end;

local function ask(p11) -- Line: 54
    -- upvalues: Players (copy), PolicyService (copy), u2 (copy), u1 (copy), u8 (copy)
    for i = 1, 4 do
        if p11.Parent ~= Players then
            return;
        end;

        local success, result = pcall(PolicyService.GetPolicyInfoForPlayerAsync, PolicyService, p11);

        if success and type(result) == "table" then
            u2[p11] = result.ArePaidRandomItemsRestricted == true;
            local v12 = u1.restricted(p11);

            if (u8[p11] or false) ~= v12 then
                u8[p11] = v12;
                u1.Changed:Fire(p11, v12);
            end;

            return;
        end;

        task.wait(i * 5);
        local _ = i;
    end;

    warn("[RandomPrizePolicy] no policy answer for " .. p11.Name .. "; treated as not restricted");
end;

local function watch(u13) -- Line: 70
    -- upvalues: u8 (copy), u1 (copy), ask (copy)
    u8[u13] = u1.restricted(u13);
    u13:GetAttributeChangedSignal("NoRandomPrizesTest"):Connect(function() -- Line: 72
        -- upvalues: u13 (copy), u1 (ref), u8 (ref)
        local v14 = u13;
        local v15 = u1.restricted(v14);

        if (u8[v14] or false) ~= v15 then
            u8[v14] = v15;
            u1.Changed:Fire(v14, v15);
        end;
    end);
    task.spawn(ask, u13);
end;

function u1.start() -- Line: 78
    -- upvalues: u3 (ref), u1 (copy), RunService (copy), Players (copy), watch (copy)
    if u3 then
        return u1;
    end;

    u3 = true;

    if RunService:IsServer() then
        Players.PlayerAdded:Connect(watch);

        for _, v in Players:GetPlayers() do
            watch(v);
        end;
    elseif Players.LocalPlayer then
        watch(Players.LocalPlayer);
    end;

    return u1;
end;

return u1;