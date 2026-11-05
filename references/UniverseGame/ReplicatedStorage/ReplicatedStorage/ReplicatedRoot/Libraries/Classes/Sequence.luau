  

 

local u1 = {};
u1.__index = u1;
game:GetService("RunService"):IsStudio();
local Signal = require(script.Parent.Signal);
local u2 = { "Played", "Ended", "Paused", "Stopped", "Completed", "DidLoop", "MovedTo", "Updated", "Failed", "Destroying" };

function u1.new(p3) -- Line: 72
    -- upvalues: u1 (copy), u2 (copy), Signal (copy)
    local u4 = setmetatable({}, u1);
    u4._Time = 0;
    u4._Position = 0;
    u4._Length = 0;
    u4._Speed = 1;
    u4._PlayedAt = 0;
    u4._Playing = false;
    u4._Paused = false;
    u4._Looped = false;
    u4._Frames = {};
    u4._FrameCache = {};
    u4._Callbacks = {};
    u4._Destroyed = false;
    u4._States = {};

    for _, v in pairs(u2) do
        u4[v] = Signal.new();
        u4[v]:Connect(function() -- Line: 97
            -- upvalues: u4 (copy), v (copy)
            u4:FireCallback(v);
        end);
    end;

    if p3 then
        u4:Load(p3);
    end;

    return u4;
end;

function u1.Load(p5, p6) -- Line: 111
    if p6.Speed ~= nil then
        p5:SetSpeed(p6.Speed);
    end;

    if p6.Looped ~= nil then
        p5:Loop(p6.Looped);
    end;

    if p6.Validate ~= nil then
        p5:SetValidate(p6.Validate);
    end;

    if p6.FrameHandler ~= nil then
        p5:SetFrameHandler(p6.FrameHandler);
    end;

    if p6.ErrorHandler ~= nil then
        p5:SetErrorHandler(p6.ErrorHandler);
    end;

    if p6.CallbackHandler ~= nil then
        p5:SetCallbackHandler(p6.FrameHandler);
    end;

    for _, v in ipairs(p6.Frames or {}) do
        if typeof(v[2]) == "number" then
            p5:AddFrames(unpack(v));
        else
            p5:AddFrame(unpack(v));
        end;
    end;

    for _, v in ipairs(p6.Callbacks or {}) do
        p5:BindCallback(unpack(v));
    end;

    return p5;
end;

function u1.BindCallback(p7, p8, ...) -- Line: 147
    local v9 = p7._Callbacks[p8];

    if not v9 then
        v9 = {};
        p7._Callbacks[p8] = v9;
    end;

    table.insert(v9, { ... });
end;

function u1.FireCallback(p10, p11, ...) -- Line: 157
    -- upvalues: u1 (copy)
    local v12 = p10._Callbacks[p11];

    if not v12 then
        return false;
    end;

    for _, v in ipairs(v12) do
        local v13 = v[1];
        local v14 = { table.unpack(v, 2) };

        for _, v2 in { ... } do
            table.insert(v14, v2);
        end;

        local v15 = table.pack(xpcall(p10.HandleCallback, debug.traceback, v13, p10, p11, unpack(v14)));

        if not v15[1] and typeof(v15[2]) == "string" then
            local v16 = v15[2];
            warn((`An error occurred attempting to run callback {p11}\n{v15[2]}`));
            p10.Failed:Fire(p11, v16);
            u1.Errored(p10, p11, v16);
        end;
    end;

    return true;
end;

function u1.AddFrame(p17, p18, ...) -- Line: 185
    local v19 = p17._Frames[p18];

    if not v19 then
        v19 = {};
        p17._Frames[p18] = v19;
    end;

    table.insert(v19, { ... });

    if p17._Length < p18 then
        p17._Length = p18;
    end;

    for i = 0, p17._Length do
        if not p17._Frames[i] then
            p17._Frames[i] = {};
        end;
    end;
end;

function u1.AddFrames(p20, p21, p22, ...) -- Line: 206
    for i = p21, p22 do
        p20:AddFrame(i, ...);
    end;
end;

