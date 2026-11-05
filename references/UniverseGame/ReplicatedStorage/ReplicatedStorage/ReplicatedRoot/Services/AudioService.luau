  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Networking.ByteNet);
require(ReplicatedRoot.Libraries.Networking.ByteNet.types);
require(ReplicatedRoot.Libraries.Classes.Trove);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local Promise = require(ReplicatedRoot.Libraries.Classes.Promise);
require(ReplicatedRoot.Libraries.Classes.Signal);
game:GetService("CollectionService");
local SoundService = game:GetService("SoundService");
local HttpService = game:GetService("HttpService");
local u1 = {
    Index = {},
    LocalSounds = {}
};
local Packets = require(script.Packets);
local EncodeFormat = require(script.EncodeFormat);
local StandSounds = SoundService.StandSounds;

function u1.CreateSound(p2, p3) -- Line: 72
    -- upvalues: TableUtil (copy), Promise (copy), SoundService (copy), StandSounds (copy)
    local u4 = p2 or {};
    local u5 = {};

    if p3 ~= nil then
        u4 = TableUtil.Reconcile(p3, u4);
    end;

    local Sound = Instance.new("Sound");

    if typeof(u4.SoundId) == "number" then
        Sound.SoundId = `rbxassetid://{u4.SoundId}`;
    elseif typeof(u4.SoundId) == "string" then
        Sound.SoundId = u4.SoundId;
    end;

    Sound.Volume = u4.Volume or 1;
    Sound.PlaybackSpeed = u4.PlaybackSpeed or 1;
    Sound.PlaybackRegionsEnabled = u4.PlaybackRegionsEnabled or false;
    Sound.PlaybackRegion = u4.PlaybackRegion or Sound.PlaybackRegion;
    local v6;

    if u4.Looped then
        v6 = u4.Looped;
    else
        v6 = false;
    end;

    Sound.Looped = v6;
    Sound.LoopRegion = u4.LoopRegion or Sound.LoopRegion;
    Sound.RollOffMinDistance = u4.RollOffMinDistance or 20;
    Sound.RollOffMaxDistance = u4.RollOffMaxDistance or 120;

    if typeof(u4.SoundGroup) == "string" then
        Promise.try(function() -- Line: 99
            -- upvalues: SoundService (ref), u4 (ref), Sound (copy)
            local v7 = SoundService:WaitForChild(u4.SoundGroup, 5);

            if v7 ~= nil then
                Sound.SoundGroup = v7;
            end;
        end);
    elseif typeof(u4.SoundGroup) == "Instance" then
        Sound.SoundGroup = Sound.SoundGroup;
    else
        Sound.SoundGroup = StandSounds;
    end;

    if u4.Attributes then
        for i, v in pairs(u4.Attributes) do
            Sound:SetAttribute(i, v);
        end;
    end;

    if u4.Effects then
        for _, v in pairs(u4.Effects) do
            local u8 = Instance.new(v.Class);

            if v.Properties then
                for i, v2 in pairs(v.Properties) do
                    pcall(function() -- Line: 122
                        -- upvalues: u8 (copy), i (copy), v2 (copy)
                        u8[i] = v2;
                    end);
                end;
            end;

            u8.Parent = Sound;
        end;
    end;

    local v9 = nil;

    if typeof(u4.Transformer) == "Instance" and u4.Transformer:IsA("ModuleScript") then
        local Transformer = require(u4.Transformer);

        if typeof(Transformer) == "function" then
            v9 = Transformer;
        end;
    elseif typeof(u4.Transformer) == "function" then
        v9 = u4.Transformer;
    end;

    if v9 ~= nil then
        Promise.try(v9, Sound, TableUtil.Copy(u4, true)):catch(warn);
    end;

    local Parent = u4.Parent;
    local Position = u4.Position;
    local u10;

    if Position then
        if Parent == nil then
            Parent = workspace.Terrain;
        end;

        u10 = Instance.new("Attachment");
        u10.Name = "Sound_Container";
        u10.Archivable = false;
        u10.Position = Position;
        u10.Parent = Parent;
    else
        u10 = nil;
    end;

    if u10 or Parent then
        Sound.Parent = u10 or Parent;
    end;

    if u4.Cleanup then
        local function Cleanup() -- Line: 166
            -- upvalues: u5 (copy), Sound (copy), u10 (ref)
            for i, v in pairs(u5) do
                v:Disconnect();
                u5[i] = nil;
            end;

            if Sound then
                Sound:Destroy();
            end;

            if u10 then
                u10:Destroy();
            end;
        end;

        u5.Destroyed = Sound.Destroying:Once(Cleanup);
        u5.Ended = Sound.Ended:Once(Cleanup);
        u5.Stopped = Sound.Stopped:Once(Cleanup);
    end;

    return Sound, u4;
