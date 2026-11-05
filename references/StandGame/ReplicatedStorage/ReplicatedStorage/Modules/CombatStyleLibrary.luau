 

 

local l__ServerStorage__1 = game:GetService("ServerStorage");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__StandLibrary__3 = require(l__ServerStorage__1.Modules.StandLibrary);
local l__Sounds__4 = l__ReplicatedStorage__2:WaitForChild("Sounds");
l__ReplicatedStorage__2:WaitForChild("Objects");
local l__Anims__5 = l__ServerStorage__1:WaitForChild("Anims");
local l__CollectionService__6 = game:GetService("CollectionService");
return {
    SwordStyle = function(p1, ...) --[[ Line: 10 ]]
        local v2 = ...;
        if p1 == "ReturnDamage_Info" then
            local v3 = {
                Damage = 7,
                Knockback = 50,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                Weapon = "Sword",
                Style = "Default Combat",
                KnockbackDirection = v2.Hit and (v2.Hit.Position - v2.Origin.Position).unit or v2.Origin.CFrame.lookVector,
                Tag = {
                    Name = v2.Tag,
                    Timer = v2.Timer
                },
                Stun = {
                    Timer = 1,
                    Name = v2.Tag
                },
                Sound = {
                    Sound = "Blade_Hit1",
                    Origin = v2.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v2.Hit
                },
                Knockback = 50,
                IsCharacterMelee = true
            };
            if v2.Combo == "Pierce Strike" then
                v3.Stun.Timer = 0.45;
                v3.PerfectBlockable = nil;
                v3.Knockback = nil;
                v3.Knockback2 = nil;
                v3.Knock = nil;
                v3.Damage = 8;
                v3.IgnoreSturdiness = false;
                v3.DontStandCrash = true;
                return v3;
            end;
            if v2.Combo == "Crescent Slice" then
                v3.Stun.Timer = 0.8;
                v3.Knockback = 0;
                return v3;
            end;
            if v2.Combo == "Unsealed Steel" then
                v3.Stun.Timer = 1;
                v3.Knockback = 0;
                v3.Damage = 17.5;
                v3.HitEffect.Type = "SharpHeavy";
                v3.Sound.Sound = "Blade_Hit4";
                return v3;
            end;
            if v2.Combo == "Mortal Slash" then
                v3.Stun.Timer = 0.5;
                v3.Knockback = 30;
                v3.Knockback2 = 60;
                v3.Damage = 15;
                v3.Knock = 1;
                v3.Sound.Sound = "Blade_Hit4";
                return v3;
            end;
            if v2.Combo ~= "Blitz Strike" then
                if v2.Combo == "Cookie Beam" then
                    v3.Damage = 0;
                    v3.Stun.Timer = 0.5;
                    v3.Knockback = 0;
                    v3.Sound.Sound = "Gore_Splatter2";
                    v3.BlockBreaker = true;
                end;
                return v3;
            end;
            v3.Stun.Timer = 0.5;
            v3.Knockback = 120;
            v3.Knockback2 = 25;
            v3.Knock = 0.3;
            v3.Beatdown = true;
            v3.IgnoreSturdiness = true;
            v3.BlockBreaker = true;
            return v3;
        end;
        if p1 == "ReturnHitbox" then
            return Vector3.new(5, 5, 6.5);
        end;
    end,
    ["Shadow The World"] = function(p4, ...) --[[ Line: 88 ]]
        -- upvalues: l__Anims__5 (copy)
        local v5 = ...;
        local v6 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.335,
            Cooldown = 1.25,
            Style = "DefaultCombat",
            Animations = l__Anims__5.ShadowTheWorldCombat
        };
        if p4 == "ReturnConfig" then
            return v6;
        end;
        if p4 == "ReturnDamage_Info" then
            local v7 = {
                Damage = 9,
                Knockback = 45,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.75,
                Weapon = "Fists",
                KnockbackDirection = v5.Hit and (v5.Hit.Position - v5.Origin.Position).unit or v5.Origin.CFrame.lookVector,
                Style = v6.Style,
                Tag = {
                    Name = v5.Tag,
                    Timer = v5.Timer
                },
                Stun = {
                    Name = v5.Tag,
                    Timer = v6.Speed - v6.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v5.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v5.Hit
                },
                IsCharacterMelee = true
            };
            if v5.Combo ~= "Heavy" then
                if v5.Combo < v6.MaxCombo then
                    v7.Knockback = 20;
                    v7.Knockback2 = 8;
                    v7.Knock = 0;
                    if v5.Combo < v6.MaxCombo - 1 then
                        v7.Stun.Timer = v6.Speed;
                    end;
                end;
                return v7;
            end;
            v7.HitEffect.Type = "Heavy";
            v7.Sound = {
                Sound = "Fist_Hit3",
                Origin = v5.Hit
            };
            v7.Knock = 1;
            v7.BlockBreaker = true;
            v7.PerfectBlockable = true;
            v7.Damage = v7.Damage * 2.5;
            return v7;
        end;
        if p4 == "ReturnHitbox" then
            return Vector3.new(5.3, 6.5, 4);
        end;
    end,
    DefaultCombat = function(p8, ...) --[[ Line: 145 ]]
        -- upvalues: l__Anims__5 (copy)
        local v9 = ...;
        local v10 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.35,
            Cooldown = 1.25,
            Style = "DefaultCombat",
            Animations = l__Anims__5.DefaultCombat
        };
        if p8 == "ReturnConfig" then
            return v10;
        end;
        if p8 == "ReturnDamage_Info" then
            local v11 = {
                Damage = 4,
                Knockback = 45,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.75,
                Weapon = "Fists",
                KnockbackDirection = v9.Hit and (v9.Hit.Position - v9.Origin.Position).unit or v9.Origin.CFrame.lookVector,
                Style = v10.Style,
                Tag = {
                    Name = v9.Tag,
                    Timer = v9.Timer
                },
                Stun = {
                    Name = v9.Tag,
                    Timer = v10.Speed - v10.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v9.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v9.Hit
                },
                IsCharacterMelee = true
            };
            if v9.Combo == "Heavy" then
                v11.HitEffect.Type = "Heavy";
                v11.Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v9.Hit
                };
                v11.Knock = 1;
                v11.BlockBreaker = true;
                v11.PerfectBlockable = true;
                v11.Damage = v11.Damage + 2;
                return v11;
            end;
            if v9.Combo ~= "Serious Punch" then
                if v9.Combo < v10.MaxCombo then
                    v11.Knockback = 10;
                    v11.Knockback2 = 5;
                    v11.Knock = 0;
                    if v9.Combo < v10.MaxCombo - 1 then
                        v11.Stun.Timer = v10.Speed;
                    end;
                end;
                return v11;
            end;
            v11.Sound = {
                Sound = { "OPFistHit", "HeavyPushHit", "Knockback1" },
                Origin = v9.Hit
            };
            v11.Knock = 30;
            v11.IgnoreBlock = true;
            v11.PerfectBlockable = nil;
            v11.Damage = 225;
            v11.Knockback = 350;
            v11.Knockback2 = 225;
            v11.HitEffect.Type = "Jaw Breaker";
            v11.HyperArmor = true;
            v11.IgnoreInvincibility = true;
            v11.NoDamageCancel = true;
            v11.IgnoreSturdiness = true;
            v11.NoIFrames = true;
            v11.BypassCounters = true;
            return v11;
        end;
        if p8 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.5);
        end;
    end,
    ["Six Pistols"] = function(p12, ...) --[[ Line: 215 ]]
        local v13 = ...;
        if p12 == "ReturnDamage_Info" then
            local v14 = {
                Damage = 8.5,
                Knockback = 0,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                Weapon = "Gun",
                IgnoreBlock = true,
                IgnoreBlock2 = true,
                Style = "Stand",
                Tag = {
                    Name = v13.Tag,
                    Timer = v13.Timer
                },
                Stun = {
                    Timer = 0.3,
                    Name = v13.Tag
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 3),
                    Origin = v13.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v13.Hit
                },
                IsProjectile = true,
                NoDamageCancel = true
            };
            local _ = v13.Combo == "Sample";
            return v14;
        end;
    end,
    ["Humanoid Stand"] = function(p15, ...) --[[ Line: 246 ]]
        -- upvalues: l__StandLibrary__3 (copy), l__Anims__5 (copy), l__ReplicatedStorage__2 (copy), l__Sounds__4 (copy), l__ServerStorage__1 (copy), l__CollectionService__6 (copy)
        local v16 = ...;
        local v17 = l__StandLibrary__3.Stands[v16.Stand];
        local v18 = {
            MaxCombo = 5,
            Blocking_Capacity = 76,
            Speed = 0.35,
            Cooldown = 1.25,
            Style = "DefaultCombat",
            Animations = l__Anims__5["Humanoid Stand Combat"]
        };
        local v19 = l__Anims__5:FindFirstChild(v16.Stand .. " Combat");
        if v19 then
            v18.Animations = v19;
        end;
        local l__Char__7 = v16.Char;
        if l__Char__7 and (l__Char__7:GetAttribute("SM_Full_Form") or l__Char__7:GetAttribute("SM_Minion")) then
            v18.Animations = l__Anims__5:FindFirstChild(v16.Stand .. " Full Form Combat");
        end;
        local v20 = {
            Attack = true,
            Heavy = true,
            Barrage = true,
            Finisher = true
        };
        if v17 then
            local v21 = ({
                X = 0.175,
                A = 0.315,
                B = 0.325,
                C = 0.335
            })[v17.Speed];
            if v21 and (v16.Combo and (v20[v16.Combo] == true or typeof(v16.Combo) == "number")) then
                v18.Speed = v21;
            end;
        end;
        if p15 == "ReturnConfig" then
            return v18;
        end;
        if p15 ~= "ReturnDamage_Info" then
            if p15 == "ReturnHitbox" then
                return Vector3.new(5, 6, 3.5);
            end;
            return;
        end;
        local l__Parent__8 = v16.Origin.Parent;
        local l__Stand__9 = v16.Stand;
        local v22 = game.Players:GetPlayerFromCharacter(l__Parent__8);
        if not v22 then
            if l__Parent__8 then
                v22 = game.Players:GetPlayerFromCharacter(l__Parent__8.Parent);
            else
                v22 = l__Parent__8;
            end;
        end;
        local v23 = {
            Damage = 4,
            Knockback = 50,
            Knockback2 = 25,
            KnockbackDirection2 = Vector3.new(0, 1, 0),
            Knock = 0.5,
            Weapon = "Fists",
            Stand = true,
            KnockbackDirection = v16.Hit and (v16.Hit.Position - v16.Origin.Position).unit or v16.Origin.CFrame.lookVector,
            Style = v18.Style
        };
        if v17 then
            local v24 = ({
                X = 10,
                Z = 9,
                O = 8.1,
                SSS = 7.5,
                SS = 7,
                ["S+"] = 6.5,
                S = 6,
                A = 5.5,
                B = 5.25,
                C = 5
            })[v17.DestructivePower];
            if v16.Combo and (v20[v16.Combo] == true or typeof(v16.Combo) == "number") then
                v23.Damage = v24 or 4.5;
            end;
        end;
        local v25 = {
            X = 10,
            Z = 2,
            S = 1.3,
            A = 1.2,
            B = 1.1,
            C = 1
        };
        v23.Tag = {
            Name = v16.Tag,
            Timer = v16.Timer
        };
        v23.Stun = {
            Name = v16.Tag,
            Timer = v18.Speed - v18.Speed / 2.5
        };
        v23.Sound = {
            Sound = "Fist_Hit" .. math.random(1, 2),
            Origin = v16.Hit
        };
        v23.HitEffect = {
            Type = "Fists",
            Origin = v16.Hit
        };
        if l__Stand__9 then
            if l__Stand__9 == "Silver Chariot" then
                v23.Sound.Sound = "Blade_Hit4";
                v23.HitEffect.Type = "Blade";
                v23.Knockback = 18;
                v23.Weapon = "Sword";
            elseif l__Stand__9 == "Anubis" then
                v23.Sound.Sound = "SwordHit" .. math.random(1, 2);
                v23.HitEffect.Type = "Blade";
                v23.Knockback = 18;
                v23.Weapon = "Sword";
            elseif l__Stand__9 == "Kikoku" then
                v23.Sound.Sound = "Blade_Hit4";
                v23.HitEffect.Type = "Blade";
                v23.Knockback = 18;
            end;
        end;
        if v16.Combo == "Heavy" then
            if v23.HitEffect.Type == "Fists" then
                v23.HitEffect.Type = "Heavy";
            else
                v23.HitEffect.Type = "SharpHeavy";
            end;
            v23.Sound = {
                Sound = "Fist_Hit3",
                Origin = v16.Hit
            };
            v23.Knock = 1;
            v23.BlockBreaker = true;
            v23.PerfectBlockable = true;
            v23.Damage = v23.Damage * 2;
            if v23.HitEffect.Type == "Blade" then
                v23.Sound.Sound = "SwordHit3";
            end;
        elseif v16.Combo == "Barrage" then
            v23.Knockback = 1;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = v25[v17.BarrageDP];
            v23.Stun.Timer = 0.5;
            v23.HyperArmor = true;
            v23.NoBackBlockBreaks = true;
            v23.Barrage = true;
            v23.IgnoreDP = true;
            if l__Parent__8:GetAttribute("SM_Full_Form") then
                v23.Damage = v23.Damage * 1.363;
            end;
        elseif v16.Combo == "Redirection Barrage" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 35;
            v23.Stun.Timer = 0.5;
            v23.IsProjectile = true;
            v23.HyperArmor = true;
            v23.NoDamageCancel = true;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Time Switch" then
            v23.Damage = 0;
            v23.Stun.Timer = 0.5;
            v23.BlockBreaker = false;
        elseif v16.Combo == "Charisma" then
            v23.BlockBreaker = nil;
            v23.PerfectBlockable = nil;
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound = nil;
            v23.HitEffect = nil;
            v23.Stun = nil;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.HitEffect = nil;
        elseif v16.Combo == "Charisma Countered" then
            v23.BlockBreaker = true;
            v23.PerfectBlockable = nil;
            v23.BypassCounters = true;
            v23.Beatdown = true;
            v23.Stun = nil;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 1;
            v23.Damage = 15.5;
        elseif v16.Combo == "Heavy Chop" then
            v23.IsCharacterMelee = true;
            v23.PerfectBlockable = false;
            v23.BlockBreaker = false;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = nil;
            v23.Damage = 10.86;
            v23.Stun.Timer = 0.8;
            v23.Style = "Finisher";
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds[l__Stand__9]["Heavy Chop"].Hit;
            v23.HyperArmor = true;
            if v23.HitEffect.Type == "Fists" then
                v23.HitEffect.Type = "Heavy";
            else
                v23.HitEffect.Type = "SharpHeavy";
            end;
        elseif v16.Combo == "Knife Barrage" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 3;
            v23.Stun.Timer = 0.75;
            v23.IsProjectile = true;
            v23.HyperArmor = true;
            v23.NoDamageCancel = true;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Stand Combo" then
            v23.Knockback = 35;
            v23.Knockback2 = -5;
            v23.Knock = 0;
            v23.Stun.Timer = 0.8;
            v23.Damage = 4;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
        elseif v16.Combo == "Stand Combo Hit" then
            v23.Knockback = 35;
            v23.Knockback2 = -5;
            v23.Knock = 0;
            v23.IgnoreRagdoll = true;
            v23.IgnoreInvincibility = true;
            v23.Damage = 4;
            v23.Stun.Timer = 0.35;
        elseif v16.Combo == "Punishment" then
            v23.Damage = 16;
            v23.BlockDamage = 55;
            v23.Stun.Timer = 1;
            v23.Knock = 1.5;
            v23.Knockback = 70;
            v23.Knockback2 = nil;
            v23.HyperArmor = true;
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds[l__Stand__9].Punishment.Hit;
        elseif v16.Combo == "Multi Shot" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 15;
            v23.Stun.Timer = 0.3;
            v23.IsProjectile = true;
            v23.HyperArmor = true;
            v23.NoDamageCancel = true;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Prone Shot" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 9;
            v23.Stun.Timer = 0.25;
            v23.BlockBreaker = true;
            v23.IsProjectile = true;
            v23.HyperArmor = true;
            v23.NoBackBlockBreaks = true;
            v23.NoDamageCancel = true;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Kick Barrage" then
            v23.Knockback = 10;
            v23.Knockback2 = -2.5;
            v23.Knock = 0;
            v23.Damage = 0.7;
            v23.Stun.Timer = 0.65;
            v23.HyperArmor = true;
            v23.Sound.Sound = l__Stand__9 .. " Kick Barrage Hit" .. math.random(1, 2);
        elseif v16.Combo == "Arrow Barrage" then
            v23.Knockback = 4;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 0;
            v23.Stun.Timer = 0.35;
            v23.HyperArmor = true;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.HitEffect.Type = "Blade";
            v23.Weapon = "Sword";
        elseif v16.Combo == "Ora Kicks" then
            v23.Knockback = 4;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 1;
            v23.Stun.Timer = 0.6;
            v23.HyperArmor = true;
        elseif v16.Combo == "Bulb Shoot" then
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = nil;
            v23.Stun.Timer = 1;
            v23.Damage = 5;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Killer Virus" then
            v23.Blockable = true;
            v23.Knockback = 30;
            v23.Knockback2 = 10;
            v23.Knock = nil;
            v23.Stun.Timer = 0.5;
            v23.Damage = 10;
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds["Purple Haze"].VirusHit;
        elseif v16.Combo == "Infectious Strike" then
            v23.BlockBreaker = true;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = nil;
            v23.Stun.Timer = 0.5;
            v23.Damage = 3;
        elseif v16.Combo == "Life Beam of Creation" then
            v23.IsProjectile = true;
            v23.Knockback = 10;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 12.42;
            v23.Stun.Timer = 0.8;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Propeller Blades" then
            v23.Knockback = 1;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 0.8;
            v23.Stun.Timer = 0;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
            v23.Weapon = "Sword";
        elseif v16.Combo == "Scorpion" then
            v23.IsProjectile = true;
            v23.BlockBreaker = true;
            v23.Knockback = 60;
            v23.Knockback2 = 30;
            v23.Knock = 1;
            v23.Damage = 15.52;
            v23.Stun.Timer = 0.2;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Propeller Charge" then
            v23.PerfectBlockable = true;
            v23.BlockBreaker = true;
            v23.Knockback = 35;
            v23.Knockback2 = 5;
            v23.Knock = 1;
            v23.Damage = 15;
            v23.Stun.Timer = 0.35;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
            v23.Weapon = "Sword";
        elseif v16.Combo == "Air Support" then
            v23.IsProjectile = true;
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = 12.5;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 27.5;
            v23.Stun.Timer = 0.5;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Emerald Splash" then
            v23.IsProjectile = true;
            v23.BlockBreaker = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = nil;
            v23.Stun.Timer = 0.65;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Emerald Barrage" then
            v23.IsProjectile = true;
            v23.Knockback = 0.5;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = nil;
            v23.Stun.Timer = 0.45;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Hierophant\'s Field" then
            v23.BlockBreaker = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 0;
            v23.Stun.Timer = 0;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "20 Meter Emerald Splash" then
            v23.IsProjectile = true;
            v23.BlockBreaker = nil;
            v23.Blockable = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = nil;
            v23.Stun.Timer = 0;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
            v23.BypassCounters = true;
        elseif v16.Combo == "Vola Barrage" then
            v23.IsProjectile = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 25;
            v23.Stun.Timer = 0.5;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Million Pricks" then
            v23.Knock = 0;
            v23.Knockback = 1;
            v23.Knockback2 = 0;
            v23.Damage = nil;
            v23.Stun.Timer = 0.75;
            v23.Sound.Sound = "Slash_Hit" .. math.random(1, 3);
            v23.HitEffect.Type = "Blade";
            v23.Style = v16.Combo;
        elseif v16.Combo == "Cycle Slash" then
            v23.Knock = 0;
            v23.KnockbackDirection = -(v16.Hit.Position - v16.Origin.Position).unit;
            v23.Knockback = 17.5;
            v23.Knockback2 = 0;
            v23.Damage = 24;
            v23.Stun.Timer = 0.5;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.HitEffect.Type = "Blade";
            v23.Style = v16.Combo;
        elseif v16.Combo == "Last Shot" then
            v23.Knockback = 10;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.IsProjectile = true;
            v23.Blockable = true;
            v23.Damage = 18.78;
            v23.Stun.Timer = 0.8;
            v23.Sound.Sound = "Blade_Hit4";
            v23.HitEffect.Type = "Blade";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Dark Space" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 17.1;
            v23.Stun.Timer = 1.2;
            v23.Style = "Void Ball";
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Cream Void Hit";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Dimension Slash" then
            v23.Knockback = 30;
            v23.Knockback2 = 75;
            v23.Knock = 2;
            v23.Damage = 20;
            v23.BlockBreaker = true;
            v23.Style = "Erasure";
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Gore_Splatter2";
            v23.Weapon = "Sword";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Gaebolg" then
            v23.Knockback = 100;
            v23.Knockback2 = 80;
            v23.Knock = 4;
            v23.Damage = 40;
            v23.IgnoreBlock = true;
            v23.Style = "Gaebolg";
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Gore_Splatter2";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Rod Pull" then
            v23.IsProjectile = true;
            v23.Damage = 5;
            v23.Knock = 0;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Stun.Timer = 1.5;
            v23.PerfectBlockable = true;
            v23.HyperArmor = true;
        elseif v16.Combo == "Rod Throw" then
            v23.IsProjectile = true;
            v23.Damage = 18;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Stun.Timer = 0;
            v23.BlockBreaker = true;
            v23.Knock = 1;
            v23.IsCharacterMelee = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Rod Slap" then
            v23.PerfectBlockable = true;
            v23.BlockBreaker = true;
            v23.Knockback = 50;
            v23.Knockback2 = 15;
            v23.Knock = 2.5;
            v23.Stun.Timer = 0;
            v23.Damage = 18;
            v23.IsCharacterMelee = true;
            v23.HyperArmor = true;
        elseif v16.Combo == "Double Vine Slap" then
            v23.Damage = 16;
            v23.Stun.Timer = 1;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
            v23.HyperArmor = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
        elseif v16.Combo == "Double Vine Slap2" then
            v23.Damage = 16;
            v23.Knockback = 40;
            v23.Stun.Timer = 0.5;
            v23.Knock = 0;
            v23.BlockBreaker = true;
            v23.IsCharacterMelee = true;
            v23.HyperArmor = true;
        elseif v16.Combo == "Grapple" then
            v23.Damage = 10;
            v23.Stun.Timer = 0;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
        elseif v16.Combo == "Vine Trap" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.KnockbackDirection = nil;
            v23.KnockbackDirection2 = nil;
            v23.Knock = 0;
            v23.Damage = 18;
            v23.Stun.Timer = 1.5;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.BlockBreaker = nil;
            v23.IsCharacterMelee = true;
            v23.NoBackBlockBreaks = true;
        elseif v16.Combo == "Hook Pierce" then
            v23.Damage = 18;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Stun.Timer = 1;
            v23.BlockBreaker = true;
            v23.NoDamageCancel = true;
            v23.IsProjectile = true;
            v23.Weapon = "Sword";
        elseif v16.Combo == "Void Surprise" then
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = nil;
            v23.Damage = 13.66;
            v23.Stun.Timer = 1.2;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Cream Void Hit";
            v23.IgnoreBlock = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Devastation" then
            v23.Knockback = 50;
            v23.Knockback2 = 0;
            v23.Knock = 1;
            v23.Damage = 17.1;
            v23.Stun.Timer = 0.5;
            v23.HitEffect.Type = "Blade";
            v23.Style = "Void Ball";
            v23.Sound.Sound = "Cream Void Hit";
            v23.BlockBreaker = true;
            v23.IgnoreBlock = nil;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Madness Sorrow" then
            v23.Knockback = 75;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.Damage = 18.8;
            v23.Stun.Timer = 0;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Cream Void Hit";
            v23.IgnoreBlock = true;
            v23.BypassCounters = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Shard Shot" then
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds["Crazy Diamond"]["Bearing Shot"].Hit;
            v23.HitEffect.Type = "Blade";
            v23.Stun.Timer = 0.8;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 10;
            v23.IsProjectile = true;
            v23.NoDamageCancel = false;
            v23.IsCharacterMelee = true;
            v23.Weapon = "Sword";
        elseif v16.Combo == "Bearing Shot" then
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds["Crazy Diamond"][v16.Combo].Hit;
            v23.HitEffect.Type = "Blade";
            v23.Stun.Timer = 0.75;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 14;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.IsCharacterMelee = true;
        elseif v16.Combo == "Blood Slash" then
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds["Crazy Diamond"][v16.Combo].Hit;
            v23.HitEffect = nil;
            v23.Stun.Timer = 0.65;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 11.18;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.IsCharacterMelee = true;
        elseif v16.Combo == "Crazy Beatdown" then
            v23.PerfectBlockable = true;
            v23.IgnoreBlock = true;
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
            v23.Stun.Timer = 0.5;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 0;
        elseif v16.Combo == "You\'re In My Range" then
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
            v23.Stun.Timer = 0.5;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 0;
        elseif v16.Combo == "Yo Angelo" then
            v23.Stun.Timer = 1;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
        elseif v16.Combo == "Crazy Wall" then
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
            v23.Stun.Timer = 0.5;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 1;
            v23.Damage = 15;
            v23.BlockBreaker = true;
        elseif v16.Combo == "Bubble Prison" then
            v23.Stun.Timer = 0.5;
            v23.Knock = 0;
            v23.BlockBreaker = true;
            v23.IsCharacterMelee = true;
            v23.Damage = 10;
            v23.PerfectBlockable = true;
        elseif v16.Combo == "Friction Beatdown" then
            v23.PerfectBlockable = true;
            v23.IgnoreBlock = true;
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
            v23.Stun.Timer = 0.5;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.HitEffect = nil;
            v23.KnockbackDirection = v16.Origin.CFrame.lookVector;
        elseif v16.Combo == "Shovel Barrage" then
            v23.Sound.Sound = "Shovel_Hit" .. math.random(1, 2);
            v23.Stun.Timer = 0.45;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
        elseif v16.Combo == "Vision Plunder" then
            v23.Sound.Sound = l__Sounds__4["Crazy Diamond"]["Bearing Shot"].Hit;
            v23.Stun.Timer = 0.55;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.Damage = 9.3;
        elseif v16.Combo == "Moisture Plunder" then
            v23.Sound.Sound = l__Sounds__4["Crazy Diamond"]["Bearing Shot"].Hit;
            v23.Sound.Volume = 0.4;
            v23.Sound.Pitch = math.random(120, 200) / 100;
            v23.Stun.Timer = 0.4;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.HitEffect.Type = "Blade";
            v23.Damage = 0.35;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Go Beyond" then
            v23.Sound.Sound = l__Sounds__4["Crazy Diamond"]["Bearing Shot"].HeavyHit;
            v23.Stun.Timer = 1.5;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.IgnoreBlock = true;
            v23.TrueDamage = true;
            v23.BypassCounters = true;
            v23.Damage = 12.42;
        elseif v16.Combo == "Friction Plunder" then
            v23.Sound.Sound = l__Sounds__4["Crazy Diamond"]["Bearing Shot"].Hit;
            v23.Stun.Timer = 1;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.Damage = 18.6;
            v23.NoHitAnim = true;
            v23.NoDamageCancel = true;
            v23.DontStandCrash = true;
        elseif v16.Combo == "Bubble Generation" then
            v23.IgnoreBlock = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = -30;
            v23.HitEffect = nil;
            v23.Sound = nil;
            v23.IgnoreDP = true;
            v23.NoHitAnim = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Soaring Tempest" then
            v23.Stun.Timer = 0.6;
            v23.Knockback = 12.5;
            v23.Knockback2 = 35;
            v23.Damage = 25;
            v23.Knock = 0;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.BlockBreaker = false;
            v23.HitEffect.Type = "SharpHeavy";
            v23.Sound.Sound = "Blade_Hit4";
        elseif v16.Combo == "Thunderbolt" then
            v23.Stun.Timer = 0.8;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Damage = 16;
            v23.Knock = 0;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.BlockBreaker = false;
            v23.HitEffect.Type = "SharpHeavy";
            v23.Sound = nil;
        elseif v16.Combo == "Ice Spikes" then
            v23.Stun.Timer = 0.5;
            v23.Knockback = 35;
            v23.Knockback2 = 50;
            v23.Damage = 17.5;
            v23.Knock = 2;
            v23.NoDamageCancel = true;
            v23.Sound.Sound = "Serious";
            v23.BlockBreaker = true;
            v23.HitEffect.Type = "Heavy";
        elseif v16.Combo == "Frog Rain" then
            v23.Stun = nil;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Damage = 0.5;
            v23.Knock = 0;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.NoHitAnim = true;
            v23.BypassCounters = true;
        elseif v16.Combo == "Hazardous Forecast" then
            v23.Stun.Timer = 1;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Damage = 1;
            v23.Knock = 0;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Blade_Hit" .. math.random(3);
        elseif v16.Combo == "Heavy Weather" then
            v23.Stun.Timer = 0.5;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Damage = 0;
            v23.Knock = 1;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
            v23.NoHitAnim = true;
            v23.Sound = nil;
            v23.HitEffect = nil;
            v23.IgnoreBlock = true;
            v23.BypassCounters = true;
        elseif v16.Combo == "Ice Punch" then
            v23.Stun.Timer = 0.75;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
            v23.Damage = 20;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.HitAnim = l__ServerStorage__1.Anims.SlamHurt1;
        elseif v16.Combo == "Ice Sweeps" then
            v23.Stun.Timer = 0.75;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
            v23.Damage = 12;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Weapon = "Sword";
        elseif v16.Combo == "Flash Freeze" then
            v23.Stun.Timer = 0.5;
            v23.Knock = 2;
            v23.Knockback = 35;
            v23.Knockback2 = 100;
            v23.Damage = 25;
            v23.NoDamageCancel = true;
            v23.Sound.Sound = "Serious";
            v23.BlockBreaker = true;
            v23.HitEffect.Type = "Heavy";
        elseif v16.Combo == "Ice Swipe" then
            v23.BlockBreaker = true;
            v23.PerfectBlockable = true;
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound = nil;
            v23.HitEffect = nil;
            v23.Stun.Timer = 0.5;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.HitEffect = nil;
            v23.IsCharacterMelee = true;
        elseif v16.Combo == "Zipper Extension" then
            v23.Stun.Timer = 0.75;
            v23.Knock = 0;
            v23.CharacterAttack = true;
            v23.Damage = 10;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
        elseif v16.Combo == "Zipper Pole" then
            v23.Stun.Timer = 0.8;
            v23.Knock = 0;
            v23.Damage = 10;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
        elseif v16.Combo == "Zipper Slam" then
            v23.Stun.Timer = 1;
            v23.Knock = 1;
            v23.IsCharacterMelee = true;
            v23.Damage = 15.5;
            v23.BlockBreaker = true;
            v23.Knockback = 50;
            v23.Knockback2 = 15;
            v23.HitAnim = l__ServerStorage__1.Anims.SlamHurt1;
        elseif v16.Combo == "Zipper Flank" then
            v23.Stun.Timer = 1.25;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
            v23.Damage = 15;
            v23.BlockBreaker = true;
            v23.PerfectBlockable = true;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
        elseif v16.Combo == "Zipper Explosion" then
            v23.Stun.Timer = 0.8;
            v23.Damage = 5;
        elseif v16.Combo == "Living Zippers" then
            v23.Stun.Timer = 0.5;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
            v23.Damage = 1;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.HitEffect = nil;
        elseif v16.Combo == "Arrivederci Beatdown" then
            v23.PerfectBlockable = true;
            v23.IgnoreBlock = true;
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
            v23.Stun.Timer = 0.5;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 0;
        elseif v16.Combo == "Tail Whip" then
            v23.Stun.Timer = 0.9;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
            v23.Damage = 15;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
        elseif v16.Combo == "Fossilization" then
            v23.Stun.Timer = 0.75;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
            v23.Damage = 15;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Sound.Sound = "Blade_Hit4";
            v23.HideStun = true;
        elseif v16.Combo == "Dino Army" then
            v23.Stun.Timer = 0.3;
            v23.Knock = 0;
            v23.Damage = 5;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Sound.Sound = "Fist_Hit3";
            v23.IsProjectile = true;
        elseif v16.Combo == "Dino Dash" then
            v23.Stun.Timer = 0;
            v23.Knock = 1;
            v23.IsCharacterMelee = true;
            v23.Damage = 15;
            v23.Knockback = 60;
            v23.Knockback2 = 35;
        elseif v16.Combo == "Dino Barrage" then
            v23.Stun.Timer = 0.75;
            v23.Knock = 0;
            v23.IsCharacterMelee = true;
            v23.Damage = 5;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.NoHitAnim = true;
        elseif v16.Combo == "Dino Barrage Beatdown" then
            v23.BlockBreaker = true;
            v23.PerfectBlockable = true;
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound = nil;
            v23.HitEffect = nil;
            v23.Stun.Timer = 0.5;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.HitEffect = nil;
            v23.IsCharacterMelee = true;
        elseif v16.Combo == "Finisher" then
            v23.PerfectBlockable = true;
            v23.BlockBreaker = true;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 1;
            v23.Damage = v23.Damage * 2.5;
            v23.Style = "Finisher";
            if l__Parent__8:GetAttribute("SM_Full_Form") then
                v23.Damage = v23.Damage * 1.8;
            end;
            v23.Sound.Sound = "Stand Heavy Punch";
            if v23.HitEffect.Type == "Fists" then
                v23.HitEffect.Type = "Heavy";
            else
                v23.HitEffect.Type = "SharpHeavy";
            end;
            if l__Stand__9 and l__Stand__9 == "Ultra Instinct" then
                v23.Sound.Sound = "DBZ Punch Hit";
            elseif v23.HitEffect.Type == "SharpHeavy" then
                v23.Sound.Sound = { "SwordHit3", "Stand Heavy Punch" };
            end;
            v23.HyperArmor = true;
        elseif v16.Combo == "Nail Slash" then
            v23.Spin = true;
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = nil;
            v23.BlockBreaker = false;
            v23.Knockback = 70;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.Damage = 20;
            v23.Style = "Finisher";
            v23.Stun.Timer = 1;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
            v23.CharacterAttack = true;
            v23.HyperArmor = true;
        elseif v16.Combo == "Life Giver" then
            v23.PerfectBlockable = true;
            v23.BlockBreaker = true;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.Stun.Timer = 1;
            v23.Damage = 7.763;
            v23.Style = "Life Giver";
            v23.Sound.Sound = "Stand Heavy Punch";
        elseif v16.Combo == "Reality Overwriting Punch" then
            v23.PerfectBlockable = true;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = true;
            v23.Knockback = 5;
            v23.Knockback2 = 3;
            v23.Knock = 0;
            v23.Stun.Timer = 0.9;
            v23.Damage = 12.5;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.Style = "Jaw Breaker";
            v23.HitEffect.Type = "Jaw Breaker";
            v23.DontStandCrash = true;
            v23.TrueDamage = true;
        elseif v16.Combo == "Speed Slice" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = true;
            v23.IgnoreBlock = nil;
            v23.Stun.Timer = 0.5;
            v23.Damage = 17.5;
            v23.Knockback = 55;
            v23.Knockback2 = 40;
            v23.Knock = 1.5;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Heaven\'s Judgement" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.8;
            v23.Damage = 40;
            v23.Sound.Sound = "Gaebolg_Hit" .. math.random(1, 3);
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Gravitational Shift" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 1.5;
            v23.Damage = 6;
            v23.HitEffect.Type = "Gravity";
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Uppercut to The Moon" then
            v23.PerfectBlockable = true;
            v23.BlockBreaker = true;
            v23.Knockback = 20;
            v23.Knockback2 = 35;
            v23.Knock = 0;
            v23.Stun.Timer = 3;
            v23.Damage = 8;
            v23.HitEffect.Type = "Gravity";
            v23.Sound.Sound = "Stand Heavy Punch";
        elseif v16.Combo == "Road Roller" then
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = true;
            v23.BlockBreaker = nil;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.Stun.Timer = 1;
            v23.Damage = 30;
            v23.HitEffect.Type = "Jaw Breaker";
            v23.Sound.Sound = "Serious";
        elseif v16.Combo == "Cursed Blade" then
            v23.IgnoreBlock = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0;
            v23.Damage = 0;
            v23.TrueDamage = true;
            v23.HitEffect.Type = "Jaw Breaker";
            v23.Sound.Sound = "Serious";
        elseif v16.Combo == "Curse Imbued Slice" then
            v23.BlockBreaker = nil;
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = true;
            v23.Knockback = 17;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.Stun.Timer = 0.75;
            v23.Damage = 20;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "SwordHit3";
            v23.TrueDamage = true;
        elseif v16.Combo == "Enraged Fury" then
            v23.BlockBreaker = nil;
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.5;
            v23.TrueDamage = true;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "SwordHit" .. math.random(1, 2);
        elseif v16.Combo == "Pinky Slash" then
            v23.BlockBreaker = true;
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.5;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Gore_Splatter2";
            v23.Damage = 12.5;
        elseif v16.Combo == "Lightning Jabs" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 1.15;
            v23.Damage = 5;
            v23.Sound = nil;
        elseif v16.Combo == "Electric Discharge" then
            v23.BlockBreaker = nil;
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.6;
            v23.Sound.Sound = "Slash_Hit" .. math.random(1, 3);
        elseif v16.Combo == "Surface Inversion Punch" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.Knockback = 20;
            v23.Knockback2 = 35;
            v23.Knock = 0;
            v23.Stun.Timer = 0.65;
            v23.Damage = 9.32;
            v23.HitEffect.Type = "Gravity";
            v23.Sound.Sound = "GravityHit";
        elseif v16.Combo == "Wormhole Uppercut" then
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = nil;
            v23.BlockBreaker = nil;
            v23.Knockback = 60;
            v23.Knockback2 = -10;
            v23.Knock = 0.75;
            v23.IgnoreSturdiness = true;
            v23.Stun.Timer = 0.75;
            v23.Damage = 17.5;
            v23.Style = "Jaw Breaker";
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Wormhole Uppercut Beatdown" then
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = true;
            v23.IgnoreInvincibility = true;
            v23.BypassCounters = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 1;
            v23.Damage = 0;
            v23.Sound.Sound = "Fist_Hit3";
            v23.NoHitAnim = true;
        elseif v16.Combo == "Flash Freeze" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = true;
            v23.IgnoreBlock = true;
            v23.Knockback = 75;
            v23.Knockback2 = 65;
            v23.Knock = 2;
            v23.Damage = 24;
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Jaw Breaker";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Kamehameha" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = true;
            v23.IgnoreBlock = true;
            v23.Knockback = 100;
            v23.Knockback2 = 75;
            v23.Knock = 5;
            v23.Damage = 70;
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Jaw Breaker";
            v23.NoDamageCancel = true;
            v23.IgnoreInvincibility = true;
        elseif v16.Combo == "Godly Display" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = true;
            v23.Knockback = 15;
            v23.Knockback2 = 45;
            v23.Knock = 0.5;
            v23.Stun.Timer = 1.5;
            v23.IgnoreSturdiness = true;
            v23.Damage = 10;
            v23.IgnoreInvincibility = true;
        elseif v16.Combo == "Godly Display2" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = true;
            v23.Knockback = 10;
            v23.Knockback2 = 15;
            v23.Knock = 0;
            v23.Damage = 60;
            v23.Sound = nil;
            v23.HitEffect = false;
            v23.NoDamageCancel = true;
            v23.IgnoreRagdoll = true;
            v23.IgnoreInvincibility = true;
            local v26 = math.random(1, 8);
            if v26 == 1 then
                v23.Knockback = -v23.Knockback;
            elseif v26 == 2 then
                v23.Knockback = v23.Knockback;
            elseif v26 == 3 then
                v23.Knockback = v23.Knockback;
                v23.KnockbackDirection = Vector3.new(1, 0, 0);
            elseif v26 == 4 then
                v23.Knockback = -v23.Knockback;
                v23.KnockbackDirection = Vector3.new(1, 0, 0);
            elseif v26 == 5 then
                v23.Knockback = v23.Knockback;
                v23.KnockbackDirection = Vector3.new(0, 0, 1);
            elseif v26 == 6 then
                v23.Knockback = -v23.Knockback;
                v23.KnockbackDirection = Vector3.new(0, 0, 1);
            elseif v26 == 7 then
                v23.Knockback = v23.Knockback;
                v23.KnockbackDirection = Vector3.new(1, 0, 1);
            elseif v26 == 8 then
                v23.Knockback = -v23.Knockback;
                v23.KnockbackDirection = Vector3.new(1, 0, 1);
            end;
        elseif v16.Combo == "Fire Fist" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = nil;
            v23.Knockback = 75;
            v23.Knockback2 = 55;
            v23.Knock = 1;
            v23.Damage = 50;
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Jaw Breaker";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Heaven Ascended Smite" then
            v23.Knock = 1.4;
            v23.BlockBreaker = true;
            v23.Damage = 18.6;
            v23.Sound.Sound = "";
            v23.HitEffect.Type = "";
            v23.Knockback = 60;
            v23.Knockback2 = 65;
            v23.NoDamageCancel = true;
            v23.TrueDamage = true;
            local v27 = math.random(1, 8);
            if v27 == 1 then
                v23.Knockback = -v23.Knockback;
            elseif v27 == 2 then
                v23.Knockback = v23.Knockback;
            elseif v27 == 3 then
                v23.Knockback = v23.Knockback;
                v23.KnockbackDirection = Vector3.new(1, 0, 0);
            elseif v27 == 4 then
                v23.Knockback = -v23.Knockback;
                v23.KnockbackDirection = Vector3.new(1, 0, 0);
            elseif v27 == 5 then
                v23.Knockback = v23.Knockback;
                v23.KnockbackDirection = Vector3.new(0, 0, 1);
            elseif v27 == 6 then
                v23.Knockback = -v23.Knockback;
                v23.KnockbackDirection = Vector3.new(0, 0, 1);
            elseif v27 == 7 then
                v23.Knockback = v23.Knockback;
                v23.KnockbackDirection = Vector3.new(1, 0, 1);
            elseif v27 == 8 then
                v23.Knockback = -v23.Knockback;
                v23.KnockbackDirection = Vector3.new(1, 0, 1);
            end;
        elseif v16.Combo == "Firefly Light" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.6;
            v23.Damage = 55;
            v23.Sound.Sound = "";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Firefly Light Act2" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = nil;
            v23.Knockback = 30;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.Stun.Timer = 1.5;
            v23.Damage = 5;
            v23.Sound.Sound = "";
            v23.NoDamageCancel = true;
            v23.IgnoreRagdoll = true;
        elseif v16.Combo == "Air Punch" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = nil;
            v23.Knockback = 75;
            v23.Knockback2 = 55;
            v23.Knock = 1.5;
            v23.Damage = 35;
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Jaw Breaker";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Flame Pillar" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = true;
            v23.IgnoreBlock = nil;
            v23.Knockback = 55;
            v23.Knockback2 = 55;
            v23.Stun.Timer = 1.5;
            v23.Damage = 35;
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Jaw Breaker";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Flame Emperor" then
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.IgnoreBlock = true;
            v23.Knockback = 75;
            v23.Knockback2 = 55;
            v23.Knock = 2;
            v23.Damage = 60;
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Jaw Breaker";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Mes" then
            v23.PerfectBlockable = true;
            v23.BlockBreaker = true;
            v23.IgnoreBlock = true;
            v23.Knockback = 3;
            v23.Knockback2 = 10;
            v23.Knock = 1;
            v23.Damage = v23.Damage * 2;
            v23.Style = "Mes";
            v23.Sound.Sound = "Mes2";
            v23.HitEffect.Type = "Blade";
            v23.Stun.Timer = 0.5;
        elseif v16.Combo == "Mes Squeeze" then
            v23.IgnoreBlock = true;
            v23.Knockback = 0;
            v23.Knockback2 = 10;
            v23.Knock = 1.25;
            v23.Damage = 32;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Takt" then
            v23.IgnoreBlock = true;
            v23.Knockback = 0;
            v23.Knockback2 = -10;
            v23.Knock = 1.25;
            v23.Damage = 45;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Ora Beatdown" then
            v23.PerfectBlockable = true;
            v23.IgnoreBlock = true;
            v23.Knockback = 35;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = v23.Damage * 2;
            v23.Style = "Ora Beatdown";
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HyperArmor = true;
            v23.Beatdown = true;
        elseif v16.Combo == "7 Page Beatdown" then
            v23.PerfectBlockable = true;
            v23.IgnoreBlock = true;
            v23.Knockback = 35;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = v23.Damage * 2;
            v23.Style = "7 Page Beatdown";
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HyperArmor = true;
            v23.Beatdown = true;
        elseif v16.Combo == "String Pilot" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.5;
            v23.Damage = 5;
            v23.Sound = nil;
        elseif v16.Combo == "String Slam" then
            v23.Knockback = 35;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = v23.Damage * 2;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.Beatdown = true;
            v23.HitEffect.Type = "Heavy";
        elseif v16.Combo == "String Beatdown" then
            v23.PerfectBlockable = true;
            v23.IgnoreBlock = true;
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
            v23.Knockback = 35;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = v23.Damage * 2;
        elseif v16.Combo == "String Barrier" then
            v23.BlockBreaker = false;
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = nil;
            v23.Stun.Timer = 0.5;
            v23.Knockback2 = nil;
            v23.Knock = nil;
            v23.Damage = 15;
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds["Stone Free"][v16.Combo]["Victim Hit"];
        elseif v16.Combo == "String Bandage" then
            v23.IgnoreBlock = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = -10;
            v23.HitEffect = nil;
            v23.Sound = nil;
            v23.IgnoreDP = true;
            v23.NoHitAnim = true;
        elseif v16.Combo == "String Lasso" then
            v23.Knockback = 0;
            v23.Stun.Timer = 1.5;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 15;
            v23.IsProjectile = true;
        elseif v16.Combo == "Home Run" then
            v23.Knockback = 15;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 2;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HyperArmor = true;
            v23.Beatdown = true;
            v23.HitEffect.Type = "Heavy";
            v23.IsProjectile = true;
            v23.IsCharacterMelee = true;
        elseif v16.Combo == "Home Run Beatdown" then
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = true;
            v23.IgnoreInvincibility = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0;
            v23.Damage = 0;
            v23.Sound = nil;
            v23.NoHitAnim = true;
            v23.HitEffect = nil;
            v23.IsProjectile = true;
        elseif v16.Combo == "Arigato Gyro" then
            v23.PerfectBlockable = true;
            v23.IgnoreBlock = true;
            v23.Knockback = 35;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = v23.Damage * 2;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HyperArmor = true;
            v23.Beatdown = true;
        elseif v16.Combo == "Arigato Gyro Beatdown" then
            v23.PerfectBlockable = nil;
            v23.IgnoreBlock = true;
            v23.IgnoreInvincibility = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.5;
            v23.Damage = 0;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.NoHitAnim = true;
        elseif v16.Combo == "Kidnap" then
            v23.IgnoreBlock = true;
            v23.PerfectBlockable = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = v23.Damage * 5;
            v23.Style = "Kidnap";
            v23.IsCharacterMelee = true;
            v23.HyperArmor = true;
        elseif v16.Combo == "Marionette Control" then
            v23.PerfectBlockable = true;
            v23.BlockBreaker = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 1;
            v23.Damage = 20;
            v23.Style = "Marionette Control";
            v23.Sound.Sound = "Marionette Control";
        elseif v16.Combo == "Crossfire Hurricane Special" then
            v23.IsProjectile = true;
            v23.IgnoreBlock = nil;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.Stun.Timer = 0.6;
            v23.Damage = 21;
            v23.Style = "Crossfire Hurricane Special";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Crossfire Hurricane" then
            v23.IsProjectile = true;
            v23.IgnoreBlock = true;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.Stun.Timer = 0.75;
            v23.Damage = 15;
            v23.Style = "Crossfire Hurricane";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Red Bind" then
            v23.BlockBreaker = nil;
            v23.PerfectBlockable = nil;
            v23.Knockback = 70;
            v23.Knockback2 = 20;
            v23.Knock = 0;
            v23.Damage = 6;
            v23.Style = "Red Bind";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Detonate Bomb" then
            v23.IgnoreBlock = nil;
            v23.BlockDamage = 50;
            v23.Damage = 15.5;
            v23.Chip_Damage = v23.Damage * 0.75;
            v23.Knock = 1.3;
            v23.Knockback = 30;
            v23.Knockback2 = 40;
            v23.Style = "Killer Queen Bomb";
            v23.Sound.Sound = "Serious";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "First Bomb" then
            v23.PerfectBlockable = nil;
            v23.Damage = 4.96;
            v23.Stun.Timer = 0.5;
            v23.Knock = 0;
            v23.Knockback = 50;
            v23.Knockback2 = 15;
        elseif v16.Combo == "Sheer Heart Attack" then
            v23.IgnoreBlock = nil;
            v23.BlockDamage = 30;
            v23.Damage = 15.5;
            v23.Chip_Damage = v23.Damage * 0.75;
            v23.Knock = 1.5;
            v23.Knockback = 30;
            v23.Knockback2 = 20;
            v23.Style = "Killer Queen Bomb";
            v23.Sound.Sound = "Serious";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Coin Bomb" then
            v23.IgnoreBlock = true;
            v23.Damage = 15.5;
            v23.Chip_Damage = v23.Damage * 0.75;
            v23.Knock = 1.3;
            v23.Knockback = 31.5;
            v23.Knockback2 = 20;
            v23.Style = "Killer Queen Bomb";
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Blade";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Scattered Coin Bombs" then
            v23.Stun.Timer = 0.65;
            v23.Damage = 33;
            v23.Knock = 0;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Style = "Killer Queen Bomb";
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v23.Sound.Volume = 0.1;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Bomb Leap" then
            v23.IgnoreBlock = nil;
            v23.BlockBreaker = nil;
            v23.Damage = 8;
            v23.Knock = 0.8;
            v23.Knockback = 31.5;
            v23.Knockback2 = 20;
            v23.Style = "Killer Queen Bomb";
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Blade";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Bites the Dust" then
            v23.IgnoreBlock = true;
            v23.TrueDamage = true;
            v23.Damage = 34.2;
            v23.Knock = 0;
            v23.Knockback2 = 0;
            v23.Knockback = 0;
            v23.Style = "Killer Queen Bomb";
            v23.Sound.Sound = "Killer QueenExplosion";
            v23.HitEffect.Type = "Blade";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Stray Cat Bubble Bomb" then
            v23.IgnoreBlock = nil;
            v23.Damage = 15.5;
            v23.Chip_Damage = v23.Damage * 0.75;
            v23.Knock = 1.3;
            v23.Knockback = 31.5;
            v23.Knockback2 = 20;
            v23.Style = "Zipper Punch";
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Blade";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "D4C Victim Clone Explosion" then
            v23.Sound.Sound = "Gore_Splatter2";
            v23.Knock = 2;
            v23.Knockback2 = 40;
            v23.Knockback = 63;
            v23.Damage = 22;
            v23.Style = "Killer Queen Bomb";
            v23.IgnoreBlock = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Smoke Grenade Explosion" then
            v23.Sound.Sound = "Gore_Splatter2";
            v23.Knock = 2;
            v23.Knockback2 = 40;
            v23.Knockback = 63;
            v23.Damage = 20;
            v23.Style = "Killer Queen Bomb";
            v23.IgnoreBlock = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Frag Grenade Explosion" then
            v23.Sound.Sound = "Gore_Splatter2";
            v23.Knock = 2;
            v23.Knockback2 = 30;
            v23.Knockback = 55;
            v23.Damage = 20;
            v23.Style = "Killer Queen Bomb";
            v23.IgnoreBlock = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Little Boy" then
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Blade";
            v23.Knock = 0;
            v23.Knockback2 = 15;
            v23.Knockback = 22.5;
            v23.Stun.Timer = 0.3;
            v23.Damage = 10;
            v23.IgnoreBlock = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Big Man" then
            v23.Sound.Sound = "Serious";
            v23.HitEffect.Type = "Blade";
            v23.Knock = 2;
            v23.Knockback2 = 60;
            v23.Knockback = 50;
            v23.Stun.Timer = 1;
            v23.Damage = 40;
            v23.IgnoreBlock = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Bakugo" then
            v23.PerfectBlockable = nil;
            v23.Knockback = 20;
            v23.Knockback2 = 30;
            v23.Knock = 0;
            v23.Damage = 7.5;
            v23.Style = "Bakugo";
            v23.Sound.Sound = "Grab";
        elseif v16.Combo == "Bakugo Explosion" then
            v23.IgnoreBlock = true;
            v23.Knockback = 65;
            v23.Knockback2 = 24;
            v23.Knock = 1.5;
            v23.Damage = 15;
            v23.Style = "Bakugo Explosion";
            v23.Sound = nil;
            v23.NoDamageCancel = true;
            v23.IgnoreInvincibility = true;
        elseif v16.Combo == "Shake Key" then
            v23.IgnoreBlock = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 18;
            v23.Stun.Timer = 0.8;
            v23.Sound.Sound = "Red Bind";
            v23.NoDamageCancel = true;
            v23.IgnoreInvincibility = true;
            v23.BypassCounters = true;
        elseif v16.Combo == "Restock Supplies" then
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = -40;
            v23.Stun.Timer = 0;
            v23.Sound.Sound = nil;
            v23.NoDamageCancel = true;
            v23.HitEffect.Type = "Heal";
            v23.NoHitAnim = true;
        elseif v16.Combo == "Blighted Quiver" then
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.Stun = nil;
            v23.Sound.Sound = "";
            v23.NoDamageCancel = true;
            v23.HitEffect.Type = "Heal";
            v23.NoHitAnim = true;
        elseif v16.Combo == "Bloodthirster" then
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.Stun = nil;
            v23.Sound.Sound = "";
            v23.NoDamageCancel = true;
            v23.NoHitAnim = true;
        elseif v16.Combo == "Blessing of Sparks" then
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.Stun = nil;
            v23.Sound.Sound = "";
            v23.NoDamageCancel = true;
            v23.HitEffect = nil;
            v23.NoHitAnim = true;
        elseif v16.Combo == "Chip Damage" then
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.Stun = nil;
            v23.Sound.Sound = "";
            v23.NoDamageCancel = true;
            v23.HitEffect = nil;
            v23.NoHitAnim = true;
        elseif v16.Combo == "Gold Experience Tree" then
            v23.Blockable = true;
            v23.Knockback = 50;
            v23.Knockback2 = 65;
            v23.Knock = 1;
            v23.Damage = 12.42;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "King Crimson Chop" then
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 1;
            v23.Damage = 8;
            v23.HitEffect.Type = "Blade";
            v23.IgnoreBlock = true;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HyperArmor = true;
        elseif v16.Combo == "Chop" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.8;
            v23.Damage = 8;
            v23.HitEffect.Type = "Blade";
            v23.IgnoreBlock = nil;
            v23.PerfectBlockable = nil;
            v23.BlockBreaker = nil;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HyperArmor = true;
        elseif v16.Combo == "Impale" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.75;
            v23.HitEffect.Type = "Blade";
            v23.IgnoreBlock = true;
            v23.PerfectBlockable = true;
            v23.BlockBreaker = nil;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HyperArmor = true;
        elseif v16.Combo == "Raging Demon" then
            v23.Knockback = 5;
            v23.Knockback2 = 1;
            v23.Knock = 0;
            v23.Damage = 0;
            v23.IgnoreBlock = true;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Jaw Breaker";
            v23.Stun.Timer = 1;
            v23.NoDamageCancel = true;
            v23.HyperArmor = true;
        elseif v16.Combo == "Spirit Disc" then
            v23.BlockBreaker = nil;
            v23.Knockback = 25;
            v23.Knockback2 = 7.5;
            v23.Knock = 0;
            v23.Stun.Timer = 0.75;
            v23.Damage = 20;
            v23.IgnoreBlock = nil;
            v23.Sound.Sound = "Disc2";
        elseif v16.Combo == "Memory Disc" then
            v23.BlockBreaker = true;
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 1;
            v23.Stun.Timer = 0.75;
            v23.Damage = 30;
            v23.IgnoreBlock = nil;
            v23.PerfectBlockable = true;
            v23.Sound.Sound = "Disc2";
        elseif v16.Combo == "Acidic Spew" then
            v23.Knockback = 35;
            v23.Knockback2 = 10;
            v23.Knock = 0;
            v23.Stun.Timer = 0.75;
            v23.Damage = 15;
            v23.NoDamageCancel = true;
            v23.Sound.Sound = "Acid_Hit";
        elseif v16.Combo == "Arm Extend" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 0.5;
            v23.Damage = v23.Damage * 1.2;
            v23.HyperArmor = true;
        elseif v16.Combo == "Erasure Pull" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Stun.Timer = 1.4;
            v23.Damage = 0;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Knife" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.IsProjectile = true;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
            v23.Knock = 0;
            v23.Stun.Timer = 0.75;
            v23.Damage = 5;
            v23.IgnoreBlock = true;
            v23.NoDamageCancel = true;
            v23.IsCharacterMelee = true;
            v23.Weapon = "Sword";
        elseif v16.Combo == "Heaven Ascended Knife" then
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Sound.Sound = "";
            v23.HitEffect.Type = "";
            v23.Knock = 0;
            v23.Stun.Timer = 0.25;
            v23.Damage = 5;
            v23.IgnoreBlock = true;
            v23.NoDamageCancel = true;
            v23.IgnoreBlock2 = true;
            v23.Weapon = "Sword";
        elseif v16.Combo == "Pocket Revolver" then
            v23.IsProjectile = true;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
            v23.Knock = 0;
            v23.Damage = 10.87;
            v23.Stun.Timer = 0.65;
            v23.BlockBreaker = true;
            v23.NoDamageCancel = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
        elseif v16.Combo == "Burst Fire" then
            v23.IsProjectile = true;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
            v23.Knock = 0;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Damage = 7.5;
            v23.Stun.Timer = 0.5;
            v23.BlockBreaker = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Nail Shots" then
            v23.Spin = true;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
            v23.HitEffect.Type = "Blade";
            v23.Knock = 0;
            v23.Damage = 7.5;
            v23.BlockDamage = 13;
            v23.Stun.Timer = 0.45;
            v23.IgnoreBlock = nil;
            v23.BlockBreaker = nil;
            v23.PerfectBlockable = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.NoDamageCancel = true;
            v23.IsProjectile = true;
        elseif v16.Combo == "Focused Nail Shot" then
            v23.Spin = true;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
            v23.HitEffect.Type = "Blade";
            v23.Knock = 0;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Damage = 15;
            v23.Stun.Timer = 1;
            v23.Blockable = true;
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.BlockBreaker = false;
            v23.NoDamageCancel = true;
            v23.IsProjectile = true;
            v23.CharacterAttack = true;
        elseif v16.Combo == "Golden Rectangle Nail" then
            v23.Knock = 0;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Damage = 17.5;
            v23.Stun.Timer = 0.8;
            v23.Blockable = true;
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.NoDamageCancel = true;
            v23.Spin = true;
            v23.IsProjectile = true;
            v23.CharacterAttack = true;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Life Creation" then
            v23.IsProjectile = true;
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knock = 0;
            v23.Knockback = 30;
            v23.Knockback2 = 20;
            v23.Damage = 12.42;
            v23.Stun.Timer = 0.7;
            v23.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
            v23.HitEffect.Type = "Blade";
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Erasure" then
            v23.Knock = 0;
            v23.Damage = 28.8;
            v23.Stun.Timer = 1.5;
            v23.Style = "Erasure";
            v23.HitEffect = nil;
            v23.Sound = nil;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Star Finger" then
            v23.Knockback = 15;
            v23.Knockback2 = 5;
            v23.Knock = 0;
            v23.Damage = 9.32;
            v23.Style = "Star Finger";
            v23.Sound.Sound = "Blade_Hit4";
            v23.HitEffect.Type = "Blade";
            v23.Stun.Timer = 1.3;
        elseif v16.Combo == "Injury Overwrite" then
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = -15;
            v23.HitEffect.Type = "Jaw Breaker";
            v23.Style = "Injury Overwrite";
        elseif v16.Combo == "Distribution" then
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = -10;
            v23.Stun.Timer = 0;
            v23.HitEffect.Type = "Gold Experience Distribution";
            v23.Style = "Gold Experience Distribution";
        elseif v16.Combo == "Life Shot" then
            v23.Blockable = true;
            v23.Knockback = 15;
            v23.Knockback2 = 15;
            v23.Knock = 0.9;
            v23.Damage = 12.42;
            v23.Stun.Timer = 1.5;
            v23.HitEffect.Type = "Gold Experience Distribution";
            v23.Style = "Sensory Acceleration";
        elseif v16.Combo == "Tea Time" then
            v23.IgnoreBlock = true;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = -10;
            v23.HitEffect.Type = "Heal";
            v23.NoHitAnim = true;
            v23.Style = "";
            v23.Sound.Sound = "";
        elseif v16.Combo == "Skull Crusher" then
            v23.Knockback = 3;
            v23.Knockback2 = -2;
            v23.Knock = 0;
            v23.Damage = 14;
            v23.Stun.Timer = 0.9;
            v23.Sound.Sound = "Stand Heavy Punch";
        elseif v16.Combo == "Shinei" then
            v23.Knockback = 100;
            v23.Knockback2 = 25;
            v23.Knock = 1.25;
            v23.Damage = 15.5;
            v23.IgnoreBlock = true;
            v23.PerfectBlockable = true;
            v23.Stun.Timer = 0.75;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Donut";
        elseif v16.Combo == "Road Sign Slam" then
            v23.Knockback = 15;
            v23.Knockback2 = 2;
            v23.Knock = 0;
            v23.Damage = 12.5;
            v23.IgnoreBlock = true;
            v23.PerfectBlockable = false;
            v23.Stun.Timer = 1;
            v23.HitEffect.Type = "Blade";
            v23.Sound.Sound = "Road Sign Hit";
        elseif v16.Combo == "Infinite Speed" then
            v23.Knockback = 5;
            v23.Knockback2 = -2;
            v23.Knock = 0.2;
            v23.Stun.Timer = 1.1;
            v23.Damage = 22.5;
            v23.BlockBreaker = false;
            v23.Sound.Sound = "Gore_Splatter2";
            v23.HitEffect.Type = "Blade";
        elseif v16.Combo == "Platinum Slam" then
            v23.BlockBreaker = true;
            v23.PerfectBlockable = true;
            local v28 = math.random(1, 4);
            if v28 == 1 then
                v23.Knockback = -55;
            elseif v28 == 2 then
                v23.Knockback = 55;
            elseif v28 == 3 then
                v23.Knockback = 55;
                v23.KnockbackDirection = v16.Origin.CFrame.rightVector;
            elseif v28 == 4 then
                v23.Knockback = -55;
                v23.KnockbackDirection = v16.Origin.CFrame.rightVector;
            end;
            v23.Knockback2 = 15;
            v23.Knock = 1.5;
            v23.Damage = 18.75;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HyperArmor = true;
        elseif v16.Combo == "Diamond Slam" then
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds["Crazy Diamond"]["Blood Slash"].Hit;
            v23.HitEffect = nil;
            v23.BypassCounters = true;
            v23.Blockable = true;
            v23.Stun.Timer = 0.2;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 1.25;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Restoration Trap" then
            v23.PerfectBlockable = false;
            v23.BlockBreaker = false;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = nil;
            v23.Damage = 10.86;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
            v23.HyperArmor = true;
        elseif v16.Combo == "Blood Reformation" then
            v23.Sound.Sound = l__ReplicatedStorage__2.Sounds["Crazy Diamond"]["Blood Slash"].Hit;
            v23.HitEffect = nil;
            v23.Stun.Timer = 0.6;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.Knock = 0;
            v23.Damage = 11.18;
            v23.IsProjectile = true;
            v23.NoDamageCancel = true;
        elseif v16.Combo == "Diamond is Unbreakable" then
            v23.TrueDamage = true;
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.IgnoreRagdoll = true;
            v23.IgnoreInvincibility = true;
            v23.NoDamageCancel = true;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.Stun = nil;
            v23.NoHitAnim = true;
            v23.HitEffect = nil;
            v23.Sound = nil;
            v23.IgnoreDP = true;
        elseif v16.Combo == "Chop Sui" then
            v23.PerfectBlockable = false;
            v23.BlockBreaker = false;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = nil;
            v23.Damage = nil;
        elseif v16.Combo == "No Mickey" then
            v23.IgnoreBlock = true;
            v23.PerfectBlockable = true;
            v23.BlockBreaker = false;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = nil;
            v23.Damage = 12.42;
            v23.Sound.Sound = "Stand Heavy Punch";
            v23.HitEffect.Type = "Heavy";
        elseif v16.Combo == "Modify Structure" then
            v23.Damage = 3.1;
            v23.Stun.Timer = 1.25;
            v23.BlockBreaker = false;
            v23.Knock = 0;
            v23.Knockback = 0;
            v23.Knockback2 = -15;
        elseif v16.Combo == "Power Storage" then
            v23.Damage = 0;
            v23.Stun.Timer = 0;
            v23.BlockBreaker = false;
            v23.Knock = 0;
            v23.Knockback = 0;
            v23.Knockback2 = 0;
            v23.IgnoreBlock = true;
            v23.IgnoreBlock2 = true;
            v23.IgnoreRagdoll = true;
            v23.IgnoreInvincibility = true;
            v23.NoDamageCancel = true;
            v23.NoHitAnim = true;
            v23.HitEffect = nil;
            v23.Sound = nil;
        elseif v16.Combo == "Spring Trap" then
            v23.BlockBreaker = nil;
            v23.PerfectBlockable = nil;
            v23.Beatdown = true;
            v23.NoHitAnim = true;
            v23.Sound = nil;
            v23.HitEffect = nil;
            v23.Stun = nil;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.HitEffect = nil;
        elseif v16.Combo == "Spring Trap Countered" then
            v23.BlockBreaker = true;
            v23.PerfectBlockable = nil;
            v23.Beatdown = true;
            v23.Stun = nil;
            v23.Knockback = nil;
            v23.Knockback2 = nil;
            v23.Knock = 0;
            v23.Damage = 4.65;
        elseif v16.Combo == v18.MaxCombo then
            local v29 = nil;
            if not v29 and (v22 and v22:FindFirstChild("StandSkillTree")) then
                for _, v30 in pairs({ "Supernatural Swordplay" }) do
                    local v31 = v22.StandSkillTree:findFirstChild(v30);
                    if v31 and v31.Value then
                        v29 = true;
                        break;
                    end;
                end;
            end;
            if v29 then
                v23.Damage = v23.Damage * 2.25;
                v23.IgnoreBlock = true;
                v23.IgnoreBlock2 = true;
            end;
        elseif v16.Combo < v18.MaxCombo then
            v23.Knockback = 10;
            v23.Knockback2 = 5;
            v23.Knock = 0;
            if l__Stand__9 == "Scary Monsters" then
                v23.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
                v23.HitEffect.Type = "Blade";
                v23.Weapon = "Sword";
            end;
            if v16.Combo < v18.MaxCombo - 1 then
                local l__Speed__10 = v18.Speed;
                local v32;
                if v22 then
                    v32 = l__CollectionService__6:HasTag(v22.Character, "Electric Imbued Combat");
                else
                    v32 = v22;
                end;
                if not v32 and (v22 and v22:FindFirstChild("StandSkillTree")) then
                    for _, v33 in pairs({}) do
                        local v34 = v22.StandSkillTree:findFirstChild(v33);
                        if v34 and v34.Value then
                            v32 = true;
                            break;
                        end;
                    end;
                end;
                if v32 then
                    l__Speed__10 = l__Speed__10 + v18.Speed / 1;
                end;
                v23.Stun.Timer = l__Speed__10;
            end;
            if v16.Combo == 1 then
                v23.Stun.Timer = 0.32;
            else
                v23.Stun.Timer = 0.28;
            end;
        end;
        if l__Parent__8 and (l__Parent__8.Parent and l__Parent__8:FindFirstChild("UpperTorso")) then
            if l__Parent__8.UpperTorso:findFirstChild("Crazy Diamond Heal Mode") then
                v23.Style = "Crazy Diamond Heal Mode";
                v23.HitEffect.Type = "Crazy Diamond Heal Mode";
                v23.Sound2 = {
                    Sound = "Crazy Diamond Heal",
                    Origin = v23.Sound.Origin
                };
            end;
            if (l__CollectionService__6:HasTag(l__Parent__8, "Awakening") or l__CollectionService__6:HasTag(l__Parent__8.Parent, "Awakening")) and (l__Stand__9 and (l__Stand__9 == "Gold Experience Requiem" or l__Stand__9 == "Paragon Platinum")) then
                v23.GERAwakening = true;
            end;
        end;
        v23.Stand = v16.Stand or l__Stand__9;
        return v23;
    end,
    Kikoku = function(p35, ...) --[[ Line: 2618 ]]
        -- upvalues: l__StandLibrary__3 (copy), l__Anims__5 (copy)
        local v36 = ...;
        local _ = l__StandLibrary__3.Stands[v36.Stand];
        local v37 = {
            MaxCombo = 5,
            Blocking_Capacity = 100,
            Speed = 0.25,
            Cooldown = 1,
            Style = "DefaultCombat",
            Animations = l__Anims__5["Kikoku Combat"]
        };
        if p35 == "ReturnConfig" then
            return v37;
        end;
        if p35 == "ReturnDamage_Info" then
            local l__Parent__11 = v36.Origin.Parent;
            local _ = v36.Stand;
            if not game.Players:GetPlayerFromCharacter(l__Parent__11) then
                game.Players:GetPlayerFromCharacter(l__Parent__11.Parent);
            end;
            local v38 = {
                Damage = 10,
                Knockback = 45,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.7,
                Weapon = "Blade",
                Stand = true,
                KnockbackDirection = v36.Hit and (v36.Hit.Position - v36.Origin.Position).unit or v36.Origin.CFrame.lookVector,
                Style = v37.Style,
                Tag = {
                    Name = v36.Tag,
                    Timer = v36.Timer
                },
                Stun = {
                    Name = v36.Tag,
                    Timer = v37.Speed
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 3),
                    Origin = v36.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v36.Hit
                },
                IsCharacterMelee = true
            };
            if v36.Combo ~= "Heavy" then
                if v36.Combo < v37.MaxCombo then
                    v38.Knockback = 10;
                    v38.Knockback2 = 5;
                    v38.Knock = 0;
                    if v36.Combo < v37.MaxCombo - 1 then
                        v38.Stun.Timer = v37.Speed;
                    end;
                end;
                return v38;
            end;
            v38.HitEffect.Type = "SharpHeavy";
            v38.Sound = {
                Sound = "Stab1",
                Origin = v36.Hit
            };
            v38.Knock = 1;
            v38.BlockBreaker = true;
            v38.PerfectBlockable = true;
            v38.Damage = v38.Damage * 2;
            return v38;
        end;
        if p35 == "ReturnHitbox" then
            return Vector3.new(8, 5, 8);
        end;
    end,
    Gaebolg = function(p39, ...) --[[ Line: 2679 ]]
        -- upvalues: l__StandLibrary__3 (copy), l__Anims__5 (copy)
        local v40 = ...;
        local _ = l__StandLibrary__3.Stands[v40.Stand];
        local v41 = {
            MaxCombo = 5,
            Blocking_Capacity = 76,
            Speed = 0.3,
            Cooldown = 1.25,
            Style = "DefaultCombat",
            Animations = l__Anims__5["Gaebolg Combat"]
        };
        if p39 == "ReturnConfig" then
            return v41;
        end;
        if p39 == "ReturnDamage_Info" then
            local l__Parent__12 = v40.Origin.Parent;
            local _ = v40.Stand;
            if not game.Players:GetPlayerFromCharacter(l__Parent__12) then
                game.Players:GetPlayerFromCharacter(l__Parent__12.Parent);
            end;
            local v42 = {
                Damage = 6.5,
                Knockback = 45,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                Stand = true,
                KnockbackDirection = v40.Hit and (v40.Hit.Position - v40.Origin.Position).unit or v40.Origin.CFrame.lookVector,
                Style = v41.Style,
                Tag = {
                    Name = v40.Tag,
                    Timer = v40.Timer
                },
                Stun = {
                    Name = v40.Tag,
                    Timer = v41.Speed - v41.Speed / 2.5
                },
                Sound = {
                    Sound = "Gaebolg_Hit" .. math.random(1, 2),
                    Origin = v40.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v40.Hit
                },
                IsCharacterMelee = true
            };
            if v40.Combo ~= "Heavy" then
                if v40.Combo < v41.MaxCombo then
                    v42.Knockback = 10;
                    v42.Knockback2 = 5;
                    v42.Knock = 0;
                    if v40.Combo < v41.MaxCombo - 1 then
                        v42.Stun.Timer = v41.Speed;
                    end;
                end;
                return v42;
            end;
            v42.HitEffect.Type = "SharpHeavy";
            v42.Sound = {
                Sound = "Gaebolg_Hit3",
                Origin = v40.Hit
            };
            v42.Knock = 1;
            v42.BlockBreaker = true;
            v42.PerfectBlockable = true;
            v42.Damage = v42.Damage + 2;
            return v42;
        end;
        if p39 == "ReturnHitbox" then
            return Vector3.new(5, 6, 6);
        end;
    end,
    ["Gate of Babylon"] = function(p43, ...) --[[ Line: 2739 ]]
        -- upvalues: l__Anims__5 (copy)
        local v44 = ...;
        local v45 = {
            MaxCombo = 5,
            Blocking_Capacity = 30,
            Speed = 0.3,
            Cooldown = 1.25,
            Style = "DefaultCombat",
            Animations = l__Anims__5.DefaultCombat
        };
        if p43 == "ReturnConfig" then
            return v45;
        end;
        if p43 == "ReturnDamage_Info" then
            local v46 = game.Players:GetPlayerFromCharacter(v44.Origin.Parent);
            local v47;
            if v46 then
                v47 = v46:findFirstChild("PlayerStats");
            else
                v47 = nil;
            end;
            local v48 = {
                Damage = 4,
                Knockback = 30,
                Knockback2 = 10,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                KnockbackDirection = v44.Hit and (v44.Hit.Position - v44.Origin.Position).unit or v44.Origin.CFrame.lookVector,
                Style = v45.Style,
                Tag = {
                    Name = v44.Tag,
                    Timer = v44.Timer
                },
                Stun = {
                    Name = v44.Tag,
                    Timer = v45.Speed - 0.15
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v44.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v44.Hit
                },
                NoDamageCancel = true
            };
            if v44.Combo ~= "Sword of Babylon" then
                if v44.Combo == "Weapons of Babylon" then
                    v48.Weapon = "Sword";
                    v48.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
                    v48.HitEffect.Type = "Blade";
                    v48.Knock = 0;
                    v48.Knockback = 0;
                    v48.Knockback2 = 0;
                    local v49;
                    if v47 then
                        local v50 = 4 * (v47.Level.Value * 0.1);
                        v49 = v50 > 8.5 and 8.5 or (v50 < 4 and 4 or v50);
                    else
                        v49 = nil;
                    end;
                    v48.Damage = v49;
                    v48.Style = "Sword of Babylon";
                    v48.Stun.Timer = 0.35;
                end;
                return v48;
            end;
            v48.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
            v48.HitEffect.Type = "Blade";
            v48.Knock = 0;
            v48.Knockback = 0;
            v48.Knockback2 = 0;
            v48.Weapon = "Sword";
            local v51;
            if v47 then
                local v52 = 5 * (v47.Level.Value * 0.1);
                v51 = v52 > 18 and 18 or (v52 < 5 and 5 or v52);
            else
                v51 = nil;
            end;
            v48.Damage = v51;
            v48.Style = "Sword of Babylon";
            v48.Stun.Timer = 0.35;
            return v48;
        end;
        if p43 == "ReturnHitbox" then
            return Vector3.new(5, 6, 6);
        end;
    end,
    Uzu = function(p53, ...) --[[ Line: 2836 ]]
        -- upvalues: l__Anims__5 (copy)
        local v54 = ...;
        local v55 = {
            MaxCombo = 5,
            Blocking_Capacity = 30,
            Speed = 0.3,
            Cooldown = 1.25,
            Style = "DefaultCombat",
            Animations = l__Anims__5.DefaultCombat
        };
        if p53 == "ReturnConfig" then
            return v55;
        end;
        if p53 == "ReturnDamage_Info" then
            local v56 = {
                Damage = 4,
                Knockback = 30,
                Knockback2 = 10,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                KnockbackDirection = v54.Hit and (v54.Hit.Position - v54.Origin.Position).unit or v54.Origin.CFrame.lookVector,
                Style = v55.Style,
                Tag = {
                    Name = v54.Tag,
                    Timer = v54.Timer
                },
                Stun = {
                    Name = v54.Tag,
                    Timer = v55.Speed - 0.15
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v54.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v54.Hit
                },
                IsCharacterMelee = true,
                NoDamageCancel = true
            };
            if v54.Combo == "UBW Sword" then
                v56.Weapon = "Sword";
                v56.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
                v56.HitEffect.Type = "Blade";
                v56.Knock = 0;
                v56.Damage = 7.5;
                v56.Style = "Unlimited Blade Works";
                v56.Stun.Timer = 0.5;
                v56.IgnoreInvincibility = true;
                return v56;
            end;
            if v54.Combo ~= "Quick Fire" then
                if v54.Combo == "Charged Shot" then
                    v56.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
                    v56.HitEffect.Type = "Blade";
                    v56.Knock = 3;
                    v56.Knockback2 = 75;
                    v56.Knockback = 100;
                    v56.Damage = 35;
                    v56.Style = "Unlimited Blade Works";
                    v56.BlockBreaker = true;
                end;
                return v56;
            end;
            v56.Sound.Sound = "Blade_Hit" .. math.random(1, 2);
            v56.HitEffect.Type = "Blade";
            v56.Knock = 1.5;
            v56.Knockback2 = 45;
            v56.Knockback = 75;
            v56.Damage = 22.5;
            v56.Style = "Unlimited Blade Works";
            v56.BlockBreaker = true;
            return v56;
        end;
        if p53 == "ReturnHitbox" then
            return Vector3.new(5, 6, 6);
        end;
    end,
    ["Hamon (Jonathan Joestar)"] = function(p57, ...) --[[ Line: 2904 ]]
        local v58 = ...;
        if p57 == "ReturnDamage_Info" then
            local v59 = {
                Damage = 17.5,
                Knockback = 0,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                Weapon = "Fists",
                Style = "Default Combat",
                KnockbackDirection = v58.Hit and (v58.Hit.Position - v58.Origin.Position).unit or v58.Origin.CFrame.lookVector,
                Tag = {
                    Name = v58.Tag,
                    Timer = v58.Timer
                },
                Stun = {
                    Timer = 0.3,
                    Name = v58.Tag
                },
                Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v58.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v58.Hit
                },
                IsCharacterMelee = true
            };
            if v58.Combo == "Zoom Punch" then
                v59.Stun.Timer = 1.25;
                v59.Damage = 12.5;
                v59.Sound.Sound = "Fist_Hit3";
                v59.Knockback = nil;
                v59.Knockback2 = nil;
                v59.HitType = "SmallHit";
                v59.IsCharacterMelee = true;
                return v59;
            end;
            if v58.Combo == "Scarlet Overdrive" then
                v59.Damage = 20;
                v59.Sound.Sound = "Stand Heavy Punch";
                v59.BlockBreaker = true;
                v59.Knockback = 65;
                v59.Knockback2 = 20;
                v59.Knock = 1;
                v59.HitType = "HeavyHit";
                v59.IsCharacterMelee = true;
                return v59;
            end;
            if v58.Combo == "Metal Silver Overdrive" then
                v59.Stun.Timer = 1;
                v59.Damage = 15;
                v59.Sound.Sound = "Blade_Hit4";
                v59.HitEffect.Type = "SharpHeavy";
                v59.HitType = "SmallHit";
                v59.IsCharacterMelee = true;
                v59.Knockback = nil;
                v59.Knockback2 = nil;
                return v59;
            end;
            if v58.Combo == "Sendo Overdrive" then
                v59.Knockback = nil;
                v59.Knockback2 = nil;
                v59.Stun.Timer = 0.5;
                v59.Damage = 0;
                v59.Sound.Sound = "Fist_Hit" .. math.random(1, 2);
                v59.IsCharacterMelee = true;
                return v59;
            end;
            if v58.Combo ~= "Luck & Pluck" then
                if v58.Combo ~= "Sunlight Yellow Overdrive" then
                    if v58.Combo == "Yata no Kagami" then
                        v59.Sound = {
                            Sound = "Blade_Hit1",
                            Origin = v58.Hit
                        };
                        v59.Knock = 0;
                        v59.IgnoreBlock = true;
                        v59.Damage = 10;
                        v59.Stun.Timer = 3;
                        v59.Knockback = nil;
                        v59.Knockback2 = nil;
                    end;
                    return v59;
                end;
                v59.Knockback = nil;
                v59.Knockback2 = nil;
                v59.Stun.Timer = 0.5;
                v59.Damage = 0;
                v59.Sound.Sound = "Fist_Hit" .. math.random(1, 2);
                v59.IsCharacterMelee = true;
                return v59;
            end;
            v59.Stun.Timer = 0;
            v59.Knock = 1.5;
            v59.Damage = 25;
            v59.Sound.Sound = "Blade_Hit4";
            v59.HitEffect.Type = "SharpHeavy";
            v59.BlockBreaker = true;
            v59.Knockback = 35;
            v59.Knockback2 = 10;
            v59.HitType = "HeavyHit";
            v59.IsCharacterMelee = true;
            return v59;
        end;
        if p57 == "ReturnHitbox" then
            return Vector3.new(5, 5, 3);
        end;
    end,
    ["Hamon (William Zeppeli)"] = function(p60, ...) --[[ Line: 2993 ]]
        local v61 = ...;
        if p60 == "ReturnDamage_Info" then
            local v62 = {
                Damage = 17.5,
                Knockback = 0,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                Weapon = "Fists",
                Style = "Default Combat",
                KnockbackDirection = v61.Hit and (v61.Hit.Position - v61.Origin.Position).unit or v61.Origin.CFrame.lookVector,
                Tag = {
                    Name = v61.Tag,
                    Timer = v61.Timer
                },
                Stun = {
                    Timer = 0.3,
                    Name = v61.Tag
                },
                Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v61.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v61.Hit
                },
                IsCharacterMelee = true
            };
            if v61.Combo == "Sendo Wave Kick" then
                v62.Stun.Timer = 0.45;
                v62.Damage = 17;
                v62.BlockDamage = 55;
                v62.Sound.Sound = "Fist_Hit3";
                v62.Knockback = 65;
                v62.Knockback2 = 25;
                v62.HitType = "SmallHit";
                v62.HyperArmor = true;
                v62.NoDamageCancel = true;
                v62.IsCharacterMelee = true;
                return v62;
            end;
            if v61.Combo ~= "Tornado Overdrive" then
                if v61.Combo ~= "Zoom Punch" then
                    if v61.Combo == "Sendo Overdrive" then
                        v62.Stun.Timer = 0.5;
                        v62.IgnoreBlock = true;
                        v62.IgnoreBlock2 = true;
                        v62.Damage = 0;
                        v62.Sound.Sound = "Fist_Hit" .. math.random(1, 2);
                        v62.IgnoreBlock = true;
                        v62.Knockback = 15;
                        v62.Knockback2 = 5;
                        v62.IsCharacterMelee = true;
                    end;
                    return v62;
                end;
                v62.Stun.Timer = 1;
                v62.Damage = 12.5;
                v62.Sound.Sound = "Fist_Hit3";
                v62.Knockback = nil;
                v62.Knockback2 = nil;
                v62.HitType = "SmallHit";
                v62.IsCharacterMelee = true;
                return v62;
            end;
            v62.Stun.Timer = 0;
            v62.Damage = 36;
            v62.Sound.Sound = "Fist_Hit3";
            v62.Knockback = 10;
            v62.Knockback2 = 10;
            v62.Knock = 1;
            v62.HitType = "SmallHit";
            v62.IsCharacterMelee = true;
            v62.BlockBreaker = true;
            v62.HyperArmor = true;
            v62.NoDamageCancel = true;
            return v62;
        end;
        if p60 == "ReturnHitbox" then
            return Vector3.new(5, 5, 3);
        end;
    end,
    ["Hamon (Joseph Joestar)"] = function(p63, ...) --[[ Line: 3076 ]]
        -- upvalues: l__Sounds__4 (copy)
        local v64 = ...;
        if p63 == "ReturnDamage_Info" then
            local v65 = {
                Damage = 17.5,
                Knockback = 0,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                Weapon = "Fists",
                Style = "Default Combat",
                KnockbackDirection = v64.Hit and (v64.Hit.Position - v64.Origin.Position).unit or v64.Origin.CFrame.lookVector,
                Tag = {
                    Name = v64.Tag,
                    Timer = v64.Timer
                },
                Stun = {
                    Timer = 0.3,
                    Name = v64.Tag
                },
                Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v64.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v64.Hit
                },
                IsCharacterMelee = true
            };
            if v64.Combo == "Tommy Gun Barrage" then
                v65.IsProjectile = true;
                v65.Stun.Timer = 1;
                v65.Damage = 1.1;
                v65.Knockback = nil;
                v65.Knockback2 = nil;
                v65.HitType = "SmallHit";
                v65.Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 3),
                    Origin = v64.Hit
                };
                v65.HitEffect = {
                    Type = "Blade",
                    Origin = v64.Hit
                };
                return v65;
            else
                if v64.Combo == "Clacker Boomerang" then
                    v65.Stun.Timer = 0.5;
                    v65.Damage = 5;
                    v65.Sound.Sound = l__Sounds__4["Hamon (Joseph Joestar)"]["Clacker Boomerang"].ClackerBoomeragHit1;
                    v65.HitEffect.Type = "Blade";
                    v65.Knockback = nil;
                    v65.IsProjectile = true;
                    return v65;
                end;
                if v64.Combo ~= "Clacker Volley" then
                    if v64.Combo == "Rebuff Overdrive" then
                        v65.Damage = 25;
                        v65.Sound.Sound = "Fist_Hit3";
                        v65.Knock = 1.25;
                        v65.Knockback = 45;
                        v65.Knockback2 = 20;
                        v65.HitType = "SmallHit";
                        v65.BlockBreaker = true;
                    end;
                    return v65;
                end;
                v65.Stun.Timer = 1;
                v65.Damage = 4;
                v65.Sound.Sound = "Fist_Hit3";
                v65.Knockback = nil;
                v65.Knockback2 = nil;
                v65.HitType = "SmallHit";
                return v65;
            end;
        else
            if p63 == "ReturnHitbox" then
                return Vector3.new(5, 5, 3);
            end;
        end;
    end,
    ["Hamon (Caesar Zeppeli)"] = function(p66, ...) --[[ Line: 3147 ]]
        local v67 = ...;
        if p66 == "ReturnDamage_Info" then
            local v68 = {
                Damage = 17.5,
                Knockback = 0,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                Weapon = "Fists",
                Style = "Default Combat",
                KnockbackDirection = v67.Hit and (v67.Hit.Position - v67.Origin.Position).unit or v67.Origin.CFrame.lookVector,
                Tag = {
                    Name = v67.Tag,
                    Timer = v67.Timer
                },
                Stun = {
                    Timer = 0.3,
                    Name = v67.Tag
                },
                Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v67.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v67.Hit
                },
                IsCharacterMelee = true,
                HamonType = "Caesar"
            };
            if v67.Combo == "Bubble Launcher" then
                v68.Sound = nil;
                v68.Stun.Timer = 0.6;
                v68.Knockback = nil;
                v68.Knockback2 = nil;
                v68.Knock = 0;
                v68.IsProjectile = true;
                v68.NoDamageCancel = true;
                v68.Damage = 2.5;
                return v68;
            end;
            if v67.Combo ~= "Bubble Cutter" then
                if v67.Combo == "Bubble Barrier" then
                    v68.Sound = nil;
                    v68.Knockback = 15;
                    v68.Knockback2 = 5;
                    v68.Knock = 0.75;
                    v68.NoDamageCancel = true;
                    v68.BlockBreaker = true;
                    v68.Damage = 18;
                    return v68;
                end;
                if v67.Combo ~= "Hamon Hypnosis" then
                    if v67.Combo == "Bubble Lense" then
                        v68.Knock = 1;
                        v68.TrueDamage = true;
                        v68.NoDamageCancel = true;
                        v68.IgnoreBlock = true;
                        v68.IgnoreInvincibility = true;
                        v68.Damage = 27.5;
                        v68.BypassCounters = true;
                    end;
                    return v68;
                end;
                v68.Stun.Timer = 1;
                v68.Damage = 15;
                v68.Sound.Sound = "Fist_Hit3";
                v68.Knockback = nil;
                v68.Knockback2 = nil;
                v68.HitType = "SmallHit";
                v68.IsCharacterMelee = true;
                return v68;
            end;
            v68.Sound = nil;
            v68.Stun.Timer = 0.3;
            v68.Knockback = 20;
            v68.Knockback2 = 20;
            v68.Knock = 0.6;
            v68.IsProjectile = true;
            v68.NoDamageCancel = true;
            v68.BlockBreaker = nil;
            v68.BlockDamage = 40;
            v68.Damage = 7;
            return v68;
        end;
        if p66 == "ReturnHitbox" then
            return Vector3.new(5, 5, 3);
        end;
    end,
    Spin = function(p69, ...) --[[ Line: 3231 ]]
        local v70 = ...;
        if p69 == "ReturnDamage_Info" then
            local v71 = {
                Damage = 17.5,
                Knockback = 50,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                Weapon = "Fists",
                Style = "Default Combat",
                KnockbackDirection = v70.Hit and (v70.Hit.Position - v70.Origin.Position).unit or v70.Origin.CFrame.lookVector,
                Tag = {
                    Name = v70.Tag,
                    Timer = v70.Timer
                },
                Stun = {
                    Timer = 1.7,
                    Name = v70.Tag
                },
                Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v70.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v70.Hit
                },
                Spin = true,
                IsCharacterMelee = true
            };
            if v70.Combo == "Double Steel Ball" then
                v71.Stun.Timer = 0.75;
                v71.Damage = 4;
                v71.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
                v71.HitEffect.Type = "Blade";
                v71.Knockback = nil;
                v71.NoDamageCancel = true;
                v71.IsProjectile = true;
                v71.SpinAbility = true;
                return v71;
            end;
            if v70.Combo == "Twisting Spin Punch" then
                v71.Stun.Timer = 0.5;
                v71.Knockback = nil;
                v71.Knockback2 = nil;
                v71.Beatdown = true;
                v71.BlockBreaker = true;
                v71.IsCharacterMelee = true;
                v71.SpinAbility = true;
                return v71;
            end;
            if v70.Combo == "Steel Ball" then
                v71.Stun.Timer = 0.75;
                v71.Damage = 6;
                v71.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
                v71.HitEffect.Type = "Blade";
                v71.Knockback = nil;
                v71.NoDamageCancel = true;
                v71.IsProjectile = true;
                v71.SpinAbility = true;
                return v71;
            end;
            if v70.Combo ~= "Whirling Steel Ball" then
                if v70.Combo == "Spin Reflex" then
                    v71.Stun.Timer = 0.5;
                    v71.IgnoreBlock = true;
                    v71.Damage = 23;
                    v71.Sound.Sound = "Stand Heavy Punch";
                    v71.HitEffect.Type = "Heavy";
                    v71.Knock = 0;
                    v71.NoDamageCancel = true;
                    v71.NoHitAnim = true;
                    v71.IsCharacterMelee = true;
                    v71.SpinAbility = true;
                end;
                return v71;
            end;
            v71.Stun.Timer = 0.5;
            v71.Knock = 1.5;
            v71.BlockBreaker = true;
            v71.Damage = 28;
            v71.Sound.Sound = "Blade_Hit" .. math.random(1, 3);
            v71.HitEffect.Type = "SharpHeavy";
            v71.NoDamageCancel = true;
            v71.IsProjectile = true;
            v71.Knockback = 5;
            v71.Knockback2 = 80;
            v71.SpinAbility = true;
            return v71;
        end;
        if p69 == "ReturnHitbox" then
            return Vector3.new(5, 5, 3);
        end;
    end,
    ["Dragon Sage"] = function(p72, ...) --[[ Line: 3310 ]]
        local v73 = ...;
        if p72 == "ReturnDamage_Info" then
            local v74 = {
                Damage = 17.5,
                Knockback = 50,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                Weapon = "Fists",
                Style = "Default Combat",
                KnockbackDirection = v73.Hit and (v73.Hit.Position - v73.Origin.Position).unit or v73.Origin.CFrame.lookVector,
                Tag = {
                    Name = v73.Tag,
                    Timer = v73.Timer
                },
                Stun = {
                    Timer = 1.7,
                    Name = v73.Tag
                },
                Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v73.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v73.Hit
                },
                Spin = true,
                IsCharacterMelee = true
            };
            if v73.Combo == "Lightning Drop" then
                v74.Knock = 3;
                v74.BlockBreaker = true;
                v74.Damage = 50;
                v74.Sound.Sound = "";
                v74.HitEffect.Type = "";
                v74.Knockback = 20;
                v74.Knockback2 = 35;
                v74.NoDamageCancel = true;
                v74.IgnoreRagdoll = true;
                v74.Stun.Timer = 0.8;
                v74.DontStandCrash = true;
                local v75 = math.random(1, 8);
                if v75 == 1 then
                    v74.Knockback = -v74.Knockback;
                    return v74;
                end;
                if v75 == 2 then
                    v74.Knockback = v74.Knockback;
                    return v74;
                end;
                if v75 == 3 then
                    v74.Knockback = v74.Knockback;
                    v74.KnockbackDirection = Vector3.new(1, 0, 0);
                    return v74;
                end;
                if v75 == 4 then
                    v74.Knockback = -v74.Knockback;
                    v74.KnockbackDirection = Vector3.new(1, 0, 0);
                    return v74;
                end;
                if v75 == 5 then
                    v74.Knockback = v74.Knockback;
                    v74.KnockbackDirection = Vector3.new(0, 0, 1);
                    return v74;
                end;
                if v75 == 6 then
                    v74.Knockback = -v74.Knockback;
                    v74.KnockbackDirection = Vector3.new(0, 0, 1);
                    return v74;
                end;
                if v75 == 7 then
                    v74.Knockback = v74.Knockback;
                    v74.KnockbackDirection = Vector3.new(1, 0, 1);
                    return v74;
                end;
                if v75 == 8 then
                    v74.Knockback = -v74.Knockback;
                    v74.KnockbackDirection = Vector3.new(1, 0, 1);
                    return v74;
                end;
            else
                if v73.Combo == "Lightning Elbow" then
                    v74.Knock = 3;
                    v74.Damage = 12.5;
                    v74.Sound.Sound = "";
                    v74.HitEffect.Type = "Lightning Elbow";
                    v74.Knockback = 65;
                    v74.Knockback2 = 20;
                    v74.NoDamageCancel = true;
                    return v74;
                end;
                if v73.Combo == "Lacerate" then
                    v74.Knock = 0;
                    v74.Stun.Timer = 1.5;
                    v74.Damage = 40;
                    v74.Sound.Sound = "Gore_Splatter2";
                    v74.HitEffect.Type = "Blade";
                    v74.Knockback = 0;
                    v74.Knockback2 = 0;
                    v74.BlockBreaker = true;
                    v74.IgnoreInvincibility = true;
                    return v74;
                end;
                if v73.Combo == "Snap Ignis" then
                    v74.Knock = 2.5;
                    v74.IgnoreBlock = true;
                    v74.Damage = 20;
                    v74.Sound.Sound = "";
                    v74.HitEffect.Type = "";
                    v74.Knockback = 10;
                    v74.Knockback2 = 50;
                    v74.NoDamageCancel = true;
                    v74.IgnoreRagdoll = true;
                    v74.IgnoreInvincibility = true;
                end;
            end;
            return v74;
        end;
        if p72 == "ReturnHitbox" then
            return Vector3.new(5, 5, 3);
        end;
    end,
    ["Horse Head Bonk"] = function(p76, ...) --[[ Line: 3413 ]]
        local v77 = ...;
        if p76 == "ReturnDamage_Info" then
            return {
                Damage = 5,
                Knockback = 35,
                Knockback2 = 35,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 2,
                BlockBreaker = true,
                Weapon = "Fists",
                Style = "Jaw Breaker",
                KnockbackDirection = v77.Hit and (v77.Hit.Position - v77.Origin.Position).unit or v77.Origin.CFrame.lookVector,
                Tag = {
                    Name = v77.Tag,
                    Timer = v77.Timer
                },
                Sound = {
                    Sound = "Serious",
                    Origin = v77.Hit
                },
                HitEffect = {
                    Type = "Jaw Breaker",
                    Origin = v77.Hit
                }
            };
        end;
        if p76 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.5);
        end;
    end,
    ["Revolver Bullet"] = function(p78, ...) --[[ Line: 3439 ]]
        local v79 = ...;
        if p78 == "ReturnDamage_Info" then
            return {
                Damage = 5,
                Knockback = 0,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                BlockBreaker = true,
                Weapon = "Blade",
                Style = "Blade",
                KnockbackDirection = v79.Hit and (v79.Hit.Position - v79.Origin.Position).unit or v79.Origin.CFrame.lookVector,
                Tag = {
                    Name = v79.Tag,
                    Timer = v79.Timer
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 3),
                    Origin = v79.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v79.Hit
                },
                NoDamageCancel = true,
                IsProjectile = true
            };
        end;
        if p78 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.5);
        end;
    end,
    ["Jaw Breaker"] = function(p80, ...) --[[ Line: 3467 ]]
        local v81 = ...;
        if p80 == "ReturnDamage_Info" then
            return {
                Damage = 26,
                Knockback = 25,
                Knockback2 = 55,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 2,
                BlockBreaker = true,
                Weapon = "Fists",
                Style = "Jaw Breaker",
                KnockbackDirection = v81.Hit and (v81.Hit.Position - v81.Origin.Position).unit or v81.Origin.CFrame.lookVector,
                Tag = {
                    Name = v81.Tag,
                    Timer = v81.Timer
                },
                Sound = {
                    Sound = "Serious",
                    Origin = v81.Hit
                },
                HitEffect = {
                    Type = "Jaw Breaker",
                    Origin = v81.Hit
                },
                IsCharacterMelee = true
            };
        end;
        if p80 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.5);
        end;
    end,
    Vampirism = function(p82, ...) --[[ Line: 3494 ]]
        -- upvalues: l__ServerStorage__1 (copy), l__ReplicatedStorage__2 (copy)
        local v83 = ...;
        if p82 == "ReturnDamage_Info" then
            local v84 = {
                Damage = 18,
                Knockback = 25,
                Knockback2 = 55,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 2,
                Weapon = "Fists",
                Style = "Jaw Breaker",
                KnockbackDirection = v83.Hit and (v83.Hit.Position - v83.Origin.Position).unit or v83.Origin.CFrame.lookVector,
                Tag = {
                    Name = v83.Tag,
                    Timer = v83.Timer
                },
                Sound = {
                    Sound = "Serious",
                    Origin = v83.Hit
                },
                HitEffect = {
                    Type = "Jaw Breaker",
                    Origin = v83.Hit
                },
                Stun = {
                    Timer = 0,
                    Name = v83.Tag
                },
                Combo = v83.Combo
            };
            if v83.Combo == "Space Ripper Stingy Eyes" then
                v84.Damage = 23.05;
                v84.BlockBreaker = false;
                v84.Knockback = nil;
                v84.Knockback2 = nil;
                v84.Knock = 0;
                v84.Stun.Timer = 1.1;
                v84.NoDamageCancel = true;
                v84.Sound.Sound = "Gore_Splatter";
                v84.HitEffect.Type = "SharpHeavy";
                v84.IgnoreSturdiness = false;
                v84.DontStandCrash = true;
                return v84;
            end;
            if v83.Combo == "Superhuman Barrage" then
                v84.Knockback = nil;
                v84.Knockback2 = nil;
                v84.Stun.Timer = 0.5;
                v84.Damage = 0;
                v84.Knock = 0;
                v84.Sound.Sound = "Fist_Hit" .. math.random(1, 2);
                v84.IsCharacterMelee = true;
                v84.HitEffect.Type = "Fists";
                return v84;
            end;
            if v83.Combo == "Zombie Creation" then
                v84.Knockback = nil;
                v84.Knockback2 = nil;
                v84.Stun.Timer = 1;
                v84.BlockBreaker = true;
                v84.Damage = 0;
                v84.Knock = 0;
                v84.Sound.Sound = "Blade_Hit4";
                v84.IsCharacterMelee = true;
                v84.HitEffect.Type = "SharpHeavy";
                v84.HitAnim = l__ServerStorage__1.Anims.SlamHurt1;
                v84.NoDamageCancel = true;
                v84.Damage = 23;
                return v84;
            end;
            if v83.Combo == "Life Absorption" then
                v84.Knockback = nil;
                v84.Knockback2 = nil;
                v84.Knock = 0;
                v84.Damage = 3;
                v84.Sound.Sound = "Grab";
                v84.KnockbackDirection = v83.Origin.CFrame.lookVector;
                v84.HitEffect = nil;
                v84.IsCharacterMelee = true;
                v84.NoHitAnim = true;
                return v84;
            end;
            if v83.Combo == "Oblivion of Death" then
                v84.Knockback = nil;
                v84.Knockback2 = nil;
                v84.Knock = 0;
                v84.Damage = 2;
                v84.Sound.Sound = "Grab";
                v84.KnockbackDirection = v83.Origin.CFrame.lookVector;
                v84.HitEffect = nil;
                v84.IsCharacterMelee = true;
                v84.NoHitAnim = true;
                v84.PerfectBlockable = true;
                v84.IgnoreBlock = true;
                return v84;
            end;
            if v83.Combo ~= "Vaporization Freezing Technique" then
                if v83.Combo == "Vaporization Freezing Strike" then
                    v84.Damage = 12;
                    v84.Stun.Timer = 1;
                    v84.IgnoreBlock = true;
                    v84.IgnoreBlock2 = true;
                    v84.PerfectBlockable = true;
                    v84.Knockback = 0;
                    v84.Knockback2 = 0;
                    v84.Knock = 0;
                    v84.HitEffect.Type = "Blade";
                    v84.Sound.Sound = l__ReplicatedStorage__2.Sounds.Vampirism["Vaporization Freezing Strike"].Hit;
                end;
                return v84;
            end;
            v84.BlockBreaker = nil;
            v84.PerfectBlockable = nil;
            v84.Beatdown = true;
            v84.NoHitAnim = true;
            v84.Sound = nil;
            v84.HitEffect = nil;
            v84.Stun = nil;
            v84.Knockback = nil;
            v84.Knockback2 = nil;
            v84.Knock = 0;
            v84.HitEffect = nil;
            v84.IsCharacterMelee = true;
            return v84;
        end;
        if p82 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.5);
        end;
    end,
    ["Boxing Gloves"] = function(p85, ...) --[[ Line: 3607 ]]
        -- upvalues: l__Anims__5 (copy), l__ReplicatedStorage__2 (copy)
        local v86 = ...;
        local v87 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.32,
            Cooldown = 1.25,
            Style = "Boxing Gloves",
            Animations = l__Anims__5.Boxing
        };
        if p85 == "ReturnConfig" then
            return v87;
        end;
        if p85 == "ReturnDamage_Info" then
            local v88 = {
                Damage = 5.5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                KnockbackDirection = v86.Hit and (v86.Hit.Position - v86.Origin.Position).unit or v86.Origin.CFrame.lookVector,
                Style = v87.Style,
                Tag = {
                    Name = v86.Tag,
                    Timer = v86.Timer
                },
                Stun = {
                    Name = v86.Tag,
                    Timer = v87.Speed - v87.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v86.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v86.Hit
                },
                IsCharacterMelee = true
            };
            if v86.Combo == "Heavy" then
                v88.HitEffect.Type = "Heavy";
                v88.Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v86.Hit
                };
                v88.Knock = 1;
                v88.BlockBreaker = true;
                v88.PerfectBlockable = true;
                v88.Damage = 7.5;
                return v88;
            end;
            if v86.Combo == "Jawbreaker" then
                v88.Knock = 1.25;
                v88.BlockBreaker = true;
                v88.Damage = 20;
                v88.HitEffect.Type = "Heavy";
                v88.Knockback = 35;
                v88.Knockback2 = 70;
                v88.Sound.Sound = "Serious";
                return v88;
            end;
            if v86.Combo == "Knuckle Sandwich" then
                v88.Stun.Timer = 0.5;
                v88.Damage = 4;
                v88.Knockback = 10;
                v88.Knockback2 = 5;
                v88.Knock = 0;
                return v88;
            end;
            if v86.Combo == "Liver Shot" then
                v88.Stun.Timer = 1;
                v88.Damage = 12;
                v88.Knockback = 5;
                v88.Knockback2 = 3;
                v88.Sound.Sound = l__ReplicatedStorage__2.Sounds["Crazy Diamond"].HitSounds.StandHit2;
                v88.Knock = 0;
                return v88;
            end;
            if v86.Combo ~= "Haymaker" then
                if v86.Combo < v87.MaxCombo then
                    v88.Knockback = 10;
                    v88.Knockback2 = 5;
                    v88.Knock = 0;
                end;
                return v88;
            end;
            v88.Knock = 1.5;
            v88.BlockBreaker = true;
            v88.Damage = 30;
            v88.Knockback2 = 20;
            v88.Knockback = 70;
            v88.Sound.Sound = "Serious";
            return v88;
        end;
        if p85 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.5);
        end;
    end,
    ["Boxing Claws"] = function(p89, ...) --[[ Line: 3685 ]]
        -- upvalues: l__Anims__5 (copy)
        local v90 = ...;
        local v91 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.32,
            Cooldown = 1.25,
            Style = "Boxing Gloves",
            Animations = l__Anims__5.Boxing
        };
        if p89 == "ReturnConfig" then
            return v91;
        elseif p89 == "ReturnDamage_Info" then
            local v92 = {
                Damage = 5.5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                KnockbackDirection = v90.Hit and (v90.Hit.Position - v90.Origin.Position).unit or v90.Origin.CFrame.lookVector,
                Style = v91.Style,
                Tag = {
                    Name = v90.Tag,
                    Timer = v90.Timer
                },
                Stun = {
                    Name = v90.Tag,
                    Timer = v91.Speed - v91.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v90.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v90.Hit
                },
                IsCharacterMelee = true
            };
            if v90.Combo == "Heavy" then
                v92.HitEffect.Type = "Heavy";
                v92.Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v90.Hit
                };
                v92.Knock = 1;
                v92.BlockBreaker = true;
                v92.PerfectBlockable = true;
                v92.Damage = 7.5;
                return v92;
            else
                if v90.Combo ~= "Barrage" then
                    if v90.Combo < v91.MaxCombo then
                        v92.Knockback = 10;
                        v92.Knockback2 = 5;
                        v92.Knock = 0;
                    end;
                    return v92;
                end;
                v92.Knockback = 20;
                v92.Knockback2 = 0;
                v92.Knock = 0;
                v92.Damage = 2.8;
                v92.Stun.Timer = 0.4;
                return v92;
            end;
        else
            if p89 == "ReturnHitbox" then
                return Vector3.new(5, 6, 3.5);
            end;
        end;
    end,
    ["Bone Gloves"] = function(p93, ...) --[[ Line: 3741 ]]
        -- upvalues: l__Anims__5 (copy)
        local v94 = ...;
        local v95 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.32,
            Cooldown = 1.25,
            Style = "Boxing Gloves",
            Animations = l__Anims__5.Boxing
        };
        if p93 == "ReturnConfig" then
            return v95;
        elseif p93 == "ReturnDamage_Info" then
            local v96 = {
                Damage = 5.5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                KnockbackDirection = v94.Hit and (v94.Hit.Position - v94.Origin.Position).unit or v94.Origin.CFrame.lookVector,
                Style = v95.Style,
                Tag = {
                    Name = v94.Tag,
                    Timer = v94.Timer
                },
                Stun = {
                    Name = v94.Tag,
                    Timer = v95.Speed - v95.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v94.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v94.Hit
                },
                IsCharacterMelee = true
            };
            if v94.Combo == "Heavy" then
                v96.HitEffect.Type = "Heavy";
                v96.Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v94.Hit
                };
                v96.Knock = 1;
                v96.BlockBreaker = true;
                v96.PerfectBlockable = true;
                v96.Damage = 7.5;
                return v96;
            else
                if v94.Combo ~= "Barrage" then
                    if v94.Combo < v95.MaxCombo then
                        v96.Knockback = 10;
                        v96.Knockback2 = 5;
                        v96.Knock = 0;
                    end;
                    return v96;
                end;
                v96.Knockback = 20;
                v96.Knockback2 = 0;
                v96.Knock = 0;
                v96.Damage = 2.8;
                v96.Stun.Timer = 0.4;
                return v96;
            end;
        else
            if p93 == "ReturnHitbox" then
                return Vector3.new(5, 6, 3.5);
            end;
        end;
    end,
    ["Festive Gloves"] = function(p97, ...) --[[ Line: 3797 ]]
        -- upvalues: l__Anims__5 (copy)
        local v98 = ...;
        local v99 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.32,
            Cooldown = 1.25,
            Style = "Boxing Gloves",
            Animations = l__Anims__5.Boxing
        };
        if p97 == "ReturnConfig" then
            return v99;
        elseif p97 == "ReturnDamage_Info" then
            local v100 = {
                Damage = 5.5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                KnockbackDirection = v98.Hit and (v98.Hit.Position - v98.Origin.Position).unit or v98.Origin.CFrame.lookVector,
                Style = v99.Style,
                Tag = {
                    Name = v98.Tag,
                    Timer = v98.Timer
                },
                Stun = {
                    Name = v98.Tag,
                    Timer = v99.Speed - v99.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v98.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v98.Hit
                },
                IsCharacterMelee = true
            };
            if v98.Combo == "Heavy" then
                v100.HitEffect.Type = "Heavy";
                v100.Sound = {
                    Sound = "Fist_Hit3",
                    Origin = v98.Hit
                };
                v100.Knock = 1;
                v100.BlockBreaker = true;
                v100.PerfectBlockable = true;
                v100.Damage = 7.5;
                return v100;
            else
                if v98.Combo ~= "Barrage" then
                    if v98.Combo < v99.MaxCombo then
                        v100.Knockback = 10;
                        v100.Knockback2 = 5;
                        v100.Knock = 0;
                    end;
                    return v100;
                end;
                v100.Knockback = 20;
                v100.Knockback2 = 0;
                v100.Knock = 0;
                v100.Damage = 2.8;
                v100.Stun.Timer = 0.4;
                return v100;
            end;
        else
            if p97 == "ReturnHitbox" then
                return Vector3.new(5, 6, 3.5);
            end;
        end;
    end,
    ["Akuma Gloves"] = function(p101, ...) --[[ Line: 3853 ]]
        -- upvalues: l__Anims__5 (copy)
        local v102 = ...;
        local v103 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.3,
            Cooldown = 1.25,
            Style = "Akuma Gloves",
            Animations = l__Anims__5.Boxing
        };
        if p101 == "ReturnConfig" then
            return v103;
        end;
        if p101 == "ReturnDamage_Info" then
            local v104 = {
                Damage = 7,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                KnockbackDirection = v102.Hit and (v102.Hit.Position - v102.Origin.Position).unit or v102.Origin.CFrame.lookVector,
                Style = v103.Style,
                Tag = {
                    Name = v102.Tag,
                    Timer = v102.Timer
                },
                Stun = {
                    Name = v102.Tag,
                    Timer = v103.Speed - v103.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v102.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v102.Hit
                },
                IsCharacterMelee = true
            };
            if v102.Combo ~= "Heavy" then
                if v102.Combo < v103.MaxCombo then
                    v104.Knockback = 10;
                    v104.Knockback2 = 5;
                    v104.Knock = 0;
                    if v102.Combo < v103.MaxCombo - 1 then
                        v104.Stun.Timer = v103.Speed + v103.Speed / 1;
                    end;
                end;
                return v104;
            end;
            v104.HitEffect.Type = "Heavy";
            v104.Sound = {
                Sound = "Fist_Hit3",
                Origin = v102.Hit
            };
            v104.Knock = 1;
            v104.BlockBreaker = true;
            v104.PerfectBlockable = true;
            v104.Damage = 12;
            return v104;
        end;
        if p101 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.75);
        end;
    end,
    Shinobi = function(p105, ...) --[[ Line: 3907 ]]
        -- upvalues: l__Anims__5 (copy)
        local v106 = ...;
        local v107 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.32,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Boxing
        };
        if p105 == "ReturnConfig" then
            return v107;
        end;
        if p105 == "ReturnDamage_Info" then
            local v108 = {
                Damage = 5.5,
                Knockback = 32,
                Knockback2 = 10,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v106.Hit and (v106.Hit.Position - v106.Origin.Position).unit or v106.Origin.CFrame.lookVector,
                Style = v107.Style,
                Tag = {
                    Name = v106.Tag,
                    Timer = v106.Timer
                },
                Stun = {
                    Name = v106.Tag,
                    Timer = v107.Speed - 0.15
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v106.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v106.Hit
                },
                IsCharacterMelee = true
            };
            if v106.Combo ~= "Owl Slash" then
                if v106.Combo == "Ressurection" then
                    v108.IgnoreBlock = true;
                    local v109 = math.random(1, 4);
                    if v109 == 1 then
                        v108.Knockback = -32;
                    elseif v109 == 2 then
                        v108.Knockback = 32;
                    elseif v109 == 3 then
                        v108.Knockback = 32;
                        v108.KnockbackDirection = v106.Origin.CFrame.rightVector;
                    elseif v109 == 4 then
                        v108.Knockback = -32;
                        v108.KnockbackDirection = v106.Origin.CFrame.rightVector;
                    end;
                    v108.Knockback2 = 35;
                    v108.Knock = 2;
                    v108.Damage = 20;
                end;
                return v108;
            end;
            v108.PerfectBlockable = true;
            v108.IgnoreBlock = true;
            v108.Knockback = 0;
            v108.Knockback2 = 0;
            v108.KnockbackDirection = nil;
            v108.KnockbackDirection2 = nil;
            v108.Knock = 2;
            v108.Damage = 24;
            v108.Stun.Timer = 1;
            v108.Sound.Sound = "Gore_Splatter2";
            return v108;
        end;
        if p105 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.5);
        end;
    end,
    Oni = function(p110, ...) --[[ Line: 3974 ]]
        -- upvalues: l__Anims__5 (copy)
        local v111 = ...;
        local v112 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.32,
            Cooldown = 1.25,
            Style = "Boxing Gloves",
            Animations = l__Anims__5.Boxing
        };
        if p110 == "ReturnConfig" then
            return v112;
        end;
        if p110 == "ReturnDamage_Info" then
            local v113 = {
                Damage = 5.5,
                Knockback = 32,
                Knockback2 = 10,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Fists",
                KnockbackDirection = v111.Hit and (v111.Hit.Position - v111.Origin.Position).unit or v111.Origin.CFrame.lookVector,
                Style = v112.Style,
                Tag = {
                    Name = v111.Tag,
                    Timer = v111.Timer
                },
                Stun = {
                    Name = v111.Tag,
                    Timer = v112.Speed - 0.15
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v111.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v111.Hit
                },
                IsCharacterMelee = true
            };
            if v111.Combo ~= "Misogi" then
                if v111.Combo == "Axe Kick" then
                    v113.BlockBreaker = true;
                    v113.Knockback2 = 35;
                    v113.Knock = 3;
                    v113.Damage = 50;
                    v113.NoDamageCancel = true;
                    local v114 = math.random(1, 8);
                    if v114 == 1 then
                        v113.Knockback = -v113.Knockback;
                        return v113;
                    end;
                    if v114 == 2 then
                        v113.Knockback = v113.Knockback;
                        return v113;
                    end;
                    if v114 == 3 then
                        v113.Knockback = v113.Knockback;
                        v113.KnockbackDirection = Vector3.new(1, 0, 0);
                        return v113;
                    end;
                    if v114 == 4 then
                        v113.Knockback = -v113.Knockback;
                        v113.KnockbackDirection = Vector3.new(1, 0, 0);
                        return v113;
                    end;
                    if v114 == 5 then
                        v113.Knockback = v113.Knockback;
                        v113.KnockbackDirection = Vector3.new(0, 0, 1);
                        return v113;
                    end;
                    if v114 == 6 then
                        v113.Knockback = -v113.Knockback;
                        v113.KnockbackDirection = Vector3.new(0, 0, 1);
                        return v113;
                    end;
                    if v114 == 7 then
                        v113.Knockback = v113.Knockback;
                        v113.KnockbackDirection = Vector3.new(1, 0, 1);
                        return v113;
                    end;
                    if v114 == 8 then
                        v113.Knockback = -v113.Knockback;
                        v113.KnockbackDirection = Vector3.new(1, 0, 1);
                    end;
                end;
                return v113;
            end;
            v113.KnockbackDirection = v111.Origin.CFrame.lookVector;
            v113.Knockback = 30;
            v113.Knockback2 = 0;
            v113.Knock = 2;
            v113.Damage = 40;
            v113.NoIFrames = true;
            return v113;
        end;
        if p110 == "ReturnHitbox" then
            return Vector3.new(5, 6, 3.5);
        end;
    end,
    Bat = function(p115, ...) --[[ Line: 4052 ]]
        -- upvalues: l__Anims__5 (copy)
        local v116 = ...;
        local v117 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Bat",
            Animations = l__Anims__5.Pluck
        };
        if p115 == "ReturnConfig" then
            return v117;
        end;
        if p115 == "ReturnDamage_Info" then
            local v118 = {
                Damage = 5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                KnockbackDirection = v116.Hit and (v116.Hit.Position - v116.Origin.Position).unit or v116.Origin.CFrame.lookVector,
                Style = v117.Style,
                Tag = {
                    Name = v116.Tag,
                    Timer = v116.Timer
                },
                Stun = {
                    Name = v116.Tag,
                    Timer = v117.Speed - v117.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v116.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v116.Hit
                },
                IsCharacterMelee = true
            };
            if v116.Combo ~= "Heavy" then
                if v116.Combo < v117.MaxCombo then
                    v118.Knockback = 10;
                    v118.Knockback2 = 5;
                    v118.Knock = 0;
                end;
                return v118;
            end;
            v118.HitEffect.Type = "Heavy";
            v118.Sound = {
                Sound = "Fist_Hit3",
                Origin = v116.Hit
            };
            v118.Knock = 1;
            v118.BlockBreaker = true;
            v118.PerfectBlockable = true;
            v118.Damage = 9;
            return v118;
        end;
        if p115 == "ReturnHitbox" then
            return Vector3.new(5, 5, 3.5);
        end;
    end,
    ["Stop Sign"] = function(p119, ...) --[[ Line: 4101 ]]
        -- upvalues: l__Anims__5 (copy)
        local v120 = ...;
        local v121 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Bat",
            Animations = l__Anims__5.Pluck
        };
        if p119 == "ReturnConfig" then
            return v121;
        end;
        if p119 == "ReturnDamage_Info" then
            local v122 = {
                Damage = 5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                KnockbackDirection = v120.Hit and (v120.Hit.Position - v120.Origin.Position).unit or v120.Origin.CFrame.lookVector,
                Style = v121.Style,
                Tag = {
                    Name = v120.Tag,
                    Timer = v120.Timer
                },
                Stun = {
                    Name = v120.Tag,
                    Timer = v121.Speed - v121.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v120.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v120.Hit
                },
                IsCharacterMelee = true,
                Weapon = "Sword"
            };
            if v120.Combo ~= "Heavy" then
                if v120.Combo < v121.MaxCombo then
                    v122.Knockback = 10;
                    v122.Knockback2 = 5;
                    v122.Knock = 0;
                end;
                return v122;
            end;
            v122.HitEffect.Type = "Heavy";
            v122.Sound = {
                Sound = "Fist_Hit3",
                Origin = v120.Hit
            };
            v122.Knock = 1;
            v122.BlockBreaker = true;
            v122.PerfectBlockable = true;
            v122.Damage = 9;
            return v122;
        end;
        if p119 == "ReturnHitbox" then
            return Vector3.new(5, 5, 3.5);
        end;
    end,
    ["Candy cane"] = function(p123, ...) --[[ Line: 4150 ]]
        -- upvalues: l__Anims__5 (copy)
        local v124 = ...;
        local v125 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Bat",
            Animations = l__Anims__5.Pluck
        };
        if p123 == "ReturnConfig" then
            return v125;
        end;
        if p123 == "ReturnDamage_Info" then
            local v126 = {
                Damage = 5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                KnockbackDirection = v124.Hit and (v124.Hit.Position - v124.Origin.Position).unit or v124.Origin.CFrame.lookVector,
                Style = v125.Style,
                Weapon = "Sword",
                Tag = {
                    Name = v124.Tag,
                    Timer = v124.Timer
                },
                Stun = {
                    Name = v124.Tag,
                    Timer = v125.Speed - v125.Speed / 2.5
                },
                Sound = {
                    Sound = "Fist_Hit" .. math.random(1, 2),
                    Origin = v124.Hit
                },
                HitEffect = {
                    Type = "Fists",
                    Origin = v124.Hit
                },
                IsCharacterMelee = true
            };
            if v124.Combo ~= "Heavy" then
                if v124.Combo < v125.MaxCombo then
                    v126.Knockback = 10;
                    v126.Knockback2 = 5;
                    v126.Knock = 0;
                end;
                return v126;
            end;
            v126.HitEffect.Type = "Heavy";
            v126.Sound = {
                Sound = "Fist_Hit3",
                Origin = v124.Hit
            };
            v126.Knock = 1;
            v126.BlockBreaker = true;
            v126.PerfectBlockable = true;
            v126.Damage = 9;
            return v126;
        end;
        if p123 == "ReturnHitbox" then
            return Vector3.new(5, 5, 3.5);
        end;
    end,
    Pluck = function(p127, ...) --[[ Line: 4199 ]]
        -- upvalues: l__Anims__5 (copy)
        local v128 = ...;
        local v129 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Pluck
        };
        if p127 == "ReturnConfig" then
            return v129;
        end;
        if p127 == "ReturnDamage_Info" then
            local v130 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v128.Hit and (v128.Hit.Position - v128.Origin.Position).unit or v128.Origin.CFrame.lookVector,
                Style = v129.Style,
                Tag = {
                    Name = v128.Tag,
                    Timer = v128.Timer
                },
                Stun = {
                    Name = v128.Tag,
                    Timer = v129.Speed - v129.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v128.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v128.Hit
                },
                IsCharacterMelee = true
            };
            if v128.Combo ~= "Heavy" then
                if v128.Combo < v129.MaxCombo then
                    v130.Knockback = 10;
                    v130.Knockback2 = 5;
                    v130.Knock = 0;
                end;
                return v130;
            end;
            v130.HitEffect.Type = "SharpHeavy";
            v130.Sound = {
                Sound = "Blade_Hit4",
                Origin = v128.Hit
            };
            v130.Knock = 1;
            v130.BlockBreaker = true;
            v130.PerfectBlockable = true;
            v130.Damage = 12;
            return v130;
        end;
        if p127 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    Scythe = function(p131, ...) --[[ Line: 4249 ]]
        -- upvalues: l__Anims__5 (copy)
        local v132 = ...;
        local v133 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Scythe
        };
        if p131 == "ReturnConfig" then
            return v133;
        end;
        if p131 == "ReturnDamage_Info" then
            local v134 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v132.Hit and (v132.Hit.Position - v132.Origin.Position).unit or v132.Origin.CFrame.lookVector,
                Style = v133.Style,
                Tag = {
                    Name = v132.Tag,
                    Timer = v132.Timer
                },
                Stun = {
                    Name = v132.Tag,
                    Timer = v133.Speed - v133.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v132.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v132.Hit
                },
                IsCharacterMelee = true
            };
            if v132.Combo ~= "Heavy" then
                if v132.Combo < v133.MaxCombo then
                    v134.Knockback = 10;
                    v134.Knockback2 = 5;
                    v134.Knock = 0;
                end;
                return v134;
            end;
            v134.HitEffect.Type = "SharpHeavy";
            v134.Sound = {
                Sound = "Blade_Hit4",
                Origin = v132.Hit
            };
            v134.Knock = 1;
            v134.BlockBreaker = true;
            v134.PerfectBlockable = true;
            v134.Damage = 12;
            return v134;
        end;
        if p131 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    ["Cursed Scythe"] = function(p135, ...) --[[ Line: 4299 ]]
        -- upvalues: l__Anims__5 (copy)
        local v136 = ...;
        local v137 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Scythe
        };
        if p135 == "ReturnConfig" then
            return v137;
        end;
        if p135 == "ReturnDamage_Info" then
            local v138 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v136.Hit and (v136.Hit.Position - v136.Origin.Position).unit or v136.Origin.CFrame.lookVector,
                Style = v137.Style,
                Tag = {
                    Name = v136.Tag,
                    Timer = v136.Timer
                },
                Stun = {
                    Name = v136.Tag,
                    Timer = v137.Speed - v137.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v136.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v136.Hit
                },
                IsCharacterMelee = true
            };
            if v136.Combo ~= "Heavy" then
                if v136.Combo < v137.MaxCombo then
                    v138.Knockback = 10;
                    v138.Knockback2 = 5;
                    v138.Knock = 0;
                end;
                return v138;
            end;
            v138.HitEffect.Type = "SharpHeavy";
            v138.Sound = {
                Sound = "Blade_Hit4",
                Origin = v136.Hit
            };
            v138.Knock = 1;
            v138.BlockBreaker = true;
            v138.PerfectBlockable = true;
            v138.Damage = 12;
            return v138;
        end;
        if p135 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    ["Festive Scythe"] = function(p139, ...) --[[ Line: 4349 ]]
        -- upvalues: l__Anims__5 (copy)
        local v140 = ...;
        local v141 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Scythe
        };
        if p139 == "ReturnConfig" then
            return v141;
        end;
        if p139 == "ReturnDamage_Info" then
            local v142 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v140.Hit and (v140.Hit.Position - v140.Origin.Position).unit or v140.Origin.CFrame.lookVector,
                Style = v141.Style,
                Tag = {
                    Name = v140.Tag,
                    Timer = v140.Timer
                },
                Stun = {
                    Name = v140.Tag,
                    Timer = v141.Speed - v141.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v140.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v140.Hit
                },
                IsCharacterMelee = true
            };
            if v140.Combo ~= "Heavy" then
                if v140.Combo < v141.MaxCombo then
                    v142.Knockback = 10;
                    v142.Knockback2 = 5;
                    v142.Knock = 0;
                end;
                return v142;
            end;
            v142.HitEffect.Type = "SharpHeavy";
            v142.Sound = {
                Sound = "Blade_Hit4",
                Origin = v140.Hit
            };
            v142.Knock = 1;
            v142.BlockBreaker = true;
            v142.PerfectBlockable = true;
            v142.Damage = 12;
            return v142;
        end;
        if p139 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    ["Cyber Scythe"] = function(p143, ...) --[[ Line: 4399 ]]
        -- upvalues: l__Anims__5 (copy)
        local v144 = ...;
        local v145 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Scythe
        };
        if p143 == "ReturnConfig" then
            return v145;
        end;
        if p143 == "ReturnDamage_Info" then
            local v146 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v144.Hit and (v144.Hit.Position - v144.Origin.Position).unit or v144.Origin.CFrame.lookVector,
                Style = v145.Style,
                Tag = {
                    Name = v144.Tag,
                    Timer = v144.Timer
                },
                Stun = {
                    Name = v144.Tag,
                    Timer = v145.Speed - v145.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v144.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v144.Hit
                },
                IsCharacterMelee = true
            };
            if v144.Combo ~= "Heavy" then
                if v144.Combo < v145.MaxCombo then
                    v146.Knockback = 10;
                    v146.Knockback2 = 5;
                    v146.Knock = 0;
                end;
                return v146;
            end;
            v146.HitEffect.Type = "SharpHeavy";
            v146.Sound = {
                Sound = "Blade_Hit4",
                Origin = v144.Hit
            };
            v146.Knock = 1;
            v146.BlockBreaker = true;
            v146.PerfectBlockable = true;
            v146.Damage = 12;
            return v146;
        end;
        if p143 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    ["Candy Cane Sword"] = function(p147, ...) --[[ Line: 4449 ]]
        -- upvalues: l__Anims__5 (copy)
        local v148 = ...;
        local v149 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Pluck
        };
        if p147 == "ReturnConfig" then
            return v149;
        end;
        if p147 == "ReturnDamage_Info" then
            local v150 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v148.Hit and (v148.Hit.Position - v148.Origin.Position).unit or v148.Origin.CFrame.lookVector,
                Style = v149.Style,
                Tag = {
                    Name = v148.Tag,
                    Timer = v148.Timer
                },
                Stun = {
                    Name = v148.Tag,
                    Timer = v149.Speed - v149.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v148.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v148.Hit
                },
                IsCharacterMelee = true
            };
            if v148.Combo ~= "Heavy" then
                if v148.Combo < v149.MaxCombo then
                    v150.Knockback = 10;
                    v150.Knockback2 = 5;
                    v150.Knock = 0;
                end;
                return v150;
            end;
            v150.HitEffect.Type = "SharpHeavy";
            v150.Sound = {
                Sound = "Blade_Hit4",
                Origin = v148.Hit
            };
            v150.Knock = 1;
            v150.BlockBreaker = true;
            v150.PerfectBlockable = true;
            v150.Damage = 12;
            return v150;
        end;
        if p147 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    ["Festive Blade"] = function(p151, ...) --[[ Line: 4499 ]]
        -- upvalues: l__Anims__5 (copy)
        local v152 = ...;
        local v153 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Pluck
        };
        if p151 == "ReturnConfig" then
            return v153;
        end;
        if p151 == "ReturnDamage_Info" then
            local v154 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v152.Hit and (v152.Hit.Position - v152.Origin.Position).unit or v152.Origin.CFrame.lookVector,
                Style = v153.Style,
                Tag = {
                    Name = v152.Tag,
                    Timer = v152.Timer
                },
                Stun = {
                    Name = v152.Tag,
                    Timer = v153.Speed - v153.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v152.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v152.Hit
                },
                IsCharacterMelee = true
            };
            if v152.Combo ~= "Heavy" then
                if v152.Combo < v153.MaxCombo then
                    v154.Knockback = 10;
                    v154.Knockback2 = 5;
                    v154.Knock = 0;
                end;
                return v154;
            end;
            v154.HitEffect.Type = "SharpHeavy";
            v154.Sound = {
                Sound = "Blade_Hit4",
                Origin = v152.Hit
            };
            v154.Knock = 1;
            v154.BlockBreaker = true;
            v154.PerfectBlockable = true;
            v154.Damage = 12;
            return v154;
        end;
        if p151 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    ["Candy Cane Blade"] = function(p155, ...) --[[ Line: 4549 ]]
        -- upvalues: l__Anims__5 (copy)
        local v156 = ...;
        local v157 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Pluck
        };
        if p155 == "ReturnConfig" then
            return v157;
        end;
        if p155 == "ReturnDamage_Info" then
            local v158 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v156.Hit and (v156.Hit.Position - v156.Origin.Position).unit or v156.Origin.CFrame.lookVector,
                Style = v157.Style,
                Tag = {
                    Name = v156.Tag,
                    Timer = v156.Timer
                },
                Stun = {
                    Name = v156.Tag,
                    Timer = v157.Speed - v157.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v156.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v156.Hit
                },
                IsCharacterMelee = true
            };
            if v156.Combo ~= "Heavy" then
                if v156.Combo < v157.MaxCombo then
                    v158.Knockback = 10;
                    v158.Knockback2 = 5;
                    v158.Knock = 0;
                end;
                return v158;
            end;
            v158.HitEffect.Type = "SharpHeavy";
            v158.Sound = {
                Sound = "Blade_Hit4",
                Origin = v156.Hit
            };
            v158.Knock = 1;
            v158.BlockBreaker = true;
            v158.PerfectBlockable = true;
            v158.Damage = 12;
            return v158;
        end;
        if p155 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    Dagger = function(p159, ...) --[[ Line: 4599 ]]
        -- upvalues: l__Anims__5 (copy)
        local v160 = ...;
        local v161 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.35,
            Cooldown = 1,
            Style = "Dagger",
            Animations = l__Anims__5.Dagger
        };
        if p159 == "ReturnConfig" then
            return v161;
        end;
        if p159 == "ReturnDamage_Info" then
            local v162 = {
                Damage = 8,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v160.Hit and (v160.Hit.Position - v160.Origin.Position).unit or v160.Origin.CFrame.lookVector,
                Style = v161.Style,
                Tag = {
                    Name = v160.Tag,
                    Timer = v160.Timer
                },
                Stun = {
                    Name = v160.Tag,
                    Timer = v161.Speed - v161.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v160.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v160.Hit
                },
                IsCharacterMelee = true
            };
            if v160.Combo ~= "Heavy" then
                if v160.Combo < v161.MaxCombo then
                    v162.Knockback = 10;
                    v162.Knockback2 = 5;
                    v162.Knock = 0;
                    if v160.Combo < v161.MaxCombo - 1 then
                        v162.Stun.Timer = v161.Speed;
                    end;
                end;
                return v162;
            end;
            v162.HitEffect.Type = "SharpHeavy";
            v162.Sound = {
                Sound = "Blade_Hit4",
                Origin = v160.Hit
            };
            v162.Knock = 1;
            v162.BlockBreaker = true;
            v162.PerfectBlockable = true;
            v162.Damage = 12;
            return v162;
        end;
        if p159 == "ReturnHitbox" then
            return Vector3.new(5, 5, 5);
        end;
    end,
    ["Godspeed Teleport"] = function(p163, ...) --[[ Line: 4653 ]]
        -- upvalues: l__Anims__5 (copy)
        local v164 = ...;
        local v165 = {
            MaxCombo = 5,
            Blocking_Capacity = 76,
            Speed = 0.4,
            Cooldown = 1,
            Style = "Shift Sword Style",
            Animations = l__Anims__5["Shift Sword Style"]
        };
        if p163 == "ReturnConfig" then
            return v165;
        end;
        if p163 == "ReturnDamage_Info" then
            return {
                Damage = 8,
                Knockback = 0,
                Knockback2 = 0,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0,
                BlockBreaker = true,
                KnockbackDirection = v164.Hit and (v164.Hit.Position - v164.Origin.Position).unit or v164.Origin.CFrame.lookVector,
                Tag = {
                    Name = v164.Tag,
                    Timer = v164.Timer
                },
                Stun = {
                    Timer = 1,
                    Name = v164.Tag
                },
                Sound = {
                    Sound = "ElectricExplosion",
                    Origin = v164.Hit
                },
                HitEffect = {
                    Type = "Godspeed",
                    Origin = v164.Hit
                },
                Style = v165.Style
            };
        end;
        if p163 == "ReturnHitbox" then
            return Vector3.new(5, 5, 4);
        end;
    end,
    ["Shift Katana"] = function(p166, ...) --[[ Line: 4689 ]]
        -- upvalues: l__Anims__5 (copy)
        local v167 = ...;
        local v168 = {
            MaxCombo = 5,
            Blocking_Capacity = 76,
            Speed = 0.4,
            Cooldown = 1,
            Style = "Shift Sword Style",
            Animations = l__Anims__5["Shift Sword Style"]
        };
        if p166 == "ReturnConfig" then
            return v168;
        end;
        if p166 == "ReturnDamage_Info" then
            local v169 = {
                Damage = 8.5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v167.Hit and (v167.Hit.Position - v167.Origin.Position).unit or v167.Origin.CFrame.lookVector,
                Style = v168.Style,
                Tag = {
                    Name = v167.Tag,
                    Timer = v167.Timer
                },
                Stun = {
                    Name = v167.Tag,
                    Timer = v168.Speed - v168.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v167.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v167.Hit
                },
                IsCharacterMelee = true
            };
            if v167.Combo == "Heavy" then
                v169.HitEffect.Type = "SharpHeavy";
                v169.Sound = {
                    Sound = "Blade_Hit4",
                    Origin = v167.Hit
                };
                v169.Knock = 1;
                v169.BlockBreaker = true;
                v169.PerfectBlockable = true;
                v169.Damage = 12;
                return v169;
            end;
            if v167.Combo ~= "Thunder Clap" then
                if v167.Combo < v168.MaxCombo then
                    v169.Knockback = 10;
                    v169.Knockback2 = 5;
                    v169.Knock = 0;
                    if v167.Combo < v168.MaxCombo - 1 then
                        v169.Stun.Timer = v168.Speed;
                    end;
                end;
                return v169;
            end;
            v169.Sound = {
                Sound = "Gore2",
                Origin = v167.Hit
            };
            v169.Knock = 2;
            v169.BlockBreaker = true;
            v169.Damage = 28;
            math.random(1, 4);
            v169.Knockback = 0;
            v169.Knockback2 = 35;
            v169.NoDamageCancel = true;
            return v169;
        end;
        if p166 == "ReturnHitbox" then
            return Vector3.new(5, 5, 4);
        end;
    end,
    ["Shift Katana"] = function(p170, ...) --[[ Line: 4754 ]]
        -- upvalues: l__Anims__5 (copy)
        local v171 = ...;
        local v172 = {
            MaxCombo = 5,
            Blocking_Capacity = 76,
            Speed = 0.4,
            Cooldown = 1,
            Style = "Shift Sword Style",
            Animations = l__Anims__5["Shift Sword Style"]
        };
        if p170 == "ReturnConfig" then
            return v172;
        end;
        if p170 == "ReturnDamage_Info" then
            local v173 = {
                Damage = 8.5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v171.Hit and (v171.Hit.Position - v171.Origin.Position).unit or v171.Origin.CFrame.lookVector,
                Style = v172.Style,
                Tag = {
                    Name = v171.Tag,
                    Timer = v171.Timer
                },
                Stun = {
                    Name = v171.Tag,
                    Timer = v172.Speed - v172.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v171.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v171.Hit
                },
                IsCharacterMelee = true
            };
            if v171.Combo == "Heavy" then
                v173.HitEffect.Type = "SharpHeavy";
                v173.Sound = {
                    Sound = "Blade_Hit4",
                    Origin = v171.Hit
                };
                v173.Knock = 1;
                v173.BlockBreaker = true;
                v173.PerfectBlockable = true;
                v173.Damage = 12;
                return v173;
            end;
            if v171.Combo ~= "Thunder Clap" then
                if v171.Combo < v172.MaxCombo then
                    v173.Knockback = 10;
                    v173.Knockback2 = 5;
                    v173.Knock = 0;
                    if v171.Combo < v172.MaxCombo - 1 then
                        v173.Stun.Timer = v172.Speed + v172.Speed / 1;
                    end;
                end;
                return v173;
            end;
            v173.Sound = {
                Sound = "Gore2",
                Origin = v171.Hit
            };
            v173.Knock = 2;
            v173.BlockBreaker = true;
            v173.Damage = 28;
            math.random(1, 4);
            v173.Knockback = 0;
            v173.Knockback2 = 35;
            v173.NoDamageCancel = true;
            return v173;
        end;
        if p170 == "ReturnHitbox" then
            return Vector3.new(5, 5, 4);
        end;
    end,
    ["Sword of Honor"] = function(p174, ...) --[[ Line: 4817 ]]
        -- upvalues: l__Anims__5 (copy)
        local v175 = ...;
        local v176 = {
            MaxCombo = 5,
            Blocking_Capacity = 100,
            Speed = 0.4,
            Cooldown = 1,
            Style = "Shift Sword Style",
            Animations = l__Anims__5["Shift Sword Style"]
        };
        if p174 == "ReturnConfig" then
            return v176;
        end;
        if p174 == "ReturnDamage_Info" then
            local v177 = {
                Damage = 8.5,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v175.Hit and (v175.Hit.Position - v175.Origin.Position).unit or v175.Origin.CFrame.lookVector,
                Style = v176.Style,
                Tag = {
                    Name = v175.Tag,
                    Timer = v175.Timer
                },
                Stun = {
                    Name = v175.Tag,
                    Timer = v176.Speed - v176.Speed / 2.5
                },
                Sound = {
                    Sound = "SwordHit" .. math.random(1, 2),
                    Origin = v175.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v175.Hit
                },
                IsCharacterMelee = true
            };
            if v175.Combo ~= "Heavy" then
                if v175.Combo < v176.MaxCombo then
                    v177.Knockback = 10;
                    v177.Knockback2 = 5;
                    v177.Knock = 0;
                    if v175.Combo < v176.MaxCombo - 1 then
                        v177.Stun.Timer = v176.Speed + v176.Speed / 1;
                    end;
                end;
                return v177;
            end;
            v177.HitEffect.Type = "SharpHeavy";
            v177.Sound = {
                Sound = "SwordHit3",
                Origin = v175.Hit
            };
            v177.Knock = 1;
            v177.BlockBreaker = true;
            v177.PerfectBlockable = true;
            v177.Damage = 12;
            return v177;
        end;
        if p174 == "ReturnHitbox" then
            return Vector3.new(5, 5, 6.5);
        end;
    end,
    ["The Incinerator"] = function(p178, ...) --[[ Line: 4871 ]]
        -- upvalues: l__Anims__5 (copy)
        local v179 = ...;
        local v180 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.265,
            Cooldown = 1,
            Style = "Shift Sword Style",
            Animations = l__Anims__5["Shift Sword Style"]
        };
        if p178 == "ReturnConfig" then
            return v180;
        end;
        if p178 == "ReturnDamage_Info" then
            local v181 = {
                Damage = 9,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v179.Hit and (v179.Hit.Position - v179.Origin.Position).unit or v179.Origin.CFrame.lookVector,
                Style = v180.Style,
                Tag = {
                    Name = v179.Tag,
                    Timer = v179.Timer
                },
                Stun = {
                    Name = v179.Tag,
                    Timer = v180.Speed - v180.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v179.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v179.Hit
                },
                IsCharacterMelee = true
            };
            if v179.Combo == "Heavy" then
                v181.HitEffect.Type = "SharpHeavy";
                v181.Sound = {
                    Sound = "Blade_Hit4",
                    Origin = v179.Hit
                };
                v181.Knock = 4;
                v181.BlockBreaker = true;
                v181.PerfectBlockable = true;
                v181.Damage = 25;
                return v181;
            end;
            if v179.Combo ~= "Incinerate" then
                if v179.Combo < v180.MaxCombo then
                    v181.Knockback = 10;
                    v181.Knockback2 = 5;
                    v181.Knock = 0;
                    if v179.Combo < v180.MaxCombo - 1 then
                        v181.Stun.Timer = v180.Speed;
                    end;
                end;
                return v181;
            end;
            v181.Damage = math.random(200, 250) / 100;
            v181.Stun.Timer = 0.5;
            v181.Knockback = 0;
            v181.Knockback2 = 0;
            v181.Knock = 0;
            v181.HitEffect.Type = "Burn";
            v181.IgnoreBlock = true;
            v181.Sound.Sound = "Burn" .. math.random(1, 2);
            v181.Style = v179.Combo;
            return v181;
        end;
        if p178 == "ReturnHitbox" then
            return Vector3.new(7.5, 8, 6.5);
        end;
    end,
    ["Beach Boy"] = function(p182, ...) --[[ Line: 4937 ]]
        -- upvalues: l__Anims__5 (copy)
        local v183 = ...;
        local v184 = {
            MaxCombo = 5,
            Blocking_Capacity = 60,
            Speed = 0.35,
            Cooldown = 1.25,
            Style = "Beach Boy",
            Animations = l__Anims__5["Shift Sword Style"]
        };
        if p182 == "ReturnConfig" then
            return v184;
        end;
        if p182 == "ReturnDamage_Info" then
            local v185 = {
                Damage = 7.5,
                Knockback = 30,
                Knockback2 = 10,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "",
                KnockbackDirection = v183.Hit and (v183.Hit.Position - v183.Origin.Position).unit or v183.Origin.CFrame.lookVector,
                Style = v184.Style,
                Tag = {
                    Name = v183.Tag,
                    Timer = v183.Timer
                },
                Stun = {
                    Name = v183.Tag,
                    Timer = v184.Speed - v184.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v183.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v183.Hit
                },
                IsCharacterMelee = true
            };
            if v183.Combo ~= "Heavy" then
                if v183.Combo < v184.MaxCombo then
                    v185.Knockback = 40;
                    v185.Knockback2 = 15;
                    v185.Knock = 0;
                    if v183.Combo < v184.MaxCombo - 1 then
                        v185.Stun.Timer = v184.Speed;
                    end;
                end;
                return v185;
            end;
            v185.HitEffect.Type = "SharpHeavy";
            v185.Sound = {
                Sound = "Blade_Hit4",
                Origin = v183.Hit
            };
            v185.Knock = 1;
            v185.BlockBreaker = true;
            v185.PerfectBlockable = true;
            v185.Damage = 15;
            return v185;
        end;
        if p182 == "ReturnHitbox" then
            return Vector3.new(6, 5, 7.5);
        end;
    end,
    ["Blade Projections"] = function(p186, ...) --[[ Line: 4991 ]]
        -- upvalues: l__Anims__5 (copy)
        local v187 = ...;
        local v188 = {
            MaxCombo = 5,
            Blocking_Capacity = 76,
            Speed = 0.35,
            Cooldown = 1.25,
            Style = "Blade Projections",
            Animations = l__Anims__5.Blade_Projections
        };
        if p186 == "ReturnConfig" then
            return v188;
        end;
        if p186 == "ReturnDamage_Info" then
            local v189 = {
                Damage = 8,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v187.Hit and (v187.Hit.Position - v187.Origin.Position).unit or v187.Origin.CFrame.lookVector,
                Style = v188.Style,
                Tag = {
                    Name = v187.Tag,
                    Timer = v187.Timer
                },
                Stun = {
                    Name = v187.Tag,
                    Timer = v188.Speed - v188.Speed / 2.5
                },
                Sound = {
                    Sound = "Blade_Hit" .. math.random(1, 2),
                    Origin = v187.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v187.Hit
                },
                IsCharacterMelee = true
            };
            if v187.Combo ~= "Heavy" then
                if v187.Combo < v188.MaxCombo then
                    v189.Knockback = 10;
                    v189.Knockback2 = 5;
                    v189.Knock = 0;
                    if v187.Combo < v188.MaxCombo - 1 then
                        v189.Stun.Timer = v188.Speed;
                    end;
                end;
                return v189;
            end;
            v189.HitEffect.Type = "SharpHeavy";
            v189.Sound = {
                Sound = "Blade_Hit4",
                Origin = v187.Hit
            };
            v189.Knock = 1;
            v189.BlockBreaker = true;
            v189.PerfectBlockable = true;
            v189.Damage = 12;
            return v189;
        end;
        if p186 == "ReturnHitbox" then
            return Vector3.new(5, 6, 4.5);
        end;
    end,
    Shovel = function(p190, ...) --[[ Line: 5045 ]]
        -- upvalues: l__Anims__5 (copy)
        local v191 = ...;
        local v192 = {
            MaxCombo = 5,
            Blocking_Capacity = 56,
            Speed = 0.4,
            Cooldown = 1.25,
            Style = "Pluck",
            Animations = l__Anims__5.Pluck
        };
        if p190 == "ReturnConfig" then
            return v192;
        end;
        if p190 == "ReturnDamage_Info" then
            local v193 = {
                Damage = 6,
                Knockback = 50,
                Knockback2 = 20,
                KnockbackDirection2 = Vector3.new(0, 1, 0),
                Knock = 0.5,
                Weapon = "Sword",
                KnockbackDirection = v191.Hit and (v191.Hit.Position - v191.Origin.Position).unit or v191.Origin.CFrame.lookVector,
                Style = v192.Style,
                Tag = {
                    Name = v191.Tag,
                    Timer = v191.Timer
                },
                Stun = {
                    Name = v191.Tag,
                    Timer = v192.Speed - v192.Speed / 2.5
                },
                Sound = {
                    Sound = "Shovel_Hit" .. math.random(1, 3),
                    Origin = v191.Hit
                },
                HitEffect = {
                    Type = "Blade",
                    Origin = v191.Hit
                },
                IsCharacterMelee = true
            };
            if v191.Combo ~= "Heavy" then
                if v191.Combo < v192.MaxCombo then
                    v193.Knockback = 10;
                    v193.Knockback2 = 5;
                    v193.Knock = 0;
                    if v191.Combo < v192.MaxCombo - 1 then
                        v193.Stun.Timer = v192.Speed;
                    end;
                end;
                return v193;
            end;
            v193.HitEffect.Type = "SharpHeavy";
            v193.Sound = {
                Sound = "Blade_Hit4",
                Origin = v191.Hit
            };
            v193.Knock = 1;
            v193.BlockBreaker = true;
            v193.PerfectBlockable = true;
            v193.Damage = 12;
            return v193;
        end;
        if p190 == "ReturnHitbox" then
            return Vector3.new(5, 5, 6.5);
        end;
    end
};