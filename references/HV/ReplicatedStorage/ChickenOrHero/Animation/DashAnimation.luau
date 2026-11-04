 

 

local AnimationConfig = require(script.Parent.AnimationConfig);
local DashAnimationPolicy = require(script.Parent.DashAnimationPolicy);
local AnimationLibrary = require(script.Parent.AnimationLibrary);
local u1 = {};
local u2 = {};

function u1.stop(u3) -- Line: 9
    -- upvalues: u2 (copy), AnimationConfig (copy)
    local u4 = u2[u3];

    if not (u4 and u4.active) then
        return;
    end;

    u4.serial = u4.serial + 1;
    u4.active = nil;
    u4.facing = nil;
    local serial = u4.serial;

    for _, v in u4.tracks do
        if v.track.IsPlaying then
            v.track:Stop(AnimationConfig.Dash.FadeOut);
        end;
    end;

    u3:SetAttribute("DashAnimationActive", nil);
    task.delay(AnimationConfig.Dash.FadeOut, function() -- Line: 16
        -- upvalues: u2 (ref), u3 (copy), u4 (copy), serial (copy)
        if u2[u3] == u4 and (u4.serial == serial and not u4.active) then
            u3:SetAttribute("DashVisualFacing", nil);
        end;
    end);
end;

function u1.release(p5) -- Line: 22
    -- upvalues: u2 (copy)
    local v6 = u2[p5];

    if not v6 then
        return;
    end;

    u2[p5] = nil;

    for _, v in v6.connections do
        v:Disconnect();
    end;

    for _, v in v6.tracks do
        v.track:Destroy();
    end;

    p5:SetAttribute("DashAnimationActive", nil);
    p5:SetAttribute("DashVisualFacing", nil);
end;

function u1.prepare(u7, p8) -- Line: 30
    -- upvalues: AnimationConfig (copy), u2 (copy), u1 (copy), AnimationLibrary (copy)
    if not (AnimationConfig.Enabled and AnimationConfig.Dash.Enabled) then
        return;
    end;

    local v9 = u7:FindFirstChildOfClass("Humanoid");
    local u10 = p8;

    if not u10 then
        if v9 then
            u10 = v9:FindFirstChildOfClass("Animator");
        else
            u10 = v9;
        end;
    end;

    if u10 and v9.RigType == Enum.HumanoidRigType.R6 then
        local v11 = u2[u7];

        if v11 and v11.animator ~= u10 then
            u1.release(u7);
            v11 = nil;
        end;

        if not v11 then
            v11 = {
                serial = 0,
                animator = u10,
                tracks = {},
                connections = {},
                retryAt = {},
                attempts = {}
            };
            u2[u7] = v11;
            table.insert(v11.connections, u7.Destroying:Connect(function() -- Line: 40
                -- upvalues: u1 (ref), u7 (copy)
                u1.release(u7);
            end));
            table.insert(v11.connections, v9.Died:Connect(function() -- Line: 41
                -- upvalues: u1 (ref), u7 (copy)
                u1.stop(u7);
            end));
        end;

        local os_clock_ret = os.clock();
        local u12 = AnimationLibrary.prepare();

        for _, v in { "DashLeft", "DashRight", "DashBack" } do
            local v13 = v11.tracks[v];

            if v13 and (v13.track.Length <= 0 and (os_clock_ret - v13.loadedAt > 8 and (v11.attempts[v] or 0) < 3)) then
                v13.track:Destroy();
                v11.tracks[v] = nil;
                v13 = nil;
            end;

            if not v13 and (u12[v] and ((v11.retryAt[v] or 0) <= os_clock_ret and (v11.attempts[v] or 0) < 3)) then
                v11.attempts[v] = (v11.attempts[v] or 0) + 1;
                v11.retryAt[v] = os_clock_ret + 2;
                local success, result = pcall(function() -- Line: 51
                    -- upvalues: u10 (ref), u12 (copy), v (copy)
                    return u10:LoadAnimation(u12[v].animation);
                end);

                if success then
                    result.Name = "CoH_" .. v;
                    result.Looped = false;
                    result.Priority = Enum.AnimationPriority.Action;
                    v11.tracks[v] = {
                        track = result,
                        loadedAt = os_clock_ret
                    };
                else
                    warn("Chicken or Hero dash animation " .. v .. ": " .. tostring(result));
                end;
            end;
        end;

        return v11;
    end;
end;

function u1.isActive(p14) -- Line: 60
    -- upvalues: u2 (copy)
    local v15 = u2[p14];
    local v16;

    if v15 == nil or v15.active == nil then
        v16 = false;
    else
        v16 = v15.active.IsPlaying and os.clock() < v15.endsAt;
    end;

    return v16;
end;

function u1.facing(p17) -- Line: 64
    -- upvalues: u2 (copy), u1 (copy)
    local v18 = u2[p17];

    if u1.isActive(p17) then
        return v18.facing;
    end;
end;

function u1.play(p19, p20, p21, p22, p23) -- Line: 68
    -- upvalues: DashAnimationPolicy (copy), u1 (copy)
    local v24, v25 = DashAnimationPolicy.select(p20, p21);

    if v24 then
        return u1.playNamed(p19, v24, v25, p22, p23);
    end;

    return false;
end;

function u1.playNamed(u26, p27, p28, p29, p30) -- Line: 74
    -- upvalues: DashAnimationPolicy (copy), u1 (copy), AnimationConfig (copy), u2 (copy)
    if not DashAnimationPolicy.isName(p27) then
        return false;
    end;

    local u31 = u1.prepare(u26, p30);
    local v32;

    if u31 then
        v32 = u31.tracks[p27];
    else
        v32 = u31;
    end;

    if not v32 or v32.track.Length <= 0 then
        return false;
    end;

    local v33, v34 = DashAnimationPolicy.timing(v32.track.Length, p29, AnimationConfig.Dash);

    if not v33 then
        return false;
    end;

    u1.stop(u26);
    u31.serial = u31.serial + 1;
    local track = v32.track;
    local serial = u31.serial;
    u31.active = track;
    u31.facing = p28;
    u31.endsAt = os.clock() + v33;
    u26:SetAttribute("DashVisualFacing", p28);
    u26:SetAttribute("DashAnimationActive", true);
    u26:SetAttribute("LastDashAnimation", p27);
    track:Play(AnimationConfig.Dash.FadeIn, 1, v34);
    track.TimePosition = 0;
    task.delay(v33, function() -- Line: 90
        -- upvalues: u2 (ref), u26 (copy), u31 (copy), serial (copy), u1 (ref)
        if u2[u26] == u31 and u31.serial == serial then
            u1.stop(u26);
        end;
    end);

    return true;
end;

return u1;