end;

function u1.SpawnSound(p11, p12) -- Line: 187
    -- upvalues: u1 (copy), TableUtil (copy)
    local v13, v14 = u1.CreateSound(p11, TableUtil.Reconcile({
        Cleanup = true
    }, p12 or {}));
    v13:Play();

    return v13, v14;
end;

function u1.SpawnLocalSound(p15, p16) -- Line: 195
    -- upvalues: Core (copy), TableUtil (copy), u1 (copy), Packets (copy)
    if Core.Context == "Server" then
        local v17 = nil;
        local v18 = nil;

        if typeof(p15) == "table" then
            if p15._Key then
                v17 = p15._Key;
            else
                v18 = TableUtil.Reconcile(p16 or {}, p15);
            end;
        elseif typeof(p15) == "string" then
            v17 = u1.Index[p15];

            if not v17 then
                return;
            end;
        end;

        local v19 = v18 == nil and (p16 or {}) or v18;
        local v20;

        if typeof(v19.Clients) == "table" then
            v20 = v19.Clients;
        else
            v20 = v19.Clients ~= "All" and v19.Clients ~= nil and {} or game.Players:GetPlayers();
        end;

        local v21 = not v19.Reliable and true or v19.Reliable;

        if v17 then
            if v17 then
                local v22 = {
                    Key = v17,
                    ExtraData = p16
                };

                if v21 == nil or v21 == true then
                    Packets.SpawnFromKeyReliable.sendToList(v22, v20);

                    return;
                end;

                if v21 == false then
                    Packets.SpawnFromKeyReliable.sendToList(v22, v20);
                end;
            end;
        else
            local v23 = {
                Cleanup = true,
                SoundId = v19.SoundId,
                Volume = v19.Volume,
                PlaybackSpeed = v19.PlaybackSpeed,
                PlaybackRegionsEnabled = v19.PlaybackRegionsEnabled
            };
            local v24;

            if v19.PlaybackRegion then
                v24 = v19.PlaybackRegion.Min or nil;
            else
                v24 = nil;
            end;

            v23.PlaybackRegion0 = v24;
            local v25;

            if v19.PlaybackRegion then
                v25 = v19.PlaybackRegion.Max or nil;
            else
                v25 = nil;
            end;

            v23.PlaybackRegion1 = v25;
            v23.RollOffMinDistance = v19.RollOffMinDistance;
            v23.RollOffMaxDistance = v19.RollOffMaxDistance;
            v23.SoundGroup = v19.SoundGroup;
            v23.Transformer = v19.Transformer;
            v23.Parent = v19.Parent;
            v23.Position = v19.Position;

            if v21 == nil or v21 == true then
                Packets.SpawnFromDataReliable.sendToList(v23, v20);

                return;
            end;

            if v21 == false then
                Packets.SpawnFromDataUnreliable.sendToList(v23, v20);
            end;
        end;
    else
        local v26 = nil;

        if typeof(p15) == "Instance" then
            if p15:IsA("StringValue") then
                p15 = u1.LocalSounds[p15] or (u1.DecodeSound(p15) or nil);
            else
                p15 = v26;
            end;
        elseif typeof(p15) == "string" then
            local v27 = u1.Index[p15];
            p15 = v27 and u1.LocalSounds[v27] or (u1.DecodeSound(p15) or nil);
        elseif typeof(p15) ~= "table" then
            p15 = v26;
        end;

        if p15 then
            return u1.SpawnSound(p15, p16);
        end;
    end;
end;

