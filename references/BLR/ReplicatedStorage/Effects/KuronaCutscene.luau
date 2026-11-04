  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v.Enabled = p2 or false;
        end;
    end;
end;

function Emit_All_With_Duration(p3)
    local function emit(u4) -- Line: 25
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDuration");
            local Attribute2 = u4:GetAttribute("EmitDelay");
            local Attribute3 = u4:GetAttribute("EmitCount");

            if Attribute and Attribute ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 33
                        -- upvalues: u4 (copy), Attribute (copy)
                        u4.Enabled = true;
                        task.delay(Attribute, function() -- Line: 36
                            -- upvalues: u4 (ref)
                            u4.Enabled = false;
                        end);
                    end);

                    return;
                end;

                u4.Enabled = true;
                task.delay(Attribute, function() -- Line: 43
                    -- upvalues: u4 (copy)
                    u4.Enabled = false;
                end);

                return;
            end;

            if Attribute3 and Attribute3 ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 50
                        -- upvalues: u4 (copy), Attribute3 (copy)
                        u4:Emit(Attribute3);
                    end);

                    return;
                end;

                u4:Emit(Attribute3);
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

local function Destroy_Effect(u5: any, p6: number) -- Line: 82
    task.delay(p6, function() -- Line: 84
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

local function Weld(p7, p8) -- Line: 100
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p7;
    WeldConstraint.Part1 = p8;
    WeldConstraint.Parent = p7;

    return WeldConstraint;
end;

return function(p9) -- Line: 107
    -- upvalues: CutsceneUtils (copy), ReplicatedStorage (copy), SpectatorController (copy), SoundManager (copy), TweenService (copy)
    if p9.Task == "Cleanup" then
        CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
        local KuronaCutscene = workspace.Debris:FindFirstChild("KuronaCutscene");

        if KuronaCutscene then
            KuronaCutscene:Destroy();
        end;

        local v10 = ReplicatedStorage.Maps:FindFirstChildOfClass("Model");

        if v10 then
            v10.Parent = workspace.Maps;
        end;

        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p9.Char;
    local u11 = {};
    local u12 = {};
    local u13 = {};
    local u14 = {};
    local v15 = workspace.Maps:FindFirstChildOfClass("Model");

    if v15 then
        v15.Parent = ReplicatedStorage.Maps;
    end;

    for _, child in workspace:GetChildren() do
        if child.Name ~= p9.Char.Name then
            for _, descendant in child:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")))) then
                    table.insert(u14, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    table.insert(u14, { descendant, descendant.Transparency });
                    descendant.Transparency = NumberSequence.new(1, 1);
                end;
            end;
        end;
    end;

    for _, child in game.Lighting:GetChildren() do
        table.insert(u13, child);
        child.Parent = ReplicatedStorage;
    end;

    for _, child in script.stuff:GetChildren() do
        child:Clone().Parent = game.Lighting;
    end;

    local _ = game.Lighting.Ambient;
    local _ = game.Lighting.Brightness;
    local _ = game.Lighting.ColorShift_Bottom;
    local _ = game.Lighting.ColorShift_Top;
    local _ = game.Lighting.EnvironmentDiffuseScale;
    local _ = game.Lighting.EnvironmentSpecularScale;
    local _ = game.Lighting.OutdoorAmbient;
    local _ = game.Lighting.ShadowSoftness;
    local _ = game.Lighting.ClockTime;
    local _ = game.Lighting.GeographicLatitude;
    local _ = game.Lighting.ExposureCompensation;
    game.Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    game.Lighting.Brightness = 3;
    game.Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0);
    game.Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
    game.Lighting.EnvironmentDiffuseScale = 1;
    game.Lighting.EnvironmentSpecularScale = 1;
    game.Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    game.Lighting.ShadowSoftness = 0.2;
    game.Lighting.ClockTime = 12;
    game.Lighting.GeographicLatitude = 0;
    local Folder = Instance.new("Folder");
    Folder.Name = "KuronaCutscene";
    Folder.Parent = workspace.Debris;
    Folder:SetAttribute("Active", true);
    task.delay(8.25, function() -- Line: 188
        -- upvalues: Folder (copy)
        if Folder and Folder:GetAttribute("Active") then
            Folder:SetAttribute("Active", nil);
        end;
    end);

    for _, child in script.UserVFX:GetChildren() do
        if Char[child.Name] then
            local u16 = child:Clone();
            u16.CFrame = Char[child.Name].CFrame;
            u16.Parent = Folder;
            local v17 = Char[child.Name];
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = u16;
            WeldConstraint.Part1 = v17;
            WeldConstraint.Parent = u16;
            task.delay(8.25, function() -- Line: 84
                -- upvalues: u16 (copy)
                if typeof(u16) == "table" then
                    for _, v in u16 do
                        if v then
                            v:Destroy();
                        end;
                    end;

                    return;
                end;

                if u16 then
                    u16:Destroy();
                end;
            end);
            u11[u16.Name] = u16;
        end;
    end;

    SoundManager.SpawnSound("KuronaAwakening", 0.8, workspace, 150);
    local u18 = script.Rig:Clone();
    u18:PivotTo(p9.SpawnPos);
    u18.Parent = Folder;
    EnableVFX(u18, true);
    EnableVFX(u18.Stretch, false);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    workspace_CurrentCamera.FieldOfView = 40;
    local u19 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.4166666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 80
    });
    u19:Play();
    task.delay(1.4166666666666667, function() -- Line: 225
        -- upvalues: Folder (copy), TweenService (ref), workspace_CurrentCamera (copy), u19 (copy)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            FieldOfView = 30
        });
        u19:Play();
    end);
    task.delay(1.95, function() -- Line: 234
        -- upvalues: Folder (copy), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        workspace_CurrentCamera.FieldOfView = 30;
    end);
    task.delay(1.9833333333333334, function() -- Line: 239
        -- upvalues: Folder (copy), TweenService (ref), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            FieldOfView = 50
        }):Play();
    end);
    task.delay(2.5166666666666666, function() -- Line: 247
        -- upvalues: Folder (copy), u11 (ref)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        for _, v in u11 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Aura" then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end);
    task.delay(2.683333333333333, function() -- Line: 259
        -- upvalues: Folder (copy), TweenService (ref), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.0166666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 70
        }):Play();
    end);
    task.delay(2.95, function() -- Line: 267
        -- upvalues: Folder (copy), u18 (copy)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        Emit_All_With_Duration(u18.Stretch);
    end);
    task.delay(3.3, function() -- Line: 272
        -- upvalues: Folder (copy), u11 (ref)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        for _, v in u11 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Stretch" then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end);
    task.delay(3.7, function() -- Line: 287
        -- upvalues: Folder (copy), TweenService (ref), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.7666666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            FieldOfView = 40
        }):Play();
    end);
    task.delay(4.483333333333333, function() -- Line: 295
        -- upvalues: Folder (copy), workspace_CurrentCamera (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        workspace_CurrentCamera.FieldOfView = 40;
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.6166666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            FieldOfView = 30
        }):Play();
    end);
    task.delay(4.583333333333333, function() -- Line: 305
        -- upvalues: Folder (copy), u11 (ref)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        for _, v in u11 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Stretch" then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end);
    task.delay(6.016666666666667, function() -- Line: 318
        -- upvalues: Folder (copy), u11 (ref)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        for _, v in u11 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Eye" then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end);
    task.delay(6.116666666666666, function() -- Line: 331
        -- upvalues: Folder (copy), workspace_CurrentCamera (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        workspace_CurrentCamera.FieldOfView = 70;
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.6333333333333333, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            FieldOfView = 60
        }):Play();
    end);
    task.delay(7.833333333333333, function() -- Line: 341
        -- upvalues: Folder (copy), u11 (ref)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        for _, v in u11 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Aura" then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end);
    task.delay(8.25, function() -- Line: 354
        -- upvalues: Folder (copy), u11 (ref)
        if not Folder:GetAttribute("Active") then
            return;
        end;

        for _, v in u11 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Eye" then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end);

    local function v23() -- Line: 368
        -- upvalues: u12 (ref), Folder (copy), u13 (ref), u14 (copy), u11 (ref), u19 (copy), workspace_CurrentCamera (copy), FieldOfView (copy), CutsceneUtils (ref), ReplicatedStorage (ref)
        for _, v in u12 do
            v:Disconnect();
        end;

        if Folder then
            Folder:SetAttribute("Active", false);
            EnableVFX(Folder, false);
            task.delay(3, function() -- Line: 378
                -- upvalues: Folder (ref)
                if Folder then
                    Folder:Destroy();
                end;
            end);
        end;

        for _, child in game.Lighting:GetChildren() do
            child:Destroy();
        end;

        for _, v in u13 do
            v.Parent = game.Lighting;
        end;

        for _, v in u14 do
            local v20, v21 = unpack(v);
            v20.Transparency = v21;
        end;

        for _, v in u11 do
            EnableVFX(v, false);
            local u22 = u11;
            task.delay(3, function() -- Line: 84
                -- upvalues: u22 (copy)
                if typeof(u22) == "table" then
                    for _, v2 in u22 do
                        if v2 then
                            v2:Destroy();
                        end;
                    end;

                    return;
                end;

                if u22 then
                    u22:Destroy();
                end;
            end);
        end;

        if u19 then
            u19:Pause();
        end;

        workspace_CurrentCamera.FieldOfView = FieldOfView;
        table.clear(u12);
        table.clear(u13);
        table.clear(u11);
        u11 = nil;
        u12 = nil;
        u13 = nil;
        CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    end;

    table.insert(u12, Folder.Destroying:Connect(v23));
    table.insert(u12, Folder.AttributeChanged:Connect(v23));
end;