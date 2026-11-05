  

 

local Option = require(script:WaitForChild("Option"));

return function(u1) -- Line: 3
    -- upvalues: Option (copy)
    local PathShortcuts = u1.PathShortcuts;
    local v2 = table.find(PathShortcuts.TestPlaces, game.PlaceId) and true or false;
    local Xtal = u1.Xtal;
    local Settings = u1.Player:WaitForChild("Settings");
    local Remotes = game.ReplicatedStorage:WaitForChild("Remotes");
    local u3 = Remotes.Settings:InvokeServer("RequestDefaults");
    local ItemData = require(PathShortcuts.ReplicatedModules.ItemData);
    local u4 = {};
    local u5 = Xtal("Dematerial");
    local u6 = Xtal("Detexture");
    local u7 = Xtal("Deshadow");
    local u213 = {
        Gameplay = {
            {
                Name = "Indicators",
                Type = "Border"
            },
            {
                Name = "Item Notifier",
                Type = "Toggle",
                ValueName = "ItemNotifier",

                Updated = function(p8, p9) -- Line: 27, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ItemNotifier.Value = p9;
                end,

                Callback = function(p10) -- Line: 30, Name: Callback
                    -- upvalues: Settings (copy)
                    p10:Toggle(Settings.ItemNotifier.Value);
                end
            },
            {
                Name = "Damage Indicator",
                Type = "Toggle",
                ValueName = "DamageIndicator",

                Updated = function(p11, p12) -- Line: 37, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.DamageIndicator.Value = p12;
                end,

                Callback = function(p13) -- Line: 40, Name: Callback
                    -- upvalues: Settings (copy)
                    p13:Toggle(Settings.DamageIndicator.Value);
                end
            },
            {
                Name = "Combo Indicator",
                Type = "Selection",
                ValueName = "ComboIndicator",

                Updated = function(p14, p15) -- Line: 56, Name: Updated
                    -- upvalues: Settings (copy)
                    local v16 = p14:GetRawData();
                    Settings.ComboIndicator.Value = table.find(v16.Arguments[1], p15);
                end,

                Callback = function(p17) -- Line: 60, Name: Callback
                    -- upvalues: Settings (copy)
                    p17:Select(p17:GetRawData().Arguments[1][Settings.ComboIndicator.Value]);
                end,

                Arguments = { { "Left", "Right", "Disabled" } }
            },
            {
                Name = "Damage Quotes",
                Type = "Toggle",
                ValueName = "DamageQuotes",

                Updated = function(p18, p19) -- Line: 73, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.DamageQuotes.Value = p19;
                end,

                Callback = function(p20) -- Line: 76, Name: Callback
                    -- upvalues: Settings (copy)
                    p20:Toggle(Settings.DamageQuotes.Value);
                end
            },
            {
                Name = "Parry Indicator",
                Type = "Toggle",
                ValueName = "ParryIndicator",
                Visible = true,

                Updated = function(p21, p22) -- Line: 83, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ParryIndicator.Value = p22;
                end,

                Callback = function(p23) -- Line: 86, Name: Callback
                    -- upvalues: Settings (copy)
                    p23:Toggle(Settings.ParryIndicator.Value);
                end
            },
            {
                Name = "Stun Indicator",
                Type = "Toggle",
                ValueName = "StunIndicator",

                Updated = function(p24, p25) -- Line: 94, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.StunIndicator.Value = p25;
                end,

                Callback = function(p26) -- Line: 97, Name: Callback
                    -- upvalues: Settings (copy)
                    p26:Toggle(Settings.StunIndicator.Value);
                end
            },
            {
                Name = "Armor Indicator",
                Type = "Toggle",
                ValueName = "ArmorIndicator",

                Updated = function(p27, p28) -- Line: 104, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ArmorIndicator.Value = p28;
                end,

                Callback = function(p29) -- Line: 107, Name: Callback
                    -- upvalues: Settings (copy)
                    p29:Toggle(Settings.ArmorIndicator.Value);
                end
            },
            {
                Name = "Moveset Indicators",
                Type = "Selection",
                ValueName = "MovesetIndicators",

                Updated = function(p30, p31) -- Line: 114, Name: Updated
                    -- upvalues: Settings (copy)
                    local v32 = p30:GetRawData();
                    Settings.MovesetIndicators.Value = table.find(v32.Arguments[1], p31);
                end,

                Callback = function(p33) -- Line: 118, Name: Callback
                    -- upvalues: Settings (copy)
                    p33:Select(p33:GetRawData().Arguments[1][Settings.MovesetIndicators.Value]);
                end,

                Arguments = { { "Enabled", "Disabled", "Cooldowns Only", "Ready Only" } }
            },
            {
                Name = "Moveset Indicator Type",
                Type = "Selection",
                ValueName = "MovesetIndicatorType",

                Updated = function(p34, p35) -- Line: 133, Name: Updated
                    -- upvalues: Settings (copy)
                    local v36 = p34:GetRawData();
                    Settings.MovesetIndicatorType.Value = table.find(v36.Arguments[1], p35);
                end,

                Callback = function(p37) -- Line: 137, Name: Callback
                    -- upvalues: Settings (copy)
                    p37:Select(p37:GetRawData().Arguments[1][Settings.MovesetIndicatorType.Value]);
                end,

                Arguments = { { "Normal", "Compact" } }
            },
            {
                Name = "Moveset Indicator Tips",
                Type = "Selection",
                ValueName = "MovesetIndicatorTips",

                Updated = function(p38, p39) -- Line: 150, Name: Updated
                    -- upvalues: Settings (copy)
                    local v40 = p38:GetRawData();
                    Settings.MovesetIndicatorTips.Value = table.find(v40.Arguments[1], p39);
                end,

                Callback = function(p41) -- Line: 154, Name: Callback
                    -- upvalues: Settings (copy)
                    p41:Select(p41:GetRawData().Arguments[1][Settings.MovesetIndicatorTips.Value]);
                end,

                Arguments = { { "On Hover", "Always Visible", "Hide" } },
                Visible = v2
            },
            {
                Name = "Mobile Button Name Scheme",
                Type = "Selection",
                ValueName = "MobileButtonNameScheme",

                Updated = function(p42, p43) -- Line: 168, Name: Updated
                    -- upvalues: Settings (copy)
                    local v44 = p42:GetRawData();
                    Settings.MobileButtonNameScheme.Value = table.find(v44.Arguments[1], p43);
                end,

                Callback = function(p45) -- Line: 172, Name: Callback
                    -- upvalues: Settings (copy)
                    p45:Select(p45:GetRawData().Arguments[1][Settings.MobileButtonNameScheme.Value]);
                end,

                Arguments = { { "InputName", "MoveName" } }
            },
            {
                Name = "Display Hitboxes",
                Type = "Toggle",
                ValueName = "HitboxDisplay",

                Updated = function(p46, p47) -- Line: 186, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.HitboxDisplay.Value = p47;
                end,

                Callback = function(p48) -- Line: 189, Name: Callback
                    -- upvalues: Settings (copy)
                    p48:Toggle(Settings.HitboxDisplay.Value);
                end
            },
            {
                Name = "Show Own HUD",
                Type = "Toggle",
                ValueName = "ShowSelfHud",

                Updated = function(p49, p50) -- Line: 196, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ShowSelfHud.Value = p50;
                end,

                Callback = function(p51) -- Line: 199, Name: Callback
                    -- upvalues: Settings (copy)
                    p51:Toggle(Settings.ShowSelfHud.Value);
                end
            },
            {
                Name = "Hide All Player HUD",
                Type = "Toggle",
                ValueName = "HideAllPlayerHud",

                Updated = function(p52, p53) -- Line: 207, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.HideAllPlayerHud.Value = p53;
                end,

                Callback = function(p54) -- Line: 210, Name: Callback
                    -- upvalues: Settings (copy)
                    p54:Toggle(Settings.HideAllPlayerHud.Value);
                end
            },
            {
                Name = "Camera",
                Type = "Border"
            },
            {
                Name = "Camera Movement",
                Type = "Toggle",
                ValueName = "CameraMovement",
                Visible = true,

                Updated = function(p55, p56) -- Line: 222, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.CameraMovement.Value = p56;
                end,

                Callback = function(p57) -- Line: 225, Name: Callback
                    -- upvalues: Settings (copy)
                    p57:Toggle(Settings.CameraMovement.Value);
                end
            },
            {
                Name = "Head Tracking",
                Type = "Toggle",
                ValueName = "HeadTracking",
                Visible = true,

                Updated = function(p58, p59) -- Line: 233, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.HeadTracking.Value = p59;
                end,

                Callback = function(p60) -- Line: 236, Name: Callback
                    -- upvalues: Settings (copy)
                    p60:Toggle(Settings.HeadTracking.Value);
                end
            },
            {
                Name = "Cutscene Camera",
                Type = "Toggle",
                ValueName = "CutsceneCamera",

                Updated = function(p61, p62) -- Line: 244, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.CutsceneCamera.Value = p62;
                end,

                Callback = function(p63) -- Line: 247, Name: Callback
                    -- upvalues: Settings (copy)
                    p63:Toggle(Settings.CutsceneCamera.Value);
                end
            },
            {
                Name = "Field Of View",
                Type = "Slider",
                ValueName = "FieldOfView",

                Updated = function(p64, p65) -- Line: 254, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.FieldOfView.Value = p65;
                    workspace.CurrentCamera.FieldOfView = p65;
                end,

                Callback = function(p66) -- Line: 258, Name: Callback
                    -- upvalues: Settings (copy)
                    p66:SetText(Settings.FieldOfView.Value);
                    p66.Slider:Set(Settings.FieldOfView.Value);
                end,

                Arguments = { 70, 120, true }
            },
            {
                Name = "Requests",
                Type = "Border"
            },
            {
                Name = "Trading Requests",
                Type = "Toggle",
                ValueName = "Trading",

                Updated = function(p67, p68) -- Line: 270, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.Trading.Value = p68;
                end,

                Callback = function(p69) -- Line: 273, Name: Callback
                    -- upvalues: Settings (copy)
                    p69:Toggle(Settings.Trading.Value);
                end
            },
            {
                Name = "Party Requests",
                Type = "Toggle",
                ValueName = "PartyInvites",

                Updated = function(p70, p71) -- Line: 280, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.PartyInvites.Value = p71;
                end,

                Callback = function(p72) -- Line: 283, Name: Callback
                    -- upvalues: Settings (copy)
                    p72:Toggle(Settings.PartyInvites.Value);
                end
            },
            {
                Name = "Challenge Requests",
                Type = "Toggle",
                ValueName = "Challenge",

                Updated = function(p73, p74) -- Line: 290, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.Challenge.Value = p74;
                end,

                Callback = function(p75) -- Line: 293, Name: Callback
                    -- upvalues: Settings (copy)
                    p75:Toggle(Settings.Challenge.Value);
                end,

                Visible = v2
            },
            {
                Name = "UI",
                Type = "Border"
            },
            {
                Name = "Colorblind Friendly Meter Bar",
                Type = "Toggle",
                ValueName = "ColorBlindMeter",

                Updated = function(p76, p77) -- Line: 305, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ColorBlindMeter.Value = p77;
                end,

                Callback = function(p78) -- Line: 308, Name: Callback
                    -- upvalues: Settings (copy)
                    p78:Toggle(Settings.ColorBlindMeter.Value);
                end
            },
            {
                Name = "Stack Inventory Items",
                Type = "Toggle",
                ValueName = "StackInventoryItems",

                Updated = function(p79, p80) -- Line: 316, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.StackInventoryItems.Value = p80;
                end,

                Callback = function(p81) -- Line: 319, Name: Callback
                    -- upvalues: Settings (copy)
                    p81:Toggle(Settings.StackInventoryItems.Value);
                end
            },
            {
                Name = "Auto-skip Waves (Boundless Tower)",
                Type = "Toggle",
                ValueName = "AutoSkipWave",

                Updated = function(p82, p83) -- Line: 327, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.AutoSkipWave.Value = p83;
                end,

                Callback = function(p84) -- Line: 330, Name: Callback
                    -- upvalues: Settings (copy)
                    p84:Toggle(Settings.AutoSkipWave.Value);
                end
            },
            {
                Name = "Input",
                Type = "Border"
            },
            {
                Name = "Held Move Fidelity (Seconds)",
                Type = "Slider",
                ValueName = "HeldFidelity",

                Updated = function(p85, p86) -- Line: 341, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.HeldFidelity.Value = p86;
                end,

                Callback = function(p87) -- Line: 344, Name: Callback
                    -- upvalues: Settings (copy)
                    p87:SetText(Settings.HeldFidelity.Value);
                    p87.Slider:Set(Settings.HeldFidelity.Value);
                end,

                Arguments = { 0.1, 0.4 }
            },
            {
                Name = "Allow Move Inputs In Menu",
                Type = "Toggle",
                ValueName = "MovesInMenu",

                Updated = function(p88, p89) -- Line: 353, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.MovesInMenu.Value = p89;
                end,

                Callback = function(p90) -- Line: 356, Name: Callback
                    -- upvalues: Settings (copy)
                    p90:Toggle(Settings.MovesInMenu.Value);
                end
            },
            {
                Name = "Rush Attack Buffer (Seconds)",
                Type = "Slider",
                ValueName = "RushAttackBuffer",

                Updated = function(p91, p92) -- Line: 363, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.RushAttackBuffer.Value = p92;
                end,

                Callback = function(p93) -- Line: 366, Name: Callback
                    -- upvalues: Settings (copy)
                    p93:SetText(Settings.RushAttackBuffer.Value);
                    p93.Slider:Set(Settings.RushAttackBuffer.Value);
                end,

                Arguments = { 0, 0.5 }
            },
            {
                Name = "Hold to Rush Attack",
                Type = "Toggle",
                ValueName = "RushAttackHold",

                Updated = function(p94, p95) -- Line: 376, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.RushAttackHold.Value = p95;
                end,

                Callback = function(p96) -- Line: 379, Name: Callback
                    -- upvalues: Settings (copy)
                    p96:Toggle(Settings.RushAttackHold.Value);
                end
            },
            {
                Name = "Use D-Pad As Binds",
                Type = "Toggle",
                ValueName = "DPadAsBinds",

                Updated = function(p97, p98) -- Line: 387, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.DPadAsBinds.Value = p98;
                end,

                Callback = function(p99) -- Line: 390, Name: Callback
                    -- upvalues: Settings (copy)
                    p99:Toggle(Settings.DPadAsBinds.Value);
                end
            },
            {
                Name = "Abilities",
                Type = "Border"
            },
            {
                Name = "Auto Enable PvP",
                Type = "Toggle",
                ValueName = "AutoPvPActivate",

                Updated = function(p100, p101) -- Line: 401, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.AutoPvPActivate.Value = p101;
                end,

                Callback = function(p102) -- Line: 404, Name: Callback
                    -- upvalues: Settings (copy)
                    p102:Toggle(Settings.AutoPvPActivate.Value);
                end
            },
            {
                Name = "Pillarman Friends",
                Type = "Toggle",
                ValueName = "PillarmenFriendsActive",

                Updated = function(p103, p104) -- Line: 411, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.PillarmenFriendsActive.Value = p104;
                end,

                Callback = function(p105) -- Line: 414, Name: Callback
                    -- upvalues: Settings (copy)
                    p105:Toggle(Settings.PillarmenFriendsActive.Value);
                end
            },
            {
                Name = "TWOH Lightning on Pose",
                Type = "Toggle",
                ValueName = "TWOHPoseLightning",

                Updated = function(p106, p107) -- Line: 421, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.TWOHPoseLightning.Value = p107;
                end,

                Callback = function(p108) -- Line: 424, Name: Callback
                    -- upvalues: Settings (copy)
                    p108:Toggle(Settings.TWOHPoseLightning.Value);
                end
            },
            {
                Name = "Devil Hybrid Head",
                Type = "Toggle",
                ValueName = "DevilHybridHead",

                Updated = function(p109, p110) -- Line: 431, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.DevilHybridHead.Value = p110;
                end,

                Callback = function(p111) -- Line: 434, Name: Callback
                    -- upvalues: Settings (copy)
                    p111:Toggle(Settings.DevilHybridHead.Value);
                end,

                VIsible = v2
            },
            {
                Name = "Emotes",
                Type = "Border"
            },
            {
                Name = "Sync Emotes",
                Type = "Toggle",
                ValueName = "ShouldSyncEmotes",

                Updated = function(p112, p113) -- Line: 446, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ShouldSyncEmotes.Value = p113;
                end,

                Callback = function(p114) -- Line: 449, Name: Callback
                    -- upvalues: Settings (copy)
                    p114:Toggle(Settings.ShouldSyncEmotes.Value);
                end
            },
            {
                Name = "Specialist on Mythic+ Pull (Requires Community Emote Pack)",
                Type = "Toggle",
                ValueName = "SpecialistOnValuable",

                Updated = function(p115, p116) -- Line: 456, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.SpecialistOnValuable.Value = p116;
                end,

                Callback = function(p117) -- Line: 459, Name: Callback
                    -- upvalues: Settings (copy)
                    p117:Toggle(Settings.SpecialistOnValuable.Value);
                end
            },
            {
                Name = "Cosmetic Gamepasses",
                Type = "Border"
            },
            {
                Name = "Chat Text Color",
                Type = "Color",
                ValueName = "ChatTextColor",
                GamepassId = 11491183,

                Updated = function(p118, p119) -- Line: 470, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ChatTextColor.Value = p119;
                end,

                Callback = function(p120) -- Line: 473, Name: Callback
                    -- upvalues: Settings (copy)
                    p120:SetColor(Settings.ChatTextColor.Value);
                end
            },
            {
                Name = "Chat Bubble Text Color",
                Type = "Color",
                ValueName = "BubbleTextColor",
                GamepassId = 11491183,

                Updated = function(p121, p122) -- Line: 481, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.BubbleTextColor.Value = p122;
                end,

                Callback = function(p123) -- Line: 484, Name: Callback
                    -- upvalues: Settings (copy)
                    p123:SetColor(Settings.BubbleTextColor.Value);
                end
            },
            {
                Name = "Chat Bubble Background Color",
                Type = "Color",
                ValueName = "BubbleBackgroundColor",
                GamepassId = 11581293,

                Updated = function(p124, p125) -- Line: 492, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.BubbleBackgroundColor.Value = p125;
                end,

                Callback = function(p126) -- Line: 495, Name: Callback
                    -- upvalues: Settings (copy)
                    p126:SetColor(Settings.BubbleBackgroundColor.Value);
                end
            },
            {
                Name = "Increase Custom Chat Visibility",
                Type = "Toggle",
                ValueName = "IncreaseCustomChatVisibility",

                Updated = function(p127, p128) -- Line: 503, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.IncreaseCustomChatVisibility.Value = p128;
                end,

                Callback = function(p129) -- Line: 506, Name: Callback
                    -- upvalues: Settings (copy)
                    p129:Toggle(Settings.IncreaseCustomChatVisibility.Value);
                end
            }
        },
        Video = {
            {
                Name = "Bosses",
                Type = "Border"
            },
            {
                Name = "Bounty Posters",
                Type = "Toggle",
                ValueName = "BountyPosters",

                Updated = function(p130, p131) -- Line: 519, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.BountyPosters.Value = p131;
                end,

                Callback = function(p132) -- Line: 522, Name: Callback
                    -- upvalues: Settings (copy)
                    p132:Toggle(Settings.BountyPosters.Value);
                end
            },
            {
                Name = "Quality",
                Type = "Border"
            },
            {
                Name = "Materials",
                Type = "Toggle",
                ValueName = "Materials",

                Updated = function(p133, p134) -- Line: 533, Name: Updated
                    -- upvalues: Settings (copy), u5 (copy)
                    Settings.Materials.Value = p134;

                    if not u5 then
                        return;
                    end;

                    u5:Toggle(not Settings.Materials.Value);
                end,

                Callback = function(p135) -- Line: 538, Name: Callback
                    -- upvalues: Settings (copy)
                    p135:Toggle(Settings.Materials.Value);
                end
            },
            {
                Name = "Textures",
                Type = "Toggle",
                ValueName = "Textures",

                Updated = function(p136, p137) -- Line: 545, Name: Updated
                    -- upvalues: Settings (copy), u6 (copy)
                    Settings.Textures.Value = p137;

                    if not u6 then
                        return;
                    end;

                    u6:Toggle(not Settings.Textures.Value);
                end,

                Callback = function(p138) -- Line: 550, Name: Callback
                    -- upvalues: Settings (copy)
                    p138:Toggle(Settings.Textures.Value);
                end
            },
            {
                Name = "Extra Props",
                Type = "Toggle",
                ValueName = "ExtraProps",

                Updated = function(p139, p140) -- Line: 557, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ExtraProps.Value = p140;
                    local v141 = { "ExtraDecoration" };

                    if Settings.ExtraProps.Value then
                        for _, child in pairs(game.ReplicatedStorage.ReplicatedAssets:GetChildren()) do
                            if table.find(v141, child.Name) then
                                child.Parent = game.Workspace.Map;
                            end;
                        end;

                        return;
                    end;

                    for _, child in pairs(game.Workspace.Map:GetChildren()) do
                        if table.find(v141, child.Name) then
                            child.Parent = game.ReplicatedStorage.ReplicatedAssets;
                        end;
                    end;
                end,

                Callback = function(p142) -- Line: 576, Name: Callback
                    -- upvalues: Settings (copy)
                    p142:Toggle(Settings.ExtraProps.Value);
                end
            },
            {
                Name = "Shadows",
                Type = "Toggle",
                ValueName = "Shadows",

                Updated = function(p143, p144) -- Line: 583, Name: Updated
                    -- upvalues: Settings (copy), u7 (copy)
                    Settings.Shadows.Value = p144;
                    game.Lighting.GlobalShadows = p144;

                    if u7 then
                        u7:Toggle(Settings.Shadows.Value);
                    end;
                end,

                Callback = function(p145) -- Line: 588, Name: Callback
                    -- upvalues: Settings (copy)
                    p145:Toggle(Settings.Shadows.Value);
                end
            },
            {
                Name = "Effects Quality",
                Type = "Selection",
                ValueName = "EffectsQuality",

                Updated = function(p146, p147) -- Line: 595, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.EffectsQuality.Value = p147;
                end,

                Callback = function(p148) -- Line: 598, Name: Callback
                    p148:Select(2);
                end,

                Arguments = { { 1, 2 } }
            },
            {
                Name = "Particle Emission Scalar",
                Type = "Slider",
                ValueName = "ParticleEmissionScalar",

                Updated = function(p149, p150) -- Line: 609, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ParticleEmissionScalar.Value = p150;
                end,

                Callback = function(p151) -- Line: 612, Name: Callback
                    -- upvalues: Settings (copy)
                    p151:SetText(Settings.ParticleEmissionScalar.Value);
                    p151.Slider:Set(Settings.ParticleEmissionScalar.Value);
                end,

                Arguments = { 0, 1, true, 0.1 }
            },
            {
                Name = "Visual",
                Type = "Border"
            },
            {
                Name = "Depth of Field",
                Type = "Toggle",
                ValueName = "DoFEffect",

                Updated = function(p152, p153) -- Line: 624, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.DoFEffect.Value = p153;
                    game.Lighting.DefaultDepthOfField.Enabled = p153;
                end,

                Callback = function(p154) -- Line: 628, Name: Callback
                    -- upvalues: Settings (copy)
                    p154:Toggle(Settings.DoFEffect.Value);
                end
            },
            {
                Name = "Camera Shake",
                Type = "Toggle",
                ValueName = "CameraShake",

                Updated = function(p155, p156) -- Line: 635, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.CameraShake.Value = p156;
                end,

                Callback = function(p157) -- Line: 638, Name: Callback
                    -- upvalues: Settings (copy)
                    p157:Toggle(Settings.CameraShake.Value);
                end
            },
            {
                Name = "Gore",
                Type = "Toggle",
                ValueName = "Gore",

                Updated = function(p158, p159) -- Line: 645, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.Gore.Value = p159;
                end,

                Callback = function(p160) -- Line: 648, Name: Callback
                    -- upvalues: Settings (copy)
                    p160:Toggle(Settings.Gore.Value);
                end
            },
            {
                Name = "Title Auras",
                Type = "Toggle",
                ValueName = "TitleAuras",

                Updated = function(p161, p162) -- Line: 655, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.TitleAuras.Value = p162;
                end,

                Callback = function(p163) -- Line: 658, Name: Callback
                    -- upvalues: Settings (copy)
                    p163:Toggle(Settings.TitleAuras.Value);
                end
            },
            {
                Name = "Cosmetic Changes",
                Type = "Toggle",
                ValueName = "CosmeticalChanges",

                Updated = function(p164, p165) -- Line: 665, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.CosmeticalChanges.Value = p165;
                end,

                Callback = function(p166) -- Line: 668, Name: Callback
                    -- upvalues: Settings (copy)
                    p166:Toggle(Settings.CosmeticalChanges.Value);
                end
            },
            {
                Name = "Hide Haki Coating on Weapons",
                Type = "Toggle",
                ValueName = "HideHakiCoating",

                Updated = function(p167, p168) -- Line: 676, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.HideHakiCoating.Value = p168;
                end,

                Callback = function(p169) -- Line: 679, Name: Callback
                    -- upvalues: Settings (copy)
                    p169:Toggle(Settings.HideHakiCoating.Value);
                end
            },
            {
                Name = "Show Character Aura",
                Type = "Toggle",
                ValueName = "CharacterAura",
                Visible = true,

                Updated = function(p170, p171) -- Line: 687, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.CharacterAura.Value = p171;
                end,

                Callback = function(p172) -- Line: 690, Name: Callback
                    -- upvalues: Settings (copy)
                    p172:Toggle(Settings.CharacterAura.Value);
                end
            },
            {
                Name = "Hide Global Announcements",
                Type = "Toggle",
                ValueName = "GlobalAnnouncementsHidden",
                Visible = true,

                Updated = function(p173, p174) -- Line: 698, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.GlobalAnnouncementsHidden.Value = p174;
                end,

                Callback = function(p175) -- Line: 701, Name: Callback
                    -- upvalues: Settings (copy)
                    p175:Toggle(Settings.GlobalAnnouncementsHidden.Value);
                end
            },
            {
                Name = "Impact Frame",
                Type = "Toggle",
                ValueName = "ImpactFrame",

                Updated = function(p176, p177) -- Line: 709, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.ImpactFrame.Value = p177;
                end,

                Callback = function(p178) -- Line: 712, Name: Callback
                    -- upvalues: Settings (copy)
                    p178:Toggle(Settings.ImpactFrame.Value);
                end
            },
            {
                Name = "Pose Extras Visibility",
                Type = "Selection",
                ValueName = "PoseExtrasVisibility",

                Updated = function(p179, p180) -- Line: 719, Name: Updated
                    -- upvalues: Settings (copy)
                    local v181 = p179:GetRawData();
                    Settings.PoseExtrasVisibility.Value = table.find(v181.Arguments[1], p180);
                end,

                Callback = function(p182) -- Line: 723, Name: Callback
                    -- upvalues: Settings (copy)
                    p182:Select(p182:GetRawData().Arguments[1][Settings.PoseExtrasVisibility.Value]);
                end,

                Arguments = { { "Everyone", "Self", "Off" } }
            },
            {
                Name = "Show others\' special quote effects",
                Type = "Toggle",
                ValueName = "QuoteScreenEffects",

                Updated = function(p183, p184) -- Line: 736, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.QuoteScreenEffects.Value = p184;
                end,

                Callback = function(p185) -- Line: 739, Name: Callback
                    -- upvalues: Settings (copy)
                    p185:Toggle(Settings.QuoteScreenEffects.Value);
                end
            },
            {
                Name = "Hide Visuals for Cards",
                Type = "Toggle",
                ValueName = "HideVisuals",

                Updated = function(p186, p187) -- Line: 747, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.HideVisuals.Value = p187;
                end,

                Callback = function(p188) -- Line: 750, Name: Callback
                    -- upvalues: Settings (copy)
                    p188:Toggle(Settings.HideVisuals.Value);
                end
            }
        },
        Audio = {
            {
                Name = "Master Volume",
                Type = "Slider",
                ValueName = "MasterVolume",

                Updated = function(p189, p190) -- Line: 759, Name: Updated
                    -- upvalues: Settings (copy), u1 (copy)
                    Settings.MasterVolume.Value = p190;
                    u1:UpdateVolumes();
                end,

                Callback = function(p191) -- Line: 763, Name: Callback
                    -- upvalues: Settings (copy)
                    p191:SetText(Settings.MasterVolume.Value);
                    p191.Slider:Set(Settings.MasterVolume.Value);
                end,

                Arguments = { 0, 100, true }
            },
            {
                Name = "Sound Effect Volume",
                Type = "Slider",
                ValueName = "SoundEffectVolume",

                Updated = function(p192, p193) -- Line: 772, Name: Updated
                    -- upvalues: Settings (copy), u1 (copy)
                    Settings.SoundEffectVolume.Value = p193;
                    u1:UpdateVolumes();
                end,

                Callback = function(p194) -- Line: 776, Name: Callback
                    -- upvalues: Settings (copy)
                    p194:SetText(Settings.SoundEffectVolume.Value);
                    p194.Slider:Set(Settings.SoundEffectVolume.Value);
                end,

                Arguments = { 0, 100, true }
            },
            {
                Name = "Music Volume",
                Type = "Slider",
                ValueName = "MusicVolume",

                Updated = function(p195, p196) -- Line: 785, Name: Updated
                    -- upvalues: Settings (copy), u1 (copy)
                    Settings.MusicVolume.Value = p196;
                    u1:UpdateVolumes();
                end,

                Callback = function(p197) -- Line: 789, Name: Callback
                    -- upvalues: Settings (copy)
                    p197:SetText(Settings.MusicVolume.Value);
                    p197.Slider:Set(Settings.MusicVolume.Value);
                end,

                Arguments = { 0, 100, true }
            },
            {
                Name = "Ambience Volume",
                Type = "Slider",
                ValueName = "AmbienceVolume",

                Updated = function(p198, p199) -- Line: 798, Name: Updated
                    -- upvalues: Settings (copy), u1 (copy)
                    Settings.AmbienceVolume.Value = p199;
                    u1:UpdateVolumes();
                end,

                Callback = function(p200) -- Line: 802, Name: Callback
                    -- upvalues: Settings (copy)
                    p200:SetText(Settings.AmbienceVolume.Value);
                    p200.Slider:Set(Settings.AmbienceVolume.Value);
                end,

                Arguments = { 0, 100, true }
            },
            {
                Name = "Footsteps Volume",
                Type = "Slider",
                ValueName = "ClientEmoteVolume",

                Updated = function(p201, p202) -- Line: 811, Name: Updated
                    -- upvalues: Settings (copy), u1 (copy)
                    Settings.FootstepsVolume.Value = p202;
                    u1:UpdateVolumes();
                end,

                Callback = function(p203) -- Line: 815, Name: Callback
                    -- upvalues: Settings (copy)
                    p203:SetText(Settings.FootstepsVolume.Value);
                    p203.Slider:Set(Settings.FootstepsVolume.Value);
                end,

                Arguments = { 0, 100, true }
            },
            {
                Name = "Pose / Emote (Yours) Volume",
                Type = "Slider",
                ValueName = "ClientEmoteVolume",

                Updated = function(p204, p205) -- Line: 824, Name: Updated
                    -- upvalues: Settings (copy), u1 (copy)
                    Settings.ClientEmoteVolume.Value = p205;
                    u1:UpdateVolumes();
                end,

                Callback = function(p206) -- Line: 828, Name: Callback
                    -- upvalues: Settings (copy)
                    p206:SetText(Settings.ClientEmoteVolume.Value);
                    p206.Slider:Set(Settings.ClientEmoteVolume.Value);
                end,

                Arguments = { 0, 100, true }
            },
            {
                Name = "Pose / Emote (Others) Volume",
                Type = "Slider",
                ValueName = "OtherEmoteVolume",

                Updated = function(p207, p208) -- Line: 837, Name: Updated
                    -- upvalues: Settings (copy), u1 (copy)
                    Settings.OtherEmoteVolume.Value = p208;
                    u1:UpdateVolumes();
                end,

                Callback = function(p209) -- Line: 841, Name: Callback
                    -- upvalues: Settings (copy)
                    p209:SetText(Settings.OtherEmoteVolume.Value);
                    p209.Slider:Set(Settings.OtherEmoteVolume.Value);
                end,

                Arguments = { 0, 100, true }
            },
            {
                Name = "Custom Voicelines",
                Type = "Toggle",
                ValueName = "Voicelines",

                Updated = function(p210, p211) -- Line: 850, Name: Updated
                    -- upvalues: Settings (copy)
                    Settings.Voicelines.Value = p211;
                end,

                Callback = function(p212) -- Line: 853, Name: Callback
                    -- upvalues: Settings (copy)
                    p212:Toggle(Settings.Voicelines.Value);
                end
            }
        }
    };
    local u214 = u1.Knit.GetService("ShopService");
    local success, result = pcall(function() -- Line: 862
        -- upvalues: u1 (copy), u214 (copy), ItemData (copy), Settings (copy), u213 (copy)
        if not (game:GetService("MarketplaceService"):UserOwnsGamePassAsync(u1.Player.UserId, 10562035) or u214:OwnsGamepass(u1.Player.UserId, 10562035):expect()) and game.GameId ~= 1900951801 then
            return;
        end;

        local v215 = {};
        local v216 = { {
                Name = "Item Notifier",
                Type = "Border"
            } };

        for _, v in ItemData.GetItems() do
            local Rarity = v.Rarity;

            if v.ItemType == "Item" and (type(Rarity) == "number" and not table.find(v215, Rarity)) then
                table.insert(v215, Rarity);
            end;
        end;

        table.sort(v215, function(p217, p218) -- Line: 884
            return p217 < p218;
        end);

        for _, v in v215 do
            local u219 = ItemData.GetRarityData(v);
            local v223 = {
                Type = "Toggle",
                Name = `Toggle {u219.Name}`,

                Updated = function(p220, p221) -- Line: 893, Name: Updated
                    -- upvalues: Settings (ref), u219 (copy)
                    Settings[`Toggle{u219.Name}`].Value = p221;
                end,

                Callback = function(p222) -- Line: 896, Name: Callback
                    -- upvalues: Settings (ref), u219 (copy)
                    p222:Toggle(Settings[`Toggle{u219.Name}`].Value);
                end,

                ValueName = `Toggle{u219.Name}`
            };
            table.insert(v216, v223);
        end;

        for _, v in v216 do
            table.insert(u213.Gameplay, v);
        end;
    end);
    local success2, result2 = pcall(function() -- Line: 908
        -- upvalues: ItemData (copy), Settings (copy), u1 (copy), u213 (copy)
        local v224 = {};
        local v225 = { {
                Name = "Auto-Delete Skins",
                Type = "Border"
            } };

        for _, v in ItemData.GetSkins() do
            local Rarity = v.Rarity;

            if type(Rarity) == "number" and (Rarity ~= 8 and (Rarity ~= 9 and (Rarity ~= 10 and not table.find(v224, Rarity)))) then
                table.insert(v224, Rarity);
            end;
        end;

        table.sort(v224, function(p226, p227) -- Line: 923
            return p226 < p227;
        end);

        for _, v in v224 do
            local u228 = ItemData.GetRarityData(v);
            local v233 = {
                Type = "Toggle",
                Name = `Auto-Delete {u228.Name}`,

                Updated = function(u229, p230) -- Line: 932, Name: Updated
                    -- upvalues: Settings (ref), u228 (copy), u1 (ref)
                    if p230 == true and Settings[`AutoDelete{u228.Name}`].Value == false then
                        u1.NewPrompt({
                            Title = "Auto-Delete Warning",
                            Delay = 0,
                            RichText = true,
                            Text = `You are about to enable ugo-delete for <font color="#{u228.Color:ToHex()}">{u228.Name}</font> skins.\n\n<font color="#ff4444">WARNING:</font> <font color="#{u228.Color:ToHex()}">{u228.Name}</font> skins will be ugomatically deleted <font color="#ff4444">UNLESS</font> they are:\n• <font color="#ffc053">Premium skins</font>\n• <font color="#5E3D9F">Unusual skins</font>\n\nThis affects <font color="#ff4444">ALL</font> <font color="#{u228.Color:ToHex()}">{u228.Name}</font> skins obtained from <font color="#ff4444">ANY</font> source:\n• Trading with other players\n• Unusual Rolling\n• NPC Drops\n• NPC Crates\n• Skin Crates\n• Any other obtainment method\n\nDeleted skins are <font color="#ff4444">NOT eligible for restoration</font> by Universe Game staff team.\n\nAre you sure you want to enable this?`,
                            Options = { "Yes", "No" },

                            Callback = function(p231) -- Line: 943, Name: Callback
                                -- upvalues: Settings (ref), u228 (ref), u229 (copy)
                                if p231.Choice == 1 then
                                    Settings[`AutoDelete{u228.Name}`].Value = true;

                                    return true;
                                end;

                                Settings[`AutoDelete{u228.Name}`].Value = false;
                                u229:Toggle(false);
                            end
                        });

                        return;
                    end;

                    Settings[`AutoDelete{u228.Name}`].Value = p230;
                end,

                Callback = function(p232) -- Line: 957, Name: Callback
                    -- upvalues: Settings (ref), u228 (copy)
                    p232:Toggle(Settings[`AutoDelete{u228.Name}`].Value);
                end,

                ValueName = `AutoDelete{u228.Name}`
            };
            table.insert(v225, v233);
        end;

        for _, v in v225 do
            table.insert(u213.Gameplay, v);
        end;
    end);

    if not success2 then
        warn(result2);
    end;

    local v234 = {};

    for _, v in u213 do
        local v235 = 1;

        while v235 <= #v do
            local v236 = v[v235];

            if v236.GamepassId == nil then
                v235 = v235 + 1;
            else
                if v234[v236.GamepassId] == nil then
                    v234[v236.GamepassId] = u214:OwnsGamepass(u1.Player.UserId, v236.GamepassId):expect();
                end;

                if v234[v236.GamepassId] == true then
                    v235 = v235 + 1;
                else
                    table.remove(v, v235);
                end;
            end;
        end;
    end;

    if not success then
        warn(result);
    end;

    u1.LastSettingsTab = nil;

    function u1.SetSettingsTab(p237, p238) -- Line: 992
        if p238 == "Back" and p237.LastSettingsTab then
            p238 = p237.LastSettingsTab;
        end;

        for _, child in pairs(script.Parent.Tabs:GetChildren()) do
            if child:IsA("ScrollingFrame") or child:IsA("Frame") then
                if child.Visible and child.Name ~= p238 then
                    p237.LastSettingsTab = child.Name;
                end;

                child.Visible = child.Name == p238;
            end;
        end;
    end;

    for i, v in pairs(u213) do
        local u239 = script.Parent.Tabs:FindFirstChild(i);

        if u239 then
            for i2, v3 in pairs(v) do
                task.spawn(function() -- Line: 1010
                    -- upvalues: v3 (copy), Settings (copy), Option (ref), i2 (copy), u239 (copy), u4 (copy)
                    if v3.ValueName then
                        Settings:WaitForChild(v3.ValueName);
                    end;

                    local v240 = v3.Arguments or {};
                    local u241 = Option.new(v3.Type, unpack(v240));
                    u241:SetRawData(v3);
                    u241.Option.Text = v3.Text or (v3.Name or "?");
                    u241.Option.Name = tostring(i2);

                    if v3.Updated then
                        u241.Updated:Connect(function(...) -- Line: 1020
                            -- upvalues: v3 (ref), u241 (copy)
                            v3.Updated(u241, ...);
                        end);

                        if u241.Slider then
                            u241.Slider.Changed.Event:Connect(function(...) -- Line: 1024
                                -- upvalues: v3 (ref), u241 (copy)
                                v3.Updated(u241, ...);
                            end);
                        end;
                    end;

                    if v3.Callback then
                        v3.Callback(u241, unpack(v240));
                    end;

                    u241.ValueName = v3.ValueName;
                    u241.Option.Visible = v3.Visible == nil and true or v3.Visible;
                    u241.Option.Parent = u239;
                    table.insert(u4, u241);
                end);
            end;
        end;
    end;

    script.Parent.Actions.A_Reset.MouseButton1Down:Connect(function() -- Line: 1041
        -- upvalues: u1 (copy), u3 (copy), Settings (copy), u4 (copy)
        u1:Prompt("Reset Settings", "Are you sure you want to reset all settings?", "choose", function(p242, p243, p244) -- Line: 1046
            -- upvalues: u1 (ref), u3 (ref), Settings (ref), u4 (ref)
            u1:PlaySound("Click");

            if p243 == 1 then
                return true;
            end;

            if p243 == 2 then
                for i, v in pairs(u3) do
                    local v245 = Settings:FindFirstChild(i);

                    if v245 then
                        v245.Value = v;
                    end;
                end;

                for _, v in pairs(u4) do
                    local v246 = v.ValueName and Settings:FindFirstChild(v.ValueName);

                    if v246 then
                        if v.Type == "Selection" then
                            v:Select(v246.Value);
                        elseif v.Type == "Toggle" then
                            v:Toggle(v246.Value);
                        elseif v.Type == "Slider" then
                            v:SetText(v246.Value);
                            v.Slider:Set(v246.Value);
                        elseif v.Type == "Color" then
                            v:SetColor(v246.Value);
                        end;
                    end;
                end;

                task.defer(function() -- Line: 1073
                    -- upvalues: u1 (ref)
                    u1:Prompt("Reset successful!", "All your settings have been reset.", "ok");
                end);
            end;
        end);
    end);
    script.Parent.Actions.B_Save.MouseButton1Down:Connect(function() -- Line: 1081
        -- upvalues: Settings (copy), Remotes (copy), u1 (copy)
        local v247 = {};

        for _, child in pairs(Settings:GetChildren()) do
            v247[child.Name] = child:GetAttribute("SaveValue") or child.Value;
        end;

        local u248 = Remotes.Settings:InvokeServer("Save", v247);

        if u248 == "Success" then
            u1:Prompt("Save success!", "All your settings have been saved.", "ok");

            return;
        end;

        if u248 == "Wait" then
            u1:Prompt("Saving failed", "Please wait before saving your settings again.", "ok");

            return;
        end;

        task.defer(function() -- Line: 1092
            -- upvalues: u1 (ref), u248 (copy)
            u1:Prompt("Saving failed", "Error: " .. tostring(u248), "ok");
        end);
    end);
end;