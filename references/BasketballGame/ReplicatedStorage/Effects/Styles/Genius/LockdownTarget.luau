 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Trove);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: Debris (copy), VfxManager (copy), TweenService (copy), Essentials (copy), SfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");

    local function Cleanup(p4, p5) -- Line: 23
        -- upvalues: Debris (ref), Character (copy), VfxManager (ref), TweenService (ref), Head (copy)
        if p4 == "Charge" then
            local v6 = Debris:FindFirstChild(Character.Name .. script.Name .. "Charge");

            if v6 then
                VfxManager.Enable(v6, false);
                VfxManager.DestroyEffect(v6, 2);

                if v6:FindFirstChild("Sound") then
                    TweenService:Create(v6.Sound, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Volume = 0
                    }):Play();
                end;
            end;
        elseif p4 == "Lockdown" then
            local v7 = Character:FindFirstChild(script.Name .. "Highlight");

            if v7 then
                v7:Destroy();
            end;

            local v8 = Head:FindFirstChild(script.Name .. "Overhead");

            if v8 then
                v8:Destroy();
            end;

            local v9 = Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

            if v9 then
                if p5 then
                    v9:Destroy();

                    return;
                end;

                VfxManager.Enable(v9, false);
                VfxManager.DestroyEffect(v9, 1);

                if v9:FindFirstChild("Sound") then
                    TweenService:Create(v9.Sound, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Volume = 0
                    }):Play();
                end;
            end;
        end;
    end;

    if p2.Task ~= "Charge" then
        if p2.Task == "ChargeCleanup" then
            Cleanup("Charge");

            return;
        end;

        if p2.Task == "Pass" then
            Cleanup("Charge");

            if p2.TimeCharged >= 1 then
                task.delay(0.35 - v3, function() -- Line: 78
                    -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), SfxManager (ref)
                    local v10 = script.Pass:Clone();
                    v10.Parent = Debris;
                    v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                    VfxManager.Emit(v10);
                    VfxManager.DestroyEffect(v10, 4);
                    SfxManager:playSound({
                        Sound = "BBZ Genius Target Pass Pass",
                        Parent = v10
                    });
                end);

                return;
            end;
        else
            if p2.Task == "Lockdown" then
                local v11 = Character:FindFirstChild(script.Name .. "Highlight");

                if v11 then
                    v11:Destroy();
                end;

                local v12 = Head:FindFirstChild(script.Name .. "Overhead");

                if v12 then
                    v12:Destroy();
                end;

                local v13 = Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

                if v13 then
                    v13:Destroy();
                end;

                SfxManager:playSound({
                    Sound = "BBZ Genius Lockdown Start",
                    Parent = HumanoidRootPart
                });
                local Highlight = Instance.new("Highlight", Character);
                Highlight.Name = script.Name .. "Highlight";
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight.OutlineColor = Color3.fromRGB(133, 255, 99);
                Highlight.OutlineTransparency = 0;
                Highlight.FillTransparency = 1;
                VfxManager.DestroyEffect(Highlight, 7);
                local v14 = script.Overhead:Clone();
                v14.Name = script.Name .. "Overhead";
                v14.Parent = Head;
                VfxManager.DestroyEffect(v14, 7);
                local v15 = script.Aura:Clone();
                v15.Name = Character.Name .. script.Name .. "Aura";
                v15.Parent = Debris;
                v15.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v15, HumanoidRootPart);
                VfxManager.DestroyEffect(v15, 8);
                SfxManager:playSound({
                    Sound = "BBZ Genius Lockdown",
                    Parent = HumanoidRootPart
                }).Name = "Sound";

                return;
            end;

            if p2.Task == "HighlightCleanup" then
                Cleanup("Lockdown");

                return;
            end;

            if p2.Task == "Steal" then
                Cleanup("Lockdown");
                SfxManager:playSound({
                    Sound = "BBZ Genius Lockdown Steal",
                    Parent = HumanoidRootPart
                });
                local v16 = script.Jump:Clone();
                v16.Parent = Debris;
                v16.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
                VfxManager.Emit(v16);
                VfxManager.DestroyEffect(v16, 4);
                task.delay(0.15 - v3, function() -- Line: 129
                    -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                    local v17 = script.Steal:Clone();
                    v17.Parent = Debris;
                    v17.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 4, -1) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                    VfxManager.Emit(v17);
                    VfxManager.DestroyEffect(v17, 4);
                end);
            end;
        end;

        return;
    end;

    Cleanup("Charge", true);
    local v18 = script.Charge:Clone();
    v18.Name = Character.Name .. script.Name .. "Charge";
    v18.Parent = Debris;
    v18.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.6, 0);
    Essentials:Weld(v18, HumanoidRootPart);
    VfxManager.Enable(v18, true);
    VfxManager.DestroyEffect(v18, 8);
    SfxManager:playSound({
        Sound = "BBZ Genius Target Pass Charge",
        Parent = v18
    }).Name = "Sound";
end;