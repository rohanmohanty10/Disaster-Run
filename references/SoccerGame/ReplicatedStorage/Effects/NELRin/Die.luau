  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);

local function EmitAll(p1) -- Line: 12
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 15
                -- upvalues: descendant (copy)
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;

                if descendant:GetAttribute("EmitDuration") then
                    descendant.Enabled = true;
                    task.wait(descendant:GetAttribute("EmitDuration"));
                    descendant.Enabled = false;
                end;
            end);
        end;
    end;
end;

local function EmitBeam(p2, u3) -- Line: 30
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("Beam") then
            print(descendant);
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.25), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(u3, function() -- Line: 44
                -- upvalues: TweenService (ref), descendant (copy), u3 (copy)
                TweenService:Create(descendant, TweenInfo.new(u3 / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

return function(p4) -- Line: 55
    -- upvalues: CutsceneUtils (copy), VfxManager (copy), ReplicatedStorage (copy), RunService (copy)
    local Char = p4.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local enemy = p4.enemy;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local u5 = {};
    tick();
    local _ = game.Workspace.CurrentCamera.FieldOfView;
    local u6 = 0;
    local u7 = {};
    local Players = game:GetService("Players");
    local Values = Players.LocalPlayer.Character.Values;

    if not (Values.Goalie.Value or (Values.IsInPenalty.Value or Players.LocalPlayer.Team == game.Teams.Visitor)) then
        local u8 = nil;
        u8 = game:GetService("RunService").RenderStepped:Connect(function(p9) -- Line: 77
            -- upvalues: u6 (ref), u8 (ref)
            u6 = u6 + p9 * 60;
            local script_FOV = script.FOV;
            local math_ceil_ret = math.ceil(u6);
            local v10 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

            if v10 then
                game.Workspace.CurrentCamera.FieldOfView = v10.Value;

                return;
            end;

            u8:Disconnect();
        end);

        for _, child in workspace:GetChildren() do
            if child.Name ~= Char.Name and (child ~= enemy and (child.Name ~= "Ball" and (not child:IsDescendantOf(workspace.Debris) and child ~= workspace.Debris))) then
                for _, descendant in child:GetDescendants() do
                    if descendant:IsA("MeshPart") or (descendant:IsA("Part") or (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")))) then
                        table.insert(u7, { descendant, descendant.Transparency });
                        descendant.Transparency = 1;
                    elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        table.insert(u7, { descendant, descendant.Transparency });
                        descendant.Transparency = NumberSequence.new(1, 1);
                    end;
                end;
            end;
        end;

        CutsceneUtils.ChangeLighting(script.Lighting);
    end;

    for _, child in pairs(script.Environment:GetChildren()) do
        coroutine.wrap(function() -- Line: 108
            -- upvalues: child (copy), u5 (copy), HumanoidRootPart (copy), Folder (copy), VfxManager (ref), ReplicatedStorage (ref), Values (copy)
            local v11 = child:Clone();
            local v12 = script.HumanoidRootPart.CFrame:Inverse() * child:GetPivot();
            u5[v11.Name] = v11;
            v11:PivotTo(HumanoidRootPart.CFrame * v12);
            v11.Parent = Folder;

            if v11.Name ~= "Die Hand" then
                if v11.Name == "DarkSphere" then
                    if Values.Goalie.Value and Values.IsInPenalty.Value then
                        v11.Transparency = 1;

                        return;
                    end;
                else
                    if v11.Name == "JumpScreen" then
                        task.wait(2.566666666666667);
                        VfxManager.Emit(v11);

                        return;
                    end;

                    if v11.Name == "BodySlam" then
                        task.wait(4.99);
                        VfxManager.Emit(v11);

                        return;
                    end;

                    if v11.Name == "Hit1" then
                        task.wait(12.3);
                        VfxManager.Emit(v11);
                    end;
                end;

                return;
            end;

            VfxManager.Enable(v11, false);
            v11.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.DieHand):Play();
        end)();
    end;

    local u13 = script.Aura:Clone();
    u13.Parent = Folder;
    RunService.Heartbeat:Connect(function() -- Line: 141
        -- upvalues: u13 (copy), Char (copy)
        u13.CFrame = Char.Torso.CFrame;
    end);
    workspace:FindFirstChild("NagiCam");
    task.delay(13.9, function() -- Line: 147
        -- upvalues: Folder (copy), u7 (copy), CutsceneUtils (ref), ReplicatedStorage (ref), u5 (copy)
        Folder:Destroy();

        for _, v in u7 do
            local v14, v15 = unpack(v);
            v14.Transparency = v15;
        end;

        CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);

        for _, v in pairs(u5) do
            v:Destroy();
        end;
    end);
end;