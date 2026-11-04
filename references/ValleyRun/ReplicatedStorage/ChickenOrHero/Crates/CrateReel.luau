 

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Palette = Skin.Palette;
local NumberSequence_new_ret = NumberSequence.new(0.2, 0.6);
local u1 = setmetatable({}, {
    __mode = "k"
});

local function cardSequence(p2) -- Line: 18
    -- upvalues: u1 (copy), Palette (copy)
    local v3 = u1[p2];

    if not v3 then
        v3 = ColorSequence.new(Palette.surface, p2);
        u1[p2] = v3;
    end;

    return v3;
end;

return {
    new = function(u4, u5, u6, u7, u8, u9, p10) -- Line: 27, Name: new
        -- upvalues: SoundService (copy), TweenService (copy), Palette (copy), Skin (copy), u1 (copy), NumberSequence_new_ret (copy), RunService (copy)
        local u11 = p10 or {};
        local u12 = {
            generation = 0,
            sounds = {},
            tweens = {},
            timers = {}
        };
        local Random_new_ret = Random.new();

        local function describe(p13, p14) -- Line: 32
            -- upvalues: u11 (ref), u7 (copy)
            local v15 = u11.prize and u11.prize(p13, p14);

            if v15 then
                return v15;
            end;

            local v16 = u7.get(p14);

            return v16 and {
                kind = "Skin",
                id = p14,
                name = v16.Name,
                rarity = v16.Rarity or "Common"
            } or nil;
        end;

        local function releaseHero() -- Line: 42
            -- upvalues: u12 (copy)
            local hero = u12.hero;
            u12.hero = nil;

            if hero then
                pcall(hero.destroy, hero);
            end;
        end;

        function u12.cancel(p17) -- Line: 49
            -- upvalues: u12 (copy), u4 (copy)
            local v18 = u12;
            v18.generation = v18.generation + 1;

            if u12.connection then
                u12.connection:Disconnect();
                u12.connection = nil;
            end;

            for _, v in u12.sounds do
                v:Destroy();
            end;

            for _, v in u12.tweens do
                v:Cancel();
            end;

            for i in u12.timers do
                task.cancel(i);
            end;

            table.clear(u12.timers);
            table.clear(u12.sounds);
            table.clear(u12.tweens);
            local hero = u12.hero;
            u12.hero = nil;

            if hero then
                pcall(hero.destroy, hero);
            end;

            u4:ClearAllChildren();
        end;

        function u12.step(p19, p20) -- Line: 71
            -- upvalues: u12 (copy)
            local hero = u12.hero;

            if hero and hero.step then
                hero:step(p20);
            end;
        end;

        local function later(p21, u22, u23) -- Line: 77
            -- upvalues: u12 (copy), u4 (copy)
            local u24 = nil;
            u24 = task.delay(p21, function() -- Line: 79
                -- upvalues: u12 (ref), u24 (ref), u22 (copy), u4 (ref), u23 (copy)
                u12.timers[u24] = nil;

                if u22 == u12.generation and u4.Parent then
                    u23();
                end;
            end);
            u12.timers[u24] = true;
        end;

        local function sound(p25, p26, p27, p28) -- Line: 87
            -- upvalues: SoundService (ref), u12 (copy)
            local Sound = Instance.new("Sound");
            Sound.Name = p25;
            Sound.SoundId = "rbxassetid://" .. p26;
            Sound.Volume = p27;
            Sound.PlaybackSpeed = p28 or 1;
            Sound.Parent = SoundService;
            table.insert(u12.sounds, Sound);

            return Sound;
        end;

        local function animate(p29, p30, p31, p32) -- Line: 97
            -- upvalues: TweenService (ref), u12 (copy)
            local v33 = TweenService:Create(p29, TweenInfo.new(p30, p31, Enum.EasingDirection.Out), p32);
            table.insert(u12.tweens, v33);
            v33:Play();
        end;

        function u12.play(p34, u35, u36) -- Line: 102
            -- upvalues: u12 (copy), describe (copy), u8 (copy), u5 (copy), u4 (copy), Palette (ref), Skin (ref), u6 (copy), Random_new_ret (copy), u1 (ref), NumberSequence_new_ret (ref), u11 (ref), u9 (copy), SoundService (ref), RunService (ref), TweenService (ref)
            u12:cancel();
            local generation = u12.generation;
            local v37 = u35.emote or u35.skin;
            local u38 = describe(u35.crate, v37) or {
                rarity = "Common",
                kind = u35.emote and "Emote" or "Skin",
                id = v37,
                name = tostring(v37)
            };
            local u39 = u8[u38.rarity] or u5.Gold;
            local u40 = u5.make("Frame", u4, "ReelWindow", {
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = Palette.reel
            });
            u5.corner(u40, 12);
            u5.stroke(u40, u5.Gold, 0.45);
            Skin.ring(u40, Palette.gold, 2);
            local u41 = u5.make("Frame", u40, "Strip", {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(6804, 226),
                Position = UDim2.fromOffset(0, 17)
            });
            local u42 = {};

            for i = 1, 42 do
                local v43;

                if i == 36 then
                    v43 = u38;
                else
                    local v44 = u6.pick(u35.crate, Random_new_ret:NextInteger(1, 10000));
                    local v45 = v44.Emote or v44.Skin;
                    v43 = describe(u35.crate, v45) or {
                        kind = v44.Emote and "Emote" or "Skin",
                        id = v45,
                        name = tostring(v45),
                        rarity = v44.Rarity or "Common"
                    };
                end;

                local v46 = u8[v43.rarity] or u5.Muted;
                local v47 = u5.make("Frame", u41, "Card" .. i, {
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset((i - 1) * 162, 0),
                    Size = UDim2.fromOffset(150, 226),
                    BackgroundColor3 = Color3.new(1, 1, 1)
                });
                u5.corner(v47, 10);
                u5.stroke(v47, v46, 0.5);
                Skin.ring(v47, v46, 2);
                local make = u5.make;
                local v48 = {
                    Rotation = 90
                };
                local v49 = u1[v46];

                if not v49 then
                    v49 = ColorSequence.new(Palette.surface, v46);
                    u1[v46] = v49;
                end;

                v48.Color = v49;
                v48.Transparency = NumberSequence_new_ret;
                make("UIGradient", v47, "Tint", v48);
                u5.make("Frame", v47, "RarityLine", {
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 1, -5),
                    Size = UDim2.new(1, 0, 0, 5),
                    BackgroundColor3 = v46
                });
                local v50 = u5.make("Frame", v47, "Art", {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(4, 15),
                    Size = UDim2.fromOffset(142, 140)
                });

                if v43.kind == "Emote" then
                    u5.make("ImageLabel", v50, "Icon", {
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(92, 92),
                        Image = u11.icon or "",
                        ImageColor3 = v46:Lerp(Color3.new(1, 1, 1), 0.35),
                        ScaleType = Enum.ScaleType.Fit
                    });
                else
                    u9(v50, v43.id);
                end;

                local v51 = u5.text(v47, "Name", v43.name, 8, 159, 134, 36, 14, u5.Paper);
                v51.Font = Enum.Font.GothamBold;
                v51.TextXAlignment = Enum.TextXAlignment.Center;
                u5.text(v47, "Rarity", string.upper(v43.rarity), 5, 198, 140, 18, 10, v46).TextXAlignment = Enum.TextXAlignment.Center;
                u42[i] = v47;
                local _ = i;
            end;

            local u52 = u5.make("Frame", u40, "Pointer", {
                BackgroundTransparency = 0.15,
                BorderSizePixel = 0,
                ZIndex = 20,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.fromScale(0.5, 0),
                Size = UDim2.fromOffset(3, 260),
                BackgroundColor3 = u5.Gold
            });
            u5.make("Frame", u52, "Diamond", {
                Rotation = 45,
                BorderSizePixel = 0,
                ZIndex = 21,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromOffset(1, 10),
                Size = UDim2.fromOffset(16, 16),
                BackgroundColor3 = u5.Gold
            });
            local Sound = Instance.new("Sound");
            Sound.Name = "CrateTick";
            Sound.SoundId = "rbxassetid://" .. 10128760939;
            Sound.Volume = 0.16;
            Sound.PlaybackSpeed = 1.3;
            Sound.Parent = SoundService;
            table.insert(u12.sounds, Sound);
            local Sound2 = Instance.new("Sound");
            Sound2.Name = "CrateOpen";
            Sound2.SoundId = "rbxassetid://" .. 10128766965;
            Sound2.Volume = 0.3;
            Sound2.PlaybackSpeed = 0.8;
            Sound2.Parent = SoundService;
            table.insert(u12.sounds, Sound2);
            local Sound3 = Instance.new("Sound");
            Sound3.Name = "CrateReward";
            Sound3.SoundId = "rbxassetid://" .. 82803453482376;
            Sound3.Volume = 0.42;
            Sound3.PlaybackSpeed = 1;
            Sound3.Parent = SoundService;
            table.insert(u12.sounds, Sound3);
            Sound2:Play();
            local u53 = 0;
            local u54 = 0;
            u12.connection = RunService.RenderStepped:Connect(function(p55) -- Line: 208
                -- upvalues: generation (copy), u12 (ref), u53 (ref), u41 (copy), u54 (ref), Sound (copy), u52 (copy), u4 (ref), u42 (copy), u5 (ref), u40 (copy), u39 (copy), TweenService (ref), Palette (ref), Random_new_ret (ref), u38 (copy), Skin (ref), u11 (ref), u35 (copy), u9 (ref), Sound2 (copy), Sound3 (copy), u36 (copy)
                if generation ~= u12.generation then
                    return;
                end;

                u53 = u53 + p55;
                local math_clamp_ret = math.clamp(u53 / 5.6, 0, 1);
                local v56 = (1 - (1 - math_clamp_ret) ^ 4) * 5346 + 399;
                u41.Position = UDim2.new(0.5, -v56, 0, 17);
                local v57 = math.floor((v56 + 6) / 162) + 1;

                if v57 == u54 then
                    u52.BackgroundTransparency = math.min(0.35, u52.BackgroundTransparency + p55 * 3);
                else
                    u54 = v57;
                    Sound.PlaybackSpeed = (1 - math_clamp_ret) * 0.6 + 0.85;
                    Sound.TimePosition = 0;
                    Sound:Play();
                    u52.BackgroundTransparency = 0;
                end;

                local v58 = u4.Size.X.Offset / 2;

                for i, v in u42 do
                    v.Visible = math.abs((i - 1) * 162 + 75 - v56) < v58 + 162;
                end;

                if math_clamp_ret < 1 then
                    return;
                end;

                u12.connection:Disconnect();
                u12.connection = nil;
                Sound.PlaybackSpeed = 0.65;
                Sound:Play();
                local v59 = TweenService:Create(u5.make("Frame", u40, "WinFlash", {
                    BackgroundTransparency = 0.25,
                    BorderSizePixel = 0,
                    ZIndex = 22,
                    Size = UDim2.fromScale(1, 1),
                    BackgroundColor3 = u39
                }), TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                });
                table.insert(u12.tweens, v59);
                v59:Play();
                local v60 = u42[36];
                local Back = Enum.EasingStyle.Back;
                local v61 = {
                    BackgroundColor3 = u39:Lerp(Palette.surface, 0.65)
                };
                local v62 = TweenService:Create(v60, TweenInfo.new(0.24, Back, Enum.EasingDirection.Out), v61);
                table.insert(u12.tweens, v62);
                v62:Play();
                local u63 = generation;

                local function u95() -- Line: 249
                    -- upvalues: u40 (ref), u42 (ref), u5 (ref), u4 (ref), u39 (ref), TweenService (ref), u12 (ref), Random_new_ret (ref), u38 (ref), Skin (ref), u11 (ref), u35 (ref), u9 (ref), Sound2 (ref), generation (ref), Sound3 (ref), u36 (ref)
                    u40:Destroy();
                    table.clear(u42);
                    local v64 = u5.make("Frame", u4, "RarityBurst", {
                        BackgroundTransparency = 1,
                        Rotation = -25,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(1, 1)
                    });

                    for i = 1, 16 do
                        local v65 = i * 3.141592653589793 / 8;
                        local v66 = u5.make("Frame", v64, "Ray" .. i, {
                            BackgroundTransparency = 0.45,
                            BorderSizePixel = 0,
                            AnchorPoint = Vector2.new(0.5, 1),
                            Position = UDim2.fromOffset(math.sin(v65) * 28, -math.cos(v65) * 28),
                            Size = UDim2.fromOffset(i % 2 == 0 and 18 or 7, 20),
                            Rotation = math.deg(v65),
                            BackgroundColor3 = u39
                        });
                        u5.corner(v66, 8);
                        u5.make("UIGradient", v66, "Fade", {
                            Rotation = 90,
                            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.3), NumberSequenceKeypoint.new(1, 0.95) })
                        });
                        local Quart = Enum.EasingStyle.Quart;
                        local v67 = {
                            BackgroundTransparency = 0.75,
                            Size = UDim2.fromOffset(i % 2 == 0 and 18 or 7, i % 2 == 0 and 120 or 145)
                        };
                        local v68 = TweenService:Create(v66, TweenInfo.new(0.75, Quart, Enum.EasingDirection.Out), v67);
                        table.insert(u12.tweens, v68);
                        v68:Play();
                        local _ = i;
                    end;

                    local v69 = TweenService:Create(v64, TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Rotation = 35
                    });
                    table.insert(u12.tweens, v69);
                    v69:Play();

                    for i = 1, 2 do
                        local v70 = u5.make("Frame", u4, "ShockRing" .. i, {
                            BackgroundTransparency = 1,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            Size = UDim2.fromOffset(30, 30)
                        });
                        u5.corner(v70, 999);
                        u5.stroke(v70, u39, 0.15);
                        v70.Outline.Color = u39;
                        v70.SkinOutline.Enabled = false;
                        v70.Outline.Thickness = i == 1 and 3 or 1;
                        local Quart = Enum.EasingStyle.Quart;
                        local v71 = {
                            Size = UDim2.fromOffset(i * 40 + 210, i * 40 + 210)
                        };
                        local v72 = TweenService:Create(v70, TweenInfo.new(i * 0.2 + 0.6, Quart, Enum.EasingDirection.Out), v71);
                        table.insert(u12.tweens, v72);
                        v72:Play();
                        local v73 = TweenService:Create(v70.Outline, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Transparency = 1
                        });
                        table.insert(u12.tweens, v73);
                        v73:Play();
                        local _ = i;
                    end;

                    for i = 1, 24 do
                        local v74 = i * 3.141592653589793 / 12 + Random_new_ret:NextNumber(-0.1, 0.1);
                        local v75 = Random_new_ret:NextNumber(80, 150);
                        local v76 = u5.make("Frame", u4, "Glint" .. i, {
                            BorderSizePixel = 0,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            Size = UDim2.fromOffset(3, Random_new_ret:NextInteger(5, 11)),
                            Rotation = math.deg(v74),
                            BackgroundColor3 = u39:Lerp(Color3.new(1, 1, 1), 0.3)
                        });
                        local v77 = Random_new_ret:NextNumber(0.65, 1.1);
                        local Quart = Enum.EasingStyle.Quart;
                        local v78 = {
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0.5, math.cos(v74) * v75, 0.5, math.sin(v74) * v75),
                            Size = UDim2.fromOffset(1, 1),
                            Rotation = math.deg(v74) + 120
                        };
                        local v79 = TweenService:Create(v76, TweenInfo.new(v77, Quart, Enum.EasingDirection.Out), v78);
                        table.insert(u12.tweens, v79);
                        v79:Play();
                        local _ = i;
                    end;

                    local v80 = u38.kind == "Emote";
                    local u81 = u5.make("Frame", u4, v80 and "WinningEmote" or "WinningKnife", {
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromScale(0.15, 0.15),
                        Rotation = v80 and 0 or -70
                    });
                    Skin.glow(u81, u39);
                    local v82 = u5.make("Frame", u81, "Halo", {
                        Rotation = 45,
                        BackgroundTransparency = 0.9,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(180, 180),
                        BackgroundColor3 = u39
                    });
                    u5.corner(v82, 24);
                    u5.stroke(v82, u39, 0.45);
                    Skin.ring(v82, u39, 2);

                    if v80 then
                        local v83 = u11.hero and u11.hero(u81, u35, u38);

                        if v83 then
                            u12.hero = v83;
                        else
                            u5.make("ImageLabel", u81, "Icon", {
                                BackgroundTransparency = 1,
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                Position = UDim2.fromScale(0.5, 0.5),
                                Size = UDim2.fromOffset(120, 120),
                                Image = u11.icon or "",
                                ImageColor3 = u39:Lerp(Color3.new(1, 1, 1), 0.35),
                                ScaleType = Enum.ScaleType.Fit
                            });
                        end;
                    else
                        u9(u81, u38.id);
                    end;

                    Sound2.PlaybackSpeed = 1.35;
                    Sound2:Play();
                    local Back2 = Enum.EasingStyle.Back;
                    local v84 = {
                        Size = UDim2.fromScale(1.12, 1.12),
                        Rotation = v80 and 0 or 4
                    };
                    local v85 = TweenService:Create(u81, TweenInfo.new(0.65, Back2, Enum.EasingDirection.Out), v84);
                    table.insert(u12.tweens, v85);
                    v85:Play();
                    local v86 = TweenService:Create(v82, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Rotation = 135
                    });
                    table.insert(u12.tweens, v86);
                    v86:Play();
                    local u87 = generation;

                    local function u93() -- Line: 376
                        -- upvalues: Sound3 (ref), u81 (copy), TweenService (ref), u12 (ref), u38 (ref), u5 (ref), u4 (ref), u35 (ref), u39 (ref), u36 (ref)
                        Sound3:Play();
                        local Sine = Enum.EasingStyle.Sine;
                        local v88 = {
                            Rotation = 0,
                            Size = UDim2.fromScale(1, 1)
                        };
                        local v89 = TweenService:Create(u81, TweenInfo.new(0.55, Sine, Enum.EasingDirection.Out), v88);
                        table.insert(u12.tweens, v89);
                        v89:Play();
                        local string_upper_ret = string.upper(u38.rarity or "Common");
                        local v90 = u5.text(u4, "RarityStamp", u35.duplicate and string_upper_ret .. " · COLLECTED" or string_upper_ret .. " · UNLOCKED", 0, 12, u4.Size.X.Offset, 24, 13, u39);
                        v90.Font = Enum.Font.GothamBold;
                        v90.TextXAlignment = Enum.TextXAlignment.Center;
                        v90.TextTransparency = 1;
                        v90.ZIndex = 3;
                        local Quart = Enum.EasingStyle.Quart;
                        local v91 = {
                            TextTransparency = 0,
                            Position = UDim2.fromOffset(0, 0)
                        };
                        local v92 = TweenService:Create(v90, TweenInfo.new(0.3, Quart, Enum.EasingDirection.Out), v91);
                        table.insert(u12.tweens, v92);
                        v92:Play();
                        u36();
                    end;

                    local u94 = nil;
                    u94 = task.delay(0.55, function() -- Line: 79
                        -- upvalues: u12 (ref), u94 (ref), u87 (copy), u4 (ref), u93 (copy)
                        u12.timers[u94] = nil;

                        if u87 == u12.generation and u4.Parent then
                            u93();
                        end;
                    end);
                    u12.timers[u94] = true;
                end;

                local u96 = nil;
                u96 = task.delay(0.35, function() -- Line: 79
                    -- upvalues: u12 (ref), u96 (ref), u63 (copy), u4 (ref), u95 (copy)
                    u12.timers[u96] = nil;

                    if u63 == u12.generation and u4.Parent then
                        u95();
                    end;
                end);
                u12.timers[u96] = true;
            end);
        end;

        return u12;
    end
};