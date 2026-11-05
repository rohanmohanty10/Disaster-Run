  

 

local u1 = {
    ClassName = "Sequence"
};
local Knit = require(script.Parent.Parent.KnitPackage.Knit);
local Trove = require(Knit.Util.Trove);
local Signal = require(Knit.Util.Signal);
game:GetService("RunService");

function u1.__index(p2, p3) -- Line: 50
    -- upvalues: u1 (copy)
    local v4 = rawget(p2, p3);

    if v4 then
        return v4;
    end;

    local v5 = rawget(p2, "Data");
    local v6;

    if v5 then
        v6 = v5[p3];
    else
        v6 = nil;
    end;

    return v6 or u1[p3];
end;

function u1.new(p7) -- Line: 60
    -- upvalues: u1 (copy), Trove (copy), Signal (copy)
    local v8 = setmetatable({}, u1);
    v8.Data = p7;
    v8.Frames = {};
    v8.Cache = {};
    v8.UserData = {};
    v8.Trove = Trove.new();
    v8.Name = v8.Data.Name or "Sequence";
    v8.Playing = false;
    v8.Paused = false;
    v8.Looped = v8.Data.Looped or false;
    v8.Framerate = v8.Data.Framerate and 1 / v8.Data.Framerate;
    v8.Position = 0;
    v8.Length = 0;
    v8.Speed = v8.Data.Speed or 1;
    v8.Clock = nil;
    v8.Last = 0;
    v8.LastFrame = 0;
    v8._Time = 0;
    v8:Init();
    v8.Ended = Signal.new();
    v8.Stopped = Signal.new();
    v8.Played = Signal.new();
    v8.Reached = Signal.new();
    v8.Completed = Signal.new();
    v8.DidLoop = Signal.new();
    v8.Trove:Add(v8.Ended);
    v8.Trove:Add(v8.Stopped);
    v8.Trove:Add(v8.Played);
    v8.Trove:Add(v8.Reached);
    v8.Trove:Add(v8.Completed);
    v8.Trove:Add(v8.DidLoop);

    return v8;
end;

function u1.Init(p9) -- Line: 105
    for _, v in pairs(p9.Data.Frames) do
        local v10 = nil;
        local v11 = nil;
        local v12 = nil;

        if #v <= 2 then
            v10, v12 = unpack(v);
        elseif #v >= 3 then
            v10, v11, v12 = unpack(v);
        end;

        for i = v10, v11 or v10 do
            local v13 = p9.Frames[i] or {};
            table.insert(v13, v12);

            if not p9.Frames[i] then
                p9.Frames[i] = v13;
            end;

            if p9.Length < i then
                p9.Length = i;
            end;
        end;
    end;
end;

function u1.GetSpeed(p14) -- Line: 132
    return ((p14.Data.Clock ~= false and p14.Clock and true or false) and p14.Clock.Timescale * p14.Speed or p14.Speed) * (p14.Timescale or 1);
end;

function u1.Run(p15, p16, ...) -- Line: 136
    if p15.Cache[p16] then
        return;
    end;

    local v17 = p15.Frames[p16];

    if v17 then
        p15.Cache[p16] = true;

        for _, v in pairs(v17) do
            if typeof(v) == "function" then
                local v18 = { v(p15, ...) };
                local v19;

                if typeof(v18[1]) == "string" then
                    v19 = v18[1]:lower() or nil;
                else
                    v19 = nil;
                end;

                if v19 then
                    if v19 == "goto" or v19 == "moveto" then
                        p15:PlayAt(v18[2] or nil);
                    elseif v19 == "stop" or v18[1] == false then
                        p15:Stop();
                    elseif v19 == "pause" then
                        p15:Pause();
                    elseif v19 == "repeat" then
                        p15:MoveTo(p16 - 1);
                    elseif v19 == "playsequence" then
                        local v20 = v18[2];
                        local v21 = v18[3];

                        if typeof(v20) == "table" and v20.ClassName == "Sequence" then
                            v20:PlayAt(v21, unpack(v18[4] or {}));
                        end;
                    elseif v19 == "switchsequence" or v19 == "switch" then
                        local v22 = v18[2];
                        local v23 = v18[3];

                        if typeof(v22) == "table" and v22.ClassName == "Sequence" then
                            p15:Stop();
                            v22:PlayAt(v23, unpack(v18[4] or {}));
                        end;
                    end;
                end;
            end;
        end;

        p15.Reached:Fire(p16);
    end;
end;

function u1.Clear(p24) -- Line: 176
    table.clear(p24.Cache);
end;

function u1.PlayAt(u25, p26, ...) -- Line: 180
    if u25.Playing then
        u25:MoveTo(p26 or 0);

        return;
    end;

    u25.Playing = true;
    u25.Played:Fire();
    u25:MoveTo(p26 or 0);
    u25._Time = p26 or 0;
    task.spawn(function(...) -- Line: 192
        -- upvalues: u25 (copy)
        u25:Run(0, ...);

        while true do
            local v27;

            repeat
                if not getmetatable(u25) or (not u25.Playing or u25._Time > u25.Length) then
                    if u25._Time >= u25.Length then
                        u25.Completed:Fire();
                    end;

                    u25:End();

                    return;
                end;

                v27 = task.wait();

                if not u25.Playing then
                    return;
                end;
            until not u25.Paused;

            local v28 = u25;
            v28._Time = v28._Time + v27 * u25:GetSpeed() * 60;
            u25.Position = math.floor(u25._Time);

            for i, _ in pairs(u25.Frames) do
                if u25._Time >= i then
                    u25:Run(i, ...);

                    if not u25.Playing then
                        break;
                    end;
                end;
            end;

            if u25.Looped and u25._Time > u25.Length then
                u25:Clear();
                u25._Time = u25._Time - u25.Length;
                u25:Run(0, ...);
                u25.DidLoop:Fire();
            end;
        end;
    end, ...);
end;

function u1.Play(p29, ...) -- Line: 298
    return p29:PlayAt(0, ...);
end;

function u1.Resume(p30) -- Line: 302
    if p30.Paused then
        p30.Paused = false;
    end;
end;

function u1.Pause(p31) -- Line: 308
    if p31.Playing then
        if not p31.Paused then
            p31.Paused = true;
        end;
    else
        p31.Paused = false;
    end;
end;

function u1.End(p32) -- Line: 318
    p32.Playing = false;
    p32.Paused = false;
    p32.Position = 0;
    p32.Last = 0;
    p32.Ended:Fire();
end;

function u1.Stop(p33) -- Line: 327
    if p33.Playing then
        p33.Stopped:Fire();
    end;

    p33:End();
end;

function u1.MoveTo(p34, p35) -- Line: 335
    p34.Position = math.clamp(p35, 0, p34.Length);
    p34._Time = p34.Position;
    p34.LastFrame = p35;
    p34:Clear();
end;

function u1.Destroy(p36) -- Line: 342
    -- upvalues: Trove (copy)
    p36:Stop();
    p36.Trove:Destroy();

    for _, v in pairs(p36) do
        if getmetatable(v) == Trove then
            v:Destroy();
        end;
    end;

    setmetatable(p36, nil);
end;

return u1;