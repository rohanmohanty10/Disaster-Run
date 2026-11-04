  

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Parent = script.Parent.Parent.Parent;
local UtilityModules = Parent.UtilityModules;
local Assets = Parent.Assets;
local CoreRemotes = Parent.CoreRemotes;
local Trove = require(UtilityModules.Trove);
require(UtilityModules.t);
local FastSignal = require(Parent.UtilityModules.FastSignal);
local GlobalConfig = require(Parent.Components.GlobalConfig);
local SharedComponent = require(Parent.Components.SharedComponent);
local u1 = {};
u1.__index = u1;

function u1.Destroy(p2) -- Line: 61
    if p2._Destroyed then
        warn("Attempt to destroy an already destroyed object CharacterClass", debug.traceback());

        return;
    end;

    p2._Destroyed = true;
    p2.Trove:Destroy();
end;

function u1.GetDebugClone(p3: table, p4: any, p5: boolean?) -- Line: 70
    local v6 = "_DebugClone:" .. p4;

    if p3[v6] then
        return p3[v6], false;
    end;

    if p5 then
        return p3:CreateDebugClone(p4), true;
    end;
end;

function u1.DestroyDebugClone(p7, p8) -- Line: 78
    local v9 = "_DebugClone:" .. p8;

    if p7[v9] then
        p7.Trove:Remove(p7[v9]);
        p7[v9]:Destroy();
    end;

    p7[v9] = nil;
end;

local function findMatchingPart(p10, p11, p12, p13) -- Line: 87
    local v14 = p13 or {};

    for _, descendant in p10:GetDescendants() do
        if descendant.Name == p11 and (descendant.Parent and (descendant.Parent.Name == p12 or v14[p12])) then
            return descendant;
        end;
    end;

    return nil;
end;

function u1.UpdateDebugClonePose(p15, p16) -- Line: 99
    -- upvalues: GlobalConfig (copy), findMatchingPart (copy)
    local DebugClone = p15:GetDebugClone(p16, false);

    if not DebugClone then
        return;
    end;

    for _, descendant in DebugClone:GetDescendants() do
        if descendant:IsA("BasePart") and (GlobalConfig.BodyPartNames[descendant.Name] or GlobalConfig.AuxNames[descendant.Name]) then
            local v17 = p15.Character:FindFirstChild(descendant.Name) or findMatchingPart(p15.Character, descendant.Name, descendant.Parent.Name);

            if v17 then
                descendant.CFrame = v17.CFrame;
            end;
        end;
    end;
end;

function u1.CreateDebugClone(p18: table, p19: any, p20: table, p21: userdata) -- Line: 113
    -- upvalues: GlobalConfig (copy)
    local u22 = p18.Character:Clone();

    local function ProcessDecendant(p23) -- Line: 118
        -- upvalues: GlobalConfig (ref)
        local v24 = false;

        for i in GlobalConfig.WhitelistedClasses do
            if p23:IsA(i) then
                v24 = true;
                break;
            end;
        end;

        if not (GlobalConfig.BodyPartNames[p23.Name] or (GlobalConfig.AuxNames[p23.Name] or v24)) then
            p23:Destroy();

            return;
        end;

        if not p23:IsA("BasePart") then
            if p23:IsA("Decal") then
                p23.Transparency = math.max(p23.Transparency, 0.8);
            end;

            return;
        end;

        p23.Transparency = math.max(p23.Transparency, 0.99);
        p23.CanCollide = false;
        p23.CanTouch = false;
        p23.CanQuery = false;
        p23.Anchored = true;
    end;

    for _, descendant in pairs(u22:GetDescendants()) do
        ProcessDecendant(descendant);
    end;

    p18:UpdateDebugClonePose(p19);
    local v25 = u22:FindFirstChildOfClass("Humanoid");

    if v25 then
        v25:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true);
    end;

    u22.Name = p18.Character.Name .. "_DebugClone_" .. tick();

    if p20 == nil then
        for _, descendant in u22:GetDescendants() do
            if (GlobalConfig.BodyPartNames[descendant.Name] or descendant.Name == "Handle") and descendant:IsA("BasePart") then
                descendant.Transparency = 0.75;
            end;
        end;
    else
        local Highlight = Instance.new("Highlight");
        Highlight.FillColor = Color3.fromRGB(0, 255, 8);
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.FillTransparency = 0.5;
        Highlight.OutlineTransparency = 1;
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.Adornee = u22;
        Highlight.Parent = u22;

        for i, v in p20 do
            Highlight[i] = v;
        end;
    end;

    if p21 then
        p21:Once(function() -- Line: 184
            -- upvalues: u22 (copy)
            u22:Destroy();
        end);
    end;

    p18.CharacterDebugCloneAdded:Fire(u22);
    p18["_DebugClone:" .. p19] = u22;

    return u22;
