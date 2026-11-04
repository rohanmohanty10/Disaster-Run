 

 

local RunService = game:GetService("RunService");
game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 7
    -- upvalues: u1 (copy)
    return setmetatable({
        _FrameMarkerElapsed = 0,
        Framerate = p2.Framerate or 60,
        _sequences = {}
    }, u1);
end;

function u1.At(p3, p4, p5) -- Line: 16
    p3._sequences[p4] = p5;
end;

function u1.Chain(p6: table, p7: table) -- Line: 20
    for i, v in p7 do
        p6:At(i, v);
    end;

    p6:Play();

    return p6;
end;

function u1.Update(p8, p9) -- Line: 30
    p8._FrameMarkerElapsed = p8._FrameMarkerElapsed + p9 * p8.Framerate;
end;

function u1.Play(u10) -- Line: 34
    -- upvalues: RunService (copy)
    u10._Connection = RunService.Heartbeat:Connect(function(p11) -- Line: 35
        -- upvalues: u10 (copy)
        for i, v in u10._sequences do
            if i <= u10._FrameMarkerElapsed then
                task.spawn(v, u10);
                u10._sequences[i] = nil;
            end;
        end;

        local v12 = u10;
        v12._FrameMarkerElapsed = v12._FrameMarkerElapsed + p11 * u10.Framerate;
    end);
end;

function u1.Stop(p13) -- Line: 47
    p13.Framerate = 0;
end;

function u1.Destroy(p14) -- Line: 51
    p14._Connection:Disconnect();
    p14:Stop();
    setmetatable(p14, nil);
end;

return u1;