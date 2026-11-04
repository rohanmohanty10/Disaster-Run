 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Shared = script.Parent.Parent.Shared;
local Holder = require(Shared.Holder);
require(Shared.Types);
local Entity = require(Shared.Entity);
local ClockUnwrap = require(Shared.ClockUnwrap);
local Replicate = Shared.Remotes.Replicate;
local SafeReplicate = Shared.Remotes.SafeReplicate;
local _clientOwned = Holder._clientOwned;

if not _clientOwned[LocalPlayer] then
    _clientOwned[LocalPlayer] = {};
end;

local u1 = _clientOwned[LocalPlayer];
local buffer_create_ret = buffer.create(950);
local u2 = 0;
local u3 = 0;
local u4 = false;

local function MapRotation(p5: number) -- Line: 30
    return math.round((p5 + 3.141592653589793) / 0.00009587526218325454);
end;

local function FireEvent(p6: any, p7: string, ...) -- Line: 34
    local _events = p6._events;

    if not _events then
        return;
    end;

    local v8 = _events[p7];

    if v8 then
        v8:Fire(p6, ...);
    end;
end;

local function SerializeFull(p9: buffer, p10, p11: number) -- Line: 45
    local X = p10.X;
    local Y = p10.Y;
    local Z = p10.Z;
    local v12, v13, v14 = p10:ToOrientation();
    buffer.writef32(p9, p11, X);
    local v15 = p11 + 4;
    buffer.writef32(p9, v15, Y);
    local v16 = v15 + 4;
    buffer.writef32(p9, v16, Z);
    local v17 = v16 + 4;
    local math_round_ret = math.round((v12 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p9, v17, math_round_ret);
    local v18 = v17 + 2;
    local math_round_ret2 = math.round((v13 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p9, v18, math_round_ret2);
    local v19 = v18 + 2;
    local math_round_ret3 = math.round((v14 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p9, v19, math_round_ret3);

    return v19 + 2;
end;

local function SerializeYaw(p20: buffer, p21, p22: number) -- Line: 65
    local X = p21.X;
    local Y = p21.Y;
    local Z = p21.Z;
    local _, v23, _ = p21:ToOrientation();
    buffer.writef32(p20, p22, X);
    local v24 = p22 + 4;
    buffer.writef32(p20, v24, Y);
    local v25 = v24 + 4;
    buffer.writef32(p20, v25, Z);
    local v26 = v25 + 4;
    local math_round_ret = math.round((v23 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p20, v26, math_round_ret);

    return v26 + 2;
end;

local function Flush() -- Line: 81
    -- upvalues: u2 (ref), ClockUnwrap (copy), u3 (ref), buffer_create_ret (copy), u4 (ref), SafeReplicate (copy), Replicate (copy)
    if u2 == 0 then
        return;
    end;

    local buffer_create_ret2 = buffer.create(u2 + 4);
    local v27 = ClockUnwrap.quantize(u3);
    buffer.writeu32(buffer_create_ret2, 0, v27);
    buffer.copy(buffer_create_ret2, 4, buffer_create_ret, 0, u2);

    if u4 then
        SafeReplicate:FireServer(buffer_create_ret2);
    else
        Replicate:FireServer(buffer_create_ret2);
    end;

    u2 = 0;
end;

local function WriteEntity(p28: number, p29, p30: boolean?, p31: boolean?, p32: boolean?) -- Line: 98
    -- upvalues: u2 (ref), Flush (copy), buffer_create_ret (copy), SerializeFull (copy)
    if u2 + (p30 and 21 or 17) > 900 then
        Flush();
    end;

    buffer.writeu16(buffer_create_ret, u2, p28);
    u2 = u2 + 2;
    local v33 = p30 and 1 or 0;

    if p31 then
        v33 = v33 + 2;
    end;

    if p32 then
        v33 = v33 + 4;
    end;

    buffer.writeu8(buffer_create_ret, u2, v33);
    u2 = u2 + 1;

    if p30 then
        u2 = SerializeFull(buffer_create_ret, p29, u2);

        return;
    end;

    local v34 = buffer_create_ret;
    local v35 = u2;
    local X = p29.X;
    local Y = p29.Y;
    local Z = p29.Z;
    local _, v36, _ = p29:ToOrientation();
    buffer.writef32(v34, v35, X);
    local v37 = v35 + 4;
    buffer.writef32(v34, v37, Y);
    local v38 = v37 + 4;
    buffer.writef32(v34, v38, Z);
    local v39 = v38 + 4;
    local math_round_ret = math.round((v36 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(v34, v39, math_round_ret);
    u2 = v39 + 2;
end;

local function CFrameChanged(p40, p41) -- Line: 127
    if p40 == p41 then
        return false;
    end;

    return (p40 == nil or p41 == nil) and true or p40:FuzzyEq(p41, 0.0001) == false;
end;

local function CheckLocker(p42) -- Line: 138
    -- upvalues: Entity (copy)
    if p42._cfLockFailed then
        if p42._lockedCFReplication and (p42.isContextOwner and not p42._player) then
            local v43 = Entity._GetPart(p42);

            if v43 then
                Entity._LockPartPhysicsReplication(v43);
                p42._cfLockFailed = nil;
            end;
        else
            p42._cfLockFailed = nil;
        end;
    end;
end;

local function CheckEntity(p44) -- Line: 152
    -- upvalues: u3 (ref), Entity (copy), FireEvent (copy), u4 (ref), WriteEntity (copy)
    if p44.destroyed or p44.paused then
        return;
    end;

    local entityConfig = p44.entityConfig;
    local TICK_RATE = entityConfig.TICK_RATE;

    if p44.isHalfTicked then
        TICK_RATE = TICK_RATE * 2;
    elseif p44.isHalfTicked == nil then
        return;
    end;

    local v45 = u3;
    local v46 = v45 - (p44.lastReplicatedTime or 0);

    if v46 < TICK_RATE then
        return;
    end;

    if p44._cfLockFailed then
        if p44._lockedCFReplication and (p44.isContextOwner and not p44._player) then
            local v47 = Entity._GetPart(p44);

            if v47 then
                Entity._LockPartPhysicsReplication(v47);
                p44._cfLockFailed = nil;
            end;
        else
            p44._cfLockFailed = nil;
        end;
    end;

    FireEvent(p44, "Ticked", v46);
    local PrimaryPart = Entity.GetPrimaryPart(p44);

    if p44.autoUpdatePosition and PrimaryPart then
        Entity.Push(p44, v45, PrimaryPart.CFrame);
    end;

    local latestCFrame = p44.latestCFrame;
    local lastCheckedCFrame = p44.lastCheckedCFrame;

    if latestCFrame then
        local v48;

        if lastCheckedCFrame == latestCFrame then
            v48 = false;
        else
            v48 = (lastCheckedCFrame == nil or latestCFrame == nil) and true or lastCheckedCFrame:FuzzyEq(latestCFrame, 0.0001) == false;
        end;

        if v48 then
            p44.lastReplicatedTime = v45;
            local FULL_ROTATION = entityConfig.FULL_ROTATION;
            p44.lastCheckedCFrame = latestCFrame;
            u4 = u4 or p44._teleport;
            WriteEntity(p44.id, latestCFrame, FULL_ROTATION, p44.isHalfTicked, p44._teleport);
            p44._teleport = nil;
        end;
    end;
end;

return {
    Update = function() -- Line: 193, Name: Update
        -- upvalues: u3 (ref), u1 (copy), CheckEntity (copy), Flush (copy), u4 (ref)
        u3 = os.clock();

        for i in u1 do
            CheckEntity(i);
        end;

        Flush();
        u4 = false;
    end
};