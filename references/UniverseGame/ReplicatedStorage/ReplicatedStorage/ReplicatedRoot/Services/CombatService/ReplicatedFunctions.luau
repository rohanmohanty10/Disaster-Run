  

 

local v1 = {};
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
local Knit = require(ReplicatedStorage.ReplicatedModules.KnitPackage.Knit);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local CommonUtil = require(ReplicatedRoot.Libraries.Utility.CommonUtil);
local DirectoryUtil = require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local PhysicsService = require(ReplicatedRoot.Services.PhysicsService);
local TagService = require(ReplicatedRoot.Services.TagService);
local Enums = require(ReplicatedRoot.Libraries.Enums);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local UIOutput = ReplicatedStorage.Remotes:FindFirstChild("UIOutput");
local ClientUIOutput = ReplicatedStorage.Remotes:FindFirstChild("ClientUIOutput");

function v1.Init(u2) -- Line: 30
    -- upvalues: Enums (copy), TableUtil (copy), CommonUtil (copy), Core (copy), PhysicsService (copy), DirectoryUtil (copy), Trove (copy), Signal (copy), TagService (copy), TweenService (copy), Knit (copy), Players (copy), UIOutput (copy), ClientUIOutput (copy)
    u2.ObjectSignals = {};

    function u2.CreateAttackInfo(p3) -- Line: 33
        local v4 = p3 or {};
        v4._IsAttack = true;

        return v4;
    end;

    function u2.CalculateAttackPriority(p5) -- Line: 39
        -- upvalues: Enums (ref)
        local v6 = nil;
        local v7 = nil;

        for i, v in pairs(Enums.AttackPriority) do
            if p5 >= v then
                local v8 = math.abs(v - p5);

                if v6 == nil or v8 < v7 then
                    v7 = v8;
                    v6 = i;
                end;
            end;
        end;

        return v6;
    end;

    function u2.GetRelativePart(p9, p10) -- Line: 55
        return p9:FindFirstChild(p10, true);
    end;

    function u2.GetObjects(p11) -- Line: 64
        -- upvalues: u2 (copy)
        local v12 = {};

        if typeof(p11) == "table" then
            v12.Player = p11.Player;
            v12.Character = p11.Character;
            v12.RootPart = p11.RootPart;
            v12.Humanoid = p11.Humanoid;

            if p11.ClassName == "MoveAction" then
                v12.Move = p11;
                v12.Ability = p11.Ability;

                return v12;
            end;

            if p11.ClassName == "Ability" then
                v12.Ability = p11;

                return v12;
            end;
        elseif typeof(p11) == "Instance" then
            if p11:IsA("Humanoid") or p11:IsA("BasePart") then
                return u2.GetObjects(p11.Parent);
            end;

            if p11:IsA("Model") then
                v12.Player = game.Players:GetPlayerFromCharacter(p11);
                v12.Humanoid = p11:FindFirstChildWhichIsA("Humanoid");
                v12.RootPart = p11:FindFirstChild("HumanoidRootPart");

                if v12.Humanoid then
                    v12.Character = p11;

                    return v12;
                end;
            elseif p11:IsA("Player") then
                return u2.GetObjects(p11.Character);
            end;
        end;

        return v12;
    end;

    function u2.GetCharacter(p13) -- Line: 95
        -- upvalues: u2 (copy)
        local v14 = nil;
        local v15 = nil;
        local v16 = nil;
        local v17 = nil;

        if typeof(p13) == "Instance" then
            if p13:IsA("Humanoid") or p13:IsA("BasePart") then
                return u2.GetCharacter(p13.Parent);
            end;

            if p13:IsA("Model") then
                v14 = game.Players:GetPlayerFromCharacter(p13);
                v16 = p13:FindFirstChildWhichIsA("Humanoid");
                v17 = p13:FindFirstChild("HumanoidRootPart");

                if not v16 then
                    p13 = v15;
                end;
            else
                if p13:IsA("Player") then
                    return u2.GetCharacter(p13.Character);
                end;

                p13 = v15;
            end;
        else
            p13 = v15;
        end;

        return {
            Player = v14,
            Character = p13,
            Humanoid = v16,
            RootPart = v17
        };
    end;

    local u18 = RaycastParams.new();
    u18.IgnoreWater = true;
    u18.FilterType = Enum.RaycastFilterType.Include;
    u18.FilterDescendantsInstances = { workspace.Map };
    u18.CollisionGroup = "Map";

    function u2.RaycastMap(p19, p20) -- Line: 128
        -- upvalues: u18 (copy)
        return workspace:Raycast(p19, p20, u18);
    end;

    function u2.RetrieveTargets(p21) -- Line: 133
        -- upvalues: u2 (copy), TableUtil (ref), CommonUtil (ref)
        local v22 = p21 or {};
        local Move = v22.Move;
        local Caster = v22.Caster;

        if Caster == nil and Move then
            Caster = Move.Character;
        end;

        local Hitbox = v22.Hitbox;

        if Move ~= nil and typeof(Hitbox) == "string" then
            Hitbox = u2.ResolveFromMove(Move, Hitbox);
        end;

        local CasterPart = v22.CasterPart;

        if not CasterPart then
            if Caster then
                CasterPart = Caster:FindFirstChild("HumanoidRootPart");
            else
                CasterPart = Caster;
            end;
        end;

        local v23 = v22.Origin or CasterPart and (CasterPart:GetAttribute("TargetCFrame") or CasterPart.CFrame) or CFrame.identity;
        local v24 = v22.From or v23;
        local v25 = v22.MaxHorizontalAngle or 45;
        local v26 = v22.MaxVerticalAngle or 90;
        local v27 = v22.Targets or nil or u2.Hitbox({
            Caster = Caster,
            Info = TableUtil.Reconcile(Hitbox or {}, {
                Origin = v23,
                Size = v22.Size or (Hitbox and (Hitbox.Size or 24) or 24),
                DebugColor = Color3.new(0, 0, 1),
                Debug = v22.Debug == true,
                Hidden = v22.Debug ~= true
            })
        });
        local v28 = {};

        for _, v in pairs(v27) do
            local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local v29 = CommonUtil.GetAngleBetween(v24.LookVector * Vector3.new(1, 0, 1), CFrame.lookAt(v24.Position * Vector3.new(1, 0, 1), HumanoidRootPart.Position * Vector3.new(1, 0, 1)).LookVector);
                local v30 = v29 ~= v29 and 0 or v29;
                local v31 = CommonUtil.GetAngleBetween(v24.LookVector * Vector3.new(0, 1, 0), CFrame.lookAt(v24.Position * Vector3.new(0, 1, 0), HumanoidRootPart.Position * Vector3.new(0, 1, 0)).LookVector);
                local v32 = v31 ~= v31 and 0 or v31;

                if v25 >= math.deg(v30) and v26 >= math.deg(v32) then
                    local v33 = {
                        Character = v.Character,
                        RootPart = HumanoidRootPart,
                        HorizontalAngle = math.deg(v30),
                        VerticalAngle = math.deg(v32),
                        Distance = (v23.Position - HumanoidRootPart.Position).Magnitude
                    };
                    table.insert(v28, v33);
                end;
            end;
        end;

        table.sort(v28, function(p34, p35) -- Line: 205
            return p34.HorizontalAngle < p35.HorizontalAngle;
        end);

        return v28;
    end;

    function u2.StepVelocity(p36) -- Line: 212
        -- upvalues: u2 (copy), TableUtil (ref), Core (ref), PhysicsService (ref)
        local v37 = p36 or {};
        local Character = v37.Character;

        if not Character then
            if v37.Object then
                Character = v37.Object.Parent or nil;
            else
                Character = nil;
            end;
        end;

        local Player = v37.Player;

        if not Player then
            if Character then
                Player = game.Players:GetPlayerFromCharacter(Character) or nil;
            else
                Player = nil;
            end;
        end;

        local Object = v37.Object;

        if not Object then
            if Character then
                Object = Character:FindFirstChild("HumanoidRootPart") or nil;
            else
                Object = nil;
            end;
        end;

        local v38;

        if Character then
            v38 = Character:FindFirstChildWhichIsA("Humanoid") or nil;
        else
            v38 = nil;
        end;

        local v39 = v37.Priority or u2.Enums.Step.Main;
        local v40 = v37.OverridePriority or v39;
        local v41 = TableUtil.Reconcile({
            Parent = v37.Parent or Character,
            Object = Object,
            Character = Character,
            Player = Player,
            Filter = { Character }
        }, v37);

        if not Player or Core.Context ~= "Server" then
            for _, child in pairs(Object:GetChildren()) do
                if child:IsA("LinearVelocity") and child.Name == (v37.Name or "StepVelocity") then
                    local v42 = child:GetAttribute("Priority");

                    if child.Enabled and (v42 == nil or v40 < v42) then
                        return;
                    end;
                end;
            end;

            if v41.Homing then
                local v43 = u2.GetHomingTargets(TableUtil.Reconcile(v41.Homing, {
                    Caster = Character
                }))[1];

                if v43 then
                    v41.Direction = CFrame.lookAt(Object.Position, v43.RootPart.Position).LookVector;
                    v41.TargetHeight = v43.RootPart.Position.Y;
                    v41.Normal = nil;
                    v41.Turn = false;

                    if v41.Homing.Info and v38.FloorMaterial == Enum.Material.Air then
                        v41 = TableUtil.Reconcile(v41.Homing.Info, v41);
                    end;
                end;
            end;

            local v44 = PhysicsService.StepVelocity(v41);

            if v44 then
                v44:SetAttribute("Priority", v39);
            end;

            return v44;
        end;

        u2.Remotes.StepVelocity:Fire(Player, v41);
    end;

    function u2.ResolveFromSequence(p45, p46) -- Line: 264
        local v47 = string.split(p46, "/");

        if v47[1] == "@Move" then
            p45 = p45.Move;
        elseif v47[1] == "@Data" then
            p45 = p45.Move.Data;
        elseif v47[1] == "@Info" then
            p45 = p45.Info;
        end;

        for i, v in ipairs(v47) do
            if i > 1 then
                p45 = p45[v] or error(v .. " is not found within directory");
            end;
        end;

        return p45;
    end;

    function u2.ResolveFromMove(p48, p49) -- Line: 282
        -- upvalues: DirectoryUtil (ref)
        return DirectoryUtil.Get({
            Path = p49,
            Roots = {
                { "@Move", p48 },
                { "@Data", p48.Data }
            }
        });
    end;

    function u2.ResolveFromAttackResult(p50, p51) -- Line: 292
        -- upvalues: Core (ref)
        local v52 = string.split(p51, "/");

        if v52[1] == "@Directory" then
            local Directory = p50.Directory;

            if not Directory then
                if p50.Move then
                    Directory = p50.Move.Directory or nil;
                else
                    Directory = nil;
                end;
            end;

            if Directory then
                return Core.Get({
                    Path = string.sub(p51, 12)
                }, Directory);
            end;
        end;

        local v53 = 0;

        if v52[1] == "@Attacker" then
            if v52[2] == "Player" then
                p50 = p50.AttackerPlayer;
                v53 = 2;
            else
                p50 = p50.Attacker;
                v53 = 1;
            end;
        elseif v52[1] == "@Target" then
            if v52[2] == "Player" then
                p50 = p50.TargetPlayer;
                v53 = 2;
            else
                p50 = p50.Target;
                v53 = 1;
            end;
        elseif v52[1] == "@Info" or v52[1] == "@Stats" then
            p50 = p50.Stats;
            v53 = 1;
        elseif v52[1] == "@Move" then
            p50 = p50.Move;
            v53 = 1;
        end;

        for i, v in ipairs(v52) do
            if v53 < i then
                p50 = p50[v] or error(v .. " is not found within directory");
            end;
        end;

        return p50;
    end;

    function u2.GetSignal(u54, p55) -- Line: 336
        -- upvalues: u2 (copy), Trove (ref), Signal (ref)
        local u56 = u2.ObjectSignals[u54];

        if u56 == nil then
            if not u54:IsDescendantOf(workspace) then
                return;
            end;

            u56 = {
                Signals = {},
                Collector = Trove.new()
            };
            u56.Collector:AttachToInstance(u54);
            u56.Collector:Connect(u54.AncestryChanged, function() -- Line: 349
                -- upvalues: u54 (copy), u56 (ref)
                if not u54:IsDescendantOf(game) then
                    u56.Collector:Destroy();
                end;
            end);
            u56.Collector:Add(function() -- Line: 355
                -- upvalues: u2 (ref), u54 (copy)
                u2.ObjectSignals[u54] = nil;
            end);
            u2.ObjectSignals[u54] = u56;
        end;

        local v57 = u56.Signals[p55];

        if v57 == nil then
            v57 = u56.Collector:Construct(Signal);
            u56.Signals[p55] = v57;
        end;

        return v57;
    end;

    function u2.GetAttackPriority(p58) -- Line: 370
        -- upvalues: TagService (ref)
        local v59 = TagService.GetContainer(p58);

        return not v59 and 0 or TagService.GetTagTotal(v59, "AttackPriority", 0);
    end;

    function u2.FireSignal(p60, p61, ...) -- Line: 378
        -- upvalues: u2 (copy)
        local v62 = u2.GetSignal(p60, p61);

        if v62 == nil then
            return;
        end;

        v62:Fire(...);
    end;

    function u2.ConnectSignal(p63, p64, ...) -- Line: 384
        -- upvalues: u2 (copy)
        local v65 = u2.GetSignal(p63, p64);

        if v65 ~= nil then
            return v65:Connect(...);
        end;
    end;

    function u2.GetSound(p66, p67) -- Line: 391
        if not p66 then
            return;
        end;

        for _, v in pairs(p66:QueryDescendants("Sound")) do
            if v.Name == p67 then
                return v;
            end;
        end;
    end;

    local function TweenCallback(p68, p69, u70, p71, p72, p73, p74, p75, p76) -- Line: 400
        -- upvalues: TweenService (ref)
        local v77 = TweenService:Create(p68, TweenInfo.new(p71 or 0.5, p72 or Enum.EasingStyle.Quad, p73 or Enum.EasingDirection.Out, p74 or 0, p75 or false, p76 or 0), p69);
        v77.Completed:Connect(function() -- Line: 410
            -- upvalues: u70 (copy)
            if u70 then
                u70();
            end;
        end);
        v77:Play();
    end;

    function u2.SoftStopSound(p78, p79, p80) -- Line: 416
        -- upvalues: u2 (copy), TweenCallback (copy)
        local u81 = u2.GetSound(p78, p79);

        if u81 ~= nil then
            local u82 = u81:GetAttribute("OriginalVolume") or u81.Volume;
            TweenCallback(u81, {
                Volume = 0
            }, function() -- Line: 422, Name: StopSound
                -- upvalues: u81 (copy), u82 (copy)
                u81:Stop();
                u81.Volume = u82;
                u81:SetAttribute("OriginalVolume", u82);
            end, p80 or 0.5, Enum.EasingStyle.Linear);

            return u81;
        end;
    end;

    function u2.SoftPlaySound(p83, p84, p85, p86) -- Line: 440
        -- upvalues: u2 (copy), TweenCallback (copy)
        local v87;

        if typeof(p83) == "Instance" and p83:IsA("Sound") then
            v87 = p83;
        else
            v87 = u2.FetchSound(p83, p84);
        end;

        if typeof(v87) == "table" then
            return v87;
        end;

        if p86 and (p86.Overwrite == false and v87.IsPlaying) then
            return v87;
        end;

        if p86 and p86.AdjustSpeed then
            v87.PlaybackSpeed = p83:GetAttribute("Timescale") or 1;
        end;

        local v88 = v87:GetAttribute("OriginalVolume") or v87.Volume;
        v87.Volume = 0;
        v87:Play();
        TweenCallback(v87, {
            Volume = v88
        }, nil, p85 or 0.5, Enum.EasingStyle.Linear);

        return v87;
    end;

    local u90 = {
        Destroy = function() -- Line: 472, Name: Destroy
        end,

        Play = function() -- Line: 475, Name: Play
        end,

        Stop = function() -- Line: 478, Name: Stop
        end,

        Clone = function(p89) -- Line: 482, Name: Clone
            return p89;
        end
    };

    function u2.FetchSound(p91, p92) -- Line: 487
        -- upvalues: u2 (copy), TableUtil (ref), u90 (copy)
        return u2.GetSound(p91, p92) or TableUtil.Copy(u90, true);
    end;

    function u2.PlaySound(p93, p94, p95) -- Line: 491
        -- upvalues: u2 (copy)
        if typeof(p94) == "table" then
            for _, v in p94 do
                local v96 = u2.FetchSound(p93, v);

                if v96 then
                    if p95 and p95.AdjustSpeed then
                        v96.PlaybackSpeed = p93:GetAttribute("Timescale") or 1;
                    end;

                    v96:Play();
                end;
            end;

            return;
        end;

        local v97 = u2.FetchSound(p93, p94);

        if v97 then
            if p95 and p95.AdjustSpeed then
                v97.PlaybackSpeed = p93:GetAttribute("Timescale") or 1;
            end;

            v97:Play();

            return v97;
        end;
    end;

    function u2.PlaySoundAt(p98, p99, p100, p101) -- Line: 519
        -- upvalues: u2 (copy)
        if typeof(p99) == "table" then
            for _, v in p99 do
                local v102 = u2.FetchSound(p98, v);
                local v103;

                if typeof(p100) == "Instance" and p100:IsA("BasePart") then
                    v103 = p100;
                else
                    v103 = Instance.new("Part");
                    v103.Transparency = 1;
                    v103.Anchored = true;
                    v103.CanCollide = false;
                    local v104;

                    if typeof(p100) == "CFrame" then
                        v104 = p100;
                    else
                        v104 = CFrame.new(p100);
                    end;

                    v103.CFrame = v104;
                    v103.Parent = workspace.Effects;
                    task.delay(v102.TimeLength or 1, v103.Destroy, v103);
                end;

                local v105 = v102:Clone();
                v105.Parent = v103;

                if p101 and p101.AdjustSpeed then
                    v105.PlaybackSpeed = p98:GetAttribute("Timescale") or 1;
                end;

                v105:Play();
            end;

            return;
        end;

        local v106 = u2.FetchSound(p98, p99);

        if v106 then
            local v107;

            if typeof(p100) == "Instance" and p100:IsA("BasePart") then
                v107 = p100;
            else
                v107 = Instance.new("Part");
                v107.Transparency = 1;
                v107.Anchored = true;
                v107.CanCollide = false;

                if typeof(p100) ~= "CFrame" then
                    p100 = CFrame.new(p100);
                end;

                v107.CFrame = p100;
                v107.Parent = workspace.Effects;
                task.delay(v106.TimeLength or 1, v107.Destroy, v107);
            end;

            local v108 = v106:Clone();
            v108.Parent = v107;

            if p101 and p101.AdjustSpeed then
                v108.PlaybackSpeed = p98:GetAttribute("Timescale") or 1;
            end;

            v108:Play();

            return v106;
        end;
    end;

    function u2.PlaySoundLocal(p109, p110, p111) -- Line: 579
        -- upvalues: Knit (ref), u2 (copy)
        local v112 = game.Players:GetPlayerFromCharacter(p109);

        if not v112 then
            return;
        end;

        local v113 = Knit.GetService("EffectService");

        if typeof(p110) == "table" then
            for _, v in p110 do
                local v114 = u2.FetchSound(p109, v);

                if v114 then
                    if p111 and p111.AdjustSpeed then
                        v114.PlaybackSpeed = p109:GetAttribute("Timescale") or 1;
                    end;

                    v113.FireClient(v112, "PlaySoundLocal", v114);
                end;
            end;

            return;
        end;

        local v115 = u2.FetchSound(p109, p110);

        if v115 then
            if p111 and p111.AdjustSpeed then
                v115.PlaybackSpeed = p109:GetAttribute("Timescale") or 1;
            end;

            v113.FireClient(v112, "PlaySoundLocal", v115);

            return v115;
        end;
    end;

    function u2.StopSound(p116, p117) -- Line: 612
        -- upvalues: u2 (copy)
        if typeof(p117) == "table" then
            for i = 1, #p117 do
                local v118 = u2.FetchSound(p116, p117[i]);

                if v118 then
                    v118:Stop();
                end;
            end;

            return;
        end;

        local v119 = u2.FetchSound(p116, p117);

        if v119 then
            v119:Stop();

            return v119;
        end;
    end;

    function u2.IsNPC(p120) -- Line: 629
        return p120:GetAttribute("NPC") ~= nil;
    end;

    function u2.EmitStatusIndicator(p121, p122, p123) -- Line: 634
        -- upvalues: Core (ref), Players (ref), UIOutput (ref), ClientUIOutput (ref)
        if not (p121 and p123) then
            return;
        end;

        p123.Character = p121;

        if not p123.Duration then
            p123.Duration = (1 / 0);
        end;

        if Core.Context == "Server" then
            local v124 = Players:GetPlayerFromCharacter(p121);

            if v124 then
                UIOutput:FireClient(v124, "EmitStatusIndicatorEvent", p122, p123);
            end;
        else
            ClientUIOutput:Fire("EmitStatusIndicatorEvent", p122, p123);
        end;
    end;
end;

function v1.Start(u125) -- Line: 653
    -- upvalues: Core (copy)
    if Core.Context == "Client" then
        u125.Remotes.StepVelocity:Connect(function(p126) -- Line: 655
            -- upvalues: u125 (copy)
            u125.StepVelocity(p126);
        end);
    end;
end;

return v1;