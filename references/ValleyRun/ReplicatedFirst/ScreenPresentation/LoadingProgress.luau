 

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;

function u1.new(p2, u3) -- Line: 7
    -- upvalues: u1 (copy), RunService (copy)
    local u4 = setmetatable({
        elapsed = 0,
        finishing = false,
        alive = true,
        gui = p2,
        config = u3
    }, u1);
    u4.fill = p2.Loading.Track.Fill;
    u4.shine = u4.fill:FindFirstChild("Shine");
    u4.fill.Size = UDim2.fromScale(0, 1);
    p2.Loading.Status.Text = "Ready for the chase?";
    u4.connection = RunService.RenderStepped:Connect(function(p5) -- Line: 13
        -- upvalues: u4 (copy), u3 (copy)
        local v6 = u4;
        v6.elapsed = v6.elapsed + p5;

        if not u4.finishing then
            local v7 = -2.6 * u4.elapsed / math.max(u3.MinimumLoadingTime, 1);
            local v8 = (1 - math.exp(v7)) * 0.97;
            u4.fill.Size = UDim2.fromScale(v8, 1);
        end;

        if u4.shine then
            u4.shine.Offset = Vector2.new(u4.elapsed % 2 / 2 * 2 - 1, 0);
        end;
    end);

    return u4;
end;

function u1.complete(p9) -- Line: 28
    -- upvalues: TweenService (copy)
    if not p9.alive or p9.finishing then
        return false;
    end;

    p9.finishing = true;
    p9.tween = TweenService:Create(p9.fill, TweenInfo.new(p9.config.LoadingFinishTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Size = UDim2.fromScale(1, 1)
    });
    local u10 = false;
    local v11 = p9.tween.Completed:Connect(function() -- Line: 39
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    p9.tween:Play();
    local v12 = os.clock() + p9.config.LoadingFinishTime + 1;

    while p9.alive and (not u10 and os.clock() < v12) do
        task.wait();
    end;

    v11:Disconnect();

    if not p9.alive then
        return false;
    end;

    if not u10 then
        p9.tween:Cancel();
    end;

    p9.fill.Size = UDim2.fromScale(1, 1);
    p9.gui:SetAttribute("LoadingProgressFinishedAt", workspace:GetServerTimeNow());
    task.wait(p9.config.LoadingFinishHold);

    return p9.alive;
end;

function u1.destroy(p13) -- Line: 60
    p13.alive = false;

    if p13.connection then
        p13.connection:Disconnect();
    end;

    if p13.tween then
        p13.tween:Cancel();
    end;
end;

return u1;