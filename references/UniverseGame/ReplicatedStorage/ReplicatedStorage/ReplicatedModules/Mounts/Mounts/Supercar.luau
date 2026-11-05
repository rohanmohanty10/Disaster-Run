  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
local u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");
game:GetService("CollectionService");
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsHandler);

return {
    Inherit = "Noobie",
    ItemId = "MOUNT_5",
    Animator = "SupercarAnimator",
    Model = game.ReplicatedStorage["Client Assets"].Mounts["2021 Koenigsegg Jesko // Rosh"],
    MovementProperties = {
        CHARACTER_TILT_MULTIPLIER = 0,
        MAX_SPEED = 250,
        BACKWARD_MAX_SPEED = -120,
        HOVER_HEIGHT = 3.5
    },

    OnSetup = function(u2) -- Line: 31, Name: OnSetup
        -- upvalues: Trove (copy), u1 (copy)
        local u3 = false;
        local SideSeat = u2.Model.BikeRoot.SideSeat;
        local ProximityAttachment = SideSeat.ProximityAttachment;
        local Interaction = ProximityAttachment.Interaction;
        Interaction.Triggered:Connect(function(u4) -- Line: 38
            -- upvalues: u2 (copy), u3 (ref), Trove (ref), Interaction (copy), u1 (ref), ProximityAttachment (copy), SideSeat (copy)
            local Character = u4.Character;

            if u4 ~= u2.Player and (not u3 and (Character:IsDescendantOf(game) and not (Character:GetAttribute("InCombat") or (Character:GetAttribute("CantBike") or (Character:GetAttribute("MoveActive") or Character:GetAttribute("Mount")))))) then
                local u5 = Trove.new();
                u5:AttachToInstance(Character);
                u5:AttachToInstance(u2.Model);
                local u6 = {};
                u5:Add(function() -- Line: 49
                    -- upvalues: u3 (ref), Interaction (ref), Character (copy), u1 (ref), u4 (copy), u6 (copy)
                    u3 = false;
                    Interaction.Enabled = true;

                    if Character:IsDescendantOf(game) then
                        Character:SetAttribute("CantBike", nil);
                        u1.ChangeCollision(Character, "Default");
                        u1.SetNetworkOwnerModel(Character, u4);

                        for i, v in u6 do
                            if i:IsDescendantOf(game) then
                                i.Massless = v;
                            end;
                        end;
                    end;
                end);
                u5:Connect(Character.Humanoid:GetPropertyChangedSignal("Jump"), function(p7) -- Line: 65
                    -- upvalues: Character (copy), u5 (copy)
                    if Character.Humanoid.Jump then
                        u5:Destroy();
                    end;
                end);

                for _, descendant in Character:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant:SetNetworkOwner(u2.Player);
                        u6[descendant] = descendant.Massless;
                        descendant.Massless = true;
                    end;
                end;

                u3 = true;
                Interaction.Enabled = false;
                Character:SetAttribute("CantBike", true);
                u1.ChangeCollision(Character, "NoCollision");
                Character.HumanoidRootPart:PivotTo(ProximityAttachment.WorldCFrame);
                u5:Add(u1.BindParts(SideSeat, Character.HumanoidRootPart, {
                    Offset0 = CFrame.new() * CFrame.Angles(0, 3.141592653589793, 0)
                }));
                u5:Add(u1.RestrainCharacter(Character));
                local v8 = u5:Construct(Instance, "Animation");
                v8.Name = "Bat Seat";
                v8.AnimationId = "rbxassetid://" .. 17614985541;
                local v9 = Character.Humanoid.Animator:LoadAnimation(v8);
                v9:Play();
                u5:Add(v9, "Stop");
            end;
        end);
    end
};