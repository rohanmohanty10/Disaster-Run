  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");
local u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function ConstrainTo360(p3) -- Line: 12
    return (p3 % 360 + 360) % 360;
end;

local Tween = require(PathShortcuts.ReplicatedModules.Petal)("Util").Tween;

return {
    Type = "Hoverboard",
    Animator = "TesseractAnimator",
    Inherit = "Hoverboard",
    ItemId = "MOUNT_37",
    MovementProperties = {
        CHARACTER_TILT_MULTIPLIER = 0.15,
        MAX_SPEED = 100,
        BACKWARD_MAX_SPEED = -65,
        MOTIONAL_ACCELERATION = 1.35,
        ROTATIONAL_ACCELERATION = 0.075,
        MOTIONAL_DECELERATION = 1.25,
        HOVER_INFLUENCE = 3,
        HOVER_HEIGHT = 9,
        ALIGN_NORMAL = false
    },

    OnSetup = function(p4) -- Line: 34, Name: OnSetup
        -- upvalues: u1 (copy)
        local _ = p4.Model;
        local Character = p4.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local Attachment = Instance.new("Attachment");
        local v5 = math.random(1, 10000000);
        Attachment.Parent = HumanoidRootPart;
        Attachment.Name = "Tesseract_Reference";
        Attachment:SetAttribute("Seed", v5);
        u1.FireAllClients("Tesseract_Mount", {
            Reference = Attachment,
            Character = Character,
            Seed = v5
        });
        local PrimaryPart = p4.Model.PrimaryPart;
        PrimaryPart.IdleLoop.Playing = true;
        PrimaryPart.MovementLoop.Playing = true;
        PrimaryPart.MovementLoop.Volume = 0;
        PrimaryPart.Summon:Play();
    end,

    OnDestroy = function(p6) -- Line: 59, Name: OnDestroy
        -- upvalues: u1 (copy)
        local HumanoidRootPart = p6.Character:FindFirstChild("HumanoidRootPart");
        local PrimaryPart = p6.Model.PrimaryPart;
        u1.FireAllClients("Play Sound At", {
            Object = PrimaryPart.Unsummon,
            Origin = PrimaryPart.CFrame
        });

        if HumanoidRootPart:FindFirstChild("Tesseract_Reference") then
            HumanoidRootPart:FindFirstChild("Tesseract_Reference"):Destroy();
        end;
    end,

    DisplayModel = script.TesseractModel,

    OnMove = function(u7, p8) -- Line: 79, Name: OnMove
        -- upvalues: Tween (copy)
        local _ = u7.Model;
        local PrimaryPart = u7.Model.PrimaryPart;

        if u7.MovementLoop then
            u7.MovementLoop:Disconnect();
        end;

        if p8 then
            u7.MovementLoop = u7.Trove:Connect(game["Run Service"].Heartbeat, function() -- Line: 88
                -- upvalues: u7 (copy), PrimaryPart (copy)
                PrimaryPart.MovementLoop.Volume = (Vector3.new(1, 0, 1) * u7.Character.HumanoidRootPart.Velocity).Magnitude / 40;
            end);
        end;

        if p8 then
            Tween(PrimaryPart.IdleLoop, 1, "Linear", "InOut", {
                Volume = 0.3
            });
            Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
                Volume = 1
            });
        else
            Tween(PrimaryPart.IdleLoop, 1, "Linear", "InOut", {
                Volume = 1.5
            });
            Tween(PrimaryPart.MovementLoop, 1, "Linear", "InOut", {
                Volume = 0
            });
        end;

        u7.Model.PrimaryPart.Movement[p8 and "Play" or "Stop"](u7.Model.PrimaryPart.Movement);
    end,

    Skills = {
        Jump = function(p9, p10, p11) -- Line: 107, Name: Jump
            -- upvalues: u2 (copy), u1 (copy)
            local _ = p9.Model;
            local PrimaryPart = p9.Model.PrimaryPart;
            local Character = p9.Character;

            if Character:GetAttribute("Tesseract_CD") then
                return;
            end;

            Character:SetAttribute("Tesseract_CD", true);
            task.delay(10, function() -- Line: 118
                -- upvalues: Character (copy)
                Character:SetAttribute("Tesseract_CD", nil);
            end);
            local HumanoidRootPart = Character.HumanoidRootPart;
            local _ = Character.Humanoid;
            local u12 = game:GetService("Players"):GetPlayerFromCharacter(Character);

            if not (u12 and p10) then
                return;
            end;

            local Tesseract_Reference = HumanoidRootPart:FindFirstChild("Tesseract_Reference");

            if not Tesseract_Reference then
                return;
            end;

            local v13 = Tesseract_Reference:GetAttribute("Seed");
            local v14 = Random.new(v13);
            local v15 = v14:NextInteger(1, 5);
            local v16 = v15 <= 3 and 3 or (v15 == 4 and 2 or 1);
            local v17 = nil;
            local v18 = nil;

            if v16 == 3 then
                local v19 = v14:NextNumber(0, 360);
                local v20 = ((v19 + (v14:NextInteger(1, 2) == 1 and 120 or -120)) % 360 + 360) % 360;
                v17 = Color3.fromHSV(v19 / 360, 0.588235 + v14:NextNumber(-0.1, 0.1), 0.9);
                v18 = Color3.fromHSV(v20 / 360, 0.588235 + v14:NextNumber(-0.1, 0.1), 0.9);
            elseif v16 == 1 then
                v17 = Color3.fromRGB(15, 15, 15);
                v18 = Color3.fromRGB(152, 152, 152);
            elseif v16 == 2 then
                v17 = Color3.fromRGB(152, 152, 152);
                v18 = Color3.fromRGB(15, 15, 15);
            end;

            local u21 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v17), ColorSequenceKeypoint.new(1, v18) });

            if PrimaryPart:FindFirstChild("Warp") then
                PrimaryPart:FindFirstChild("Warp"):Play();
            end;

            local Position = u2.GetMetadata(Character).CFrame.Position;
            local v22 = Position + Vector3.new(0, 25, 0);
            local v23 = u2.RaycastMap(Position, Vector3.new(0, 25, 0));

            if v23 and v23.Position then
                local Position2 = v23.Position;
                local v24 = Character:GetExtentsSize().Y / 2;
                v22 = Position2 - Vector3.new(0, v24, 0);
            end;

            ({
                WorldAxis = Vector3.new(0, 1, 0)
            }).WorldPosition = Position;
            local Magnitude = (Position - v22).Magnitude;
            u1.FireAllClients("Generate Quasiduck Lightning", Character, {
                Speed = 7,
                Length = 2.25,
                Sparks = true,
                Size = 2,
                FadeLength = 0.1,
                AnimationSpeed = 10,
                Explosion = nil,
                Color = u21,
                A1 = {
                    WorldAxis = Vector3.new(0, 1, 0),
                    WorldPosition = Position
                },
                A2 = HumanoidRootPart:FindFirstChildOfClass("Attachment"),
                Curves = { 0, 0 },
                MinRadius = 0.5 + Magnitude / 50,
                MaxRadius = 4 + Magnitude / 50
            });
            task.delay(0.1, function() -- Line: 188
                -- upvalues: Character (copy), u1 (ref), u12 (copy), u2 (ref), u21 (copy), HumanoidRootPart (copy)
                if not (Character and (Character.Parent and Character:GetAttribute("Mount"))) then
                    return;
                end;

                u1.FireClient(u12, "CameraShake", 5.5, 13, 0, 0.45, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1), true);
                local v25 = u2.GetMetadata(Character);
                local Position2 = v25.CFrame.Position;
                local v26 = Position2 + Vector3.new(0, 25, 0);
                local v27 = u2.RaycastMap(Position2, Vector3.new(0, 25, 0));

                if v27 and v27.Position then
                    local Position3 = v27.Position;
                    local v28 = Character:GetExtentsSize().Y / 2;
                    v26 = Position3 - Vector3.new(0, v28, 0);
                end;

                local v29 = v25.CFrame * CFrame.new(0, (Position2 - v26).Magnitude, 0);
                u1.FireAllClients("Generate Quasiduck Lightning", Character, {
                    Size = 0,
                    Color = u21,
                    Explosion = {
                        Size = 25,
                        Position = v29.Position,
                        Color = u21
                    }
                });
                HumanoidRootPart.CFrame = v29 + v25.Velocity / 10;
            end);
        end
    }
};