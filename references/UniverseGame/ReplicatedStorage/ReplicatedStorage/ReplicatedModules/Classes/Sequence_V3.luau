  

 

local u1 = {};
u1.__index = u1;
game:GetService("RunService"):IsStudio();
local Knit = require(script.Parent.Parent.KnitPackage.Knit);
local Trove = require(Knit.Util.Trove);
local Signal = require(Knit.Util.Signal);

function u1.new(p2) -- Line: 20
    -- upvalues: u1 (copy), Signal (copy), Trove (copy)
    local v3 = setmetatable({}, u1);
    v3._Time = 0;
    v3._Position = 0;
    v3._Length = 0;
    v3._Speed = 1;
    v3._Playing = false;
    v3._Paused = false;
    v3._Looped = false;
    v3._Frames = {};
    v3._FrameCache = {};
    v3._Cache = {};
    v3._Destroyed = false;
    v3.Played = Signal.new();
    v3.Ended = Signal.new();
    v3.Paused = Signal.new();
    v3.Resumed = Signal.new();
    v3.Stopped = Signal.new();
    v3.Completed = Signal.new();
    v3.DidLoop = Signal.new();
    v3.MovedTo = Signal.new();
    v3.Updated = Signal.new();
    v3.Failed = Signal.new();
    v3.Destroying = Signal.new();

    if p2 then
        v3:Load(p2);
    end;

    if p2 and p2.SupplyTrove then
        v3.Trove = Trove.new();
    end;

    return v3;
end;

function u1.Load(p4, p5) -- Line: 65
    if p5.Speed ~= nil then
        p4:SetSpeed(p5.Speed);
    end;

    if p5.Looped ~= nil then
        p4:Loop(p5.Looped);
    end;

    if p5.Validate ~= nil then
        p4:SetValidate(p5.Validate);
    end;

    if p5.FrameHandler ~= nil then
        p4:SetFrameHandler(p5.FrameHandler);
    end;

    if p5.ErrorHandler ~= nil then
        p4:SetErrorHandler(p5.ErrorHandler);
    end;

    if p5.Name then
        p4.Name = p5.Name;
    end;

    for _, v in ipairs(p5.Frames) do
        if typeof(v[2]) == "number" then
            p4:AddFrames(unpack(v));
        else
            p4:AddFrame(unpack(v));
        end;
    end;

    return p4;
end;

function u1.AddFrame(p6, p7, p8) -- Line: 99
    local v9 = p6._Frames[p7];

    if not v9 then
        v9 = {};
        p6._Frames[p7] = v9;
    end;

    table.insert(v9, p8);

    if p6._Length < p7 then
        p6._Length = p7;
    end;
end;

function u1.AddFrames(p10, p11, p12, p13) -- Line: 114
    for i = p11, p12 do
        p10:AddFrame(i, p13);
    end;
end;

function u1.RunFrame(p14, p15, ...) -- Line: 121
    -- upvalues: u1 (copy)
    if p14._FrameCache[p15] then
        return false;
    end;

    local v16 = p14._Frames[p15];

    if not v16 then
        return false;
    end;

    p14._FrameCache[p15] = true;

    for _, v in ipairs(v16) do
        if typeof(v) == "function" then
            local v17 = table.pack(xpcall(p14.RunCallback, debug.traceback, v, p14, p15, ...));
            local v18 = v17[1];

            if v18 or typeof(v17[2]) ~= "string" then
                if v18 then
                    local v19;

                    if typeof(v17[2]) == "string" then
                        v19 = v17[2]:lower() or nil;
                    else
                        v19 = nil;
                    end;

                    if v19 then
                        if v19 == "goto" or v19 == "moveto" then
                            p14:_PlayAt(v17[3] or nil);
                        else
                            if v19 == "stop" or v17[2] == false then
                                p14:Stop();

                                return nil;
                            end;

                            if v19 == "pause" then
                                p14:Pause();

                                return nil;
                            end;

                            if v19 == "repeat" then
                                p14:MoveTo(p15);

                                return nil;
                            end;

                            if v19 == "playsequence" then
                                local v20 = v17[3];
                                local v21 = v17[4];

                                if typeof(v20) == "table" and v20.ClassName == "Sequence" then
                                    v20:_PlayAt(v21, unpack(v17[5] or {}));
                                end;
                            elseif v19 == "switchsequence" or v19 == "switch" then
                                local v22 = v17[3];
                                local v23 = v17[4];

                                if typeof(v22) == "table" and v22.ClassName == "Sequence" then
                                    p14:Stop();
                                    v22:_PlayAt(v23, unpack(v17[5] or {}));
                                end;

                                return nil;
                            end;
                        end;
                    end;
                end;
            else
                local v24 = v17[2];
                warn((`An error occurred attempting to run frame {p15}\n{v17[2]}`));
                p14.Failed:Fire(p15, v24);
                u1.Errored(p14, p15, v24);
            end;
        end;
    end;

    return true;
end;

function u1.RunCallback(p25, p26, ...) -- Line: 180
    return p25(p26, ...);
end;

function u1.Validate(p27) -- Line: 185
    return true;
end;

function u1.Errored(p28, p29, p30) -- Line: 190
    p28:Stop();
end;

