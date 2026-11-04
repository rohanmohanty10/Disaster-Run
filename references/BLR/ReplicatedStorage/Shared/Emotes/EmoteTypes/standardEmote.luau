  

local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.BLRTypes);

return function(u1: table) -- Line: 24, Name: standardEmote
    -- upvalues: Trove (copy), SoundService (copy), RunService (copy)
    local Animation = Instance.new("Animation");
    Animation.AnimationId = u1.animationId;

    return {
        meta = u1.meta,
        animationId = u1.animationId,

        play = function(u2: userdata, p3: any) -- Line: 31, Name: play
            -- upvalues: Trove (ref), Animation (copy), u1 (copy), SoundService (ref), RunService (ref)
            local Humanoid = u2:FindFirstChild("Humanoid");
            local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart");
            local v4;

            if Humanoid then
                v4 = Humanoid:FindFirstChild("Animator");
            else
                v4 = Humanoid;
            end;

            if not (HumanoidRootPart and (Humanoid and v4)) then
                return nil;
            end;

            local u5 = Trove.new();
            local v6 = v4:LoadAnimation(Animation);
            v6:Play();

            if p3 == "Game" then
                v6.Looped = u1.looped ~= false;
                u5:Add(v6.Ended:Once(function() -- Line: 46
                    -- upvalues: u5 (copy)
                    u5:Destroy();
                end));
            else
                v6.Looped = true;
            end;

            v6.Priority = Enum.AnimationPriority.Action4;
            u5:Add(v6, "Stop");

            if p3 ~= "VisualUI" and u1.sound then
                local v7 = u1.sound:Clone();
                v7.SoundGroup = SoundService.Emotes;
                v7.Parent = HumanoidRootPart;
                v7:Play();
                u5:Add(v7);
            end;

            if p3 ~= "VisualUI" and u1.effect then
                u5:Add(u1.effect(u2, v6, p3));
            end;

            local u8 = u5:WrapClean();

            if p3 == "Game" then
                local u9 = u1.maxWalkDistance or 6;
                local Position = HumanoidRootPart.Position;
                u5:Add(RunService.Heartbeat:Connect(function() -- Line: 76
                    -- upvalues: HumanoidRootPart (copy), Position (copy), u9 (copy), u2 (copy), u8 (copy)
                    if u9 < (HumanoidRootPart.Position - Position).Magnitude or not u2.Parent then
                        u8();
                    end;
                end));
            end;

            return u8;
        end
    };
end;