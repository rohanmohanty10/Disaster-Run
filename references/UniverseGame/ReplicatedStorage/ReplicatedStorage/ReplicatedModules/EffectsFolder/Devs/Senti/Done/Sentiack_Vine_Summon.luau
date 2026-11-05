  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

local function CreateTween(u2, u3, p4) -- Line: 6
    -- upvalues: TweenService (copy)
    local u5 = p4 == nil and 0 or p4;
    local u6 = nil;
    coroutine.wrap(function() -- Line: 11
        -- upvalues: u5 (ref), u2 (copy), u3 (copy), TweenService (ref), u6 (ref)
        wait(u5);

        if type(u2) ~= "table" then
            u6 = TweenService:Create(u2, u3[1], u3[2]);
            u6:Play();

            return u6;
        end;

        local v7 = 1;
        local v8 = {};

        for _, v in pairs(u2) do
            local v9 = u3[v7];
            local v10 = v7 + 1;
            v7 = v10 + 1;
            v8[v.Name] = TweenService:Create(v, v9, u3[v10]);
            v8[v.Name]:Play();
        end;

        return v8;
    end)();
end;

return function(p11) -- Line: 36
    -- upvalues: u1 (copy), SoundGroups (copy), TweenService (copy)
    local v12 = u1["Gold Experience"]:WaitForChild("Vines"):Clone();
    local RedRoses = v12.RedRoses;
    local WhiteRoses = v12.WhiteRoses;
    v12.Parent = workspace.Effects;
    local PrimaryPart = v12.PrimaryPart;
    PrimaryPart.CFrame = p11.CFrame * CFrame.new(0, -4, 0);
    local Stomp = PrimaryPart.Stomp;
    SoundGroups:AssignSoundTag(Stomp);
    Stomp:Play();
    local v13 = u1["Gold Experience"].ground:Clone();
    v13.CFrame = p11.CFrame * CFrame.new(0, -2.5, 0);
    v13.Parent = workspace.Effects;

    for _, descendant in pairs(v13:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 58
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
                wait(0.1);
                descendant.Enabled = false;
            end)();
        end;
    end;

    local u14 = {
        TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
        {
            CFrame = p11.CFrame * CFrame.new(0, -2.75, 0),
            Size = PrimaryPart.Size * Vector3.new(1.15, 1.15, 1.15)
        }
    };
    local v15 = nil;
    local u16 = v15 == nil and 0 or v15;
    local u17 = nil;
    coroutine.wrap(function() -- Line: 11
        -- upvalues: u16 (ref), PrimaryPart (copy), u14 (copy), TweenService (ref), u17 (ref)
        wait(u16);

        if type(PrimaryPart) ~= "table" then
            u17 = TweenService:Create(PrimaryPart, u14[1], u14[2]);
            u17:Play();

            return u17;
        end;

        local v18 = 1;
        local v19 = {};

        for _, v in pairs(PrimaryPart) do
            local v20 = u14[v18];
            local v21 = v18 + 1;
            v18 = v21 + 1;
            v19[v.Name] = TweenService:Create(v, v20, u14[v21]);
            v19[v.Name]:Play();
        end;

        return v19;
    end)();
    RedRoses.Material = "Neon";
    RedRoses.Color = Color3.fromRGB(79, 255, 91);
    RedRoses.Size = RedRoses.Size * Vector3.new(1.15, 1.15, 1.15);
    WhiteRoses.Material = "Neon";
    WhiteRoses.Color = Color3.fromRGB(79, 255, 91);
    WhiteRoses.Size = WhiteRoses.Size * Vector3.new(1.15, 1.15, 1.15);
    local u22 = { RedRoses, WhiteRoses };
    local u23 = {
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            Transparency = 0
        },
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            Transparency = 0
        }
    };
    local v24 = 0.35;
    local u25 = v24 == nil and 0 or v24;
    local u26 = nil;
    coroutine.wrap(function() -- Line: 11
        -- upvalues: u25 (ref), u22 (copy), u23 (copy), TweenService (ref), u26 (ref)
        wait(u25);

        if type(u22) ~= "table" then
            u26 = TweenService:Create(u22, u23[1], u23[2]);
            u26:Play();

            return u26;
        end;

        local v27 = 1;
        local v28 = {};

        for _, v in pairs(u22) do
            local v29 = u23[v27];
            local v30 = v27 + 1;
            v27 = v30 + 1;
            v28[v.Name] = TweenService:Create(v, v29, u23[v30]);
            v28[v.Name]:Play();
        end;

        return v28;
    end)();
    wait(0.8);

    for _, descendant in pairs(RedRoses:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 93
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
                wait(0.1);
                descendant.Enabled = false;
            end)();
        end;
    end;

    for _, descendant in pairs(WhiteRoses:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 103
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
                wait(0.1);
                descendant.Enabled = false;
            end)();
        end;
    end;

    RedRoses.Color = Color3.fromRGB(117, 0, 0);
    RedRoses.Material = "SmoothPlastic";
    WhiteRoses.Color = Color3.fromRGB(163, 162, 165);
    WhiteRoses.Material = "SmoothPlastic";
    wait(3);
    local v31 = PrimaryPart:Clone();
    v31.Material = "Neon";
    v31.Parent = PrimaryPart.Parent;
    v31.Transparency = 1;
    v31.Name = "Neon_Vine_Lol";
    local v32 = RedRoses:Clone();
    v32.Material = "Neon";
    v32.Parent = PrimaryPart.Parent;
    v32.Transparency = 1;
    v32.Name = "Neon_FlowerR_Lol";
    local v33 = WhiteRoses:Clone();
    v33.Material = "Neon";
    v33.Parent = PrimaryPart.Parent;
    v33.Transparency = 1;
    v33.Name = "Neon_FlowerW_Lol";
    local u34 = { v31, v32, v33 };
    local u35 = {
        TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            Transparency = 1
        },
        TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            Transparency = 1
        },
        TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            Transparency = 1
        },
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            Transparency = 0
        },
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            Transparency = 0
        },
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            Transparency = 0
        }
    };
    local v36 = nil;
    local u37 = v36 == nil and 0 or v36;
    local u38 = nil;
    coroutine.wrap(function() -- Line: 11
        -- upvalues: u37 (ref), u34 (copy), u35 (copy), TweenService (ref), u38 (ref)
        wait(u37);

        if type(u34) ~= "table" then
            u38 = TweenService:Create(u34, u35[1], u35[2]);
            u38:Play();

            return u38;
        end;

        local v39 = 1;
        local v40 = {};

        for _, v in pairs(u34) do
            local v41 = u35[v39];
            local v42 = v39 + 1;
            v39 = v42 + 1;
            v40[v.Name] = TweenService:Create(v, v41, u35[v42]);
            v40[v.Name]:Play();
        end;

        return v40;
    end)();
    wait(1);
    local Despawn = PrimaryPart.Despawn;
    SoundGroups:AssignSoundTag(Despawn);
    Despawn:Play();

    for _, descendant in pairs(PrimaryPart.Parent:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    for _, descendant in pairs(v13:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 167
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
                wait(0.1);
                descendant.Enabled = false;
            end)();
        end;
    end;

    wait(2);
    PrimaryPart.Parent:Destroy();
    v13:Destroy();
end;