function u1._PlayAt(p31, p32, ...) -- Line: 196
    p31._Time = p32 or 0;

    if p31:IsPlaying() then
        p31:MoveTo(p31._Time);

        return;
    end;

    p31._Playing = true;
    p31:MoveTo(p31._Time);
    p31:RunFrame(0, ...);
    p31.Played:Fire(...);

    while (p31._Time <= p31:GetLength() or p31:IsLooped()) and p31:IsPlaying() do
        local v33 = task.wait();

        if not p31:IsPlaying() then
            return;
        end;

        if not p31:IsPaused() then
            p31._Time = p31._Time + v33 * p31:GetSpeed() * 60;
            p31._Position = math.floor(p31._Time);

            if not p31.Validate(p31, ...) then
                p31.Failed:Fire(p31._Position, "ValidateFailed");
                break;
            end;

            p31.Updated:Fire(p31._Position);

            for i, _ in pairs(p31._Frames) do
                if p31._Time >= i and (p31:RunFrame(i, ...) == nil or not p31:IsPlaying()) then
                    break;
                end;
            end;

            if p31:IsLooped() and p31._Time > p31:GetLength() then
                table.clear(p31._FrameCache);
                p31._Time = p31._Time - p31:GetLength();
                p31:RunFrame(0, ...);
                p31.DidLoop:Fire();
            end;
        end;
    end;

    p31:End();
    p31.Completed:Fire();
end;

function u1.End(p34) -- Line: 257
    p34._Playing = false;
    p34._Position = 0;
    p34.Ended:Fire();
    table.clear(p34._FrameCache);
end;

function u1.Play(p35, ...) -- Line: 266
    return task.spawn(p35._PlayAt, p35, 0, ...);
end;

function u1.PlayAt(p36, p37, ...) -- Line: 271
    return task.spawn(p36._PlayAt, p36, p37 or 0, ...);
end;

function u1.Pause(p38) -- Line: 276
    if p38._Playing then
        p38._Paused = true;
        p38.Paused:Fire();
    end;
end;

function u1.Resume(p39) -- Line: 284
    if p39._Paused then
        p39._Paused = false;
        p39.Resumed:Fire();
    end;
end;

function u1.Stop(p40) -- Line: 292
    if p40._Playing then
        p40:End();
        p40.Stopped:Fire();

        if p40.Trove then
            p40.Trove:Destroy();
        end;
    end;
end;

function u1.MoveTo(p41, p42, p43) -- Line: 305
    p41._Position = math.clamp(p42, 0, p41._Length);
    p41._Time = p42;

    for i, _ in pairs(p41._FrameCache) do
        if p41:GetPosition() <= i then
            p41._FrameCache[i] = nil;
        end;
    end;

    if p43 == true then
        for i, _ in pairs(p41._Frames) do
            if i < p41:GetPosition() then
                p41._FrameCache[i] = true;
            end;
        end;
    end;

    p41.MovedTo:Fire(p41._Position);
end;

function u1.IsPlaying(p44) -- Line: 324
    return p44._Playing;
end;

function u1.IsPaused(p45) -- Line: 329
    return p45._Paused;
end;

function u1.IsLooped(p46) -- Line: 334
    return p46._Looped;
end;

function u1.Loop(p47, p48) -- Line: 339
    p47._Looped = p48;
end;

function u1.GetSpeed(p49) -- Line: 345
    return p49._Speed;
end;

function u1.GetPosition(p50) -- Line: 350
    return p50._Position;
end;

u1.GetCurrentFrame = u1.GetPosition;

function u1.GetLength(p51) -- Line: 358
    return p51._Length;
end;

function u1.SetSpeed(p52, p53) -- Line: 363
    p52._Speed = p53;
end;

function u1.GetValidate(p54) -- Line: 368
    return p54.Validate;
end;

function u1.SetValidate(p55, p56) -- Line: 373
    p55.Validate = p56;
end;

function u1.GetFrameHandler(p57) -- Line: 378
    return p57.RunCallback;
end;

function u1.SetFrameHandler(p58, p59) -- Line: 383
    p58.RunCallback = p59;
end;

function u1.GetErrorHandler(p60) -- Line: 388
    return p60.Errored;
end;

function u1.GetCache(p61, p62) -- Line: 393
    local v63 = p62 or "Cache";

    if not p61._Cache[v63] then
        p61._Cache[v63] = {};
    end;

    return p61._Cache[v63];
end;

function u1.SetErrorHandler(p64, p65) -- Line: 402
    p64.Errored = p65;
end;

function u1.Destroy(p66) -- Line: 407
    -- upvalues: Signal (copy)
    if p66._Destroyed then
        return;
    end;

    p66._Destroyed = true;

    if p66:IsPlaying() then
        p66:Stop();
    end;

    p66.Destroying:Fire();

    if p66.Trove then
        p66.Trove:Destroy();
    end;

    for i, v in pairs(p66) do
        if type(v) == "table" and Signal.Is(v) then
            v:Destroy();
            p66[i] = nil;
        end;
    end;

    for _, v in pairs(p66._Cache) do
        if type(v) == "table" then
            table.clear(v);
        end;
    end;

    table.clear(p66._Cache);
end;

return u1;