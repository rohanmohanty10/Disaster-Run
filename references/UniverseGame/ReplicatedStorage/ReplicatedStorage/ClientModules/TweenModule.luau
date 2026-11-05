  

 

local v1 = {};
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local u2;

if script.TweenEvent == nil and RunService:IsServer() then
    u2 = Instance.new("RemoteEvent", script);
    u2.Name = "TweenEvent";
else
    u2 = script:WaitForChild("TweenEvent");
end;

local function TweenInfo_To_Table(p3) -- Line: 65
    return {
        p3.Time or 1,
        p3.EasingStyle or Enum.EasingStyle.Quad,
        p3.EasingDirection or Enum.EasingDirection.Out,
        p3.RepeatCount or 0,
        p3.Reverses or false,
        p3.DelayTime or 0
    };
end;

local function Table_To_TweenInfo(p4) -- Line: 76
    return TweenInfo.new(unpack(p4));
end;

local function serverAssignProperties(p5, p6) -- Line: 80
    for i, v in pairs(p6) do
        p5[i] = v;
    end;
end;

local u7 = {};

function v1.GetTweenObject(p8, u9, p10, u11) -- Line: 88
    -- upvalues: TweenInfo_To_Table (copy), u7 (copy), u2 (ref)
    local u12 = {
        DontUpdate = {}
    };
    local u13 = TweenInfo_To_Table(p10);

    local function Play(p14, p15, p16) -- Line: 93
        -- upvalues: u13 (ref), u7 (ref), u9 (copy), u12 (copy), u2 (ref), u11 (copy)
        local v17 = os.time() + u13[1];
        local u18 = u13[1];
        u7[u9] = u7[u9] or os.time();
        local v19 = p16 or false;
        u12.Paused = false;

        if p15 == nil and not v19 then
            u7[u9] = v17;
            u2:FireAllClients("RunTween", u9, u13, u11);
        elseif v19 and p15 == nil then
            u18 = u18 + (u7[u9] - os.time());
            u7[u9] = v17 + (u7[u9] - os.time());
            u2:FireAllClients("QueueTween", u9, u13, u11);
        elseif v19 then
            u2:FireClient(p15, "QueueTween", u9, u13, u11);
        else
            u2:FireClient(p15, "RunTween", u9, u13, u11);
        end;

        if not p14 or p15 ~= nil then
            if p15 == nil then
                coroutine.wrap(function() -- Line: 124
                    -- upvalues: u7 (ref), u9 (ref), u18 (ref), u12 (ref), u11 (ref)
                    local v20 = u7[u9];
                    local v21 = 0;

                    repeat
                        wait(0.1);
                        v21 = v21 + 1;
                    until u18 <= v21;

                    if u7[u9] == v20 then
                        u7[u9] = nil;
                    end;

                    if u12.Paused == nil or u12.Paused == false then
                        local v22 = u9;

                        for i, v in pairs(u11) do
                            v22[i] = v;
                        end;
                    end;
                end)();
            end;

            return;
        end;

        local v23 = u7[u9];
        local v24 = 0;

        repeat
            wait(0.1);
            v24 = v24 + 1;
        until u18 <= v24;

        if u7[u9] == v23 then
            u7[u9] = nil;
        end;

        if u12.Paused == nil or u12.Paused == false then
            local v25 = u9;

            for i, v in pairs(u11) do
                v25[i] = v;
            end;
        end;
    end;

    function u12.Play(p26, p27, p28) -- Line: 137
        -- upvalues: Play (copy)
        Play(p27, p28);
    end;

    function u12.QueuePlay(p29, p30, p31) -- Line: 141
        -- upvalues: Play (copy)
        Play(p30, p31, true);
    end;

    function u12.Pause(p32, p33) -- Line: 145
        -- upvalues: u12 (copy), u2 (ref), u9 (copy)
        if p33 == nil then
            u12.Paused = true;
            u2:FireAllClients("PauseTween", u9);

            return;
        end;

        table.insert(u12.DontUpdate, p33);
        u2:FireClient("PauseTween", u9);
    end;

    function u12.Stop(p34, p35) -- Line: 155
        -- upvalues: u12 (copy), u2 (ref), u9 (copy)
        if p35 ~= nil then
            u2:FireClient("StopTween", u9);

            return;
        end;

        u12.Stopped = true;
        u2:FireAllClients("StopTween", u9);
    end;

    return u12;
end;

if RunService:IsClient() then
    local u36 = {};
    u2.OnClientEvent:Connect(function(p37, u38, u39, u40) -- Line: 170
        -- upvalues: u7 (copy), u36 (copy), TweenService (copy)
        if u39 ~= nil then
            u39 = TweenInfo.new(unpack(u39));
        end;

        local function runTween(p41) -- Line: 175
            -- upvalues: u38 (copy), u39 (ref), u7 (ref), u36 (ref), TweenService (ref), u40 (copy)
            if not u38 then
                return;
            end;

            local v42 = os.time() + u39.Time;
            u7[u38] = u7[u38] or os.time();
            local v43 = u7[u38];

            if p41 and u7[u38] >= os.time() then
                local v44 = u7[u38] - os.time();
                u7[u38] = v42 + v44;
                v43 = u7[u38];
                wait(v44);
            else
                u7[u38] = v42;
            end;

            if u36[u38] ~= nil then
                u36[u38]:Cancel();
            end;

            local v45 = TweenService:Create(u38, u39, u40);
            u36[u38] = v45;
            v45:Play();
            wait(u39.Time or 1);

            if u7[u38] == v43 then
                u7[u38] = nil;
            end;

            if u36[u38] == v45 then
                u36[u38] = nil;
            end;
        end;

        if p37 == "RunTween" then
            runTween();
        elseif p37 == "QueueTween" then
            runTween(true);
        elseif p37 == "StopTween" then
            if u36[u38] == nil then
                warn("Tween being stopped does not exist.");
            else
                u36[u38]:Stop();
                u36[u38] = nil;
            end;
        elseif p37 == "PauseTween" then
            if u36[u38] == nil then
                warn("Tween being paused does not exist.");
            else
                u36[u38]:Pause();
            end;
        end;
    end);
end;

return v1;