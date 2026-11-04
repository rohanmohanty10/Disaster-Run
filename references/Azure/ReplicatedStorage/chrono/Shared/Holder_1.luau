 
 

require(script.Parent.Types);
local Warn = require(script.Parent.Warn);
local _Signals = require(script.Parent.Events)._Signals;
local u1 = game:GetService("RunService"):IsServer();
local u2 = 0;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};

local function GetNextId() -- Line: 29
    -- upvalues: u3 (copy), u2 (ref)
    local table_remove_ret = table.remove(u3);

    if table_remove_ret then
        return table_remove_ret;
    end;

    if u2 >= 65535 then
        error("Max ID reached, please investigate.");
    end;

    u2 = u2 + 1;

    return u2;
end;

local Random_new_ret = Random.new();

local function ReleaseId(p7: number) -- Line: 43
    -- upvalues: Random_new_ret (copy), u3 (copy)
    task.delay(Random_new_ret:NextNumber(5, 10), table.insert, u3, p7);
end;

local function SetAsCharacter(p8: userdata, p9: any) -- Line: 69
    -- upvalues: u5 (copy), u4 (copy), u1 (copy), u6 (copy), _Signals (copy)
    if not u5[p9.id] or p9.id < 1 then
        error("Entity must be registered before being set as a player character");
    end;

    local v10 = u4[p8];

    if v10 then
        local _player = v10._player;
        v10._player = nil;

        if _player and u4[_player] == v10 then
            u4[_player] = nil;

            if v10._player ~= nil then
                v10._player = nil;

                if u1 then
                    if not u6[v10] then
                        u6[v10] = {};
                    end;

                    u6[v10]._player = false;
                end;
            end;

            _Signals.PlayerCharacterUnregistered:Fire(_player, v10);
        end;
    end;

    u4[p8] = p9;

    if p9._player ~= p8 then
        p9._player = p8;

        if u1 then
            if not u6[p9] then
                u6[p9] = {};
            end;

            u6[p9]._player = p8 or false;
        end;
    end;

    _Signals.PlayerCharacterRegistered:Fire(p8, p9);
end;

return {
    idMap = u5,
    _clientOwned = {},
    _playerChars = u4,
    _entityChangedFields = u6,

    RegisterChange = function(p11: any, p12: string, p13: any, p14: boolean?, p15: any) -- Line: 13, Name: RegisterChange
        -- upvalues: u1 (copy), u6 (copy)
        if not p14 and p11[p12] == p13 then
            return;
        end;

        p11[p12] = p13;

        if not u1 then
            return;
        end;

        if not u6[p11] then
            u6[p11] = {};
        end;

        u6[p11][p12] = p15 or (p13 or false);
    end,

    RegisterEntity = function(p16) -- Line: 88, Name: RegisterEntity
        -- upvalues: u5 (copy), Warn (copy), u1 (copy), u3 (copy), u2 (ref), u4 (copy), SetAsCharacter (copy), _Signals (copy)
        if p16.destroyed then
            error("Cannot register a destroyed entity");
        end;

        if u5[p16.id] then
            Warn.medium("Entity is already registered", p16);

            return;
        end;

        if u1 then
            local table_remove_ret = table.remove(u3);

            if not table_remove_ret then
                if u2 >= 65535 then
                    error("Max ID reached, please investigate.");
                end;

                u2 = u2 + 1;
                table_remove_ret = u2;
            end;

            if u5[table_remove_ret] then
                error((`Entity Collision {table_remove_ret}`));
            end;

            p16.id = table_remove_ret;
            u5[table_remove_ret] = p16;
        else
            local id = p16.id;

            if u5[id] then
                Warn.high("Entity ID collision detected for ID:", id);
            end;

            u5[id] = p16;
        end;

        p16.registered = true;

        if p16._player then
            if u4[p16._player] then
                Warn.medium("Player already has an entity registered", p16, "overwriting");
            end;

            SetAsCharacter(p16._player, p16);
        end;

        _Signals.EntityAdded:Fire(p16);
    end,

    UnregisterEntity = function(p17) -- Line: 126, Name: UnregisterEntity
        -- upvalues: u5 (copy), _Signals (copy), u4 (copy), u1 (copy), u6 (copy), Warn (copy), Random_new_ret (copy), u3 (copy)
        if not u5[p17.id] then
            return;
        end;

        _Signals.EntityRemoved:Fire(p17);
        local _player = p17._player;

        if _player then
            if u4[_player] == p17 then
                local _player2 = p17._player;
                p17._player = nil;

                if _player2 and u4[_player2] == p17 then
                    u4[_player2] = nil;

                    if p17._player ~= nil then
                        p17._player = nil;

                        if u1 then
                            if not u6[p17] then
                                u6[p17] = {};
                            end;

                            u6[p17]._player = false;
                        end;
                    end;

                    _Signals.PlayerCharacterUnregistered:Fire(_player2, p17);
                end;
            else
                Warn.medium("Entity being unregistered does not match player mapping", p17, "ignoring");
            end;
        end;

        local id = p17.id;

        if u1 then
            u5[id] = nil;
            task.delay(Random_new_ret:NextNumber(5, 10), table.insert, u3, id);
            p17.id = -1;
        else
            u5[id] = nil;
        end;

        p17._lastId = id;
        p17.registered = false;
    end,

    GetEntityStorageInstance = function() -- Line: 193, Name: getEntityStorageInstance
        if workspace:FindFirstChild("Chrono_EntityStorage") then
            return workspace:FindFirstChild("Chrono_EntityStorage");
        end;

        local Camera = Instance.new("Camera");
        Camera.Name = "Chrono_EntityStorage";
        Camera.Parent = workspace;

        return Camera;
    end,

    SetAsCharacter = SetAsCharacter,

    RemovePlayerCharacter = function(p18) -- Line: 53, Name: RemovePlayerCharacter
        -- upvalues: u4 (copy), u1 (copy), u6 (copy), _Signals (copy)
        local _player = p18._player;
        p18._player = nil;

        if _player and u4[_player] == p18 then
            u4[_player] = nil;

            if p18._player ~= nil then
                p18._player = nil;

                if u1 then
                    if not u6[p18] then
                        u6[p18] = {};
                    end;

                    u6[p18]._player = false;
                end;
            end;

            _Signals.PlayerCharacterUnregistered:Fire(_player, p18);
        end;
    end,

    GetEntityFromPlayer = function(p19: userdata) -- Line: 172, Name: GetEntityFromPlayer
        -- upvalues: u4 (copy)
        return u4[p19];
    end,

    GetEntityFromId = function(p20: number) -- Line: 184, Name: GetEntityFromId
        -- upvalues: u5 (copy)
        return u5[p20];
    end,

    GetEntityFromModel = function(p21: userdata) -- Line: 158, Name: GetEntityFromModel
        -- upvalues: u5 (copy)
        for _, v in u5 do
            if v.model == p21 then
                return v;
            end;
        end;

        return nil;
    end
};