function u1.EncodeSound(p28, p29) -- Line: 276
    -- upvalues: u1 (copy), EncodeFormat (copy)
    if u1.Index[p28] then
        return u1.Index[p28];
    end;

    if p29._Key then
        return p29._Key;
    end;

    local StringValue = Instance.new("StringValue");
    StringValue.Name = p28;
    local v30 = {
        SoundId = p29.SoundId,
        Volume = p29.Volume or 1,
        PlaybackSpeed = p29.PlaybackSpeed or 1,
        PlaybackRegionsEnabled = p29.PlaybackRegionsEnabled,
        PlaybackRegion = p29.PlaybackRegion and { p29.PlaybackRegion.Min, p29.PlaybackRegion.Max } or nil,
        Looped = p29.Looped,
        LoopRegion = p29.LoopRegion and { p29.LoopRegion.Min, p29.LoopRegion.Max } or nil,
        RollOffMinDistance = p29.RollOffMinDistance,
        RollOffMaxDistance = p29.RollOffMaxDistance,
        Cleanup = p29.Cleanup,
        Effects = p29.Effects
    };

    if typeof(p29.SoundGroup) == "string" then
        v30.SoundGroup = p29.SoundGroup;
    elseif typeof(p29.SoundGroup) == "Instance" then
        local ObjectValue = Instance.new("ObjectValue");
        ObjectValue.Name = "SoundGroup";
        ObjectValue.Value = p29.SoundGroup;
        ObjectValue.Parent = StringValue;
    end;

    if typeof(p29.Transformer) == "Instance" then
        local ObjectValue = Instance.new("ObjectValue");
        ObjectValue.Name = "Transformer";
        ObjectValue.Value = p29.Transformer;
        ObjectValue.Parent = StringValue;
    end;

    if typeof(p29.Attributes) == "table" then
        for i, v in pairs(p29.Attributes) do
            StringValue:SetAttribute(i, v);
        end;
    end;

    local v31 = {};

    for i, v in pairs(v30) do
        v31[EncodeFormat.SoundKeys[i]] = v;
    end;

    StringValue.Value = game:GetService("HttpService"):JSONEncode(v31);
    StringValue.Parent = script.Index;
    p29._Key = StringValue;
    u1.Index[p28] = StringValue;

    return StringValue;
end;

function u1.DecodeSound(p32) -- Line: 340
    -- upvalues: u1 (copy), HttpService (copy), EncodeFormat (copy)
    if typeof(p32) == "string" then
        p32 = u1.Index[p32];
    end;

    if u1.LocalSounds[p32] then
        return u1.LocalSounds[p32];
    end;

    local v33 = HttpService:JSONDecode(p32.Value);
    local v34 = {};

    for i, v in pairs(v33) do
        v34[EncodeFormat.SoundIndex[i]] = v;
    end;

    local SoundGroup = p32:FindFirstChild("SoundGroup");
    local Transformer = p32:FindFirstChild("Transformer");

    if SoundGroup then
        v34.SoundGroup = SoundGroup.Value;
    end;

    if Transformer then
        v34.Transformer = Transformer.Value;
    end;

    for i, v in pairs(p32:GetAttributes()) do
        if v34.Attributes == nil then
            v34.Attributes = {};
        end;

        if v34.Attributes then
            v34.Attributes[i] = v;
        end;
    end;

    u1.LocalSounds[p32] = v34;

    return v34;
end;

function u1._Start() -- Line: 379
    -- upvalues: Core (copy), Packets (copy), u1 (copy)
    if Core.Context == "Client" then
        Packets.SpawnFromKeyReliable.listen(function(p35) -- Line: 381
            -- upvalues: u1 (ref)
            u1.SpawnLocalSound(p35.Key, p35.ExtraData);
        end);
        Packets.SpawnFromKeyUnreliable.listen(function(p36) -- Line: 384
            -- upvalues: u1 (ref)
            u1.SpawnLocalSound(p36.Key, p36.ExtraData);
        end);
        Packets.SpawnFromDataReliable.listen(function(p37) -- Line: 387
            -- upvalues: u1 (ref)
            u1.SpawnLocalSound(p37);
        end);
        Packets.SpawnFromDataUnreliable.listen(function(p38) -- Line: 390
            -- upvalues: u1 (ref)
            u1.SpawnLocalSound(p38);
        end);
    end;
end;

return u1;