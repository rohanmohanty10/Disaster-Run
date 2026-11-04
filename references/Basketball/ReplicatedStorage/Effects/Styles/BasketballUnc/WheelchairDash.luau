 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), LocalPlayer (copy), VfxManager (copy), Debris (copy), Essentials (copy), Players (copy), Effects (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local MovementController = p1.MovementController;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u4 = Character:FindFirstChild(script.Name .. "Wheelchair");

    if p2.Task == "UncRelay" then
        if u4 and u4:FindFirstChild("Wheel Chair") then
            SfxManager:playSound({
                Sound = "BBZ Basketball Unc Unc Relay",
                Parent = HumanoidRootPart
            });

            if LocalPlayer.Character == Character then
                MovementController.States.NoWalk = true;
                task.delay(1.0833333333333333 - v3, function() -- Line: 33
                    -- upvalues: MovementController (copy)
                    MovementController.States.NoWalk = false;
                end);
            end;

            task.delay(0 - v3, function() -- Line: 38
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Enable(u4.PrimaryPart.Enable, true);
                VfxManager.Emit(u4);
            end);
            task.delay(0.6 - v3, function() -- Line: 43
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Enable(u4.PrimaryPart.Enable, false);
            end);
            task.delay(0.8333333333333334 - v3, function() -- Line: 47
                -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
                local v5 = script.Throw:Clone();
                v5.Parent = Debris;
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1, 2, -1.25);
                Essentials:Weld(v5, HumanoidRootPart);
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 2);
            end);
        end;
    else
        if p2.Task == "UncRelayCatch" then
            Effects:SubtitleV2({
                { Players:FindFirstChild(Character.Name), "Right back at me!", 1 }
            });
            SfxManager:playSound({
                Sound = "BBZ Basketball Unc Unc Relay Voice",
                Parent = HumanoidRootPart
            });

            return;
        end;

        if p2.Task == "Activate" then
            local v6 = Players:FindFirstChild(Character.Name);
            local u7 = script.Enable:Clone();
            u7.Name = Character.Name .. script.Name;
            u7.Parent = Debris;
            u7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.721, -4.5);
            VfxManager.Enable(u7, true);
            Essentials:Weld(u7, HumanoidRootPart);
            Effects:SubtitleV2({
                { v6, "OG rollin\' through!", 1 }
            });
            SfxManager:playSound({
                Sound = "BBZ Basketball Unc Wheelchair Dash Start",
                Parent = u7
            });
            SfxManager:playSound({
                Sound = "BBZ Basketball Unc Wheelchair Dash Driving",
                Parent = u7
            });
            SfxManager:playSound({
                Sound = "BBZ Basketball Unc Wheelchair Dash Voice",
                Parent = HumanoidRootPart
            });
            task.delay(4, function() -- Line: 90
                -- upvalues: u7 (copy)
                if u7 then
                    u7:Destroy();
                end;
            end);

            return;
        end;

        if p2.Task == "Cleanup" then
            SfxManager:playSound({
                Sound = "BBZ Basketball Unc Wheelchair Dash End",
                Parent = HumanoidRootPart
            });
            local v8 = Debris:FindFirstChild(Character.Name .. script.Name);

            if v8 then
                local u9 = {};
                local u10 = {};

                for _, descendant in pairs(v8:GetDescendants()) do
                    if descendant:IsA("Beam") or descendant:IsA("Trail") then
                        table.insert(u9, descendant);
                        u10[descendant] = {};
                        local v11 = descendant;

                        for i, v in ipairs(descendant.Transparency.Keypoints) do
                            u10[v11][i] = {
                                Start = v.Value,
                                Needed = 1 - v.Value
                            };
                        end;
                    elseif descendant:IsA("Sound") then
                        TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Volume = 0
                        }):Play();
                    end;
                end;

                local NumberValue = Instance.new("NumberValue");
                NumberValue.Changed:Connect(function() -- Line: 120
                    -- upvalues: u9 (copy), u10 (copy), NumberValue (copy)
                    for _, v in u9 do
                        local v12 = v;
                        local v13 = {};

                        for i, v2 in ipairs(v.Transparency.Keypoints) do
                            table.insert(v13, NumberSequenceKeypoint.new(v2.Time, u10[v12][i].Start + u10[v12][i].Needed * NumberValue.Value));
                        end;

                        v12.Transparency = NumberSequence.new(v13);
                    end;
                end);
                TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Value = 1
                }):Play();
                VfxManager.DestroyEffect(NumberValue, 1);
                VfxManager.DestroyEffect(v8, 2);
            end;
        end;
    end;
end;