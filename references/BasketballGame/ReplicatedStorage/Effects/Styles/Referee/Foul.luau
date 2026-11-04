 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Trove);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy), Essentials (copy), LocalPlayer (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local _ = p1.BallController;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if p2.Task ~= "Book Dunk" then
        if p2.Task == "Zone" then
            local Model = Instance.new("Model", Debris);
            Model.Name = Character.Name .. script.Name .. "Aura";
            VfxManager.DestroyEffect(Model, 8);

            for _, child in pairs(script.Foul.AuraBodyPartsToWeld:GetChildren()) do
                local v4 = Character:FindFirstChild(child.Name);

                if v4 then
                    local v5 = child:Clone();
                    v5.CFrame = v4.CFrame;
                    v5.Parent = Model;
                    Essentials:Weld(v5, v4);
                end;
            end;

            VfxManager.Enable(Model, true);
            local Highlight = Instance.new("Highlight", Character);
            Highlight.Name = script.Name .. "Highlight";
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.new(255, 255, 255);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 1;
            VfxManager.DestroyEffect(Highlight, 5);
            local v6 = script.Foul.Zone:Clone();
            v6.Name = Character.Name .. script.Name .. "Zone";
            v6.Parent = Debris;
            v6.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v6, HumanoidRootPart);
            TweenService:Create(v6, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0
            }):Play();
            SfxManager:playSound({
                Sound = "BBZ Referee Foul Activate",
                Parent = HumanoidRootPart
            });
            SfxManager:playSound({
                Sound = "BBZ Referee Foul Zone",
                Parent = v6
            });
            task.wait(0.25);
            VfxManager.DestroyEffect(v6, 5);

            if LocalPlayer.Character ~= Character then
                TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();

                return;
            end;

            TweenService:Create(v6, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(35, 35, 35)
            }):Play();

            while v6 and v6:IsDescendantOf(Debris) do
                TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 0.75
                }):Play();
                task.wait(0.5);
                TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Transparency = 0
                }):Play();
                task.wait(0.5);
            end;
        elseif p2.Task == "Cleanup" then
            local v7 = Character:FindFirstChild(script.Name .. "Highlight");

            if v7 then
                v7:Destroy();
            end;

            local v8 = Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

            if v8 then
                VfxManager.Enable(v8, false);
                VfxManager.DestroyEffect(v8, 2);
            end;

            local v9 = Debris:FindFirstChild(Character.Name .. script.Name .. "Zone");

            if v9 then
                local v10 = v9:Clone();
                v10.Parent = Debris;
                TweenService:Create(v10, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                VfxManager.DestroyEffect(v10, 0.25);
                local v11 = v10:FindFirstChildOfClass("Sound");

                if v11 then
                    v11:Destroy();
                end;

                local v12 = v9:FindFirstChildOfClass("Sound");

                if v12 then
                    v12.Parent = v10;
                    TweenService:Create(v12, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Volume = 0
                    }):Play();
                end;

                v9:Destroy();

                return;
            end;
        elseif p2.Task == "Defense" then
            SfxManager:playSound({
                Sound = "BBZ Referee Foul Defense",
                Parent = HumanoidRootPart
            });
            local Whistle = Character:FindFirstChild("Whistle");
            local Basketball = workspace:FindFirstChild("Basketball");
            local v13 = script.Foul.Ground:Clone();
            v13.Parent = Debris;
            v13.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) + Vector3.new(0, -2.5, 0);
            VfxManager.Emit(v13);
            VfxManager.DestroyEffect(v13, 2);

            if Whistle then
                local v14 = script.Foul.Enable:Clone();
                v14.Parent = Debris;
                v14.CFrame = Whistle.CFrame;
                v14.Weld.Part0 = Whistle;
                VfxManager.Emit(v14);
                VfxManager.DestroyEffect(v14, 2);
            end;

            task.delay(0.25 - v3, function() -- Line: 222
                -- upvalues: Basketball (copy), Debris (ref), VfxManager (ref)
                if Basketball then
                    local v15 = script.Foul.Ball:Clone();
                    v15.Parent = Debris;
                    v15.CFrame = Basketball.CFrame;
                    VfxManager.Emit(v15);
                    VfxManager.DestroyEffect(v15, 2);
                end;
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Referee Book Dunk",
        Parent = HumanoidRootPart
    });
    local u16 = workspace:FindFirstChild(script.Name .. "Book");
    local BALL = Character:FindFirstChild("BALL", true);
    local NumberValue = Instance.new("NumberValue", u16);
    NumberValue.Value = 0;
    NumberValue.Changed:Connect(function() -- Line: 32
        -- upvalues: NumberValue (copy), u16 (copy)
        if NumberValue.Value > 0 and u16 then
            u16:ScaleTo(NumberValue.Value);
        end;
    end);

    if u16 then
        u16:ScaleTo(0.001);
    end;

    task.delay(0.05 - v3, function() -- Line: 44
        -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
        if BALL then
            local v17 = script["Book Dunk"].Ball:Clone();
            v17.Parent = Debris;
            v17.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v17);
            VfxManager.DestroyEffect(v17, 2);
        end;
    end);
    task.delay(0.3333333333333333 - v3, function() -- Line: 54
        -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
        if BALL then
            local v18 = script["Book Dunk"].Ball:Clone();
            v18.Parent = Debris;
            v18.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v18);
            VfxManager.DestroyEffect(v18, 2);
        end;
    end);
    task.delay(0.5 - v3, function() -- Line: 64
        -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
        if BALL then
            local v19 = script["Book Dunk"].Ball:Clone();
            v19.Parent = Debris;
            v19.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v19);
            VfxManager.DestroyEffect(v19, 2);
        end;
    end);
    task.delay(0.55 - v3, function() -- Line: 74
        -- upvalues: u16 (copy), TweenService (ref), NumberValue (copy)
        if u16 then
            TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 0.5
            }):Play();
        end;
    end);
    task.delay(0.95 - v3, function() -- Line: 80
        -- upvalues: u16 (copy), Debris (ref), Essentials (ref), VfxManager (ref)
        if u16 and u16:FindFirstChild("BookToRig") then
            local v20 = script["Book Dunk"].Book:Clone();
            v20.Parent = Debris;
            v20.CFrame = CFrame.new(u16.BookToRig.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            Essentials:Weld(v20, u16.BookToRig);
            VfxManager.Emit(v20);
            VfxManager.DestroyEffect(v20, 2);
        end;
    end);
    task.delay(1.15 - v3, function() -- Line: 91
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref)
        local v21 = script["Book Dunk"].Jump:Clone();
        v21.CFrame = HumanoidRootPart.CFrame * CFrame.fromOrientation(0.5235987755982988, 3.141592653589793, 3.141592653589793) + Vector3.new(0, -3, 0);
        VfxManager.Emit(v21);
        VfxManager.DestroyEffect(v21, 2);
    end);
    task.delay(1.25 - v3, function() -- Line: 98
        -- upvalues: u16 (copy), TweenService (ref), NumberValue (copy)
        if u16 then
            TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
        end;
    end);
    task.delay(1.5166666666666666 - v3, function() -- Line: 104
        -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
        if BALL then
            local v22 = script["Book Dunk"].End:Clone();
            v22.Parent = Debris;
            v22.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(3.141592653589793, 0, 0);
            VfxManager.Emit(v22);
            VfxManager.DestroyEffect(v22, 2);
        end;
    end);
end;