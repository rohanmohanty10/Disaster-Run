 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local ScaryMonsterScreenEffect = require(script.Parent.Parent.ScreenEffects.ScaryMonsterScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), VfxManager (copy), LocalPlayer (copy), Lighting (copy), Part_Icles (copy), TweenService (copy), ScaryMonsterScreenEffect (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Enemy = p2.Enemy;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        if p2.Task == "Cleanup" then
            local v5 = Debris:FindFirstChild(v4);

            if v5 then
                v5:SetAttribute("Active", nil);

                return;
            end;
        elseif p2.Task == "Time Skip" then
            SfxManager:playSound({
                Sound = "BBZ Scary Monster Time Skip",
                Parent = Character:FindFirstChild("HumanoidRootPart")
            });
            ScaryMonsterScreenEffect(Character, p2.CFrame);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name) or Character.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(1.5 - u3, function() -- Line: 38
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Time, stop.", 1 },
            { u6, "<animation style=\"glitch\">THE WORLD.</animation>", 1.5 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 56
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u3;
        end;

        u7 = u7 + p9 * 60;
        local v10 = script_Fov[math.ceil(u7)];

        if v10 ~= nil then
            if math.ceil(u7) >= #script_Fov then
                u8:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v10, p9 * 6);
        end;
    end);
    task.delay(4.45 - u3, function() -- Line: 78
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(4.45 - u3, function() -- Line: 91
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Scary Monster World",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Ball:Clone();
    u12.CFrame = BALL.CFrame;
    u12.Parent = Debris;
    Essentials:Weld(u12, BALL);
    VfxManager.DestroyEffect(u12, 10.45 - u3);
    local u13;

    if Head then
        u13 = script.Head:Clone();
        u13.CFrame = Head.CFrame;
        u13.Parent = Folder;
        Essentials:Weld(u13, Head);
    else
        u13 = nil;
    end;

    local Model = Instance.new("Model");
    Model.Parent = Folder;

    if Enemy then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v14 = Enemy:FindFirstChild(child.Name);

            if v14 then
                local v15 = child:Clone();
                v15.CFrame = v14.CFrame;
                v15.Parent = Model;
                Essentials:Weld(v15, v14);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = script.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local _ = u16.Vignette1;
    u16.Vignette.ImageTransparency = 0;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    task.delay(10.45 - u3, function() -- Line: 147
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect:Destroy();
    end);
    task.delay(0.48333333333333334 - u3, function() -- Line: 151
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Impact);
        Part_Icles:AbsoluteEmit(u12.Dust);
        Part_Icles:AbsoluteEmit(u12.Extra);
        Part_Icles:AbsoluteEmit(u12.Crazy);
    end);
    task.delay(0.5 - u3, function() -- Line: 160
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Aura);
    end);
    task.delay(0.9333333333333333 - u3, function() -- Line: 166
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Impact);
        Part_Icles:AbsoluteEmit(u12.Dust);
        Part_Icles:AbsoluteEmit(u12.Extra);
        Part_Icles:AbsoluteEmit(u12.Crazy);
    end);
    task.delay(1.35 - u3, function() -- Line: 175
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13);
    end);
    task.delay(1.6 - u3, function() -- Line: 181
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Impact);
        Part_Icles:AbsoluteEmit(u12.Dust);
        Part_Icles:AbsoluteEmit(u12.Extra);
        Part_Icles:AbsoluteEmit(u12.Crazy);
    end);
    task.delay(2.15 - u3, function() -- Line: 190
        -- upvalues: Folder (copy), TweenService (ref), RunService (ref), ColorCorrectionEffect (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        TweenService:Create(NumberValue, TweenInfo.new(0.5), {
            Value = 1
        }):Play();
        local u17 = tick();
        local u18 = RunService.RenderStepped:Connect(function() -- Line: 198
            -- upvalues: ColorCorrectionEffect (ref), u17 (copy), NumberValue (copy)
            ColorCorrectionEffect.TintColor = Color3.fromHSV((tick() - u17) / 2 % 1, NumberValue.Value, 1);
        end);
        task.delay(2.3000000000000003, function() -- Line: 202
            -- upvalues: TweenService (ref), NumberValue (copy)
            TweenService:Create(NumberValue, TweenInfo.new(0.5), {
                Value = 0.5
            }):Play();
        end);
        task.delay(7.299999999999999, function() -- Line: 206
            -- upvalues: TweenService (ref), NumberValue (copy), u18 (copy)
            TweenService:Create(NumberValue, TweenInfo.new(1), {
                Value = 0
            }):Play();
            task.delay(1, function() -- Line: 209
                -- upvalues: NumberValue (ref), u18 (ref)
                NumberValue:Destroy();
                u18:Disconnect();
            end);
        end);
    end);
    task.delay(2.183333333333333 - u3, function() -- Line: 216
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Impact);
        Part_Icles:AbsoluteEmit(u12.Dust);
        Part_Icles:AbsoluteEmit(u12.Extra);
        Part_Icles:AbsoluteEmit(u12.Crazy);
    end);
    task.delay(2.5 - u3, function() -- Line: 225
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Rainbow);
    end);
    task.delay(2.6 - u3, function() -- Line: 231
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Rainbow.LightningM1);
    end);
    task.delay(2.7 - u3, function() -- Line: 237
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Rainbow.Dist);
    end);
    task.delay(2.75 - u3, function() -- Line: 243
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Rainbow.BigDist);
    end);
    task.delay(2.8333333333333335 - u3, function() -- Line: 249
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dash);
    end);
    task.delay(2.85 - u3, function() -- Line: 255
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Time);
    end);
    task.delay(2.8666666666666667 - u3, function() -- Line: 261
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Distortion);
    end);
    task.delay(3.0833333333333335 - u3, function() -- Line: 267
        -- upvalues: Folder (copy), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model);
    end);
    task.delay(3.2333333333333334 - u3, function() -- Line: 273
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Impact);
        Part_Icles:AbsoluteEmit(u12.Dust);
        Part_Icles:AbsoluteEmit(u12.Extra);
        Part_Icles:AbsoluteEmit(u12.Crazy);
    end);
    task.delay(3.9833333333333334 - u3, function() -- Line: 282
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Impact);
        Part_Icles:AbsoluteEmit(u12.Dust);
        Part_Icles:AbsoluteEmit(u12.Extra);
        Part_Icles:AbsoluteEmit(u12.Crazy);
    end);
    local u19 = {};

    local function v20() -- Line: 292
        -- upvalues: u19 (ref), Folder (copy), u16 (copy)
        for _, v in pairs(u19) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u16 then
            u16:Destroy();
        end;

        u19 = nil;
    end;

    table.insert(u19, Folder.AttributeChanged:Connect(v20));
    table.insert(u19, Folder.Destroying:Connect(v20));
end;