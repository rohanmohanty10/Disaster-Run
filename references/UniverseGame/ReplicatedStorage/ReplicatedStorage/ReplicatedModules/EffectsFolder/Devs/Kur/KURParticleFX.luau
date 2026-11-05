  

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local wrap = coroutine.wrap;
local _ = math.cos;
local _ = math.sin;
local rad = math.rad;
local random = math.random;
local Angles = CFrame.Angles;

local function tweendeb(p1, p2) -- Line: 8
    p1:Play();
    p1.Completed:Wait();

    if p2 then
        p2:Destroy();
    end;

    return true;
end;

local function weld(p3, p4) -- Line: 15
    local Weld = p3:FindFirstChild("Weld");

    if Weld then
        Weld.Part0 = p3;
        Weld.Part1 = p4;

        return;
    end;

    local Weld2 = Instance.new("Weld");
    Weld2.Parent = p3;
    Weld2.Part0 = p3;
    Weld2.Part1 = p4;
end;

local function generateparticlehit(p5, p6, p7, p8, p9, p10) -- Line: 28
    if typeof(p6) == "table" then
        for _, v in pairs(p6) do
            local v11 = v:Clone();
            v11.Parent = workspace.Effects;
            v11.CFrame = p5.CFrame;

            if p10 then
                v11.Parent = p5;
                local Weld = v11:FindFirstChild("Weld");

                if Weld then
                    Weld.Part0 = v11;
                    Weld.Part1 = p5;
                else
                    local Weld2 = Instance.new("Weld");
                    Weld2.Parent = v11;
                    Weld2.Part0 = v11;
                    Weld2.Part1 = p5;
                end;
            end;

            if v11:FindFirstChild("Attachment") then
                for _, child in pairs(v11.Attachment:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        if p8 then
                            child.Color = p8;
                        end;

                        child:Emit(p7);
                    end;
                end;
            elseif v11:IsA("BasePart") then
                for _, child in pairs(v11:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        if p8 then
                            child.Color = p8;
                        end;

                        child:Emit(p7);
                    end;
                end;
            elseif v11:IsA("ParticleEmitter") then
                if p8 then
                    v11.Color = p8;
                end;

                v11:Emit(p7);
            end;

            if p9 then
                game.Debris:AddItem(v11, p9);
            else
                game.Debris:AddItem(v11, 0.25);
            end;
        end;
    end;
end;

local function generatehit(u12, p13, p14) -- Line: 89
    -- upvalues: random (copy), wrap (copy), Angles (copy), rad (copy), TweenService (copy), tweendeb (copy)
    local Hits = game.ReplicatedStorage["Client Assets"].BakEffects.Hits;
    local u15 = Hits.Hit:Clone();
    local v16, u17, v18;

    if p13 then
        v16 = p13.Hit or Hits.Hit2;
        u15.Color = p13.Color or u15.Color;
        v16.Color = p13.Color2 or v16.Color;
        local _ = p13.Size or 1.5;
        u17 = p13.Size2 or random(10, 30);
        v18 = p13.Count or 10;
    else
        v16 = nil;
        v18 = nil;
        u17 = nil;
    end;

    local v19 = v16:Clone();

    for _ = 1, v18 do
        wrap(function() -- Line: 107
            -- upvalues: Angles (ref), random (ref), rad (ref), u12 (copy), u15 (copy), u17 (ref), TweenService (ref)
            local v20 = u12 * Angles(rad((random(360))), 0, (rad((random(360)))));
            local v21 = u15:Clone();
            local v22 = random(3) / 10;
            local v23 = random(3) / 10;
            v21.Size = Vector3.new(v22, u17 / 10, v23) * 1.5;
            v21.CFrame = v20 * CFrame.new(0, v21.Size.Y / 2, 0);
            v21.Parent = workspace.Effects;
            local v24 = TweenService:Create(v21, TweenInfo.new(0.5), {
                Transparency = 1,
                CFrame = v21.CFrame * CFrame.new(0, random(3, 8), 0),
                Size = Vector3.new()
            });
            v24:Play();
            v24.Completed:Wait();

            if v21 then
                v21:Destroy();
            end;
        end)();
    end;

    v19.CFrame = u12 * CFrame.Angles(rad((random(360))), rad((random(360))), (rad((random(360)))));
    v19.Parent = workspace.Effects;
    local v25 = TweenService:Create(v19, TweenInfo.new(0.3), {
        Transparency = 1,
        Size = v19.Size * 1.5
    });
    wrap(tweendeb)(v25, v19);
end;

return function(p26, p27, p28) -- Line: 129
    -- upvalues: generatehit (copy), generateparticlehit (copy)
    if p28.Sphere then
        local Color = p28.Sphere.Color;
        generatehit(p26.HumanoidRootPart.CFrame, {
            Color = Color,
            Color2 = Color
        });
    end;

    generateparticlehit(p26.Torso or p26.PrimaryPart, p28.Particles, p28.EmitAmount, p28.EmitColor, p28.DisTime);
end;