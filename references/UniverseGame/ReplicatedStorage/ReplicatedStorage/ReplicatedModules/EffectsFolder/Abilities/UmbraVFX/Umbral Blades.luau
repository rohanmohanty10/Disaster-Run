  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = {};
local wrap = coroutine.wrap;
local Angles = CFrame.Angles;
local _ = math.rad;
local u2 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");

local function tweendeb(p3, p4) -- Line: 12
    p3:Play();
    p3.Completed:Wait();

    if p4 then
        p4:Destroy();
    end;

    return true;
end;

return function(p5, u6, p7, ...) -- Line: 19
    -- upvalues: Angles (copy), u1 (copy), TweenService (copy), wrap (copy), tweendeb (copy), Trove (copy), u2 (copy)
    if p5 == "Shoot" then
        local v8, v9 = ...;
        local HumanoidRootPart = v8.HumanoidRootPart;
        local v10 = Angles(1.5707963267948966, 1.5707963267948966, 0);
        local v11 = Angles(0, 0, 3.141592653589793);
        local v12 = u1[u6];

        if v12 then
            for _, v in ipairs(v12) do
                v.Weld:Destroy();
                v.Anchored = true;
                local v13 = CFrame.new(v.Position, HumanoidRootPart.Position) * v10 * v11;
                local v14 = v13 * CFrame.new(0, (v.Position - HumanoidRootPart.Position).Magnitude - v.Size.Y / 2 + 1, 0);
                v.CFrame = v13;
                local v15 = TweenService:Create(v, TweenInfo.new(v9, Enum.EasingStyle.Sine), {
                    CFrame = v14
                });
                wrap(tweendeb)(v15, v);
            end;

            u1[u6] = nil;
        end;
    else
        if not u6 then
            return;
        end;

        local v16 = Trove.new();
        v16:AttachToInstance(u6);
        local v17 = u2.Umbra.katana:Clone();
        local v18 = Angles(1.5707963267948966, 0, 1.5707963267948966);
        local Amount = p7.Amount;
        local v19 = p7.Amount / 2;
        local v20 = {};

        if p7.CustomColor then
            v17.Color = p7.CustomColor;
            local v21 = v17:GetChildren();

            for i = 1, #v21 do
                if v21[i] and v21[i]:IsA("ParticleEmitter") then
                    v21[i].Color = ColorSequence.new(Color3.fromRGB(p7.CustomColor.R * 255 * 1.075, p7.CustomColor.G * 255 * 1.075, p7.CustomColor.B * 255 * 1.075));
                end;
            end;
        end;

        for i = 1, Amount do
            local v22 = v17:Clone();
            local Weld = Instance.new("Weld");
            v16:Add(function() -- Line: 67
                -- upvalues: u1 (ref), u6 (copy)
                u1[u6] = nil;
            end);
            v16:Add(Weld);
            v16:Add(v22);
            Weld.Part0 = v22;
            Weld.Part1 = u6.Head;

            if v19 < i then
                Weld.C0 = CFrame.new((i - v19) * 1, 0, -2) * v18;
            else
                Weld.C0 = CFrame.new(i * 1, 0, 2) * v18;
            end;

            Weld.Parent = v22;
            v22.Parent = workspace.Effects;
            TweenService:Create(v22, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Transparency = 0.5
            }):Play();
            table.insert(v20, v22);
        end;

        u1[u6] = v20;
    end;
end;