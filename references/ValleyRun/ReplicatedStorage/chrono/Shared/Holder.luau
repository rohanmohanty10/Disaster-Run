 

 

require(script.Parent.Types);
local Warn = require(script.Parent.Warn);
local _Signals = require(script.Parent.Events)._Signals;
local u1 = game:GetService("RunService"):IsServer();
local u2 = 0;
local u3 = {};
local u4 = {};
local u5 = {};

local function GetNextId() -- Line: 14
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

local function ReleaseId(p6: number) -- Line: 28
    -- upvalues: Random_new_ret (copy), u3 (copy)
    task.delay(Random_new_ret:NextNumber(5, 10), table.insert, u3, p6);
end;

local function SetAsCharacter(p7: userdata, p8: any) -- Line: 58
    -- upvalues: u5 (copy), u4 (copy), _Signals (copy)
    if not u5[p8.id] or p8.id < 1 then
        error("Entity must be registered before being set as a player character");
    end;

    local v9 = u4[p7];

    if v9 then
        local _player = v9._player;
        v9._player = nil;

        if _player and u4[_player] == v9 then
            u4[_player] = nil;
            _Signals["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"]:Fire(v9, "_player", nil);
            _Signals.PlayerCharacterUnregistered:Fire(_player, v9);
        end;
    end;

    u4[p7] = p8;
    _Signals["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"]:Fire(p8, "_player", p7);
    _Signals.PlayerCharacterRegistered:Fire(p7, p8);
end;

return {
    idMap = u5,
    _clientOwned = {},
    _playerChars = u4,

    RegisterEntity = function(p10) -- Line: 81, Name: RegisterEntity
        -- upvalues: u5 (copy), Warn (copy), u1 (copy), u3 (copy), u2 (ref), u4 (copy), SetAsCharacter (copy), _Signals (copy)
        if p10.destroyed then
            error("Cannot register a destroyed entity");
        end;

        if u5[p10.id] then
            Warn.medium("Entity is already registered", p10);

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

            p10.id = table_remove_ret;
            u5[table_remove_ret] = p10;
        else
            local id = p10.id;

            if u5[id] then
                Warn.high("Entity ID collision detected for ID:", id);
            end;

            u5[id] = p10;
        end;

        p10.registered = true;

        if p10._player then
            if u4[p10._player] then
                Warn.medium("Player already has an entity registered", p10, "overwriting");
            end;

            SetAsCharacter(p10._player, p10);
        end;

        _Signals.EntityAdded:Fire(p10);
    end,

    UnregisterEntity = function(p11) -- Line: 119, Name: UnregisterEntity
        -- upvalues: u5 (copy), _Signals (copy), u4 (copy), Warn (copy), u1 (copy), Random_new_ret (copy), u3 (copy)
        if not u5[p11.id] then
            return;
        end;

        _Signals.EntityRemoved:Fire(p11);
        local _player = p11._player;

        if _player then
            if u4[_player] == p11 then
                local _player2 = p11._player;
                p11._player = nil;

                if _player2 and u4[_player2] == p11 then
                    u4[_player2] = nil;
                    _Signals["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"]:Fire(p11, "_player", nil);
                    _Signals.PlayerCharacterUnregistered:Fire(_player2, p11);
                end;
            else
                Warn.medium("Entity being unregistered does not match player mapping", p11, "ignoring");
            end;
        end;

        local id = p11.id;

        if u1 then
            u5[id] = nil;
            task.delay(Random_new_ret:NextNumber(5, 10), table.insert, u3, id);
            p11.id = -1;
        else
            u5[id] = nil;
        end;

        p11._lastId = id;
        p11.registered = false;
    end,

    GetEntityStorageInstance = function() -- Line: 186, Name: getEntityStorageInstance
        if workspace:FindFirstChild("Chrono_EntityStorage") then
            return workspace:FindFirstChild("Chrono_EntityStorage");
        end;

        local Camera = Instance.new("Camera");
        Camera.Name = "Chrono_EntityStorage";
        Camera.Parent = workspace;

        return Camera;
    end,

    SetAsCharacter = SetAsCharacter,

    RemovePlayerCharacter = function(p12) -- Line: 38, Name: RemovePlayerCharacter
        -- upvalues: u4 (copy), _Signals (copy)
        local _player = p12._player;
        p12._player = nil;

        if _player and u4[_player] == p12 then
            u4[_player] = nil;
            _Signals["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"]:Fire(p12, "_player", nil);
            _Signals.PlayerCharacterUnregistered:Fire(_player, p12);
        end;
    end,

    GetEntityFromPlayer = function(p13: userdata) -- Line: 165, Name: GetEntityFromPlayer
        -- upvalues: u4 (copy)
        return u4[p13];
    end,

    GetEntityFromId = function(p14: number) -- Line: 177, Name: GetEntityFromId
        -- upvalues: u5 (copy)
        return u5[p14];
    end,

    GetEntityFromModel = function(p15: userdata) -- Line: 151, Name: GetEntityFromModel
        -- upvalues: u5 (copy)
        for _, v in u5 do
            if v.model == p15 then
                return v;
            end;
        end;

        return nil;
    end
};