  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

local function CreateInstance(p2, p3) -- Line: 6
    local function CheckProperty(p4, p5) -- Line: 7
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 14
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

local function Wait(p7) -- Line: 22
    -- upvalues: RunService (copy)
    local v8 = 0;

    repeat
        v8 = v8 + RunService.Heartbeat:Wait();
    until (p7 or 0) <= v8;

    return v8;
end;

return function(p9, p10) -- Line: 33
    -- upvalues: RunService (copy), TweenService (copy), CreateInstance (copy), u1 (copy)
    local HumanoidRootPart = p9.HumanoidRootPart;
    local _ = p9.Humanoid;
    local u11 = p10.Duration or 5;
    local v12 = p10.Amount or math.random(5, 5);
    local v13 = p10.Radius or 3;
    local v14 = p10.Offset or HumanoidRootPart.CFrame;
    local v15 = p10.Size or Vector3.new(3.5, 3.5, 3.5);
    local v16 = p10.State or true;
    local v17 = RaycastParams.new();
    v17.FilterType = Enum.RaycastFilterType.Exclude;

    local function Destruction(u18) -- Line: 47
        -- upvalues: u11 (copy), RunService (ref), TweenService (ref)
        coroutine.wrap(function() -- Line: 48
            -- upvalues: u11 (ref), RunService (ref), TweenService (ref), u18 (copy)
            local v19 = 0;

            repeat
                v19 = v19 + RunService.Heartbeat:Wait();
            until (u11 or 0) <= v19;

            TweenService:Create(u18, TweenInfo.new(1), {
                Size = Vector3.new()
            }):Play();
            TweenService:Create(u18, TweenInfo.new(1), {
                Color = Color3.fromRGB()
            }):Play();

            for _, child in pairs(u18:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = false;
                end;
            end;

            local v20 = 0;

            repeat
                v20 = v20 + RunService.Heartbeat:Wait();
            until (1.1 or 0) <= v20;

            u18:Destroy();
        end)();
    end;

    if v16 then
        for i = 1, v12 do
            local v21 = 6.283185307179586 / v12 * i;
            local v22 = v13 * math.cos(v21);
            local v23 = v13 * math.sin(v21);
            local u24 = CreateInstance("Part", {
                Anchored = true,
                CanCollide = false,
                Massless = true,
                Transparency = 1,
                Size = v15,
                CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.15, 0),
                Name = "DebrisPart" .. i
            });
            u24.CFrame = v14 * CFrame.new(v22, 0.15, v23) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
            local CFrame2 = u24.CFrame;
            local v25 = 6.283185307179586 / v12 * i;
            local v26 = math.cos(v25) * 6;
            local v27 = math.sin(v25) * 6;
            v17.FilterDescendantsInstances = { u24, workspace.Effects, p9 };
            local v28 = workspace:Raycast(u24.Position, Vector3.new(0, -5, 0), v17);

            if v28 then
                local Instance2 = v28.Instance;
                u24.CFrame = v14 * CFrame.new(v26, -4, v27);
                u24.Transparency = 0;
                u24.Color = Instance2.Color;
                u24.Material = Instance2.Material;
                u24:SetAttribute("RockPart", p9.Name);

                for _, child in pairs(u1["Crazy Diamond"].ReworkHealAura:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        local v29 = child:Clone();
                        v29.Enabled = true;
                        v29.Parent = u24;
                    end;
                end;

                if u24.Material == Enum.Material.Plastic then
                    u24.Material = Enum.Material.SmoothPlastic;
                end;

                u24.Parent = workspace.Effects;
                TweenService:Create(u24, TweenInfo.new(1.25), {
                    CFrame = CFrame2
                }):Play();
                coroutine.wrap(function() -- Line: 48
                    -- upvalues: u11 (copy), RunService (ref), TweenService (ref), u24 (copy)
                    local v30 = 0;

                    repeat
                        v30 = v30 + RunService.Heartbeat:Wait();
                    until (u11 or 0) <= v30;

                    TweenService:Create(u24, TweenInfo.new(1), {
                        Size = Vector3.new()
                    }):Play();
                    TweenService:Create(u24, TweenInfo.new(1), {
                        Color = Color3.fromRGB()
                    }):Play();

                    for _, child in pairs(u24:GetChildren()) do
                        if child:IsA("ParticleEmitter") then
                            child.Enabled = false;
                        end;
                    end;

                    local v31 = 0;

                    repeat
                        v31 = v31 + RunService.Heartbeat:Wait();
                    until (1.1 or 0) <= v31;

                    u24:Destroy();
                end)();
            else
                u24:Destroy();
            end;
        end;

        return;
    end;

    for _, child in pairs(workspace.Effects:GetChildren()) do
        if child:IsA("BasePart") and child:GetAttribute("RockPart") == p9.Name then
            coroutine.wrap(function() -- Line: 48
                -- upvalues: u11 (copy), RunService (ref), TweenService (ref), child (copy)
                local v32 = 0;

                repeat
                    v32 = v32 + RunService.Heartbeat:Wait();
                until (u11 or 0) <= v32;

                TweenService:Create(child, TweenInfo.new(1), {
                    Size = Vector3.new()
                }):Play();
                TweenService:Create(child, TweenInfo.new(1), {
                    Color = Color3.fromRGB()
                }):Play();

                for _, child2 in pairs(child:GetChildren()) do
                    if child2:IsA("ParticleEmitter") then
                        child2.Enabled = false;
                    end;
                end;

                local v33 = 0;

                repeat
                    v33 = v33 + RunService.Heartbeat:Wait();
                until (1.1 or 0) <= v33;

                child:Destroy();
            end)();
        end;
    end;
end;