function u1.RunFrame(p23, p24, ...) -- Line: 213
    -- upvalues: u1 (copy)
    if p23._FrameCache[p24] then
        return false;
    end;

    local v25 = p23._Frames[p24];

    if not v25 then
        return false;
    end;

    p23._FrameCache[p24] = true;

    for _, v in ipairs(v25) do
        local v26 = v[1];
        local v27 = { table.unpack(v, 2) };

        for _, v2 in { ... } do
            table.insert(v27, v2);
        end;

        local v28 = table.pack(xpcall(p23.HandleFrame, debug.traceback, v26, p23, p24, unpack(v27)));
        local v29 = v28[1];

        if v29 or typeof(v28[2]) ~= "string" then
            if v29 then
                local v30;

                if typeof(v28[2]) == "string" then
                    v30 = v28[2]:lower() or nil;
                else
                    v30 = nil;
                end;

                if v30 then
                    if v30 == "goto" or v30 == "moveto" then
                        p23:_PlayAt(v28[3] or nil);
                    else
                        if v30 == "stop" or v28[2] == false then
                            p23:Stop();

                            return nil;
                        end;

                        if v30 == "pause" then
                            p23:Pause();

                            return nil;
                        end;

                        if v30 == "repeat" then
                            p23:MoveTo(v28[3] or p24);

                            return nil;
                        end;

                        if v30 == "playsequence" then
                            local v31 = v28[3];
                            local v32 = v28[4];

                            if v31 then
                                v31:PlayAt(v32, unpack(v28[5] or {}));
                            end;
                        elseif v30 == "switchsequence" or v30 == "switch" then
                            local v33 = v28[3];
                            local v34 = v28[4];

                            if v33 then
                                p23:Stop();
                                v33:PlayAt(v34, unpack(v28[5] or {}));
                            end;

                            return nil;
                        end;
                    end;
                end;
            end;
        else
            local v35 = v28[2];
            warn((`An error occurred attempting to run frame {p24}\n{v28[2]}`));
            p23.Failed:Fire(p24, v35);
            u1.Errored(p23, p24, v35);
        end;
    end;

    return true;
end;

function u1.HandleFrame(p36, p37, ...) -- Line: 275
    return p36(p37, ...);
end;

function u1.Validate(p38) -- Line: 280
    return true;
end;

function u1.Errored(p39, p40, p41) -- Line: 285
    p39:Stop();
end;

function u1.HandleCallback(p42, p43, ...) -- Line: 290
    return p42(p43, ...);
end;

function u1._PlayAt(p44, p45, ...) -- Line: 296
    p44._Time = p45 or 0;

    if p44:IsPlaying() then
        p44:MoveTo(p44._Time);

        return;
    end;

    local v46 = os.clock();
    p44._PlayedAt = v46;
    p44._Playing = true;
    p44.Played:Fire(...);
    p44:MoveTo(p44._Time);
    p44:RunFrame(0, ...);

    while (p44._Time <= p44:GetLength() or p44:IsLooped()) and (p44:IsPlaying() and v46 == p44._PlayedAt) do
        local v47 = task.wait();

        if not p44:IsPlaying() then
            return;
        end;

        if v46 ~= p44._PlayedAt then
            return;
        end;

        if not p44:IsPaused() then
            if p44.Validate ~= nil and not p44.Validate(p44, ...) then
                p44.Failed:Fire(p44._Position, "ValidateFailed");
                break;
            end;

            p44._Time = p44._Time + v47 * p44:GetSpeed() * 60;
            p44._Position = math.floor(p44._Time);

            for i, _ in ipairs(p44._Frames) do
                if p44._Time >= i then
                    if p44:RunFrame(i, ...) == nil or not p44:IsPlaying() then
                        break;
                    end;

                    if v46 ~= p44._PlayedAt then
                        return;
                    end;
                end;
            end;

            p44.Updated:Fire(p44._Position);

            if p44:IsLooped() and p44._Time > p44:GetLength() then
                table.clear(p44._FrameCache);
                p44._Time = p44._Time - p44:GetLength();
                p44:RunFrame(0, ...);
                p44.DidLoop:Fire();
            end;
        end;
    end;

    p44:End();
    p44.Completed:Fire();
end;

function u1.End(p48) -- Line: 365
    p48._Playing = false;
    p48._Time = 0;
    p48._Position = 0;
    p48.Ended:Fire();
    table.clear(p48._FrameCache);
