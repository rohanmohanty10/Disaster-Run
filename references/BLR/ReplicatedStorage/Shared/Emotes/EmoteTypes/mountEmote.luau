  

local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.BLRTypes);

return function(u1: table) -- Line: 32, Name: mountEmote
    -- upvalues: Trove (copy), SoundService (copy), RunService (copy)
    local u2 = {};

    for i, v in pairs(u1.anims) do
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v;
        u2[i] = Animation;
    end;

    return {
        isMount = true,
        meta = u1.meta,
        anims = u1.anims,

        play = function(u3: userdata, p4: any) -- Line: 48, Name: play
            -- upvalues: Trove (ref), u1 (copy), u2 (copy), SoundService (ref), RunService (ref)
            local Humanoid = u3:FindFirstChild("Humanoid");
            local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");
            local v5;

            if Humanoid then
                v5 = Humanoid:FindFirstChild("Animator");
            else
                v5 = Humanoid;
            end;

            if not (HumanoidRootPart and (Humanoid and v5)) then
                return nil;
            end;

            local v6 = Trove.new();
            local v7 = p4 == "Game" and "idle" or (u1.trackToDisplay or "walk");
            local u8 = {};

            for i, v in pairs(u2) do
                local v9 = v5:LoadAnimation(v);

                if i == v7 then
                    v9:Play();
                end;

                if p4 == "Game" then
                    v9.Looped = u1.looped ~= false;
                else
                    v9.Looped = true;
                end;

                v9.Priority = Enum.AnimationPriority.Action4;
                u8[i] = v9;
                v6:Add(v9, "Stop");
            end;

            if p4 ~= "VisualUI" and u1.sound then
                local v10 = u1.sound:Clone();
                v10.SoundGroup = SoundService.Emotes;
                v10.Parent = HumanoidRootPart;
                v10:Play();
                v6:Add(v10);
            end;

            local u11;

            if p4 == "VisualUI" or not u1.init then
                u11 = nil;
            else
                u11 = table.pack(u1.init(u3, u8, p4));
                v6:Add(u11[1]);
                table.remove(u11, 1);
            end;

            local u12 = v6:WrapClean();
            local u13 = "idle";

            if p4 == "Game" then
                local _ = HumanoidRootPart.Position;
                local u14 = tick();
                local u15 = nil;
                v6:Add(RunService.Heartbeat:Connect(function() -- Line: 104
                    -- upvalues: HumanoidRootPart (copy), u14 (copy), u12 (copy), u15 (ref), u13 (ref), u8 (copy), u1 (ref), u3 (copy), u11 (ref)
                    if HumanoidRootPart.AssemblyLinearVelocity.Y >= 5 and tick() - u14 > 1 then
                        u12();

                        return;
                    end;

                    local Magnitude = (HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude;

                    if Magnitude >= 5 then
                        u15 = nil;
                    elseif not u15 then
                        u15 = tick();
                    end;

                    if Magnitude >= 5 and u13 ~= "walk" then
                        u13 = "walk";
                        print("Walking");
                        u8.idle:Stop();
                        u8.walk:Play();

                        if u1[u13] then
                            u1[u13](u3, u8[u13], table.unpack(u11));
                        end;
                    elseif Magnitude < 5 and u13 ~= "idle" and tick() - (u15 or tick()) >= 0.25 then
                        u13 = "idle";
                        print("Idle");
                        u8.walk:Stop();
                        u8.idle:Play();

                        if u1[u13] then
                            u1[u13](u3, u8[u13], table.unpack(u11));
                        end;
                    end;
                end));
            end;

            return u12;
        end
    };
end;