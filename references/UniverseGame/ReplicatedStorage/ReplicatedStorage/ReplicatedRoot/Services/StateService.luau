  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local u1 = {
    Name = "StateService",
    StateContainers = {}
};
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);

function u1.GetStateContainer(p2) -- Line: 21
    -- upvalues: u1 (copy)
    return u1.StateContainers[p2];
end;

function u1.CreateStateContainer(u3) -- Line: 25
    -- upvalues: u1 (copy), Trove (copy)
    local v4 = u1.GetStateContainer(u3);

    if v4 ~= nil then
        return v4;
    end;

    local u5 = {
        States = {},
        Collector = Trove.new()
    };
    u5.Collector:Connect(u3.Destroying, function() -- Line: 35
        -- upvalues: u5 (copy), u1 (ref), u3 (copy)
        u5.Collector:Destroy();
        u1.StateContainers[u3] = nil;
    end);
    u1.StateContainers[u3] = u5;

    return u5;
end;

function u1.RemoveStateContainer(p6) -- Line: 45
    -- upvalues: u1 (copy)
    local v7 = u1.GetStateContainer(p6);

    if v7 then
        v7.Collector:Destroy();
        u1.StateContainers[p6] = nil;
    end;
end;

function u1.GetState(p8, p9) -- Line: 53
    -- upvalues: u1 (copy)
    local v10 = u1.GetStateContainer(p8);

    return v10 and v10.States[p9 or "_MainState"] or nil;
end;

function u1.CreateState(p11, p12) -- Line: 59
    -- upvalues: u1 (copy)
    local u13 = p12 or "_MainState";
    local u14 = u1.CreateStateContainer(p11);
    local v15 = u14.States[u13];

    if v15 ~= nil then
        return v15;
    end;

    local u16 = {
        Collector = u14.Collector:Extend()
    };
    u16.Collector:Connect(p11.Destroying, function() -- Line: 70
        -- upvalues: u16 (copy), u14 (copy), u13 (copy)
        u16.Collector:Destroy();
        u14.States[u13] = nil;
    end);
    u14.States[u13] = u16;

    return u16;
end;

function u1.RemoveState(p17, p18) -- Line: 80
    -- upvalues: u1 (copy)
    local v19 = p18 or "_MainState";
    local v20 = u1.GetStateContainer(p17);

    if v20 ~= nil then
        local v21 = v20.States[v19];

        if v21 ~= nil then
            v21.Collector:Destroy();
            v20.States[v19] = nil;
        end;
    end;
end;

function u1.ResetState(p22, p23) -- Line: 92
    -- upvalues: u1 (copy)
    local v24 = p23 or "_MainState";
    u1.RemoveState(p22, v24);
    u1.CreateState(p22, v24);
end;

function u1.WaitForState(p25, p26, p27) -- Line: 98
    -- upvalues: u1 (copy)
    local v28 = u1.GetState(p25, p26 or "_MainState");
    local v29 = os.clock();

    while not v28 do
        v28 = u1.GetState(p25);

        if p27 and p27 <= os.clock() - v29 then
            break;
        end;

        task.wait();
    end;

    return v28;
end;

function u1._Init() -- Line: 112
    -- upvalues: Core (copy), u1 (copy)
    if Core.Context ~= "Studio" then
        local function PlayerAdded(p30) -- Line: 114
            -- upvalues: Core (ref), u1 (ref)
            if p30 ~= game.Players.LocalPlayer and Core.Context == "Client" then
                return;
            end;

            if not u1.GetStateContainer(p30) then
                u1.CreateStateContainer(p30);
            end;

            if not u1.GetState(p30) then
                u1.CreateState(p30);
            end;

            local u31 = u1.GetState(p30);

            local function CharacterRemoving(p32) -- Line: 128
                -- upvalues: u1 (ref)
                u1.RemoveStateContainer(p32);
            end;

            local function CharacterAdded(p33) -- Line: 132
                -- upvalues: u31 (copy), u1 (ref)
                u31.CharacterState = u1.CreateState(p33);
            end;

            if p30.Character then
                u31.CharacterState = u1.CreateState(p30);
            end;

            u31.Collector:Connect(p30.CharacterAdded, CharacterAdded);
            u31.Collector:Connect(p30.CharacterRemoving, CharacterRemoving);
        end;

        local function PlayerRemoving(p34) -- Line: 143
            -- upvalues: Core (ref), u1 (ref)
            if p34 ~= game.Players.LocalPlayer and Core.Context == "Client" then
                return;
            end;

            if u1.GetStateContainer(p34) then
                u1.RemoveStateContainer(p34);
            end;
        end;

        if Core.Context == "Server" then
            for _, v in pairs(game.Players:GetPlayers()) do
                task.spawn(PlayerAdded, v);
            end;
        elseif Core.Context == "Client" then
            PlayerAdded(game.Players.LocalPlayer);
        end;

        game.Players.PlayerAdded:Connect(PlayerAdded);
        game.Players.PlayerRemoving:Connect(PlayerRemoving);
    end;
end;

return u1;