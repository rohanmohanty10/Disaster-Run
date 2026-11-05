  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

local function CreateInstance(p2, p3) -- Line: 5
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

return function(p7, p8) -- Line: 23
    -- upvalues: CreateInstance (copy), TweenService (copy), Debris (copy), u1 (copy)
    local v9;

    if p7 then
        v9 = p7:FindFirstChild("HumanoidRootPart") or p7.PrimaryPart;
        p7:FindFirstChild("Humanoid");
    else
        v9 = nil;
    end;

    if p8.IncludeRingDebris == true then
        local v10 = p8.RDData._CFrame or v9.CFrame;
        local v11 = p8.RDData.Amount or 14;
        local v12 = p8.RDData.Radius or 8;
        local v13 = p8.RDData.Size or Vector3.new(3.25, 3.25, 3.25);
        local v14 = p8.RDData.OutwardTime or 0;
        local v15 = p8.RDData.GrowTime or 0;
        local u16 = p8.RDData.Lifetime or 3.5;
        local v17 = RaycastParams.new();
        v17.FilterType = Enum.RaycastFilterType.Blacklist;

        for i = 1, v11 do
            local v18 = 6.283185307179586 / v11 * i;
            local v19 = v12 * math.cos(v18);
            local v20 = v12 * math.sin(v18);
            local u21 = CreateInstance("Part", {
                Anchored = true,
                CanCollide = false,
                Massless = true,
                CFrame = v10 * CFrame.new(0, -2.5, 0),
                Name = "DebrisPart" .. i
            });
            u21.CFrame = v10 * CFrame.new(v19, -2.5, v20) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
            v17.FilterDescendantsInstances = { u21, workspace.Effects, p7 };
            local v22 = workspace:Raycast(u21.Position, Vector3.new(0, -3.5, 0), v17);

            if v22 then
                local Instance2 = v22.Instance;
                u21.Color = Instance2.Color;
                u21.Material = Instance2.Material;

                if u21.Material == Enum.Material.Plastic then
                    u21.Material = Enum.Material.SmoothPlastic;
                end;

                u21.CFrame = v10 * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                u21.Parent = workspace.Effects;
                TweenService:Create(u21, TweenInfo.new(v15), {
                    Size = v13
                }):Play();
                TweenService:Create(u21, TweenInfo.new(v14), {
                    CFrame = v10 * CFrame.new(v19, -2.5, v20) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                }):Play();
                coroutine.wrap(function() -- Line: 74
                    -- upvalues: u16 (ref), TweenService (ref), u21 (copy)
                    wait(u16);
                    TweenService:Create(u21, TweenInfo.new(1), {
                        Size = Vector3.new()
                    }):Play();
                    TweenService:Create(u21, TweenInfo.new(1), {
                        Color = Color3.fromRGB()
                    }):Play();
                    wait(1.1);
                    u21:Destroy();
                end)();
            else
                u21:Destroy();
            end;
        end;
    end;

    if p8.IncludeFlyingDebris == true then
        local v23 = p8.FDData._CFrame or v9.CFrame * CFrame.new(0, -10, 0);
        local v24 = p8.FDData.Amount or 10;
        local v25 = p8.FDData.PivotInstance or v9;
        local Size = p8.FDData.Size;

        if not Size then
            local v26 = math.random(1, 2);
            local v27 = math.random(1, 2);
            Size = Vector3.new(v26, v27, math.random(1, 2));
        end;

        local v28 = p8.FDData.Height or 75;
        local v29 = p8.FDData.Length or 0.1;

        for _ = 1, v24 do
            local v30 = CreateInstance("Part", {
                Anchored = false,
                CanCollide = false,
                Massless = true,
                CFrame = v23 * CFrame.Angles(math.random(-45, 45), math.random(-45, 45), math.random(-45, 45))
            });
            local v31 = RaycastParams.new();
            v31.FilterType = Enum.RaycastFilterType.Blacklist;
            v31.FilterDescendantsInstances = { v30, workspace.Effects, p7 };
            local v32 = workspace:Raycast(v25.Position, Vector3.new(0, -3.5, 0), v31);

            if v32 then
                local Instance2 = v32.Instance;
                v30.Size = Size;
                v30.Color = Instance2.Color;
                v30.Material = Instance2.Material;

                if v30.Material == Enum.Material.Plastic then
                    v30.Material = Enum.Material.SmoothPlastic;
                end;

                v30.Parent = workspace.Effects;
                Debris:AddItem(v30, 2.5);
                Debris:AddItem(CreateInstance("BodyVelocity", {
                    MaxForce = Vector3.new(inf, inf, inf),
                    Velocity = v30.CFrame.UpVector * v28,
                    Parent = v30
                }), v29);
            else
                v30:Destroy();
            end;
        end;
    end;

    if p8.IncludeShockwave == true then
        local v33 = p8.Shockwave._CFrame or v9.CFrame;
        local GrowthTime = p8.Shockwave.GrowthTime;
        local Size = p8.Shockwave.Size;
        local TransparencyTime = p8.Shockwave.TransparencyTime;
        local Transparency = p8.Shockwave.Transparency;
        local v34 = u1.zaihop.GroundSlamHamma:Clone();
        v34.Parent = workspace.Effects;
        Debris:AddItem(v34, 2);
        v34.CFrame = v33;
        TweenService:Create(v34, TweenInfo.new(GrowthTime), {
            Size = Size
        }):Play();
        TweenService:Create(v34, TweenInfo.new(TransparencyTime), {
            Transparency = Transparency
        }):Play();
    end;
end;