 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local UIController = require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function ParticleOnly(p1: userdata, p2: boolean) -- Line: 19
    if p1 == nil then
        return;
    end;

    if p2 == nil then
        p2 = false;
    end;

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p2;
        end;
    end;
end;

local function BeamOnly(p3: userdata, p4: boolean) -- Line: 32
    if p3 == nil then
        return;
    end;

    if p4 == nil then
        p4 = false;
    end;

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = p4;
        end;
    end;
end;

return function(u5, p6) -- Line: 45
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), VfxManager (copy), ReplicatedStorage (copy), ParticleOnly (copy), BeamOnly (copy), TweenService (copy), UIController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u7 = p6.passedTime or 0;
    local v8 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v9 = p6.Task == "Cleanup" and Debris:FindFirstChild(v8);

        if v9 then
            v9:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 64
        -- upvalues: u5 (copy), u11 (ref), u10 (ref), u7 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * u7;
        end;

        u10 = u10 + p12 * 60;
        local v13 = script_Fov[math.ceil(u10)];

        if v13 ~= nil then
            if math.ceil(u10) >= #script_Fov then
                u11:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v13, p12 * 6);
        end;
    end);
    task.delay(17 - u7, function() -- Line: 83
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);
    local u14 = {};
    local u15 = {};

    if Debris:FindFirstChild(v8) then
        Debris:FindFirstChild(v8):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(17, function() -- Line: 99
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u16 = SfxManager:playSound({
        Sound = "BBZ Switcher blackflash dunk cutscene",
        Parent = workspace
    });
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local Friend = p6.Friend;
    local u17 = script.friendarm:Clone();
    u17.CFrame = Friend:FindFirstChild("Left Arm").CFrame;
    u17.Parent = Folder;
    VfxManager.Enable(u17, false);
    Essentials:Weld(u17, Friend:FindFirstChild("Left Arm"));
    local u18 = script.phewplayer:Clone();
    u18.CFrame = Head.CFrame;
    u18.Parent = Folder;
    VfxManager.Enable(u18, false);
    Essentials:Weld(u18, Head);
    local u19 = script.Head:Clone();
    u19.CFrame = Head.CFrame;
    u19.Parent = Folder;
    VfxManager.Enable(u19, false);
    Essentials:Weld(u19, Head);
    local u20 = script.phew:Clone();
    u20.CFrame = Friend:FindFirstChild("Head").CFrame;
    u20.Parent = Folder;
    VfxManager.Enable(u20, false);
    Essentials:Weld(u20, Friend:FindFirstChild("Head"));
    local u21 = script.BALL:Clone();
    u21.CFrame = BALL.CFrame;
    u21.Parent = Folder;
    Essentials:Weld(u21, BALL);
    VfxManager.Enable(u21, false);
    local u22 = script.Camera_VFX:Clone();
    u22:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u22.Parent = Folder;
    Essentials:Weld(u22.PrimaryPart, CamRig.CamPart);
    local u23 = script.Cutscene_VFX:Clone();
    u23:PivotTo(HumanoidRootPart.CFrame);
    u23.Parent = Folder;
    local u24 = ReplicatedStorage.Assets.VFX.Vignette:Clone();
    u24.Parent = PlayerGui;
    u24.Enabled = true;
    local _ = u24.Vignette;
    local _ = u24.Vignette1;
    ParticleOnly(u22.camstart, true);
    task.delay(0.45 - u7, function() -- Line: 177
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.rockpick);
    end);
    task.delay(0.533 - u7, function() -- Line: 185
        -- upvalues: Folder (copy), ParticleOnly (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.redspecs, true);
        task.wait(0.8);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.redspecs, false);
    end);
    task.delay(0.8 - u7, function() -- Line: 199
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camstart, false);
    end);
    task.delay(0.85 - u7, function() -- Line: 207
        -- upvalues: Folder (copy), BeamOnly (ref), u23 (copy), u22 (copy), VfxManager (ref), u18 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u23.beambackground, true);
        task.delay(2, function() -- Line: 213
            -- upvalues: Folder (ref), BeamOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            BeamOnly(u23.beambackground, false);
        end);
        task.wait(0.05);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u22.camatmo, true);
        task.delay(1, function() -- Line: 227
            -- upvalues: Folder (ref), BeamOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            BeamOnly(u22.camatmo, false);
        end);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u18);
    end);
    task.delay(1.683 - u7, function() -- Line: 242
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camstart, true);
        task.delay(0.8, function() -- Line: 249
            -- upvalues: Folder (ref), ParticleOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u22.camstart, false);
        end);
    end);
    task.delay(2.017 - u7, function() -- Line: 257
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.rockgive);
    end);
    task.delay(2.333 - u7, function() -- Line: 264
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.ballgive);
    end);
    task.delay(2.683 - u7, function() -- Line: 271
        -- upvalues: Folder (copy), BeamOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u22.throwatmo, true);
        task.delay(1.5, function() -- Line: 277
            -- upvalues: Folder (ref), BeamOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            BeamOnly(u22.throwatmo, false);
        end);
    end);
    task.delay(2.85 - u7, function() -- Line: 285
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camthrow, true);
        task.delay(1, function() -- Line: 291
            -- upvalues: Folder (ref), ParticleOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u22.camthrow, false);
        end);
        task.wait(0.03333333333333333);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u17, true);
        task.delay(1, function() -- Line: 304
            -- upvalues: Folder (ref), ParticleOnly (ref), u17 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u17, false);
        end);
    end);
    task.delay(3.333 - u7, function() -- Line: 312
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20);
    end);
    task.delay(3.867 - u7, function() -- Line: 319
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.throw);
    end);
    task.delay(3.9 - u7, function() -- Line: 327
        -- upvalues: Folder (copy), u23 (copy), HumanoidRootPart (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.wind.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.08363556861877441, 0.039254188537597656, -5.153625011444092) * CFrame.fromEulerAnglesYXZ(1.536858320236206, 2.5720887184143066, 2.7421576976776123);
        TweenService:Create(u23.wind, TweenInfo.new(0.233, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(1.8528234958648682, 0.366610050201416, -15.46875) * CFrame.fromEulerAnglesYXZ(1.5368547439575195, 2.5720884799957275, 2.742156982421875)
        }):Play();
        task.wait(0.233);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u23.wind, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(3.096060037612915, 0.5966475009918213, -22.71735382080078) * CFrame.fromEulerAnglesYXZ(1.536858320236206, 2.5720887184143066, 2.7421576976776123)
        }):Play();
    end);
    task.delay(3.917 - u7, function() -- Line: 343
        -- upvalues: Folder (copy), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local TweenService2 = game:GetService("TweenService");
        local wind = u23.wind;
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Parent = wind;
        NumberValue.Value = 1;
        local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });
        TweenService2:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        task.spawn(function() -- Line: 362
            -- upvalues: wind (copy), NumberSequence_new_ret (copy), TweenService2 (copy), NumberValue (copy)
            for _, descendant in pairs(wind:GetDescendants()) do
                task.spawn(function() -- Line: 364
                    -- upvalues: descendant (copy), NumberSequence_new_ret (ref), TweenService2 (ref), NumberValue (ref)
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                        descendant.Transparency = NumberSequence_new_ret;
                        descendant.TextureSpeed = 7;
                        TweenService2:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            TextureSpeed = 0.01
                        }):Play();
                        NumberValue.Changed:Connect(function() -- Line: 372
                            -- upvalues: descendant (ref), NumberValue (ref)
                            task.spawn(function() -- Line: 373
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                            end);
                        end);
                        task.delay(0.2, function() -- Line: 381
                            -- upvalues: NumberValue (ref), descendant (ref)
                            NumberValue.Changed:Connect(function() -- Line: 382
                                -- upvalues: descendant (ref), NumberValue (ref)
                                task.spawn(function() -- Line: 383
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                                end);
                            end);
                            task.wait(1);
                            descendant.Enabled = false;
                            NumberValue:Destroy();
                        end);
                    end;
                end);
            end;
        end);
        task.delay(0.2, function() -- Line: 399
            -- upvalues: TweenService2 (copy), NumberValue (copy)
            TweenService2:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 1
            }):Play();
        end);
    end);
    task.delay(3.983 - u7, function() -- Line: 405
        -- upvalues: Folder (copy), ParticleOnly (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u21, true);
        task.delay(1, function() -- Line: 411
            -- upvalues: Folder (ref), ParticleOnly (ref), u21 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u21, false);
        end);
    end);
    task.delay(4.7 - u7, function() -- Line: 419
        -- upvalues: Folder (copy), ParticleOnly (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.rockweld, true);
        task.delay(1, function() -- Line: 425
            -- upvalues: Folder (ref), ParticleOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u23.rockweld, false);
        end);
    end);
    task.delay(5.683 - u7, function() -- Line: 433
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.TP);
    end);
    task.delay(6.167 - u7, function() -- Line: 441
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camtra, true);
        task.delay(0.3, function() -- Line: 447
            -- upvalues: Folder (ref), ParticleOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u22.camtra, false);
        end);
    end);
    task.delay(6.3 - u7, function() -- Line: 455
        -- upvalues: Folder (copy), ParticleOnly (ref), u23 (copy), BeamOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.hugelines, true);
        task.delay(4.3, function() -- Line: 461
            -- upvalues: Folder (ref), ParticleOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u23.hugelines, false);
        end);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u22.slideatmo, true);
        task.delay(8, function() -- Line: 475
            -- upvalues: Folder (ref), BeamOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            BeamOnly(u22.slideatmo, false);
        end);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u22.camglare, true);
        task.delay(1.5, function() -- Line: 488
            -- upvalues: Folder (ref), BeamOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            BeamOnly(u22.camglare, false);
        end);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.auraslide, true);
        task.delay(4.3, function() -- Line: 502
            -- upvalues: Folder (ref), ParticleOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u23.auraslide, false);
        end);
    end);
    task.delay(7.933 - u7, function() -- Line: 511
        -- upvalues: Folder (copy), BeamOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u22.camglare2, true);
        task.delay(2.6, function() -- Line: 517
            -- upvalues: Folder (ref), BeamOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            BeamOnly(u22.camglare2, false);
        end);
    end);
    task.delay(10.683 - u7, function() -- Line: 525
        -- upvalues: Folder (copy), UIController (ref), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        UIController:FrameText("SwitcherConstelation");
        ParticleOnly(u22.camstart, true);
        task.delay(1.5, function() -- Line: 533
            -- upvalues: Folder (ref), ParticleOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u22.camstart, false);
        end);
    end);
    task.delay(12.067 - u7, function() -- Line: 541
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.starspace);
    end);
    task.delay(12.517 - u7, function() -- Line: 548
        -- upvalues: Folder (copy), ParticleOnly (ref), u23 (copy), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.hugelines, true);
        task.delay(2, function() -- Line: 554
            -- upvalues: Folder (ref), ParticleOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u23.hugelines, false);
        end);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.auraslide, true);
        task.delay(3, function() -- Line: 568
            -- upvalues: Folder (ref), ParticleOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u23.auraslide, false);
        end);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.cameralinesorange, true);
        task.delay(1, function() -- Line: 582
            -- upvalues: Folder (ref), ParticleOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u22.cameralinesorange, false);
        end);
    end);
    task.delay(13.733 - u7, function() -- Line: 591
        -- upvalues: Folder (copy), ParticleOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19, true);
        task.delay(8, function() -- Line: 597
            -- upvalues: Folder (ref), ParticleOnly (ref), u19 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u19, false);
        end);
    end);
    task.delay(13.783 - u7, function() -- Line: 605
        -- upvalues: Folder (copy), BeamOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u19, true);
        task.delay(8, function() -- Line: 611
            -- upvalues: Folder (ref), BeamOnly (ref), u19 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            BeamOnly(u19, false);
        end);
    end);
    task.delay(14.767 - u7, function() -- Line: 620
        -- upvalues: Folder (copy), ParticleOnly (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.BGLightning, true);
        task.delay(1, function() -- Line: 626
            -- upvalues: Folder (ref), ParticleOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u23.BGLightning, false);
        end);
    end);
    task.delay(15.45 - u7, function() -- Line: 634
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camstart, true);
        task.delay(3, function() -- Line: 640
            -- upvalues: Folder (ref), ParticleOnly (ref), u22 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u22.camstart, false);
        end);
    end);
    task.delay(15.6 - u7, function() -- Line: 648
        -- upvalues: Folder (copy), ParticleOnly (ref), u23 (copy), VfxManager (ref), BeamOnly (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.enabledblackflash, true);
        task.delay(3, function() -- Line: 654
            -- upvalues: Folder (ref), ParticleOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            ParticleOnly(u23.enabledblackflash, false);
        end);
        task.wait(0.03333333333333333);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.blackflashemit);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u23.beambackground2, true);
        task.delay(4, function() -- Line: 675
            -- upvalues: Folder (ref), BeamOnly (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            BeamOnly(u23.beambackground2, false);
        end);
    end);
    task.delay(0.867 - u7, function() -- Line: 684
        -- upvalues: Folder (copy), u23 (copy), HumanoidRootPart (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, 2.1289520263671875, -7.552416801452637) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
        TweenService:Create(u23.blmack, TweenInfo.new(0.783, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, 2.1289520263671875, 4.2263994216918945) * CFrame.fromEulerAnglesYXZ(-0, 0, 0)
        }):Play();
        task.wait(0.8);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, -50.444908142089844, 4.2263994216918945) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);
    task.delay(5.017 - u7, function() -- Line: 702
        -- upvalues: Folder (copy), u23 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, 2.1158528327941895, 15.733033180236816) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);
    task.delay(7.933 - u7, function() -- Line: 709
        -- upvalues: Folder (copy), u23 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, 2.115851402282715, 42.161834716796875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);
    task.delay(10.683 - u7, function() -- Line: 716
        -- upvalues: Folder (copy), u23 (copy), u15 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, child in u23.blmack:GetChildren() do
            if child:IsA("BasePart") or child:IsA("Part") then
                child.Transparency = 1;
            end;
        end;

        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder == nil then
            MapFolder = workspace:FindFirstChild("Map2");
        end;

        for _, v in { workspace.Courts2, MapFolder } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or descendant:IsA("Decal")) then
                    table.insert(u15, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                end;
            end;

            if workspace:FindFirstChild("Barriers") and workspace:FindFirstChild("Barriers"):FindFirstChild("Ground") then
                local v25 = { workspace:FindFirstChild("Barriers"):FindFirstChild("Ground"), workspace:FindFirstChild("Barriers"):FindFirstChild("Ground").Transparency };
                table.insert(u15, v25);
                workspace:FindFirstChild("Barriers"):FindFirstChild("Ground").Transparency = 1;
            end;
        end;
    end);
    task.delay(10.7 - u7, function() -- Line: 751
        -- upvalues: Folder (copy), u23 (copy), HumanoidRootPart (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.starsandblackhole.starsandblackhole.CFrame = HumanoidRootPart.CFrame * CFrame.new(26.537023544311523, 12.061635971069336, -25.631439208984375) * CFrame.fromEulerAnglesYXZ(-1.5145390033721924, 0.25337809324264526, -0.23470880091190338);
        u23.blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, 2.1158523559570312, -5.39116096496582) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
        TweenService:Create(u23.blmack, TweenInfo.new(0.867, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, 2.1158528327941895, -3.7013168334960938) * CFrame.fromEulerAnglesYXZ(-0, 0, 0)
        }):Play();
        task.wait(0.867);
        TweenService:Create(u23.blmack, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, 2.1158528327941895, -4.676084518432617) * CFrame.fromEulerAnglesYXZ(-0, 0, 0)
        }):Play();
    end);
    task.delay(15.35 - u7, function() -- Line: 766
        -- upvalues: Folder (copy), u23 (copy), HumanoidRootPart (copy), u15 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.starsandblackhole.starsandblackhole.CFrame = HumanoidRootPart.CFrame * CFrame.new(25.420063018798828, -67.05760192871094, -29.944917678833008) * CFrame.fromEulerAnglesYXZ(-1.5145411491394043, 0.25337347388267517, -0.2347141057252884);
        u23.blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.912647247314453, -37.749298095703125, -4.676057815551758) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);

        for _, v in u15 do
            local v26, v27 = unpack(v);
            v26.Transparency = v27;
        end;
    end);
    task.delay(15.65 - u7, function() -- Line: 780
        -- upvalues: Folder (copy), u23 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(5.619481086730957, 33.725502014160156, -78.40766906738281) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);

    local function v30() -- Line: 788
        -- upvalues: u14 (ref), Folder (copy), VfxManager (ref), u15 (ref), u16 (copy), u24 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        for _, v in u15 do
            local v28, v29 = unpack(v);
            v28.Transparency = v29;
        end;

        if u16 then
            VfxManager.DestroyEffect(u16, 2);
        end;

        if u24 then
            u24:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u14 = nil;
        u15 = nil;
    end;

    table.insert(u14, Folder.AttributeChanged:Connect(v30));
    table.insert(u14, Folder.Destroying:Connect(v30));
end;