end;

function u1.CreateVelocityVisualization(p26: table, p27: vector, p28: userdata) -- Line: 198
    -- upvalues: Assets (copy)
    if p27.Magnitude >= 0.1 then
        local u29 = Assets.Arrow:Clone();
        u29.Name = "VelocityVisualization";
        local Position = p26.HumanoidRootPart.Position;
        u29:PivotTo(CFrame.lookAt(Position, Position + p27.Unit));
        u29.Parent = workspace.CurrentCamera;

        if p28 then
            p28:Once(function() -- Line: 212
                -- upvalues: u29 (copy)
                u29:Destroy();
            end);
        end;

        p26.CharacterDebugVelocityAdded:Fire(u29);

        return u29;
    end;
end;

function u1.GetVelocity(p30) -- Line: 224
    -- upvalues: Players (copy), GlobalConfig (copy)
    if p30.Player == Players.LocalPlayer or not GlobalConfig.GloballyEnabled then
        return p30.HumanoidRootPart.AssemblyLinearVelocity;
    end;

    return p30.LastServerSnapshot.Velocity;
end;

function u1.GetPrivateRemotesFolder(p31) -- Line: 232
    if p31.PrivateRemotes then
        return p31.PrivateRemotes;
    end;

    return p31.Character:WaitForChild("PrivateRemotes");
end;

function u1.GetPrivateRemote(p32: table, p33: string) -- Line: 238
    return p32:GetPrivateRemotesFolder():WaitForChild(p33);
end;

