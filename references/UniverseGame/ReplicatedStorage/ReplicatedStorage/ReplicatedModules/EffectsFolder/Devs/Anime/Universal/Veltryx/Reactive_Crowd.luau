  

 

local Players = game:GetService("Players");
local SoundGroups = require(game.ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
local LocalPlayer = Players.LocalPlayer;
local u1 = false;
local Sounds = script.Sounds;

local function PlaySound(p2) -- Line: 8
    -- upvalues: SoundGroups (copy)
    SoundGroups:AssignSoundToSoundGroup(p2, "Ambience");
    p2:Play();
end;

local function HealthReactive(u3, u4) -- Line: 13
    -- upvalues: u1 (ref), Sounds (copy), SoundGroups (copy)
    local Humanoid = u3.Humanoid;
    local u5 = u4 and 150 or 75;
    local Health = Humanoid.Health;
    local u6 = 0;
    local u7 = os.clock();
    local u8 = nil;
    u8 = Humanoid.HealthChanged:Connect(function(p9) -- Line: 25
        -- upvalues: u1 (ref), u3 (copy), u8 (ref), Health (ref), u7 (ref), u6 (ref), u5 (copy), Sounds (ref), u4 (copy), SoundGroups (ref)
        if not (u1 and u3:IsDescendantOf(game)) then
            u8:Disconnect();
            u8 = nil;

            return;
        end;

        local v10 = Health - p9;

        if v10 < 0 then
            return;
        end;

        Health = p9;
        local v11 = os.clock() - u7;
        u7 = os.clock();

        if v11 > 3 then
            u6 = 0;
        end;

        u6 = u6 + v10;

        if u5 <= u6 then
            u6 = 0;
            local v12 = Sounds[`Crowd {u4 and "Cheer" or "Disappointed"} - {math.random(1, 5)}`];
            SoundGroups:AssignSoundToSoundGroup(v12, "Ambience");
            v12:Play();
        end;
    end);
end;

local function BlockReactive(u13, u14) -- Line: 57
    -- upvalues: u1 (ref), Sounds (copy), SoundGroups (copy)
    for _, v in { "PerfectBlocked", "BlockBroken" } do
        local u15 = nil;
        u15 = u13:GetAttributeChangedSignal(v):Connect(function() -- Line: 60
            -- upvalues: u1 (ref), u13 (copy), u15 (ref), v (copy), u14 (copy), Sounds (ref), SoundGroups (ref)
            if u1 and u13:IsDescendantOf(game) then
                if u13:GetAttribute(v) then
                    if u14 then
                        local v16 = Sounds[`Crowd In Awe - {math.random(1, 2)}`];
                        SoundGroups:AssignSoundToSoundGroup(v16, "Ambience");
                        v16:Play();

                        return;
                    end;

                    local v17 = Sounds[`Crowd Disappointed - {math.random(1, 5)}`];
                    SoundGroups:AssignSoundToSoundGroup(v17, "Ambience");
                    v17:Play();
                end;

                return;
            end;

            u15:Disconnect();
            u15 = nil;
        end);
    end;
end;

return function(p18, ...) -- Line: 79
    -- upvalues: u1 (ref), Sounds (copy), SoundGroups (copy), LocalPlayer (copy), BlockReactive (copy)
    if p18 == "Start" then
        if u1 then
            return;
        end;

        u1 = true;
        Sounds.Idle.Muffler.Enabled = true;
        local Idle = Sounds.Idle;
        SoundGroups:AssignSoundToSoundGroup(Idle, "Ambience");
        Idle:Play();

        return;
    end;

    if p18 == "Entered" then
        local u19 = ... or LocalPlayer.Character;
        Sounds.Idle.Muffler.Enabled = false;
        local v20 = Sounds[`Crowd Cheer - {math.random(1, 5)}`];
        SoundGroups:AssignSoundToSoundGroup(v20, "Ambience");
        v20:Play();
        local Humanoid = u19.Humanoid;
        local Health = Humanoid.Health;
        local u21 = 0;
        local u22 = os.clock();
        local u23 = nil;
        local u24 = 75;
        local u25 = false;
        u23 = Humanoid.HealthChanged:Connect(function(p26) -- Line: 25
            -- upvalues: u1 (ref), u19 (copy), u23 (ref), Health (ref), u22 (ref), u21 (ref), u24 (copy), Sounds (ref), u25 (copy), SoundGroups (ref)
            if not (u1 and u19:IsDescendantOf(game)) then
                u23:Disconnect();
                u23 = nil;

                return;
            end;

            local v27 = Health - p26;

            if v27 < 0 then
                return;
            end;

            Health = p26;
            local v28 = os.clock() - u22;
            u22 = os.clock();

            if v28 > 3 then
                u21 = 0;
            end;

            u21 = u21 + v27;

            if u24 <= u21 then
                u21 = 0;
                local v29 = Sounds[`Crowd {u25 and "Cheer" or "Disappointed"} - {math.random(1, 5)}`];
                SoundGroups:AssignSoundToSoundGroup(v29, "Ambience");
                v29:Play();
            end;
        end);
        BlockReactive(u19, false);

        return;
    end;

    if p18 ~= "AddNPC" then
        if p18 == "End" then
            if not u1 then
                return;
            end;

            u1 = false;
            Sounds.Idle:Stop();
        end;

        return;
    end;

    local u30 = ...;
    local v31 = Sounds[`Crowd Cheer - {math.random(1, 5)}`];
    SoundGroups:AssignSoundToSoundGroup(v31, "Ambience");
    v31:Play();
    local Humanoid = u30.Humanoid;
    local Health = Humanoid.Health;
    local u32 = 0;
    local u33 = os.clock();
    local u34 = nil;
    local u35 = 150;
    local u36 = true;
    u34 = Humanoid.HealthChanged:Connect(function(p37) -- Line: 25
        -- upvalues: u1 (ref), u30 (copy), u34 (ref), Health (ref), u33 (ref), u32 (ref), u35 (copy), Sounds (ref), u36 (copy), SoundGroups (ref)
        if not (u1 and u30:IsDescendantOf(game)) then
            u34:Disconnect();
            u34 = nil;

            return;
        end;

        local v38 = Health - p37;

        if v38 < 0 then
            return;
        end;

        Health = p37;
        local v39 = os.clock() - u33;
        u33 = os.clock();

        if v39 > 3 then
            u32 = 0;
        end;

        u32 = u32 + v38;

        if u35 <= u32 then
            u32 = 0;
            local v40 = Sounds[`Crowd {u36 and "Cheer" or "Disappointed"} - {math.random(1, 5)}`];
            SoundGroups:AssignSoundToSoundGroup(v40, "Ambience");
            v40:Play();
        end;
    end);
    BlockReactive(u30, true);
end;