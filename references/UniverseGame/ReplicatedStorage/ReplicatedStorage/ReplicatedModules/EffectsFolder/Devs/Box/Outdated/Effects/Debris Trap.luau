  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

local function CreateInstance(p2, p3) -- Line: 3
    local function CheckProperty(p4, p5) -- Line: 5
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 12
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

return function(p7, p8) -- Line: 21
    -- upvalues: CreateInstance (copy), u1 (copy), TweenService (copy)
    local HumanoidRootPart = p7.HumanoidRootPart;
    local _ = p7.Humanoid;
    local u9 = p8.Duration or 5;
    local v10 = p8.DebrisAmount or math.random(5, 5);
    local v11 = p8.DebrisRadius or 3;
    local v12 = p8.DebrisCFrame or HumanoidRootPart.CFrame;
    local v13 = p8.DebrisSize or Vector3.new(3.5, 3.5, 3.5);
    local v14 = RaycastParams.new();
    v14.FilterType = Enum.RaycastFilterType.Blacklist;

    for i = 1, v10 do
        local v15 = 6.283185307179586 / v10 * i;
        local v16 = v11 * math.cos(v15);
        local v17 = v11 * math.sin(v15);
        local u18 = CreateInstance("Part", {
            Anchored = true,
            CanCollide = false,
            Massless = true,
            Transparency = 1,
            Size = v13,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.15, 0),
            Name = "DebrisPart" .. i
        });
        u18.CFrame = v12 * CFrame.new(v16, 0.15, v17) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
        local CFrame2 = u18.CFrame;
        local v19 = 6.283185307179586 / v10 * i;
        local v20 = math.cos(v19) * 6;
        local v21 = math.sin(v19) * 6;
        v14.FilterDescendantsInstances = { u18, workspace.Effects, p7 };
        local v22 = workspace:Raycast(u18.Position, Vector3.new(0, -5, 0), v14);

        if v22 then
            local Instance2 = v22.Instance;
            u18.CFrame = v12 * CFrame.new(v20, -4, v21);
            u18.Transparency = 0;
            u18.Color = Instance2.Color;
            u18.Material = Instance2.Material;

            for _, child in pairs(u1["Crazy Diamond"].HealAura:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    local v23 = child:Clone();
                    v23.Enabled = true;
                    v23.Parent = u18;
                end;
            end;

            if u18.Material == Enum.Material.Plastic then
                u18.Material = Enum.Material.SmoothPlastic;
            end;

            u18.Parent = workspace.Effects;
            TweenService:Create(u18, TweenInfo.new(0.5), {
                CFrame = CFrame2
            }):Play();
            coroutine.wrap(function() -- Line: 75
                -- upvalues: u9 (copy), TweenService (ref), u18 (copy)
                wait(u9);
                TweenService:Create(u18, TweenInfo.new(1), {
                    Size = Vector3.new()
                }):Play();
                TweenService:Create(u18, TweenInfo.new(1), {
                    Color = Color3.fromRGB()
                }):Play();
                wait(1.1);
                u18:Destroy();

                for _, child in pairs(u18:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child:Destroy();
                    end;
                end;
            end)();
        else
            u18:Destroy();
        end;
    end;
end;