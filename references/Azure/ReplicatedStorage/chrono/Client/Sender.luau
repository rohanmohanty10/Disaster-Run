 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Shared = script.Parent.Parent.Shared;
local Holder = require(Shared.Holder);
require(Shared.Types);
local Entity = require(Shared.Entity);
local ClockUnwrap = require(Shared.ClockUnwrap);
local PositionCodec = require(Shared.PositionCodec);
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

local function MapRotation(p5: number) -- Line: 39
    return math.round((p5 + 3.141592653589793) / 0.00009587526218325454);
end;

local function FireEvent(p6: any, p7: string, ...) -- Line: 43
    local _events = p6._events;

    if not _events then
        return;
    end;

    local v8 = _events[p7];

    if v8 then
        v8:Fire(p6, ...);
    end;
end;

local function SerializeFullRotation(p9: buffer, p10, p11: number) -- Line: 54
    local v12, v13, v14 = p10:ToOrientation();
    local math_round_ret = math.round((v12 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p9, p11, math_round_ret);
    local v15 = p11 + 2;
    local math_round_ret2 = math.round((v13 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p9, v15, math_round_ret2);
    local v16 = v15 + 2;
    local math_round_ret3 = math.round((v14 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p9, v16, math_round_ret3);

    return v16 + 2;
end;

local function SerializeYawRotation(p17: buffer, p18, p19: number) -- Line: 67
    local _, v20, _ = p18:ToOrientation();
    local math_round_ret = math.round((v20 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p17, p19, math_round_ret);

    return p19 + 2;
end;

local function Flush() -- Line: 76
    -- upvalues: u2 (ref), ClockUnwrap (copy), u3 (ref), buffer_create_ret (copy), u4 (ref), SafeReplicate (copy), Replicate (copy)
    if u2 == 0 then
        return;
    end;

    local buffer_create_ret2 = buffer.create(u2 + 4);
    local v21 = ClockUnwrap.quantize(u3);
    buffer.writeu32(buffer_create_ret2, 0, v21);
    buffer.copy(buffer_create_ret2, 4, buffer_create_ret, 0, u2);

    if u4 then
        SafeReplicate:FireServer(buffer_create_ret2);
    else
        Replicate:FireServer(buffer_create_ret2);
    end;

    u2 = 0;
end;

local function QuantizeVelocity(p22: number) -- Line: 93
    if p22 ~= p22 then
        return 0;
    end;

    local math_round_ret = math.round(p22 * 64);

    return math.clamp(math_round_ret, -32767, 32767);
end;

local function WriteEntity(p23: number, p24, p25: boolean?, p26: boolean?, p27: boolean?, p28: vector?) -- Line: 100
    -- upvalues: PositionCodec (copy), u2 (ref), Flush (copy), buffer_create_ret (copy)
    local v29 = PositionCodec.canEncode(p24.Position);
    local v30;

    if v29 then
        v30 = PositionCodec.COMPACT_BYTES;
    else
        v30 = PositionCodec.FLOAT_BYTES;
    end;

    if u2 + (3 + v30 + (p25 and 6 or 2) + (p28 and 6 or 0)) > 900 then
        Flush();
    end;

    buffer.writeu16(buffer_create_ret, u2, p23);
    u2 = u2 + 2;
    local v31 = p25 and 1 or 0;

    if p26 then
        v31 = v31 + 2;
    end;

    if p27 then
        v31 = v31 + 4;
    end;

    if v29 then
        v31 = v31 + PositionCodec.COMPACT_FLAG;
    end;

    if p28 then
        v31 = v31 + 16;
    end;

    buffer.writeu8(buffer_create_ret, u2, v31);
    u2 = u2 + 1;
    u2 = PositionCodec.write(buffer_create_ret, u2, p24.Position, v29);

    if p25 then
        local v32 = buffer_create_ret;
        local v33 = u2;
        local v34, v35, v36 = p24:ToOrientation();
        local math_round_ret = math.round((v34 + 3.141592653589793) / 0.00009587526218325454);
        buffer.writeu16(v32, v33, math_round_ret);
        local v37 = v33 + 2;
        local math_round_ret2 = math.round((v35 + 3.141592653589793) / 0.00009587526218325454);
        buffer.writeu16(v32, v37, math_round_ret2);
        local v38 = v37 + 2;
        local math_round_ret3 = math.round((v36 + 3.141592653589793) / 0.00009587526218325454);
        buffer.writeu16(v32, v38, math_round_ret3);
        u2 = v38 + 2;
    else
        local v39 = u2;
        local _, v40, _ = p24:ToOrientation();
        local math_round_ret = math.round((v40 + 3.141592653589793) / 0.00009587526218325454);
        buffer.writeu16(buffer_create_ret, v39, math_round_ret);
        u2 = v39 + 2;
    end;

    if p28 then
        local X = p28.X;
        local v41;

        if X == X then
            local math_round_ret = math.round(X * 64);
            v41 = math.clamp(math_round_ret, -32767, 32767);
        else
            v41 = 0;
        end;

        buffer.writei16(buffer_create_ret, u2, v41);
        local Y = p28.Y;
        local v42;

        if Y == Y then
            local math_round_ret = math.round(Y * 64);
            v42 = math.clamp(math_round_ret, -32767, 32767);
        else
            v42 = 0;
        end;

        buffer.writei16(buffer_create_ret, u2 + 2, v42);
        local Z = p28.Z;
        local v43;

        if Z == Z then
            local math_round_ret = math.round(Z * 64);
            v43 = math.clamp(math_round_ret, -32767, 32767);
        else
            v43 = 0;
        end;

        buffer.writei16(buffer_create_ret, u2 + 4, v43);
        u2 = u2 + 6;
    end;
end;

local function GetVelocity(p44: userdata?, p45, p46, p47: number, p48: boolean) -- Line: 150
    if not p44 then
        return nil;
    end;

    local v49 = p44.Anchored and Vector3.new(0, 0, 0) or p44.AssemblyLinearVelocity;

    if p48 or (not p45 or p47 <= 0) then
        return v49;
    end;

    local v50 = (p46.Position - p45.Position) / p47;

    if v50.Magnitude > 500 then
        return v49;
    end;

    if p44.Anchored then
        return v50;
    end;

    if Vector3.new(v50.X, 0, v50.Z).Magnitude > Vector3.new(v49.X, 0, v49.Z).Magnitude + 20 then
        return Vector3.new(v50.X, v49.Y, v50.Z);
    end;

    return v49;
end;

local function CFrameChanged(p51, p52) -- Line: 171
    if p51 == p52 then
        return false;
    end;

    return (p51 == nil or p52 == nil) and true or p51:FuzzyEq(p52, 0.0001) == false;
end;

local function CheckLocker(p53) -- Line: 182
    -- upvalues: Entity (copy)
    if p53._cfLockFailed then
        if p53._lockedCFReplication and (p53.isContextOwner and not p53._player) then
            local v54 = Entity._GetPart(p53);

            if v54 then
                Entity._LockPartPhysicsReplication(v54);
                p53._cfLockFailed = nil;
            end;
        else
            p53._cfLockFailed = nil;
        end;
    end;
end;

local function CheckEntity(p55) -- Line: 196
    -- upvalues: u3 (ref), Entity (copy), FireEvent (copy), u4 (ref), WriteEntity (copy), GetVelocity (copy)
    if p55.destroyed or p55.paused then
        return;
    end;

    local entityConfig = p55.entityConfig;
    local TICK_RATE = entityConfig.TICK_RATE;

    if p55.isHalfTicked then
        TICK_RATE = TICK_RATE * 2;
    elseif p55.isHalfTicked == nil then
        return;
    end;

    local v56 = u3;
    local v57 = v56 - (p55.lastReplicatedTime or 0);

    if v57 < TICK_RATE * 0.9 then
        return;
    end;

    if p55._cfLockFailed then
        if p55._lockedCFReplication and (p55.isContextOwner and not p55._player) then
            local v58 = Entity._GetPart(p55);

            if v58 then
                Entity._LockPartPhysicsReplication(v58);
                p55._cfLockFailed = nil;
            end;
        else
            p55._cfLockFailed = nil;
        end;
    end;

    FireEvent(p55, "Ticked", v57);
    local PrimaryPart = Entity.GetPrimaryPart(p55);

    if PrimaryPart and PrimaryPart.Anchored then
        p55._heldWhileAnchored = true;

        return;
    end;

    if p55._heldWhileAnchored then
        p55._heldWhileAnchored = nil;
        local lastCheckedCFrame = p55.lastCheckedCFrame;

        if PrimaryPart and (lastCheckedCFrame and (PrimaryPart.Position - lastCheckedCFrame.Position).Magnitude > 1) then
            p55._teleport = p55._teleport or v56;
        end;
    end;

    if p55.autoUpdatePosition and PrimaryPart then
        Entity.Push(p55, v56, PrimaryPart.CFrame);
    end;

    local latestCFrame = p55.latestCFrame;
    local lastCheckedCFrame = p55.lastCheckedCFrame;

    if latestCFrame then
        local v59;

        if lastCheckedCFrame == latestCFrame then
            v59 = false;
        else
            v59 = (lastCheckedCFrame == nil or latestCFrame == nil) and true or lastCheckedCFrame:FuzzyEq(latestCFrame, 0.0001) == false;
        end;

        if v59 then
            p55.lastReplicatedTime = v56;
            local FULL_ROTATION = entityConfig.FULL_ROTATION;
            p55.lastCheckedCFrame = latestCFrame;
            local v60 = p55._teleport ~= nil;
            u4 = u4 or v60;
            WriteEntity(p55.id, latestCFrame, FULL_ROTATION, p55.isHalfTicked, v60, (GetVelocity(PrimaryPart, lastCheckedCFrame, latestCFrame, v57, v60)));
            p55._teleport = nil;
        end;
    end;
end;

return {
    Update = function() -- Line: 257, Name: Update
        -- upvalues: u3 (ref), u1 (copy), CheckEntity (copy), Flush (copy), u4 (ref)
        u3 = os.clock();

        for i in u1 do
            CheckEntity(i);
        end;

        Flush();
        u4 = false;
    end
};