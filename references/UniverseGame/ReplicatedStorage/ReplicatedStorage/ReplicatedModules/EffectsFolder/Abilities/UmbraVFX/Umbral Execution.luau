  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local random = math.random;
local rad = math.rad;
local Angles = CFrame.Angles;
local wrap = coroutine.wrap;
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");

local function tweendeb(p2, p3) -- Line: 8
    p2:Play();
    p2.Completed:Wait();

    if p3 then
        p3:Destroy();
    end;

    return true;
end;

local function fetchsound(p4, p5) -- Line: 15
    return p4:FindFirstChild(p5) or Instance.new("Sound");
end;

return function(p6, p7, p8) -- Line: 19
    -- upvalues: u1 (copy), random (copy), Angles (copy), rad (copy), TweenService (copy), wrap (copy), RunService (copy)
    local u9 = p8 or 1;
    local Umbra = u1.Umbra;
    local v10 = Umbra.sphere:Clone();
    local u11 = Umbra.zone:Clone();
    local u12 = {};
    local wait = task.wait;
    local u13 = nil;

    local function generatepos(p14, p15, p16) -- Line: 27
        -- upvalues: random (ref), Angles (ref), rad (ref)
        return p14 * CFrame.new(random(p15, p16), 0, random(p15, p16)) * Angles(rad((random(-360, 360))), rad((random(-360, 360))), (rad((random(-360, 360)))));
    end;

    local function zone(p17, u18, u19) -- Line: 32
        -- upvalues: u11 (copy), TweenService (ref), u9 (copy), wrap (ref), u13 (ref), RunService (ref), Angles (ref), rad (ref), u12 (copy)
        local u20 = u11:Clone();
        u20.CFrame = p17 * CFrame.new(0, -1, 0);
        u20.Parent = workspace.Effects;
        TweenService:Create(u20, TweenInfo.new(u9, Enum.EasingStyle.Sine), {
            Size = u20.Size * 10
        }):Play();
        wrap(function() -- Line: 37
            -- upvalues: u13 (ref), RunService (ref), u20 (copy), Angles (ref), u18 (copy), rad (ref), wrap (ref), TweenService (ref), u9 (ref), u19 (copy), u12 (ref)
            local u21 = nil;

            while not u13 and RunService.Heartbeat:Wait() do
                local v22 = u20;
                v22.CFrame = v22.CFrame * Angles(0, rad(u18), 0);
            end;

            wrap(function() -- Line: 42
                -- upvalues: u21 (ref), TweenService (ref), u20 (ref), u9 (ref)
                local v23 = TweenService:Create(u20, TweenInfo.new(u9, Enum.EasingStyle.Sine), {
                    Size = Vector3.new()
                });
                local v24 = u20;
                v23:Play();
                v23.Completed:Wait();

                if v24 then
                    v24:Destroy();
                end;

                u21 = true;
            end)();

            while not u21 and RunService.Heartbeat:Wait() do
                local v25 = u20;
                v25.CFrame = v25.CFrame * Angles(0, rad(u18), 0);
            end;

            if u19 then
                for i, v in pairs(u12) do
                    if i:IsA("ParticleEmitter") then
                        i.Enabled = v;
                    else
                        i.Transparency = v;
                    end;
                end;
            end;
        end)();
    end;

    local HumanoidRootPart = p6.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;

    for i, v in pairs(p7.FXData) do
        v10[i] = v;
        u11[i] = v;
    end;

    (HumanoidRootPart:FindFirstChild("Startup") or Instance.new("Sound")):Play();
    coroutine.wrap(zone)(CFrame2, 5, true);
    wait(u9);
    (HumanoidRootPart:FindFirstChild("Ult") or Instance.new("Sound")):Play();

    for _, descendant in ipairs(p6:GetDescendants()) do
        if descendant:IsA("Decal") or descendant:IsA("BasePart") then
            u12[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        elseif descendant:IsA("ParticleEmitter") then
            u12[descendant] = descendant.Enabled;
            descendant.Enabled = false;
        end;
    end;

    u13 = true;
end;