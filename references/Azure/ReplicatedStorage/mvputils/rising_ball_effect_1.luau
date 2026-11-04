 
 

local u1 = {};
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local Effects = workspace:WaitForChild("Effects");
local Ball = script:WaitForChild("rising_ball_effect"):WaitForChild("Ball");
local u2 = {};
local u3 = {};
local Random_new_ret = Random.new();

local function deepCopy(p4) -- Line: 49
    -- upvalues: deepCopy (copy)
    if typeof(p4) ~= "table" then
        return p4;
    end;

    local v5 = {};

    for i, v in pairs(p4) do
        v5[i] = deepCopy(v);
    end;

    return v5;
end;

local function mergeTables(p6, p7) -- Line: 58
    -- upvalues: deepCopy (copy), mergeTables (copy)
    if not p7 then
        return deepCopy(p6);
    end;

    local v8 = deepCopy(p6);

    for i, v in pairs(p7) do
        if typeof(v) == "table" and typeof(v8[i]) == "table" then
            v8[i] = mergeTables(v8[i], v);
        else
            v8[i] = v;
        end;
    end;

    return v8;
end;

local function spawnBall(p9: table) -- Line: 71
    -- upvalues: Ball (copy), Random_new_ret (copy), Effects (copy), Debris (copy), TweenService (copy), RunService (copy)
    local u10 = Ball:Clone();
    u10.Anchored = true;
    u10.CanCollide = false;
    u10.CanQuery = false;
    u10.CanTouch = false;
    local v11 = p9.SpawnOffset or 2;
    local v12;

    if v11 > 0 then
        local v13 = Random_new_ret:NextNumber();
        v12 = v11 * math.sqrt(v13) or 0;
    else
        v12 = 0;
    end;

    local v14 = Random_new_ret:NextNumber(0, 6.283185307179586);
    local v15 = math.cos(v14) * v12;
    local v16 = math.sin(v14) * v12;
    local Vector3_new_ret = Vector3.new(v15, 0, v16);
    local v17 = (p9.Position or CFrame.new()) * CFrame.new(Vector3_new_ret);
    u10.CFrame = v17;
    local v18 = p9.StartSize or (p9.Size or Ball.Size);
    local MidSize = p9.MidSize;
    local v19 = p9.EndSize or v18;
    u10.Size = v18;
    u10.Color = p9.Color;
    u10.Transparency = p9.TransparencyStart == nil and 0 or (p9.TransparencyStart or 0);
    u10.Parent = Effects;
    local u20 = typeof(p9.Duration) == "table" and Random_new_ret:NextNumber(p9.Duration.Min, p9.Duration.Max) or p9.Duration;

    if p9.Highlight and p9.Highlight.Enabled ~= false then
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = u10;
        Highlight.FillColor = p9.Highlight.FillColor or Color3.new(1, 1, 0);
        Highlight.OutlineColor = p9.Highlight.OutlineColor or Color3.new(1, 1, 1);
        Highlight.FillTransparency = p9.Highlight.FillTransparency == nil and 0.2 or (p9.Highlight.FillTransparency or 0.2);
        Highlight.OutlineTransparency = p9.Highlight.OutlineTransparency == nil and 0 or (p9.Highlight.OutlineTransparency or 0);
        Highlight.DepthMode = p9.Highlight.DepthMode or Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.Enabled = true;
        Highlight.Parent = Effects;
        Debris:AddItem(Highlight, u20 + 1);
    end;

    local v21;

    if typeof(p9.Speed) == "table" then
        local v22 = p9.Speed.Min or 0;
        local v23 = p9.Speed.Max or v22;

        if v23 >= v22 then
            local v24 = v22;
            v22 = v23;
            v23 = v24;
        end;

        v21 = Random_new_ret:NextNumber(v23, v22);
    else
        v21 = p9.Speed;
    end;

    local v25 = p9.LateralDrift or 0;
    local v26;

    if v25 > 0 then
        local v27 = Random_new_ret:NextNumber();
        local v28 = v25 * math.sqrt(v27);
        local v29 = Random_new_ret:NextNumber(0, 6.283185307179586);
        local v30 = math.cos(v29) * v28;
        local v31 = math.sin(v29) * v28;
        v26 = Vector3.new(v30, 0, v31);
    else
        v26 = Vector3.new(0, 0, 0);
    end;

    local v32 = v17.Position + Vector3.new(0, v21, 0) + v26;
    local TweenInfo_new_ret = TweenInfo.new(u20, p9.MoveEasingStyle or (p9.EasingStyle or Enum.EasingStyle.Quad), p9.MoveEasingDirection or (p9.EasingDirection or Enum.EasingDirection.Out));
    local TweenInfo_new_ret2 = TweenInfo.new(u20, p9.AlphaEasingStyle or (p9.EasingStyle or Enum.EasingStyle.Quad), p9.AlphaEasingDirection or (p9.EasingDirection or Enum.EasingDirection.Out));
    local v33 = TweenService:Create(u10, TweenInfo_new_ret, {
        Position = v32
    });
    local v34 = TweenService:Create(u10, TweenInfo_new_ret2, {
        Transparency = p9.TransparencyEnd == nil and 1 or (p9.TransparencyEnd or 1)
    });
    local math_clamp_ret = math.clamp(p9.SizeStageRatio == nil and 0.5 or (p9.SizeStageRatio or 0.5), 0.01, 0.99);
    local u35 = false;

    if MidSize then
        local v36 = u20 * math_clamp_ret;
        local TweenInfo_new_ret3 = TweenInfo.new(v36, p9.SizeEasingStyle1 or (p9.EasingStyle or Enum.EasingStyle.Quad), p9.SizeEasingDirection1 or (p9.EasingDirection or Enum.EasingDirection.Out));
        local TweenInfo_new_ret4 = TweenInfo.new(u20 - v36, p9.SizeEasingStyle2 or (p9.EasingStyle or Enum.EasingStyle.Quad), p9.SizeEasingDirection2 or (p9.EasingDirection or Enum.EasingDirection.Out));
        local v37 = TweenService:Create(u10, TweenInfo_new_ret3, {
            Size = MidSize
        });
        local u38 = TweenService:Create(u10, TweenInfo_new_ret4, {
            Size = v19
        });
        v37.Completed:Connect(function() -- Line: 167
            -- upvalues: u10 (copy), u38 (copy)
            if u10 and u10.Parent then
                u38:Play();
            end;
        end);
        u38.Completed:Connect(function() -- Line: 172
            -- upvalues: u35 (ref)
            u35 = true;
        end);
        v37:Play();
    else
        local v39 = TweenService:Create(u10, TweenInfo.new(u20, p9.SizeEasingStyle1 or (p9.EasingStyle or Enum.EasingStyle.Quad), p9.SizeEasingDirection1 or (p9.EasingDirection or Enum.EasingDirection.Out)), {
            Size = v19
        });
        v39.Completed:Connect(function() -- Line: 183
            -- upvalues: u35 (ref)
            u35 = true;
        end);
        v39:Play();
    end;

    v33:Play();
    v34:Play();
    task.delay(math.max(u20 - 0.05, 0), function() -- Line: 192
        -- upvalues: u10 (copy)
        if u10 and u10.Parent then
            for _, descendant in ipairs(u10:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end);
    local u40 = false;
    local u41 = false;
    v33.Completed:Connect(function() -- Line: 203
        -- upvalues: u40 (ref)
        u40 = true;
    end);
    v34.Completed:Connect(function() -- Line: 204
        -- upvalues: u41 (ref)
        u41 = true;
    end);
    task.spawn(function() -- Line: 206
        -- upvalues: u20 (copy), u35 (ref), u40 (ref), u41 (ref), RunService (ref), u10 (copy)
        local os_clock_ret = os.clock();

        while os.clock() - os_clock_ret < u20 + 1 and not (u35 and (u40 and u41)) do
            RunService.Heartbeat:Wait();
        end;

        if u10 and u10.Parent then
            u10:Destroy();
        end;
    end);
    Debris:AddItem(u10, u20 + 1);
end;

function u1.Emit(p42: table) -- Line: 222
    -- upvalues: spawnBall (copy)
    for i = 1, p42.Amount do
        spawnBall(p42);
        local _ = i;
    end;
end;

function u1.EmitContinuous(u43: string, u44: table, u45: number, p46: number?) -- Line: 228
    -- upvalues: u2 (copy), RunService (copy), spawnBall (copy)
    if u2[u43] then
        u2[u43]:Disconnect();
        u2[u43] = nil;
    end;

    local u47 = 0;
    u2[u43] = RunService.Heartbeat:Connect(function(p48) -- Line: 234
        -- upvalues: u47 (ref), u45 (copy), u44 (copy), spawnBall (ref)
        u47 = u47 + p48;
        local v49 = 1 / u45;

        while v49 <= u47 do
            u47 = u47 - v49;

            for i = 1, u44.Amount do
                spawnBall(u44);
                local _ = i;
            end;
        end;
    end);

    if p46 and p46 > 0 then
        task.delay(p46, function() -- Line: 245
            -- upvalues: u2 (ref), u43 (copy)
            if u2[u43] then
                u2[u43]:Disconnect();
                u2[u43] = nil;
            end;
        end);
    else
        local u50 = u2[u43];
        task.delay(300, function() -- Line: 253
            -- upvalues: u2 (ref), u43 (copy), u50 (copy)
            if u2[u43] == u50 then
                u50:Disconnect();
                u2[u43] = nil;
            end;
        end);
    end;
end;

function u1.Stop(p51: string) -- Line: 262
    -- upvalues: u2 (copy)
    if u2[p51] then
        u2[p51]:Disconnect();
        u2[p51] = nil;
    end;
end;

function u1.StopAll() -- Line: 269
    -- upvalues: u2 (copy)
    for i, v in pairs(u2) do
        v:Disconnect();
        u2[i] = nil;
    end;
end;

function u1.SaveConfig(p52: string, p53: table) -- Line: 276
    -- upvalues: u3 (copy), deepCopy (copy)
    u3[p52] = deepCopy(p53);
end;

function u1.RemoveConfig(p54: string) -- Line: 280
    -- upvalues: u3 (copy)
    u3[p54] = nil;
end;

function u1.GetConfig(p55: string) -- Line: 284
    -- upvalues: u3 (copy), deepCopy (copy)
    if u3[p55] then
        return deepCopy(u3[p55]);
    end;

    return nil;
end;

function u1.EmitFromConfig(p56: string, p57: any) -- Line: 289
    -- upvalues: u3 (copy), mergeTables (copy), u1 (copy)
    local v58 = u3[p56];

    if v58 then
        p57 = mergeTables(v58, p57) or p57;
    end;

    if not p57 then
        return;
    end;

    u1.Emit(p57);
end;

function u1.EmitContinuousFromConfig(p59: string, p60: string, p61: number, p62: number?, p63: any) -- Line: 296
    -- upvalues: u3 (copy), mergeTables (copy), u1 (copy)
    local v64 = u3[p60];

    if not v64 then
        return;
    end;

    local v65 = mergeTables(v64, p63);
    u1.EmitContinuous(p59, v65, p61, p62);
end;

return u1;