end;

function u1.Play(p49, ...) -- Line: 375
    return task.spawn(p49._PlayAt, p49, 0, ...);
end;

function u1.PlayAt(p50, p51, ...) -- Line: 380
    return task.spawn(p50._PlayAt, p50, p51 or 0, ...);
end;

function u1.Pause(p52) -- Line: 385
    if p52._Playing then
        p52._Paused = true;
        p52.Paused:Fire();
    end;
end;

function u1.Resume(p53) -- Line: 393
    if p53._Paused then
        p53._Paused = false;
        p53.Resumed:Fire();
    end;
end;

function u1.Stop(p54) -- Line: 401
    if p54._Playing then
        p54:End();
        p54.Stopped:Fire();
    end;
end;

function u1.MoveTo(p55, p56, p57) -- Line: 410
    p55._Position = math.clamp(p56, 0, p55._Length);
    p55._Time = p56;

    for i, _ in pairs(p55._FrameCache) do
        if p55:GetPosition() <= i then
            p55._FrameCache[i] = nil;
        end;
    end;

    if p57 == true then
        for i, _ in pairs(p55._Frames) do
            if i < p55:GetPosition() then
                p55._FrameCache[i] = true;
            end;
        end;
    end;

    p55.MovedTo:Fire(p55._Position);
end;

function u1.IsPlaying(p58) -- Line: 429
    return p58._Playing;
end;

function u1.IsPaused(p59) -- Line: 434
    return p59._Paused;
end;

function u1.IsLooped(p60) -- Line: 439
    return p60._Looped;
end;

function u1.Loop(p61, p62) -- Line: 444
    p61._Looped = p62;
end;

function u1.GetSpeed(p63) -- Line: 450
    return p63._Speed;
end;

function u1.GetPosition(p64) -- Line: 455
    return p64._Position;
end;

function u1.GetLength(p65) -- Line: 460
    return p65._Length;
end;

function u1.SetSpeed(p66, p67) -- Line: 465
    p66._Speed = p67;
end;

function u1.GetValidate(p68) -- Line: 470
    return p68.Validate;
end;

function u1.SetValidate(p69, p70) -- Line: 475
    p69.Validate = p70;
end;

function u1.GetFrameHandler(p71) -- Line: 480
    return p71.HandleFrame;
end;

function u1.SetFrameHandler(p72, p73) -- Line: 485
    p72.HandleFrame = p73;
end;

function u1.GetCallbackHandler(p74) -- Line: 490
    return p74.HandleCallback;
end;

function u1.SetCallbackHandler(p75, p76) -- Line: 495
    p75.HandleCallback = p76;
end;

function u1.GetErrorHandler(p77) -- Line: 500
    return p77.Errored;
end;

function u1.SetErrorHandler(p78, p79) -- Line: 505
    p78.Errored = p79;
end;

function u1.GetState(p80, p81) -- Line: 510
    local v82 = p81 or "Main";

    if not p80._States[v82] then
        p80._States[v82] = {};
    end;

    return p80._States[v82];
end;

function u1.ClearState(p83, p84) -- Line: 518
    local v85 = p84 or "Main";

    if p83._States[v85] then
        table.clear(p83._States[v85]);
    end;
end;

function u1.ClearAllStates(p86) -- Line: 525
    for _, v in pairs(p86._States) do
        table.clear(v);
    end;
end;

u1.ClearAllCaches = u1.ClearAllStates;

function u1.GetCache(p87, p88) -- Line: 533
    return p87:GetState(p88 or "Cache");
end;

function u1.ClearCache(p89, p90) -- Line: 538
    return p89:ClearState(p90 or "Cache");
end;

function u1.Destroy(p91) -- Line: 544
    -- upvalues: u2 (copy)
    if table.isfrozen(p91) then
        return;
    end;

    if p91._Destroyed then
        return;
    end;

    p91._Destroyed = true;

    if p91:IsPlaying() then
        p91:Stop();
    end;

    p91.Destroying:Fire();

    for _, v in pairs(u2) do
        p91[v]:Destroy();
        p91[v] = nil;
    end;

    table.clear(p91);
    table.freeze(p91);
end;

return u1;