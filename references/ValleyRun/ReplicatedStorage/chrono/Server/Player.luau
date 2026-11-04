 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Warn = require(script.Parent.Parent.Shared.Warn);
local Config = require(script.Parent.Parent.Shared.Config);
local Entity = require(script.Parent.Parent.Shared.Entity);
local Holder = require(script.Parent.Parent.Shared.Holder);
require(script.Parent.Parent.Shared.Types);
local _playerChars = Holder._playerChars;

local function RegisterPlayer(p1: userdata, p2: userdata, p3: table) -- Line: 14
    -- upvalues: _playerChars (copy), Entity (copy), Config (copy), Holder (copy)
    local v4 = _playerChars[p1];

    if v4 then
        Entity.Destroy(v4);
    end;

    local v5 = p3.config or "PLAYER";
    local v6 = p3.modelRepMode or (Config._EntityConfigs[v5] or {}).MODEL_REPLICATION_MODE;
    p2.Archivable = true;
    local v7 = p2:FindFirstChildWhichIsA("Humanoid");

    if v7 and (p2:FindFirstChild("HumanoidRootPart") and (v7.RigType == Enum.HumanoidRigType.R6 and p2.PrimaryPart == p2:FindFirstChild("Head"))) then
        Config.SetModelPrimaryForChrono(p2, "HumanoidRootPart");
    end;

    local v8 = Entity.new(v5, p2, v6);
    Holder.SetAsCharacter(p1, v8);
    Entity.SetNetworkOwner(v8, p1);

    return v8;
end;

local function UnregisterPlayer(p9: userdata) -- Line: 57
    -- upvalues: _playerChars (copy), Entity (copy)
    local v10 = _playerChars[p9];

    if v10 then
        Entity.Destroy(v10);
    end;
end;

local function OnCharacterAdded(p11: userdata, p12: userdata) -- Line: 64
    -- upvalues: RegisterPlayer (copy)
    task.wait(0.1);
    RegisterPlayer(p12, p11, {
        config = "PLAYER"
    });
end;

local function OnPlayerAdded(u13: userdata) -- Line: 71
    -- upvalues: RegisterPlayer (copy)
    local u15 = u13.CharacterAdded:Connect(function(p14: userdata) -- Line: 72
        -- upvalues: u13 (copy), RegisterPlayer (ref)
        task.wait(0.1);
        RegisterPlayer(u13, p14, {
            config = "PLAYER"
        });
    end);

    if u13.Character then
        local Character = u13.Character;
        task.wait(0.1);
        RegisterPlayer(u13, Character, {
            config = "PLAYER"
        });
    end;

    local u16 = nil;
    u16 = u13.AncestryChanged:Connect(function() -- Line: 79
        -- upvalues: u13 (copy), u15 (copy), u16 (ref)
        if not u13:IsDescendantOf(game) then
            u15:Disconnect();
            u16:Disconnect();
        end;
    end);
end;

Config._WaitForLock(function() -- Line: 87
    -- upvalues: RunService (copy), Config (copy), Warn (copy), Holder (copy), Players (copy), OnPlayerAdded (copy), UnregisterPlayer (copy)
    if not RunService:IsServer() then
        return;
    end;

    if Config._GetConfig("PLAYER_REPLICATION") ~= "AUTOMATIC" then
        Warn.low("automatic player replication is disabled");

        return;
    end;

    local Death = script.Parent.Parent.Shared.Remotes.Death;
    local u17 = Config._GetConfig("REPLICATE_DEATHS");
    Death.OnServerEvent:Connect(function(p18, p19) -- Line: 97
        -- upvalues: u17 (copy), Holder (ref), Death (copy)
        if u17 == "NONE" then
            return;
        end;

        local EntityFromId = Holder.GetEntityFromId(p19);

        if not EntityFromId then
            return;
        end;

        if EntityFromId.networkOwner ~= p18 then
            return;
        end;

        if u17 == "PLAYER_CHARACTERS" and not EntityFromId._player then
            return;
        end;

        local model = EntityFromId.model;

        if model then
            local u20 = model:FindFirstChildWhichIsA("Humanoid");
            task.wait();

            if u20 and u20:GetState() ~= Enum.HumanoidStateType.Dead then
                u20.Health = 0;
                task.delay(0, function() -- Line: 119
                    -- upvalues: u20 (copy)
                    if u20:GetState() ~= Enum.HumanoidStateType.Dead then
                        u20.Health = 0;
                        u20.Health = 10;
                        u20.Health = 0;
                    end;
                end);
            end;
        end;

        Death:FireAllClients(p19);
    end);
    Players.PlayerAdded:Connect(OnPlayerAdded);
    Players.PlayerRemoving:Connect(UnregisterPlayer);

    for _, v in Players:GetPlayers() do
        OnPlayerAdded(v);
    end;
end);

return {
    RegisterPlayer = RegisterPlayer,
    UnregisterPlayer = UnregisterPlayer
};