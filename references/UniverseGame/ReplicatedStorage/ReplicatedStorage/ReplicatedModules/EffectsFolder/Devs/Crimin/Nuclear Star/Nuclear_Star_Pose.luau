  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
game.ReplicatedStorage:WaitForChild("Client Assets");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");

return function(u1, p2, p3, p4, p5) -- Line: 19
    -- upvalues: Players (copy), ParticleHandler (copy), PathShortcuts (copy), TweenService (copy), RunService (copy)
    if typeof(u1) == "table" and u1.Character then
        local v6 = u1;
        u1 = v6.Character;
        p2 = v6.Mode;
        p3 = v6.Color;
        p4 = v6.BPM;
        p5 = v6.Config;
    end;

    local v7 = u1:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = u1:FindFirstChild("HumanoidRootPart");
    local u8 = "";

    for _, v in Players:GetPlayers() do
        if v.Character == u1 then
            u8 = v.Name;
            break;
        end;
    end;

    if not HumanoidRootPart or (not v7 or game.Players.LocalPlayer.Settings.ExtraProps.Value ~= true) then
        return;
    end;

    local v9 = p5 or {};
    local u10 = v9.PartCount or 25;
    local u11 = v9.RotationSpeed or 1.5;
    local u12 = v9.PartSize or Vector3.new(0.2, 1, 0.2);
    local u13 = v9.Radius or 6;
    local Effects = workspace.Effects;
    local v14 = Effects:FindFirstChild(u8 .. "_nspose");

    if v14 then
        v14:Destroy();
    end;

    local Pose = u1:FindFirstChild("Pose");

    if Pose then
        Pose:Destroy();
    end;

    if p2 then
        local Model = Instance.new("Model", Effects);
        Model.Name = u8 .. "_nspose";
        local ObjectValue = Instance.new("ObjectValue");
        ObjectValue.Name = "PoseReference";
        ObjectValue.Value = Model;
        ObjectValue.Parent = u1;
        local u15 = table.create(u10);
        local u16 = {};
        local u17 = p3 or Color3.new(0.435294, 0.878431, 1);
        local v18 = ParticleHandler.GetUnusualHSVData({
            Character = u1
        });
        local v19;

        if u1 then
            v19 = u1:GetAttribute("ChromaUnusual");
        end;

        if v18 then
            u17 = ParticleHandler.HSVShift(u17, v18);
        end;

        if v19 then
            PathShortcuts.Remotes.ClientBind:Fire(u1, "Chroma", Model);
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.OutlineColor = u17;
        Highlight.FillColor = u17;
        Highlight.FillTransparency = 0.9;
        Highlight.OutlineTransparency = 0;
        Highlight.Parent = Model;
        Highlight.Adornee = u1;

        for i = 1, u10 do
            local v20 = i / u10 * 3.141592653589793 * 2;
            local v21 = math.cos(v20) * u13;
            local v22 = math.sin(v20) * u13;
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1, 1, 1);
            Part.CFrame = HumanoidRootPart.CFrame * CFrame.new(v21, 0, v22);
            Part.Material = Enum.Material.Neon;
            Part.Color = u17;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            local SpecialMesh = Instance.new("SpecialMesh");
            SpecialMesh.Scale = u12;
            SpecialMesh.MeshType = Enum.MeshType.Brick;
            SpecialMesh.Parent = Part;
            Part.Parent = Model;
            local v23 = { Part, SpecialMesh };
            u15[i] = v23;
            u16[v23] = 0;
        end;

        local PoseMusic = u1.Stand.StandHumanoidRootPart.PoseMusic;
        local u24 = 1;
        local u25 = 0;
        local u26 = 0;
        local u27 = 0;
        local u28 = false;
        local u29 = 0;
        local u30 = 1 / (p4 / 60);
        coroutine.wrap(function() -- Line: 135
            -- upvalues: Effects (copy), u8 (ref), u1 (ref), Highlight (copy), TweenService (ref), u30 (copy)
            while Effects:FindFirstChild(u8 .. "_nspose") and u1:FindFirstChild("PoseReference") do
                Highlight.OutlineTransparency = 0;
                TweenService:Create(Highlight, TweenInfo.new(u30, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    OutlineTransparency = 1
                }):Play();
                task.wait(u30);
            end;
        end)();
        local u31 = nil;
        u31 = RunService.RenderStepped:Connect(function(p32) -- Line: 143
            -- upvalues: Effects (copy), u8 (ref), u1 (ref), u31 (ref), u29 (ref), u11 (copy), PoseMusic (copy), HumanoidRootPart (copy), u24 (ref), u25 (ref), u26 (ref), u27 (ref), u17 (ref), Model (copy), TweenService (ref), u28 (ref), u15 (copy), u16 (copy), u10 (copy), u13 (copy), u12 (copy)
            if not (Effects:FindFirstChild(u8 .. "_nspose") and (u1:FindFirstChild("PoseReference") and u1:IsDescendantOf(workspace))) then
                u31:Disconnect();

                if Effects:FindFirstChild(u8 .. "_nspose") then
                    Effects:FindFirstChild(u8 .. "_nspose"):Destroy();
                end;

                if u1:FindFirstChild("PoseReference") then
                    u1:FindFirstChild("PoseReference"):Destroy();
                end;

                return;
            end;

            if game.Players.LocalPlayer.Settings.ExtraProps.Value ~= true then
                u31:Disconnect();

                if Effects:FindFirstChild(u8 .. "_nspose") then
                    Effects:FindFirstChild(u8 .. "_nspose"):Destroy();
                end;

                if u1:FindFirstChild("PoseReference") then
                    u1:FindFirstChild("PoseReference"):Destroy();
                end;

                return;
            end;

            u29 = (u29 + u11 * p32 * 60) % 360;
            local v33 = PoseMusic.PlaybackLoudness * 0.5;
            local v34 = 25 / (workspace.CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude;
            u24 = u24 + (1 + v33 / 360 - u24) * math.min(p32 * 10, 1);
            u25 = math.clamp(u24 - 1.5, 0, 1) * 8;
            u26 = math.clamp(u25 - 1.35, 0, 1) * 8;

            if u27 < u26 then
                u27 = u26;
            else
                u27 = u27 + (0 - u27) * math.min(p32 * 20, 1);
            end;

            workspace.CurrentCamera.FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value + u25 * 5 * v34;

            if u24 > 1.44 then
                local Part = Instance.new("Part");
                Part.Material = Enum.Material.ForceField;
                Part.Color = u17;
                Part.Size = Vector3.new(10, 10, 10);
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CastShadow = false;
                Part.CFrame = HumanoidRootPart.CFrame;
                Part.Parent = Model;
                TweenService:Create(Part, TweenInfo.new(0.6), {
                    Transparency = 1,
                    Size = Vector3.new(1, 1, 1),
                    CFrame = Part.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                }):Play();
                game.Debris:AddItem(Part, 0.6);
            end;

            if u24 > 1.39 and not u28 then
                u28 = true;
                local Part = Instance.new("Part");
                Part.Material = Enum.Material.ForceField;
                Part.Color = u17;
                Part.Size = Vector3.new(0, 0, 0);
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CastShadow = false;
                Part.CFrame = HumanoidRootPart.CFrame * CFrame.new(math.random(-7, 7), math.random(-2, 2), math.random(-7, 7));
                Part.Parent = Model;
                TweenService:Create(Part, TweenInfo.new(0.6), {
                    Size = Vector3.new(1, 1, 1),
                    Transparency = 1,
                    CFrame = Part.CFrame * CFrame.new(0, 4, 0)
                }):Play();
                game.Debris:AddItem(Part, 0.6);
            elseif u24 <= 1.39 and u28 then
                u28 = false;
            end;

            for i, v in u15 do
                local v35 = v[1];
                local v36 = v[2];
                local v37 = u16[v];
                local v38 = v37 + (0 - v37) * math.min(p32 * 5, 1);
                local v39 = i / u10 * 3.141592653589793 * 2 + math.rad(u29);
                local v40 = u13 * u24;
                local v41 = math.cos(v39) * v40;
                local v42 = math.sin(v39) * v40;
                local v43 = math.rad(v33);
                local v44 = math.cos(v43) * v40;
                local v45 = math.sin(v43) * v40;
                local v46 = v38 + (10 / (((v41 - v44) ^ 2 + (v42 - v45) ^ 2) ^ 0.5 * 8 + 1) - v38) * math.min(p32 * 10, 1);
                u16[v] = v46;
                v35.CFrame = HumanoidRootPart.CFrame * CFrame.new(v41, 0, v42);
                v36.Scale = Vector3.new(u12.X, u12.Y * 3 * v46, u12.Z);
            end;
        end);
    else
        local PoseReference = u1:FindFirstChild("PoseReference");

        if PoseReference and PoseReference.Value then
            PoseReference.Value:Destroy();
            PoseReference:Destroy();
        end;

        local Effects2 = workspace:FindFirstChild("Effects");
        local v47 = Effects2 and Effects2:FindFirstChild(u8 .. "_nspose");

        if v47 then
            v47:Destroy();
        end;
    end;
end;