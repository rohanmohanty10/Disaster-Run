  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local HttpService = game:GetService("HttpService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local u1 = { { 20, 1.2 }, { 9, 1.217 }, { 12, 1.433 }, { 30, 2.75 }, { 11, 2.767 }, { 5, 6.4 }, { 15, 6.417 }, { 20, 6.883 }, { 15, 6.9 }, { 12, 7.5 }, { 16, 7.683 }, { 20, 7.717 }, { 23, 7.767 }, { 23, 7.767 } };

return function(p2) -- Line: 31
    -- upvalues: SpectatorController (copy), SoundManager (copy), u1 (copy), TweenService (copy), Popup (copy), VfxManager (copy), HttpService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    SoundManager.SpawnSound("DragonDriveCutscene", 0.7, workspace, 150);
    workspace_CurrentCamera.FieldOfView = 40;
    task.spawn(function() -- Line: 39
        -- upvalues: u1 (ref), TweenService (ref), workspace_CurrentCamera (copy)
        local v3 = 0;

        for _, v in u1 do
            local v4 = v[2];
            local v5 = v[1];
            local v6 = v4 - v3;
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(v6), {
                FieldOfView = v5
            }):Play();
            task.wait(v6);
            v3 = v4;
        end;
    end);
    task.delay(0.8, function() -- Line: 53
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Jump all the cells in my body");
    end);
    task.delay(5.7, function() -- Line: 57
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "DRAGON DRIVE");
    end);
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local script_Attachments = script.Attachments;
    local u7 = {};

    for _, child in script_Attachments:GetChildren() do
        child:Clone().Parent = HumanoidRootPart;
    end;

    for _, child in script:GetChildren() do
        if script_Attachments:FindFirstChild(child.Name) then
            local v8 = child:Clone();
            v8.Parent = workspace.Debris;
            v8.CFrame = HumanoidRootPart:FindFirstChild(v8.Name).WorldCFrame;
            u7[v8.Name] = v8;
        end;
    end;

    for _, child in script.TorsoStuff:GetChildren() do
        local v9 = child:Clone();
        v9.Parent = Char:FindFirstChild("Torso");
        u7[v9.Name] = v9;
    end;

    local u10 = script.LegAttachments.Object33:Clone();
    u10.Parent = Char:FindFirstChild("Right Leg");
    local u11 = script.Head.Attachment:Clone();
    u11.Parent = Char:FindFirstChild("Head");
    task.delay(1.433, function() -- Line: 95
        -- upvalues: u7 (copy), VfxManager (ref)
        local Step = u7.Step;

        if Step then
            VfxManager.Emit(Step);

            return;
        end;

        warn("no step");
    end);
    task.delay(2.1, function() -- Line: 101
        -- upvalues: u7 (copy), VfxManager (ref), TweenService (ref)
        local v12 = u7["Inky part"];

        if not v12 then
            return;
        end;

        VfxManager.Enable(v12, true);

        for _, child in v12:GetChildren() do
            if child:IsA("ParticleEmitter") then
                TweenService:Create(child, TweenInfo.new(0.8), {
                    TimeScale = 0
                }):Play();
            end;
        end;
    end);
    task.delay(2.1, function() -- Line: 113
        -- upvalues: u7 (copy), VfxManager (ref)
        local sparechange = u7.sparechange;

        if not sparechange then
            return;
        end;

        VfxManager.Enable(sparechange, true);
    end);
    task.delay(2.417, function() -- Line: 120
        -- upvalues: u7 (copy), VfxManager (ref), HttpService (ref), TweenService (ref)
        local party = u7.party;

        if not party then
            return;
        end;

        VfxManager.Emit(party);
        local Swirl = u7.Swirl;

        if not Swirl then
            return;
        end;

        local function u15(p13) -- Line: 128
            local string_gsub_ret = string.gsub(p13, ", ", ",");
            local string_split_ret = string.split(string_gsub_ret, ",");
            local v14 = {};

            for i, v in pairs(string_split_ret) do
                v14[i] = tonumber(v);
            end;

            return v14;
        end;

        task.spawn(function() -- Line: 139
            -- upvalues: Swirl (copy), HttpService (ref), u15 (copy), TweenService (ref)
            local Attribute = Swirl:GetAttribute("bakedAnimationTrack");

            if not Attribute then
                warn(Swirl.Name .. " does not have a baked animation track. Skipping..");

                return;
            end;

            local u16 = {};
            local v17 = HttpService:JSONDecode(Attribute);

            local function u24(p18: any, p19: any, p20: table) -- Line: 145
                -- upvalues: u24 (ref), u15 (ref)
                if typeof(p19) == "table" then
                    p20[p18] = {};

                    if #p19 ~= 2 then
                        for i, v in pairs(p19) do
                            u24(i, v, p20[p18]);
                        end;

                        return;
                    end;

                    if p19[2] == "CFrame" then
                        local CFrame_new = CFrame.new;
                        local v21 = u15(p19[1]);
                        p20[p18] = CFrame_new(unpack(v21));

                        return;
                    end;

                    if p19[2] == "Vector3" then
                        local v22 = u15(p19[1]);
                        p20[p18] = Vector3.new(unpack(v22));

                        return;
                    end;

                    if p19[2] == "Color3" then
                        local Color3_new = Color3.new;
                        local v23 = u15(p19[1]);
                        p20[p18] = Color3_new(unpack(v23));
                    end;
                elseif typeof(p19) == "number" or typeof(p19) == "string" then
                    p20[p18] = p19;
                end;
            end;

            for i, v in pairs(v17) do
                u24(i, v, u16);
            end;

            u24 = nil;
            local u25 = Swirl;
            task.spawn(function() -- Line: 176
                -- upvalues: Swirl (ref), u16 (copy), u25 (copy), TweenService (ref)
                if Swirl:IsA("MeshPart") then
                    for _, v in pairs(u16) do
                        if not u25 or u25.Parent == nil then
                            return;
                        end;

                        if v.Delay and v.Delay > 0 then
                            task.wait(v.Delay);
                        end;

                        TweenService:Create(u25, TweenInfo.new(v.Lifetime, Enum.EasingStyle[v.EasingStyle], Enum.EasingDirection[v.EasingDirection]), {
                            CFrame = Swirl.CFrame * v.Offset * v.Rotation,
                            Color = v.Color,
                            Size = v.Size,
                            Transparency = v.Transparency
                        }):Play();
                        task.wait(v.Lifetime - 0.1);
                    end;
                elseif Swirl:IsA("Part") and (Swirl:FindFirstChildOfClass("SpecialMesh") and Swirl:FindFirstChildOfClass("Decal")) then
                    for _, v in pairs(u16) do
                        if not u25 or u25.Parent == nil then
                            return;
                        end;

                        if v.Delay and v.Delay > 0 then
                            task.wait(v.Delay);
                        end;

                        TweenService:Create(u25, TweenInfo.new(v.Lifetime, Enum.EasingStyle[v.EasingStyle], Enum.EasingDirection[v.EasingDirection]), {
                            CFrame = Swirl.CFrame * v.Offset * v.Rotation
                        }):Play();
                        TweenService:Create(u25:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v.Lifetime, Enum.EasingStyle[v.EasingStyle], Enum.EasingDirection[v.EasingDirection]), {
                            Scale = v.Size * v.ScalePercentage
                        }):Play();
                        TweenService:Create(u25:FindFirstChildOfClass("Decal"), TweenInfo.new(v.Lifetime, Enum.EasingStyle[v.EasingStyle], Enum.EasingDirection[v.EasingDirection]), {
                            Color3 = v.Color,
                            Transparency = v.Transparency
                        }):Play();
                        task.wait(v.Lifetime - 0.1);
                    end;
                end;

                task.wait(0.25);

                if u25 then
                    u25:Destroy();
                end;
            end);
        end);
    end);
    task.delay(6.6, function() -- Line: 216
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10);
    end);
    task.delay(7, function() -- Line: 220
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10);
    end);
    task.delay(7.6, function() -- Line: 224
        -- upvalues: u7 (copy), VfxManager (ref)
        VfxManager.Emit(u7.punchy2);
    end);
    task.delay(8.7, function() -- Line: 229
        -- upvalues: u7 (copy), HumanoidRootPart (copy), u11 (copy), u10 (copy)
        for _, v in u7 do
            local v26 = HumanoidRootPart:FindFirstChild(v.Name);

            if v26 then
                v26:Destroy();
            end;

            v:Destroy();
        end;

        if u11 then
            u11:Destroy();
        end;

        if u10 then
            u10:Destroy();
        end;

        table.clear(u7);
    end);
end;