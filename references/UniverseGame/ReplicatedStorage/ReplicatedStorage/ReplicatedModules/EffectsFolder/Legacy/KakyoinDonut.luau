  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require(ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("Init");
local CameraShaker = require(game.ReplicatedStorage.ClientModules:WaitForChild("CameraShaker"));
local LocalPlayer = game.Players.LocalPlayer;

return function(p2, p3, p4) -- Line: 9
    -- upvalues: LocalPlayer (copy), u1 (copy), CameraShaker (copy), ReplicatedStorage (copy), TweenService (copy)
    if LocalPlayer.Settings.Gore.Value == false then
        return;
    end;

    local _ = math.random(2) == 2;
    u1():Shake(CameraShaker.Presets.Bump);
    local v5 = ReplicatedStorage["Client Assets"]["The World"].KnockEffect:Clone();
    v5.Parent = workspace;
    v5:SetPrimaryPartCFrame(p3.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, -1.5707963267948966, 0));

    for _, child in ipairs(v5:GetChildren()) do
        if child.Name == "Out" then
            TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = child.Size * 20,
                CFrame = child.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play();
        else
            TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = child.Size * 20,
                CFrame = child.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
            }):Play();
        end;
    end;

    local v6 = ReplicatedStorage["Client Assets"]["The World"].DonutImpact1:Clone();
    v6.Parent = game.Workspace;
    local CFrame2 = p2.Torso.CFrame;
    local Angles = CFrame.Angles;
    local v7 = math.random(-360, 360);
    local v8 = math.rad(v7);
    local v9 = math.random(-360, 360);
    local v10 = math.rad(v9);
    local v11 = math.random(-360, 360);
    v6.CFrame = CFrame2 * Angles(v8, v10, (math.rad(v11)));
    TweenService:Create(v6, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v6.Size * 4
    }):Play();
    game.Debris:AddItem(v6, 1);
    local v12 = ReplicatedStorage["Client Assets"]["The World"].DonutImpact2:Clone();
    v12.Parent = game.Workspace;
    local CFrame3 = p2.Torso.CFrame;
    local Angles2 = CFrame.Angles;
    local v13 = math.random(-360, 360);
    local v14 = math.rad(v13);
    local v15 = math.random(-360, 360);
    local v16 = math.rad(v15);
    local v17 = math.random(-360, 360);
    v12.CFrame = CFrame3 * Angles2(v14, v16, (math.rad(v17)));
    TweenService:Create(v12, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v12.Size * 4
    }):Play();
    game.Debris:AddItem(v12, 1);

    if not p4 then
        for _ = 1, 16 do
            local u18 = ReplicatedStorage["Client Assets"]["The World"].WaterBeamIn:Clone();
            u18.Parent = workspace;
            u18.Size = Vector3.new(u18.Size.X, u18.Size.Y, math.random(1, 10));
            local CFrame4 = p2.Torso.CFrame;
            local Angles3 = CFrame.Angles;
            local v19 = math.random(-360, 360);
            local v20 = math.rad(v19);
            local v21 = math.random(-360, 360);
            local v22 = math.rad(v21);
            local v23 = math.random(-360, 360);
            u18.CFrame = CFrame4 * Angles3(v20, v22, (math.rad(v23)));
            TweenService:Create(u18, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                CFrame = u18.CFrame * CFrame.new(0, 0, -math.random(6, 15))
            }):Play();
            coroutine.wrap(function() -- Line: 52
                -- upvalues: TweenService (ref), u18 (copy)
                local v24 = { 0.25, 0.15, 0.1, 0.05 };
                local v25 = v24[math.random(1, #v24)];
                wait(v25);
                TweenService:Create(u18, TweenInfo.new(0.5 - v25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end)();
            game.Debris:AddItem(u18, 1);
        end;
    end;

    wait(2);
    v5:Destroy();
end;