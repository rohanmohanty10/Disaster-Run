  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
local u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local u2 = Knit.GetService("EffectService");
game:GetService("CollectionService");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsHandler);

return {
    Inherit = "Bike",
    Animator = "MotorcycleAnimator",
    ItemId = "MOUNT_15",
    MovementProperties = {
        MAX_SPEED = 75,
        FOV_SHIFT = 30,
        MOTIONAL_ACCELERATION = 1.5
    },

    OnSetup = function(u3) -- Line: 29, Name: OnSetup
        -- upvalues: ParticleHandler (copy), Trove (copy), u1 (copy), u2 (copy)
        ParticleHandler.EnableAllParticles(u3.Model, false);
        local u4 = false;
        local SideSeat = u3.Model.SideSeat;
        local ProximityAttachment = SideSeat.ProximityAttachment;
        local Interaction = ProximityAttachment.Interaction;
        Interaction.Triggered:Connect(function(u5) -- Line: 38
            -- upvalues: u3 (copy), u4 (ref), Trove (ref), Interaction (copy), u1 (ref), ProximityAttachment (copy), SideSeat (copy)
            local Character = u5.Character;

            if u5 ~= u3.Player and (not u4 and (Character:IsDescendantOf(game) and not (Character:GetAttribute("InCombat") or (Character:GetAttribute("CantBike") or (Character:GetAttribute("MoveActive") or Character:GetAttribute("Mount")))))) then
                local u6 = Trove.new();
                u6:AttachToInstance(Character);
                u6:AttachToInstance(u3.Model);
                local u7 = {};
                u6:Add(function() -- Line: 49
                    -- upvalues: u4 (ref), Interaction (ref), Character (copy), u1 (ref), u5 (copy), u7 (copy)
                    u4 = false;
                    Interaction.Enabled = true;

                    if Character:IsDescendantOf(game) then
                        Character:SetAttribute("CantBike", nil);
                        u1.ChangeCollision(Character, "Default");
                        u1.SetNetworkOwnerModel(Character, u5);

                        for i, v in u7 do
                            if i:IsDescendantOf(game) then
                                i.Massless = v;
                            end;
                        end;
                    end;
                end);
                u6:Connect(Character.Humanoid:GetPropertyChangedSignal("Jump"), function(p8) -- Line: 65
                    -- upvalues: Character (copy), u6 (copy)
                    if Character.Humanoid.Jump then
                        u6:Destroy();
                    end;
                end);

                for _, descendant in Character:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant:SetNetworkOwner(u3.Player);
                        u7[descendant] = descendant.Massless;
                        descendant.Massless = true;
                    end;
                end;

                u4 = true;
                Interaction.Enabled = false;
                Character:SetAttribute("CantBike", true);
                u1.ChangeCollision(Character, "NoCollision");
                Character.HumanoidRootPart:PivotTo(ProximityAttachment.WorldCFrame);
                u6:Add(u1.BindParts(SideSeat, Character.HumanoidRootPart, {
                    Offset0 = CFrame.new(1, -0.6, 0.5) * CFrame.Angles(0, 3.141592653589793, 0)
                }));
                u6:Add(u1.RestrainCharacter(Character));
                local v9 = u6:Construct(Instance, "Animation");
                v9.Name = "Bat Seat";
                v9.AnimationId = "rbxassetid://" .. 17614985541;
                local v10 = Character.Humanoid.Animator:LoadAnimation(v9);
                v10:Play();
                u6:Add(v10, "Stop");
            end;
        end);
        u3.Model.PrimaryPart.Equip:Play();
        u3.Model.PrimaryPart.Idle:Play();
        task.delay(1, u2.FireAllClients, "Batbike Active", u3.Character);
    end,

    OnMove = function(u11, p12) -- Line: 115, Name: OnMove
        -- upvalues: ParticleHandler (copy)
        for _, descendant in u11.Model:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                if descendant.Parent.Name == "ImpactBurst" and p12 then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
                end;

                descendant.Enabled = p12;
            end;
        end;

        if u11.MovementLoop then
            u11.MovementLoop:Disconnect();
        end;

        local PrimaryPart = u11.Model.PrimaryPart;

        if p12 then
            u11.MovementLoop = u11.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 133
                -- upvalues: u11 (copy), PrimaryPart (copy)
                local Magnitude = (Vector3.new(1, 0, 1) * u11.Character.HumanoidRootPart.Velocity).Magnitude;
                PrimaryPart.MovementLoop.Volume = Magnitude / 40;
                PrimaryPart.Music.Volume = Magnitude / 25;
            end);
        end;

        u11.Model.PrimaryPart.Music.Playing = p12;
        PrimaryPart.MovementLoop.Playing = p12;
        PrimaryPart.Flames.Playing = p12;
        PrimaryPart.Bats.Playing = p12;
        u11.Model.PrimaryPart.MoveStart[p12 and "Play" or "Stop"](u11.Model.PrimaryPart.MoveStart);
        ParticleHandler.EnableParticleTrails(u11.Model, p12, { "WheelTrail" });
    end
};