function u1.new(u34) -- Line: 246
    -- upvalues: u1 (copy), Players (copy), Trove (copy), FastSignal (copy), SharedComponent (copy), CoreRemotes (copy), RunService (copy), GlobalConfig (copy), TweenService (copy)
    local u35 = setmetatable({}, u1);
    u35.Player = Players:GetPlayerFromCharacter(u34);
    u35.Character = u34;
    u35.Humanoid = u34:WaitForChild("Humanoid");
    u35.HumanoidRootPart = u34:WaitForChild("HumanoidRootPart");
    u35.PrivateRemotes = {
        RectifyServerChanges = u35:GetPrivateRemote("RectifyServerChanges"),
        ServerHasSetCFrame = u35:GetPrivateRemote("ServerHasSetCFrame"),
        CacheRootCFrame = u35:GetPrivateRemote("CacheRootCFrame"),
        CacheRootVelocity = u35:GetPrivateRemote("CacheRootVelocity"),
        ReadyForUpdates = u35:GetPrivateRemote("ReadyForUpdates")
    };
    u35.Trove = Trove.new();
    u35.CharacterDebugCloneAdded = FastSignal.new();
    u35.CharacterDebugVelocityAdded = FastSignal.new();
    u35.Trove:Add(u35.CharacterDebugCloneAdded);
    u35.Trove:Add(u35.CharacterDebugVelocityAdded);
    u35.LastOutgoingData = {
        CFrame = nil,
        Velocity = nil
    };
    u35.LastServerSnapshot = {
        CFrame = nil,
        Velocity = nil
    };
    u35.LastClientSnapshot = {
        CFrame = u35.HumanoidRootPart.CFrame
    };
    u35.Trove:Add(u35.PrivateRemotes.ServerHasSetCFrame.OnClientEvent:Connect(function(...) -- Line: 285
        -- upvalues: u35 (copy), Players (ref), SharedComponent (ref), CoreRemotes (ref)
        local v36 = { ... };
        local table_clone_ret = table.clone(v36);
        local v37;

        if u35.Player == Players.LocalPlayer then
            v37 = v36[1];
            table.remove(table_clone_ret, 1);
        else
            v37 = nil;
        end;

        local v38 = SharedComponent.Deserialize(table_clone_ret);
        u35.LastClientSnapshot.CFrame = v38;
        u35.LastServerSnapshot.CFrame = v38;
        u35.HumanoidRootPart.CFrame = v38;

        if v37 then
            CoreRemotes.ClientToServer.AcknowledgeServerCFrameSet:FireServer(v37);
        end;
    end));
    u35.Trove:Add(u35.PrivateRemotes.CacheRootCFrame.OnClientEvent:Connect(function(...) -- Line: 305
        -- upvalues: SharedComponent (ref), u35 (copy)
        local v39 = SharedComponent.Deserialize({ ... });
        u35.LastServerSnapshot.CFrame = v39;
    end));
    u35.Trove:Add(u35.PrivateRemotes.CacheRootVelocity.OnClientEvent:Connect(function(...) -- Line: 309
        -- upvalues: SharedComponent (ref), u35 (copy)
        local v40 = SharedComponent.Deserialize({ ... });
        u35.LastServerSnapshot.Velocity = v40;
    end));
    u35.Trove:Add(u35.PrivateRemotes.RectifyServerChanges.OnClientEvent:Connect(function() -- Line: 313
        -- upvalues: u35 (copy)
        u35.HumanoidRootPart.CFrame = u35.LastClientSnapshot.CFrame;
    end));
    u35.Trove:Add(RunService.PostSimulation:Connect(function() -- Line: 316
        -- upvalues: GlobalConfig (ref), u35 (copy), RunService (ref)
        if not GlobalConfig.Visualization.VisualizeVelocity then
            return;
        end;

        u35:CreateVelocityVisualization(u35:GetVelocity() or Vector3.new(0, 0, 0), RunService.PostSimulation);
    end));

    if u35.Player == Players.LocalPlayer then
        u35.Trove:Add(RunService.PostSimulation:Connect(function(p41) -- Line: 322
            -- upvalues: u35 (copy)
            u35.LastClientSnapshot.CFrame = u35.HumanoidRootPart.CFrame;
        end));
        u35.Trove:Add(task.defer(function() -- Line: 326
            -- upvalues: GlobalConfig (ref), SharedComponent (ref), u35 (copy), CoreRemotes (ref)
            while true do
                if GlobalConfig.GloballyEnabled and not (GlobalConfig.Optimizations.IgnoreRedundantRootCFrameUpdates.EnabledForClientToServer and SharedComponent.IsVelocityOrCFrameRedundant(u35.LastOutgoingData.CFrame, u35.HumanoidRootPart.CFrame)) then
                    u35.LastOutgoingData.CFrame = u35.HumanoidRootPart.CFrame;
                    CoreRemotes.ClientToServer.CacheRootCFrame:FireServer(SharedComponent.Serialize(u35.HumanoidRootPart.CFrame));
                end;

                task.wait(GlobalConfig.ClientToServerRootCFrameCacheTickRate or 0.016666666666666666);
            end;
        end));
        u35.Trove:Add(task.defer(function() -- Line: 337
            -- upvalues: GlobalConfig (ref), SharedComponent (ref), u35 (copy), CoreRemotes (ref)
            while true do
                if GlobalConfig.GloballyEnabled and not (GlobalConfig.Optimizations.IgnoreRedundantVelocityUpdates.EnabledForClientToServer and SharedComponent.IsVelocityOrCFrameRedundant(u35.LastOutgoingData.Velocity, u35.HumanoidRootPart.AssemblyLinearVelocity)) then
                    u35.LastOutgoingData.Velocity = u35.HumanoidRootPart.AssemblyLinearVelocity;
                    CoreRemotes.ClientToServer.CacheRootVelocity:FireServer(SharedComponent.Serialize(u35.HumanoidRootPart.AssemblyLinearVelocity));
                end;

                task.wait(GlobalConfig.ClientToServerRootVelocityCacheTickRate or 0.05);
            end;
        end));
    else
        u35.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true);
        local CFrame2 = u35.HumanoidRootPart.CFrame;
        local u42 = Vector3.new(0, 0, 0);
        u35.Trove:Add(RunService.PostSimulation:Connect(function(p43) -- Line: 356
            -- upvalues: GlobalConfig (ref), CFrame2 (ref), u35 (copy), u42 (ref), RunService (ref), Players (ref), TweenService (ref), u34 (copy)
            if not GlobalConfig.GloballyEnabled then
                CFrame2 = u35.HumanoidRootPart.CFrame;
                u42 = Vector3.new(0, 0, 0);
                u35.LastServerSnapshot.CFrame = u35.HumanoidRootPart.CFrame;
                u35.LastServerSnapshot.Velocity = u35.HumanoidRootPart.AssemblyLinearVelocity;
                u35:DestroyDebugClone("VisualizeServerSnapshot");
                u35:DestroyDebugClone("VisualizeNativeCharacter");

                return;
            end;

            local CFrame3 = u35.HumanoidRootPart.CFrame;

            if u35.LastServerSnapshot.CFrame then
                CFrame3 = CFrame.new(u35.LastServerSnapshot.CFrame.Position + Vector3.new(0, 0.1, 0)) * u35.LastServerSnapshot.CFrame.Rotation;

                if GlobalConfig.ClientVelocityBasedPrediction.Enabled then
                    local v44 = (RunService:IsStudio() and 0.25 or Players.LocalPlayer:GetNetworkPing()) / 2;
                    local v45 = (u35:GetVelocity() or Vector3.new(0, 0, 0)) * GlobalConfig.ClientVelocityBasedPrediction.VelocityMultiplier;
                    local math_clamp_ret = math.clamp(v45.X, GlobalConfig.ClientVelocityBasedPrediction.VelocityClamps.X.Min, GlobalConfig.ClientVelocityBasedPrediction.VelocityClamps.X.Max);
                    local math_clamp_ret2 = math.clamp(v45.Y, GlobalConfig.ClientVelocityBasedPrediction.VelocityClamps.Y.Min, GlobalConfig.ClientVelocityBasedPrediction.VelocityClamps.Y.Max);
                    local math_clamp_ret3 = math.clamp(v45.Z, GlobalConfig.ClientVelocityBasedPrediction.VelocityClamps.Z.Min, GlobalConfig.ClientVelocityBasedPrediction.VelocityClamps.Z.Max);
                    local v46 = Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3) * v44;

                    if v46.Magnitude > GlobalConfig.ClientVelocityBasedPrediction.MaxCompensation then
                        v46 = v46.Unit * GlobalConfig.ClientVelocityBasedPrediction.MaxCompensation;
                    end;

                    CFrame3 = CFrame.new(CFrame3.Position + v46) * CFrame3.Rotation;
                end;
            end;

            local v47, v48 = TweenService:SmoothDamp(u35.HumanoidRootPart.CFrame, CFrame3, u42, 0.025, nil, p43);
            CFrame2 = v47;
            u42 = v48;
            u35.HumanoidRootPart.CFrame = CFrame2;
            u35.LastClientSnapshot.CFrame = u35.HumanoidRootPart.CFrame;

            if u35.LastServerSnapshot.CFrame then
                u34.Archivable = true;

                for _, descendant in u34:GetDescendants() do
                    descendant.Archivable = true;
                end;

                if GlobalConfig.Visualization.VisualizeServerSnapshot then
                    local DebugClone, v49 = u35:GetDebugClone("VisualizeServerSnapshot", true);

                    if v49 then
                        DebugClone.Parent = workspace;
                        u35.Trove:Add(DebugClone);
                    end;

                    DebugClone:PivotTo(u34:GetPivot());
                    u35:UpdateDebugClonePose("VisualizeServerSnapshot");
                    DebugClone:PivotTo(u35.LastServerSnapshot.CFrame);
                else
                    u35:DestroyDebugClone("VisualizeServerSnapshot");
                end;

                if GlobalConfig.Visualization.VisualizeNativeCharacter and u34:FindFirstChild("PlayerOwnedPart") then
                    local DebugClone, v50 = u35:GetDebugClone("VisualizeNativeCharacter", true);

                    if v50 then
                        DebugClone.Parent = workspace;
                        u35.Trove:Add(DebugClone);
                    end;

                    DebugClone:PivotTo(u34:GetPivot());
                    u35:UpdateDebugClonePose("VisualizeNativeCharacter");
                    DebugClone:PivotTo(u34.PlayerOwnedPart.CFrame);

                    return;
                end;

                u35:DestroyDebugClone("VisualizeNativeCharacter");
            end;
        end));
    end;

    u35.Trove:Add(u35.HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Connect(function() -- Line: 449
        -- upvalues: u35 (copy), Players (ref), GlobalConfig (ref)
        local _ = u35.HumanoidRootPart.CFrame == u35.LastClientSnapshot.CFrame;
        local _ = u35.HumanoidRootPart.CFrame.Position == u35.LastClientSnapshot.CFrame.Position;

        if u35.Player == Players.LocalPlayer and GlobalConfig.Optimizations.RectificationMode ~= "CFrameChangedListener" then
        end;
    end));
    u35.PrivateRemotes.ReadyForUpdates:FireServer();

    return u35;
end;

return u1;