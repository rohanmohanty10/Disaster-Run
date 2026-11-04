  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris = workspace:FindFirstChild("Debris");

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3)
    local function emit(u4) -- Line: 28
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDelay");
            local Attribute2 = u4:GetAttribute("EmitCount");

            if Attribute2 and Attribute2 ~= 0 then
                if Attribute and Attribute ~= 0 then
                    task.delay(Attribute, function() -- Line: 35
                        -- upvalues: u4 (copy), Attribute2 (copy)
                        u4:Emit(Attribute2);
                    end);

                    return;
                end;

                u4:Emit(Attribute2);
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p3:IsA("ParticleEmitter") or (p3:IsA("Beam") or p3:IsA("Trail")) then
        emit(p3);

        return;
    end;

    for _, descendant in p3:GetDescendants() do
        emit(descendant);
    end;
end;

local function Destroy_Effect(u5: any, p6: number) -- Line: 66
    task.delay(p6, function() -- Line: 68
        -- upvalues: u5 (copy)
        if typeof(u5) == "table" then
            for _, v in u5 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
end;

local function tweenbeam(u7, u8, u9, u10, u11, p12) -- Line: 84
    -- upvalues: RunService (copy), TweenService (copy)
    local u13 = nil;
    local os_clock_ret = os.clock();
    local u14 = nil;
    u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 88
        -- upvalues: u13 (ref), os_clock_ret (copy), u11 (copy), TweenService (ref), u9 (ref), u8 (copy), u10 (copy), u7 (copy), u14 (ref)
        u13 = (os.clock() - os_clock_ret) / u11;
        u13 = TweenService:GetValue(u13, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        u9 = u8 + (u10 - u8) * u13;
        u7.Transparency = NumberSequence.new(u9, u9);

        if u11 <= os.clock() - os_clock_ret then
            u14:Disconnect();
        end;
    end);
    table.insert(p12, u14);
end;

local function tweenColor(u16, p17) -- Line: 102
    -- upvalues: RunService (copy), TweenService (copy)
    local u18 = nil;
    local os_clock_ret = os.clock();
    local Start = p17.Start;
    local Goal = p17.Goal;
    local Duration = p17.Duration;
    local Conns = p17.Conns;
    local u19 = 0;
    local u20 = 0;
    local u21 = 0;
    local u22 = Start[1];
    local u23 = Start[2];
    local u24 = Start[3];
    local u25 = Goal[1];
    local u26 = Goal[2];
    local u27 = Goal[3];
    local u28 = nil;
    u28 = RunService.Heartbeat:Connect(function(p29) -- Line: 114
        -- upvalues: u18 (ref), os_clock_ret (copy), Duration (copy), TweenService (ref), u19 (ref), u22 (copy), u25 (copy), u20 (ref), u23 (copy), u26 (copy), u21 (ref), u24 (copy), u27 (copy), u16 (copy), u28 (ref)
        u18 = (os.clock() - os_clock_ret) / Duration;
        u18 = TweenService:GetValue(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        u19 = u22 + (u25 - u22) * u18;
        u20 = u23 + (u26 - u23) * u18;
        u21 = u24 + (u27 - u24) * u18;

        if u16:IsA("ColorCorrectionEffect") then
            u16.TintColor = Color3.fromRGB(u19, u20, u21);
        elseif u16.Color then
            if typeof(u16.Color) == "ColorSequence" then
                u16.Color = ColorSequence.new(Color3.fromRGB(u19, u20, u21), Color3.fromRGB(u19, u20, u21));
            else
                u16.Color = Color3.fromRGB(u19, u20, u21);
            end;
        end;

        if Duration <= os.clock() - os_clock_ret then
            u28:Disconnect();
        end;
    end);
    table.insert(Conns, u28);
end;

local function Weld(p30, p31) -- Line: 142
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p30;
    WeldConstraint.Part1 = p31;
    WeldConstraint.Parent = p30;

    return WeldConstraint;
end;

return function(u32) -- Line: 149
    -- upvalues: SpectatorController (copy), SoundManager (copy), Players (copy), Debris (copy), TweenService (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = u32.Char;
    Char:FindFirstChild("PlrFootball"):FindFirstChild("BallAnims"):FindFirstChild("BALL");
    local u33 = script.Name .. " VFX FOLDER " .. Char.Name;

    if u32.Task ~= "Cutscene" then
        local v34 = u32.Task == "Cleanup" and Debris:FindFirstChild(u33);

        if v34 then
            v34:Destroy();
            v34:SetAttribute("Active", nil);
        end;

        return;
    end;

    if not Char then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u35 = {};
    local u36 = {};
    local u37 = SoundManager.SpawnSound("kaiser shot final", 0.7, workspace, 150);
    local Vignette = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
    Char:FindFirstChild("PlrFootball"):FindFirstChild("BallAnims"):FindFirstChild("BALL");
    local Folder = Instance.new("Folder");
    Folder.Name = u33;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(8.5, function() -- Line: 177
        -- upvalues: Folder (copy)
        if Folder and Folder:GetAttribute("Active") then
            Folder:SetAttribute("Active", nil);
        end;
    end);

    if Vignette then
        for _, v in {
            Vignette.Vignette,
            Vignette.Vignette.LL,
            Vignette.Vignette.UR,
            Vignette.Vignette.LL.LR
        } do
            local v38 = TweenService:Create(v, TweenInfo.new(2.566666666666667, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(255, 107, 228)
            });
            v38:Play();
            table.insert(u36, v38);
            task.delay(2.6666666666666665, function() -- Line: 192
                -- upvalues: Folder (copy), Debris (ref), u33 (copy), TweenService (ref), v (copy), u36 (ref)
                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v39 = TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0
                });
                v39:Play();
                table.insert(u36, v39);
                task.wait(0.016666666666666666);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v40 = TweenService:Create(v, TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(50, 133, 255)
                });
                v40:Play();
                table.insert(u36, v40);
            end);
        end;
    end;

    local u41 = script["Screen Cover"]:Clone();
    u41.Parent = Vignette;
    u41.BackgroundTransparency = 1;
    task.delay(8.5, function() -- Line: 68
        -- upvalues: u41 (copy)
        if typeof(u41) == "table" then
            for _, v in u41 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u41 then
            u41:Destroy();
        end;
    end);
    task.delay(5.65, function() -- Line: 216
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u41 (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u41.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        TweenService:Create(u41, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.11666666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u41, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 1
        }):Play();
    end);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local _ = workspace_CurrentCamera.FieldOfView;
    local u42 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.05), {
        FieldOfView = 40
    });
    u42:Play();
    task.delay(5.7491666666666665, function() -- Line: 235
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u42 (ref), TweenService (ref), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u42 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
            FieldOfView = 70
        });
        u42:Play();
        task.wait(0.016666666666666666);

        if Folder:GetAttribute("Active") and Debris:FindFirstChild(u33) ~= nil then
        end;
    end);
    local camera = workspace:FindFirstChild("NagiCam"):FindFirstChild("camera");
    local u43 = script.CC:Clone();
    u43.Parent = game.Lighting;
    task.delay(8.5, function() -- Line: 68
        -- upvalues: u43 (copy)
        if typeof(u43) == "table" then
            for _, v in u43 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u43 then
            u43:Destroy();
        end;
    end);
    TweenService:Create(u43, TweenInfo.new(3, Enum.EasingStyle.Linear), {
        Brightness = 0.01
    }):Play();
    TweenService:Create(u43, TweenInfo.new(3.216666666666667, Enum.EasingStyle.Linear), {
        Contrast = 0
    }):Play();
    task.delay(2.816666666666667, function() -- Line: 263
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u43 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u43.Enabled = true;
    end);
    local u44 = script.camera:Clone();
    u44.CFrame = camera.CFrame;
    u44.Parent = Folder;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u44;
    WeldConstraint.Part1 = camera;
    WeldConstraint.Parent = u44;
    task.delay(8.5, function() -- Line: 68
        -- upvalues: u44 (copy)
        if typeof(u44) == "table" then
            for _, v in u44 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u44 then
            u44:Destroy();
        end;
    end);
    EnableVFX(u44.START, true);

    for _, v in {
        u44.START.AT,
        u44.START["ENABL\'E"],
        u44.START.START,
        u44.star.Beam
    } do
        if v.Name == "AT" then
            TweenService:Create(v, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), {
                TextureSpeed = 19
            }):Play();
        elseif v.Name == "Beam" then
            TweenService:Create(v, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), {
                TextureSpeed = 45
            }):Play();
        else
            TweenService:Create(v, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), {
                TextureSpeed = 15
            }):Play();
        end;
    end;

    task.delay(0.13333333333333333, function() -- Line: 288
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u44 (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44["ENABLE AT START"].Enabled = true;
        u44["ENABLE AT STARTT"].Enabled = true;
        task.wait(0.05);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u44.START, true);
        EnableVFX(u44.star, true);

        for _, v in {
            u44.START.AT,
            u44.START["ENABL\'E"],
            u44.START.START,
            u44.star.Beam
        } do
            TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
                Width0 = 0,
                Width1 = 0,
                TextureSpeed = 1
            }):Play();
        end;

        task.wait(0.35);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u44.START, false);
        EnableVFX(u44.star, false);
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44["ENABLE AT START"].Enabled = false;
        u44["ENABLE AT STARTT"].Enabled = false;
    end);
    task.delay(5.75, function() -- Line: 317
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u44 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44["LINES OF ACTION"]["CUT ACTION!"].Enabled = true;
        task.wait(1.5833333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44["LINES OF ACTION"]["CUT ACTION!"].Enabled = false;
    end);
    local u45 = script.CutsceneVFX:Clone();
    u45:PivotTo(HumanoidRootPart.CFrame);
    u45.Parent = Folder;
    local u46 = script["Right Leg"]:Clone();
    u46.CFrame = Char:FindFirstChild("Right Leg").CFrame;
    u46.Parent = Folder;
    local v47 = Char:FindFirstChild("Right Leg");
    local WeldConstraint2 = Instance.new("WeldConstraint");
    WeldConstraint2.Part0 = u46;
    WeldConstraint2.Part1 = v47;
    WeldConstraint2.Parent = u46;
    task.delay(0.4666666666666667, function() -- Line: 337
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u45 (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u45["Kaiser Feet"].Attachment.Leaf:Emit(14);
        u45["Kaiser Feet"].Attachment.Leaf.TimeScale = 14;
        TweenService:Create(u45["Kaiser Feet"].Attachment.Leaf, TweenInfo.new(0.3), {
            TimeScale = 0
        }):Play();
        task.delay(1.1666666666666667, function() -- Line: 344
            -- upvalues: Folder (ref), Debris (ref), u33 (ref), TweenService (ref), u45 (ref)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            TweenService:Create(u45["Kaiser Feet"].Attachment.Leaf, TweenInfo.new(0.25), {
                TimeScale = 1
            }):Play();
        end);
        u45["Kaiser Feet"].s.Smoke:Emit(5);
        u45["Kaiser Feet"].s.smokey:Emit(5);
        u45["Kaiser Feet"].s.CreGround2:Emit(3);
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u45["Kaiser Feet"].Attachment.Cre1:Emit(2);
        u45["Kaiser Feet"].Attachment.leaf1:Emit(12);
        u45["Kaiser Feet"].Attachment.Saket:Emit(4);
        u45["Kaiser Feet"].Attachment.dir:Emit(4);
    end);
    task.delay(1.55, function() -- Line: 362
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u46 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u46, true);
        task.wait(1.9833333333333334);
        EnableVFX(u46, false);
    end);
    task.delay(2.25, function() -- Line: 372
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u44 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for i = 1, 8 do
            local v48;

            if u44:FindFirstChild((tostring(i))) then
                local u49 = u44:FindFirstChild((tostring(i)));
                u49.Enabled = true;
                task.delay(0.5166666666666667, function() -- Line: 381
                    -- upvalues: Folder (ref), Debris (ref), u33 (ref), u49 (copy)
                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    u49.Enabled = false;
                end);
                v48 = i;
            else
                v48 = i;
            end;
        end;
    end);
    task.delay(2.9, function() -- Line: 391
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u32 (copy), VfxManager (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        local v50 = script.End:Clone();
        v50.Parent = workspace;
        v50.CFrame = u32.Char.HumanoidRootPart.CFrame;
        VfxManager.Emit(v50);
    end);
    task.delay(2.6333333333333333, function() -- Line: 404
        -- upvalues: Folder (copy), Debris (ref), u33 (copy)
        if Folder:GetAttribute("Active") and Debris:FindFirstChild(u33) ~= nil then
        end;
    end);
    task.delay(2.7666666666666666, function() -- Line: 451
        -- upvalues: Folder (copy), Debris (ref), u33 (copy)
        if Folder:GetAttribute("Active") and Debris:FindFirstChild(u33) ~= nil then
        end;
    end);
    task.delay(5.15, function() -- Line: 456
        -- upvalues: Folder (copy), Debris (ref), u33 (copy)
        if Folder:GetAttribute("Active") and Debris:FindFirstChild(u33) ~= nil then
        end;
    end);
    task.delay(5.466666666666667, function() -- Line: 463
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u45 (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u45["Kaiser Feet"].s["eND sMOKE"]:Emit(9);
        u45["Kaiser Feet"].s["eND sMOKE"].TimeScale = 1;
        TweenService:Create(u45["Kaiser Feet"].s["eND sMOKE"], TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
            TimeScale = 0
        }):Play();
        task.delay(0.25, function() -- Line: 469
            -- upvalues: u45 (ref)
            u45["Kaiser Feet"].s["eND sMOKE"]:Emit(9);
        end);
    end);
    task.delay(4.333333333333333, function() -- Line: 476
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u45 (copy), HumanoidRootPart (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, child in u45.Root:GetChildren() do
            if child.Name ~= "emit" and child.Name ~= "rose" then
                EnableVFX(child, true);
            end;
        end;

        task.wait(1.4666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        local v51 = script.CutsceneBG:Clone();
        v51:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 1.8, 0) * CFrame.Angles(0, -1.5707963267948966, 0));
        v51.Parent = Folder;
        v51.Field.Flower.ParticleEmitter:Emit(200);
        task.delay(1, function() -- Line: 502
            -- upvalues: Folder (ref), Debris (ref), u33 (ref), TweenService (ref), u45 (ref)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            TweenService:Create(u45["Kaiser Feet"].s["eND sMOKE"], TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), {
                TimeScale = 1
            }):Play();
        end);
    end);

    local function v55() -- Line: 510
        -- upvalues: u35 (ref), Folder (copy), u36 (ref), u43 (copy), u41 (copy), u37 (copy), TweenService (ref), Vignette (copy)
        for _, v in u35 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            local u52 = Folder;
            task.delay(4, function() -- Line: 68
                -- upvalues: u52 (copy)
                if typeof(u52) == "table" then
                    for _, v in u52 do
                        if v then
                            v:Destroy();
                        end;
                    end;

                    return;
                end;

                if u52 then
                    u52:Destroy();
                end;
            end);
            EnableVFX(Folder, false);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or (descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal")))) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        for _, v in u36 do
            v:Pause();
        end;

        if u43 then
            u43:Destroy();
        end;

        if u41 then
            u41:Destroy();
        end;

        if u37 then
            local v53 = TweenService:Create(u37, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Volume = 0
            });
            v53:Play();
            v53.Completed:Once(function() -- Line: 546
                -- upvalues: u37 (ref)
                u37:Destroy();
            end);
        end;

        task.spawn(function() -- Line: 552
            -- upvalues: Vignette (ref)
            for i = 1, 4 do
                local v54;

                if Vignette then
                    v54 = i;

                    for _, v in {
                        Vignette.Vignette,
                        Vignette.Vignette.LL,
                        Vignette.Vignette.UR,
                        Vignette.Vignette.LL.LR
                    } do
                        v.ImageTransparency = 1;
                    end;
                else
                    v54 = i;
                end;

                task.wait(0.05);
            end;
        end);
        table.clear(u36);
        table.clear(u35);
        u35 = nil;
        u36 = nil;
    end;

    table.insert(u35, Folder.Destroying:Connect(v55));
    table.insert(u35, Folder.AttributeChanged:Connect(v55));
end;