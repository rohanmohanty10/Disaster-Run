 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");
Trove.new();

return function(p1, u2) -- Line: 19
    -- upvalues: Debris (copy), VfxManager (copy), RunService (copy), SfxManager (copy)
    local TimeSent = u2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Hoops = workspace:FindFirstChild("Hoops");
    local u4 = nil;

    if Hoops then
        local Hoop = Hoops.Home.Hoop;
        local Hoop2 = Hoops.Away.Hoop;

        if Hoop and Hoop2 then
            u4 = (HumanoidRootPart.Position - Hoop2.Position).Magnitude < (HumanoidRootPart.Position - Hoop.Position).Magnitude and Hoop2.Position or Hoop.Position;
        end;
    end;

    local v5 = Character.Name .. script.Name;

    if u2.Task == "Spawn" then
        local Folder = Instance.new("Folder");
        Folder.Name = v5;
        Folder.Parent = Debris;
        Folder:SetAttribute("Active", true);
        task.delay(10 - v3, function() -- Line: 48
            -- upvalues: Folder (copy)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            Folder:SetAttribute("Active", nil);
        end);
        Character.Archivable = true;
        local v6 = Character:Clone();
        Character.Archivable = false;
        v6.HumanoidRootPart.Anchored = true;
        v6.PrimaryPart = v6.HumanoidRootPart;

        for _, descendant in pairs(v6:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                descendant:Destroy();
            end;
        end;

        local u7 = {};

        for i, v in pairs(u2.Positions) do
            if i ~= u2.Selected then
                local u8 = {};
                local u9 = v6:Clone();
                u9.Parent = Folder;
                local HumanoidRootPart2 = u9.HumanoidRootPart;
                table.insert(u8, {
                    Character = HumanoidRootPart,
                    Clone = HumanoidRootPart2
                });
                local u10 = v;

                for _, descendant in pairs(Character:GetDescendants()) do
                    if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                        local v11 = descendant:Clone();
                        v11.Parent = u9;
                        v11.Anchored = true;

                        for _, descendant2 in pairs(v11:GetDescendants()) do
                            if descendant2:IsA("BasePart") or (descendant2:IsA("Motor6D") or (descendant2:IsA("Weld") or (descendant2:IsA("WeldConstraint") or (descendant2:IsA("BallSocketConstraint") or descendant2:IsA("RigidConstraint"))))) then
                                descendant2:Destroy();
                            end;
                        end;

                        table.insert(u8, {
                            Character = descendant,
                            Clone = v11
                        });
                    end;
                end;

                if u9:FindFirstChild("Torso") and (u9:FindFirstChild("FrontJersey") and u9:FindFirstChild("BackJersey")) then
                    u9.FrontJersey.Adornee = u9.Torso;
                    u9.BackJersey.Adornee = u9.Torso;
                end;

                table.insert(u7, Character.ChildAdded:Connect(function(p12) -- Line: 107
                    -- upvalues: u9 (copy), Character (copy)
                    if not (p12:IsA("BasePart") or p12:IsA("Model")) then
                        local v13 = p12:Clone();
                        v13.Parent = u9;

                        if v13:IsA("Highlight") and v13.Adornee == Character then
                            v13.Adornee = u9;
                        end;
                    end;
                end));
                table.insert(u7, Character.ChildRemoved:Connect(function(p14) -- Line: 118
                    -- upvalues: u9 (copy)
                    local v15 = u9:FindFirstChild(p14.Name);

                    if v15 then
                        v15:Destroy();
                    end;
                end));
                local BALL = Character:FindFirstChild("BALL", true);
                local BALL2 = u9:FindFirstChild("BALL");

                if BALL and BALL2 then
                    local u16 = BALL.Trails:FindFirstChildOfClass("Trail");
                    local u17 = BALL2.Trails:FindFirstChildOfClass("Trail");

                    if u16 and u17 then
                        local PropertyChangedSignal = u16:GetPropertyChangedSignal("Enabled");
                        table.insert(u7, PropertyChangedSignal:Connect(function() -- Line: 131
                            -- upvalues: u17 (copy), u16 (copy)
                            u17.Enabled = u16.Enabled;
                        end));
                    end;
                end;

                for _, v2 in pairs(u8) do
                    v2.Clone.CFrame = v2.Character.CFrame;
                end;

                local v18 = u10 + (HumanoidRootPart.Position - u2.Positions[u2.Selected]);
                local CFrame_lookAt_ret = CFrame.lookAt(v18, (Vector3.new(u4.X, v18.Y, u4.Z)));
                local v19 = HumanoidRootPart.CFrame.LookVector:Dot(CFrame_lookAt_ret.LookVector);
                local math_clamp_ret = math.clamp(v19, -1, 1);
                local math_acos_ret = math.acos(math_clamp_ret);
                u9:PivotTo(CFrame.new(v18) * CFrame.fromOrientation(0, math_acos_ret, 0));
                local v20 = script.Smoke:Clone();
                v20.Parent = Debris;
                v20.CFrame = HumanoidRootPart2.CFrame;
                VfxManager.Emit(v20);
                VfxManager.DestroyEffect(v20, 2);
                local Ring = workspace:FindFirstChild("Ring");
                local u21;

                if Ring then
                    u21 = Ring:Clone();
                    u21.Parent = Folder;
                    u21.CFrame = CFrame.new(HumanoidRootPart2.Position.X, 1, HumanoidRootPart2.Position.Z) * Ring.CFrame.Rotation * CFrame.fromOrientation(0, math_acos_ret, 0);
                else
                    u21 = nil;
                end;

                table.insert(u7, RunService.RenderStepped:Connect(function() -- Line: 164
                    -- upvalues: u8 (copy), HumanoidRootPart (copy), u2 (copy), u10 (copy), u4 (ref), u9 (copy), u21 (ref), Ring (copy), HumanoidRootPart2 (copy)
                    for _, v2 in pairs(u8) do
                        v2.Clone.CFrame = v2.Character.CFrame;
                    end;

                    local v22 = u10 + (HumanoidRootPart.Position - u2.Positions[u2.Selected]);
                    local CFrame_lookAt_ret2 = CFrame.lookAt(v22, (Vector3.new(u4.X, v22.Y, u4.Z)));
                    local _, v23, _ = CFrame_lookAt_ret2:ToObjectSpace(HumanoidRootPart.CFrame):ToOrientation();
                    u9:PivotTo(CFrame_lookAt_ret2 * CFrame.fromOrientation(0, v23, 0));

                    if u21 and Ring then
                        u21.CFrame = CFrame.new(HumanoidRootPart2.Position.X, 1, HumanoidRootPart2.Position.Z) * Ring.CFrame.Rotation;
                    end;
                end));
            end;
        end;

        local function v26() -- Line: 184
            -- upvalues: u7 (ref), Folder (copy), Debris (ref), VfxManager (ref), SfxManager (ref), HumanoidRootPart (copy)
            for _, v in pairs(u7) do
                v:Disconnect();
            end;

            if Folder then
                for _, child in pairs(Folder:GetChildren()) do
                    if child:FindFirstChild("HumanoidRootPart") then
                        local v24 = script.Smoke:Clone();
                        v24.Parent = Debris;
                        v24.CFrame = child.HumanoidRootPart.CFrame;
                        VfxManager.Emit(v24);
                        VfxManager.DestroyEffect(v24, 2);
                    end;
                end;

                Folder:Destroy();
                SfxManager:playSound({
                    Sound = "BBZ Eclipse Spirit Shot Despawn",
                    Parent = HumanoidRootPart
                });
                local v25 = script.Smoke:Clone();
                v25.Parent = Debris;
                v25.CFrame = HumanoidRootPart.CFrame;
                VfxManager.Emit(v25);
                VfxManager.DestroyEffect(v25, 2);
            end;

            u7 = nil;
        end;

        table.insert(u7, Folder.AttributeChanged:Connect(v26));
        table.insert(u7, Folder.Destroying:Connect(v26));
        v6:Destroy();
        SfxManager:playSound({
            Sound = "BBZ Eclipse Spirit Shot Spawn",
            Parent = HumanoidRootPart
        });
        local v27 = script.Smoke:Clone();
        v27.Parent = Debris;
        v27.CFrame = HumanoidRootPart.CFrame;
        VfxManager.Emit(v27);
        VfxManager.DestroyEffect(v27, 2);
    else
        local v28 = u2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v28 then
            v28:SetAttribute("Active", nil);
        end;
    end;
end;