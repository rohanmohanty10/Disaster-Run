  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
require(game.ReplicatedStorage.ClientModules:WaitForChild("CameraShaker"));
local _ = workspace.CurrentCamera;
local CollectionService = game:GetService("CollectionService");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 14
    -- upvalues: CollectionService (copy), u1 (copy), Debris (copy), TweenService (copy), EffectsHandler (copy)
    local v3 = game.Players:GetPlayerFromCharacter(p2);

    if v3 then
        v3.Data.Skin:GetAttribute("SkinName");
    end;

    local _ = p2.HumanoidRootPart;
    local _ = p2.Humanoid;

    while p2 and (p2.Parent and CollectionService:HasTag(p2, "Barraging")) do
        local u4 = u1["Silver Chariot"].Barrage:Clone();
        u4.CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(0, 0, -6);
        u4.Parent = workspace.Effects;
        task.delay(0.3, function() -- Line: 28
            -- upvalues: u4 (copy)
            u4.Attachment.blue.Enabled = false;
            u4.Attachment.black.Enabled = false;
        end);
        Debris:AddItem(u4, 0.5);
        local u5 = u1["Silver Chariot"].Barrage2:Clone();
        u5.CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(-1.5707963267948966, 0, 0);
        u5.Parent = workspace.Effects;
        task.delay(0.3, function() -- Line: 39
            -- upvalues: u5 (copy)
            u5.P2.Enabled = false;
            u5.P1.Enabled = false;
        end);
        Debris:AddItem(u5, 0.5);
        local u6 = p2:FindFirstChild("Stand"):FindFirstChild("Rapier"):Clone();
        u6:FindFirstChild("Handle").Anchored = true;

        for _, descendant in u6:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        u6.Parent = workspace.Effects;
        local v7 = Random.new();
        local v8 = p2.HumanoidRootPart.CFrame * CFrame.new(v7:NextNumber(-3, 3), v7:NextNumber(2, 4), v7:NextNumber(0, 0.2)) * CFrame.Angles(-1.5707963267948966, 0, 0);
        local v9 = v8 * CFrame.new(0, v7:NextNumber(9, 12), v7:NextNumber(-1, 1));
        local Angles = CFrame.Angles;
        local v10 = v7:NextNumber(-10, 10);
        local v11 = v9 * Angles(0, math.rad(v10), 0);
        u6.Handle.CFrame = v8;
        TweenService:Create(u6.Handle, TweenInfo.new(0.4), {
            CFrame = v11
        }):Play();
        Debris:AddItem(u6, 0.2);
        coroutine.wrap(function() -- Line: 64
            -- upvalues: u6 (copy), TweenService (ref)
            wait(0.2);

            for _, child in pairs(u6:GetChildren()) do
                if child:IsA("BasePart") then
                    TweenService:Create(child, TweenInfo.new(0.2), {
                        Transparency = 1
                    }):Play();

                    if child:FindFirstChild("Trail") then
                        TweenService:Create(child.Trail, TweenInfo.new(0.2), {
                            Brightness = 0
                        }):Play();
                    end;
                end;
            end;

            wait(0.25);
            u6:Destroy();
        end)();
        local u12 = p2:FindFirstChild("Stand"):FindFirstChild("Rapier"):Clone();
        u12:FindFirstChild("Handle").Anchored = true;

        for _, descendant in u12:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        u12.Parent = workspace.Effects;
        local v13 = Random.new();
        local v14 = p2.HumanoidRootPart.CFrame * CFrame.new(v13:NextNumber(-3, 3), v13:NextNumber(-2, 2), v13:NextNumber(0, 0.2)) * CFrame.Angles(-1.5707963267948966, 0, 0);
        local v15 = v14 * CFrame.new(0, 12, 0);
        u12.Handle.CFrame = v14;
        TweenService:Create(u12.Handle, TweenInfo.new(0.4), {
            CFrame = v15
        }):Play();
        Debris:AddItem(u12, 0.45);
        coroutine.wrap(function() -- Line: 98
            -- upvalues: u12 (copy), TweenService (ref)
            wait(0.2);

            for _, child in pairs(u12:GetChildren()) do
                if child:IsA("BasePart") then
                    TweenService:Create(child, TweenInfo.new(0.2), {
                        Transparency = 1
                    }):Play();

                    if child:FindFirstChild("Trail") then
                        TweenService:Create(child.Trail, TweenInfo.new(0.2), {
                            Brightness = 0
                        }):Play();
                    end;
                end;
            end;

            wait(0.25);
            u12:Destroy();
        end)();

        if game.Players.LocalPlayer.Settings.CameraShake.Value == true and game:GetService("Players"):GetPlayerFromCharacter(p2) == game.Players.LocalPlayer then
            EffectsHandler.CallEffect("Camera Shake Preset", "Ride");
        end;

        task.wait(0.05);
    end;
end;