 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Teams = game:GetService("Teams");
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");
local u1 = {};
local u2 = {};

local function HideCharacter(p3: userdata, p4: userdata) -- Line: 22
    local u5 = {};

    for _, descendant in p3:GetDescendants() do
        if not (p4 and descendant:IsDescendantOf(p4)) then
            if descendant:IsA("BasePart") then
                u5[descendant] = {
                    Transparency = descendant.Transparency
                };
                descendant.Transparency = 1;
            elseif descendant:IsA("SurfaceGui") then
                u5[descendant] = {
                    Enabled = descendant.Enabled
                };
                descendant.Enabled = false;
            elseif descendant:IsA("Decal") then
                u5[descendant] = {
                    Transparency = descendant.Transparency
                };
                descendant.Transparency = 1;
            elseif descendant:IsA("ParticleEmitter") then
                u5[descendant] = {
                    Enabled = descendant.Enabled,
                    Rate = descendant.Rate,
                    EmitCount = descendant:GetAttribute("EmitCount")
                };
                descendant:SetAttribute("EmitCount", 0);
                descendant.Rate = 0;
                descendant.Enabled = false;
            end;
        end;
    end;

    return function() -- Line: 56
        -- upvalues: u5 (copy)
        for i, v in u5 do
            if i ~= nil then
                local v6 = i;

                for i2, v2 in v do
                    if i2 == "EmitCount" then
                        v6:SetAttribute("EmitCount", v2);
                    else
                        v6[i2] = v2;
                    end;
                end;
            end;
        end;

        table.clear(u5);
    end;
end;

local u7 = require("@self/SkeletonHand");
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IncludeInstances = { workspace.Courts2.Court };

