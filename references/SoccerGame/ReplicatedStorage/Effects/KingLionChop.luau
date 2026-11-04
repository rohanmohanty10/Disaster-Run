  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Debris = game:GetService("Debris");
game:GetService("TweenService");
game:GetService("Players");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 12
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), Debris (copy), VfxManager (copy)
    local Char = p1.Char;
    local Direction = p1.Direction;
    local v2 = ReplicatedStorage.Assets.Vfx.Chops.ChopsFloorTrail:Clone();
    v2.Parent = Char.HumanoidRootPart;
    v2.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
    Essentials:Weld(v2, Char.HumanoidRootPart);
    Debris:AddItem(v2, 0.5);
    local v3 = script.AuraFlash:Clone();
    v3.CFrame = Char.Torso.CFrame;
    v3.Parent = workspace.Debris;
    Essentials:Weld(v3, Char.Torso);
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 2);
    local TweenService = game:GetService("TweenService");

    local function TweenModelPivot(u4, u5, p6) -- Line: 31
        -- upvalues: Debris (ref), TweenService (copy)
        local Pivot = u4:GetPivot();
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        NumberValue.Parent = u4;
        Debris:AddItem(NumberValue, p6 + 0.5);
        local u7 = TweenService:Create(NumberValue, TweenInfo.new(p6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 1
        });
        local u9 = NumberValue.Changed:Connect(function(p8) -- Line: 47
            -- upvalues: Pivot (copy), u5 (copy), u4 (copy)
            u4:PivotTo((Pivot:Lerp(u5, p8)));
        end);
        u7:Play();
        u7.Completed:Connect(function() -- Line: 56
            -- upvalues: u9 (ref), NumberValue (copy), u4 (copy), u5 (copy), u7 (copy)
            u9:Disconnect();
            NumberValue:Destroy();
            u4:PivotTo(u5);
            u7:Destroy();
        end);
    end;

    (function(p10, p11, p12) -- Line: 64, Name: createAfterimage
        -- upvalues: Direction (copy), TweenModelPivot (copy), TweenService (copy), Debris (ref)
        local v13 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart" };

        if not p10 then
            return;
        end;

        local v14 = p10:Clone();

        if not v14 then
            return;
        end;

        v14.Parent = workspace.Debris;
        v14.Name = p10.Name .. "_Afterimage";
        v14.Torso.Jersey:Destroy();

        if v14:FindFirstChild("BodyColors") then
            v14.BodyColors:Destroy();
        end;

        local PrimaryPart = v14.PrimaryPart;
        PrimaryPart.CFrame = PrimaryPart.CFrame * CFrame.Angles(0, math.rad(Direction == "A" and -30 or 30), 0);

        for _, child in v14:GetChildren() do
            if (child:IsA("Humanoid") or child:IsA("BasePart")) and table.find(v13, child.Name) then
                if child:IsA("BasePart") then
                    child.Anchored = true;
                    child.CanCollide = false;
                    child.Material = Enum.Material.Neon;
                    child.Color = Color3.fromRGB(0, 0, 0);

                    if child.Name ~= "HumanoidRootPart" then
                        child.Transparency = 0.3;
                    end;
                end;
            else
                child:Destroy();
            end;
        end;

        for _, child in v14.Head:GetChildren() do
            if child:IsA("Decal") then
                child:Destroy();
            end;
        end;

        local HumanoidRootPart = v14:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        local _ = HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * p11;
        TweenModelPivot(v14, HumanoidRootPart.CFrame * CFrame.new(0, 0, -p11), p12);

        for _, descendant in v14:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(p12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;

        Debris:AddItem(v14, p12 + 0.5);
    end)(Char, 15, 0.42);
    task.wait(0.5);
    local v15 = script.BallEffects:Clone();
    v15.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -1, -0.5);
    v15.Parent = workspace.Debris;
    Essentials:Weld(v15, Char.HumanoidRootPart);
    Debris:AddItem(v15, 0.5);
    VfxManager.Emit(v15);
end;