return function(u8, p9) -- Line: 76
    -- upvalues: Players (copy), u1 (copy), Trove (copy), VfxManager (copy), Debris (copy), RunService (copy), workspace_CurrentCamera (copy), Essentials (copy), LocalPlayer (copy), SfxManager (copy), CameraShaker (copy), TweenService (copy), u2 (copy), Lighting (copy), Teams (copy), HideCharacter (copy), RaycastParams_new_ret (copy), u7 (copy)
    local TimeSent = p9.TimeSent;
    local v10 = workspace:GetServerTimeNow() - TimeSent;
    local CameraController = u8.CameraController;
    local Character = p9.Character;
    local v11 = Players:FindFirstChild(Character.Name);
    local Humanoid = Character:FindFirstChild("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if p9.Task ~= "Fear Aura Start" then
        if p9.Task == "Fear Aura Cleanup" then
            if u1[Character.Name] then
                u1[Character.Name]:Clean();
                u1[Character.Name] = nil;
            end;

            local v12 = Debris:FindFirstChild(Character.Name .. script.Name .. "Zone");

            if v12 then
                local v13 = v12:Clone();
                v13.Parent = Debris;
                TweenService:Create(v13, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                VfxManager.DestroyEffect(v13, 0.25);
                local v14 = v13:FindFirstChildOfClass("Sound");

                if v14 then
                    v14:Destroy();
                end;

                local v15 = v12:FindFirstChildOfClass("Sound");

                if v15 then
                    v15.Parent = v13;
                    TweenService:Create(v15, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Volume = 0
                    }):Play();
                end;

                v12:Destroy();

                return;
            end;
        else
            if p9.Task == "Cut The Lights Start" then
                if not u2[Character.Name] then
                    u2[Character.Name] = Trove.new();
                end;

                u2[Character.Name]:Add(SfxManager:playSound({
                    Sound = "BBZ Ghost Cut The Lights",
                    Parent = workspace
                }));
                local u16 = script.CourtAura:Clone();
                u16.Name = script.Name;
                u16.Parent = Debris;
                u16.CFrame = CFrame.new(0, 1 + u16.Size.Y / 2, -297.5) * CFrame.new(0, 1.5707963267948966, 0);
                local u17 = script.FakeAtmo:Clone();
                u17.Parent = Lighting;
                local u18 = {};
                local u19 = {};

                if v11 and v11.Team ~= LocalPlayer.Team then
                    u17.Density = 1;

                    for _, v in pairs(Players:GetPlayers()) do
                        if v ~= LocalPlayer and (v.Team ~= Teams.Visitor and (v.Character and v.Character:FindFirstChild("Humanoid"))) then
                            local Character2 = v.Character;
                            local Humanoid2 = Character2.Humanoid;

                            for _, child in pairs(Character2:GetChildren()) do
                                if (child:IsA("Highlight") or child:IsA("BillboardGui")) and child.Enabled then
                                    table.insert(u18, child);
                                    child.Enabled = false;
                                end;
                            end;

                            table.insert(u19, Humanoid2);
                            Humanoid2.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                        end;
                    end;
                end;

                u2[Character.Name]:Add(function() -- Line: 313
                    -- upvalues: u16 (copy), VfxManager (ref), u18 (copy), u19 (copy), u17 (copy)
                    if u16 then
                        for _, descendant in pairs(u16:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;

                        VfxManager.DestroyEffect(u16, 4);
                    end;

                    for _, v in pairs(u18) do
                        v.Enabled = true;
                    end;

                    for _, v in pairs(u19) do
                        if not v:GetAttribute("Invisible") then
                            v.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                        end;
                    end;

                    u17:Destroy();
                end);
                local v20 = script.Emit:Clone();
                v20.Parent = Debris;
                v20.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -2.5, 0);
                VfxManager.Emit(v20);
                VfxManager.DestroyEffect(v20, 2);
                task.delay(10, function() -- Line: 341
                    -- upvalues: u2 (ref), Character (copy)
                    if u2[Character.Name] then
                        u2[Character.Name]:Clean();
                        u2[Character.Name] = nil;
                    end;
                end);

                return;
            end;

            if p9.Task == "Cut The Lights Cleanup" then
                if u2[Character.Name] then
                    u2[Character.Name]:Clean();
                    u2[Character.Name] = nil;

                    return;
                end;
            else
                if p9.Task == "Fear Aura New Start" then
                    local math_max_ret = math.max(1 - v10, 0);

                    if math_max_ret <= 0.1 then
                        return;
                    end;

                    warn(math_max_ret);
                    SfxManager:playSound({
                        Sound = "BBZ Ghost Fear Aura",
                        Parent = HumanoidRootPart
                    });
                    local v21 = HideCharacter(Character);
                    task.delay(math_max_ret, v21);
                    local u22 = script.Fear.Part:Clone();
                    local u23 = u22:QueryDescendants("ParticleEmitter");

                    for _, v in u23 do
                        v.Enabled = true;
                    end;

                    task.delay(math_max_ret, function() -- Line: 375
                        -- upvalues: u23 (copy), u22 (copy)
                        for _, v in u23 do
                            v.Enabled = false;
                        end;

                        task.delay(2, u22.Destroy, u22);
                    end);
                    local u24 = script.Fear.Trail:Clone();
                    u24.Parent = HumanoidRootPart;
                    task.delay(math_max_ret, function() -- Line: 385
                        -- upvalues: VfxManager (ref), u24 (copy)
                        VfxManager.Enable(u24, false);
                        task.delay(1, u24.Destroy, u24);
                    end);
                    local u25 = script.Fear.ball:Clone();
                    u25.CFrame = Character.PlrBall.Anims.BALL.CFrame;
                    Essentials:Weld(u25, Character.PlrBall.Anims.BALL);
                    u25.Parent = Debris;
                    task.delay(math_max_ret, function() -- Line: 395
                        -- upvalues: u25 (copy)
                        for _, v in u25:QueryDescendants("ParticleEmitter") do
                            v.Enabled = false;
                        end;

                        task.delay(2, u25.Destroy, u25);
                    end);
                    u22.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.12784576, 0, 1, 0, 0, 0, 0, -1, 0, 1, 0);
                    Essentials:Weld(u22, HumanoidRootPart);
                    u22.Parent = Debris;

                    return;
                end;

                if p9.Task == "Cut The Lights New Start" then
                    local HumanoidRootPart2 = p9.Target.HumanoidRootPart;
                    local v26 = workspace:Raycast(HumanoidRootPart2.Position, Vector3.new(-0, -100, -0), RaycastParams_new_ret);
                    local v27 = v26 and v26.Position or (HumanoidRootPart2.CFrame * CFrame.new(0, -3, 0)).Position;
                    local Attachment = Instance.new("Attachment");
                    Attachment.WorldPosition = v27;
                    Attachment.Parent = workspace.Terrain;
                    local v28 = SfxManager:playSound({
                        Sound = "BBZ Ghost From The Dead",
                        Parent = Attachment
                    });

                    if v28 then
                        v28.Destroying:Once(function() -- Line: 416
                            -- upvalues: Attachment (copy)
                            Attachment:Destroy();
                        end);
                    else
                        Attachment:Destroy();
                    end;

                    u7(game.Players:GetPlayerFromCharacter(Character), v27, Character.HumanoidRootPart.Position, 1);
                end;
            end;
        end;

        return;
    end;

    if not u1[Character.Name] then
        u1[Character.Name] = Trove.new();
    end;

    local Highlight = Instance.new("Highlight", Character);
    Highlight.Name = script.Name .. "Highlight";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(29, 255, 138);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    VfxManager.DestroyEffect(Highlight, 5);
    local u29 = script.Camera_VFX:Clone();
    u29.Parent = Debris;
    u1[Character.Name]:Add(RunService.RenderStepped:Connect(function() -- Line: 106
        -- upvalues: u29 (copy), Debris (ref), workspace_CurrentCamera (ref)
        if not (u29 and u29:IsDescendantOf(Debris)) then
            return;
        end;

        u29.PrimaryPart.CFrame = workspace_CurrentCamera.CFrame;
    end));
    local u30 = {};
    local u31 = {};

    for _, descendant in pairs(u29:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            table.insert(u30, descendant);
            u31[descendant] = {};
            local v32 = descendant;

            for i, v in ipairs(descendant.Transparency.Keypoints) do
                u31[v32][i] = {
                    Start = v.Value,
                    Needed = 1 - v.Value
                };
            end;
        end;
    end;

    local u33 = u1[Character.Name]:Add(Instance.new("NumberValue"));
    u33.Changed:Connect(function() -- Line: 132
        -- upvalues: u30 (copy), u31 (copy), u33 (copy)
        for _, v in pairs(u30) do
            local v34 = v;
            local v35 = {};

            for i, v2 in ipairs(v.Transparency.Keypoints) do
                table.insert(v35, NumberSequenceKeypoint.new(v2.Time, u31[v34][i].Start + u31[v34][i].Needed * u33.Value));
            end;

            v34.Transparency = NumberSequence.new(v35);
        end;
    end);
    u33.Value = 1;
    local v36 = script.Zone:Clone();
    v36.Name = Character.Name .. script.Name .. "Zone";
    v36.Parent = Debris;
    v36.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v36, HumanoidRootPart);
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u37 = 1;

    if v11 and v11.Team ~= LocalPlayer.Team then
        local u38 = SfxManager:playSound({
            Sound = "BBZ Ghost Fear Aura Enemy",
            Parent = workspace
        });
        u38.Volume = 0;
        local v40 = RunService.Heartbeat:Connect(function(p39) -- Line: 159
            -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy), u8 (copy), FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref), u37 (ref), u33 (copy), Humanoid (copy), Highlight (copy), u38 (copy), CameraController (copy), CameraShaker (ref)
            if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
                return;
            end;

            local Magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

            if Magnitude < 40 then
                u8.CameraController.FOVActive = false;
                LocalPlayer:SetAttribute("FearSlow", math.clamp(Magnitude, 0, 40) / 40 * 3 + 1);
                FieldOfView = Essentials:Lerp(FieldOfView, 40, p39 * 5);
                workspace_CurrentCamera.FieldOfView = FieldOfView;
                u37 = math.clamp(Magnitude, 0, 40) / 40;
                u33.Value = u37;
                Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;

                if Highlight then
                    Highlight.OutlineTransparency = 1 - u37;
                end;

                u38.Volume = 1 - u37;

                if Magnitude < 20 then
                    CameraController.CamShake:Shake(CameraShaker.Presets.Bump);
                end;
            else
                u8.CameraController.FOVActive = true;
                LocalPlayer:SetAttribute("FearSlow", nil);
                FieldOfView = workspace_CurrentCamera.FieldOfView;
                u37 = 1;
                u33.Value = u37;
                Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;

                if Highlight then
                    Highlight.OutlineTransparency = 1 - u37;
                end;

                u38.Volume = 1 - u37;
            end;
        end);
        u1[Character.Name]:Add(v40);
    else
        SfxManager:playSound({
            Sound = "BBZ Ghost Fear Aura Player",
            Parent = v36
        });
    end;

    u1[Character.Name]:Add(function() -- Line: 205
        -- upvalues: u30 (copy), VfxManager (ref), u29 (copy), Humanoid (copy), Highlight (copy), u8 (copy), LocalPlayer (ref)
        for _, v in pairs(u30) do
            v.Enabled = false;
        end;

        VfxManager.DestroyEffect(u29, 2);
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
        Highlight:Destroy();
        u8.CameraController.FOVActive = true;
        LocalPlayer:SetAttribute("FearSlow", nil);
    end);
    TweenService:Create(v36, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 0
    }):Play();
    task.wait(0.25);

    if LocalPlayer.Character == Character then
        VfxManager.DestroyEffect(v36, 5);
        TweenService:Create(v36, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(40, 40, 40)
        }):Play();

        while v36 and v36:IsDescendantOf(Debris) do
            TweenService:Create(v36, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.75
            }):Play();
            task.wait(0.5);
            TweenService:Create(v36, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 0
            }):Play();
            task.wait(0.5);
        end;
    else
        VfxManager.DestroyEffect(v36, 0.5);
        TweenService:Create(v36, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end;

    task.delay(5, function() -- Line: 242
        -- upvalues: u1 (ref), Character (copy)
        if u1[Character.Name] then
            u1[Character.Name]:Clean();
            u1[Character.Name] = nil;
        end;
    end);
end;