  

 

require(script:WaitForChild("Option"));

return function(p1) -- Line: 3
    table.find(p1.PathShortcuts.TestPlaces, game.PlaceId);
    local _ = p1.Xtal;
    local Settings = p1.Player:WaitForChild("Settings");
    game.ReplicatedStorage:WaitForChild("Remotes").Settings:InvokeServer("RequestDefaults");
    ({}).ControlPanel = {
        {
            Name = "Visualizer Controls",
            Type = "Border"
        },
        {
            Name = "Sound Wave Ring Enabled",
            Type = "Toggle",
            ValueName = "PS_SOUND_WAVE_RING_ENABLED",

            Updated = function(p2, p3) -- Line: 21, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_SOUND_WAVE_RING_ENABLED.Value = p3;
            end,

            Callback = function(p4) -- Line: 24, Name: Callback
                -- upvalues: Settings (copy)
                p4:Toggle(Settings.PS_SOUND_WAVE_RING_ENABLED.Value);
            end
        },
        {
            Name = "Field Of View Change Enabled",
            Type = "Toggle",
            ValueName = "PS_FOV_CHANGE",

            Updated = function(p5, p6) -- Line: 31, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_FOV_CHANGE.Value = p6;
            end,

            Callback = function(p7) -- Line: 34, Name: Callback
                -- upvalues: Settings (copy)
                p7:Toggle(Settings.PS_FOV_CHANGE.Value);
            end
        },
        {
            Name = "Core Sound Ball Enabled",
            Type = "Toggle",
            ValueName = "PS_CORE_SOUND_BALL",

            Updated = function(p8, p9) -- Line: 41, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_CORE_SOUND_BALL.Value = p9;
            end,

            Callback = function(p10) -- Line: 44, Name: Callback
                -- upvalues: Settings (copy)
                p10:Toggle(Settings.PS_CORE_SOUND_BALL.Value);
            end
        },
        {
            Name = "Visualizer Particles Enabled",
            Type = "Toggle",
            ValueName = "PS_PARTICLES",

            Updated = function(p11, p12) -- Line: 51, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_PARTICLES.Value = p12;
            end,

            Callback = function(p13) -- Line: 54, Name: Callback
                -- upvalues: Settings (copy)
                p13:Toggle(Settings.PS_PARTICLES.Value);
            end
        },
        {
            Name = "Tempo Visualizers Enabled",
            Type = "Toggle",
            ValueName = "PS_TEMPO_VISUALIZERS",

            Updated = function(p14, p15) -- Line: 61, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_TEMPO_VISUALIZERS.Value = p15;
            end,

            Callback = function(p16) -- Line: 64, Name: Callback
                -- upvalues: Settings (copy)
                p16:Toggle(Settings.PS_TEMPO_VISUALIZERS.Value);
            end
        },
        {
            Name = "Quality Preset",
            Type = "Selection",
            ValueName = "PS_VISUALIZER_QUALITY_TYPE",

            Updated = function(p17, p18) -- Line: 71, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_VISUALIZER_QUALITY_TYPE.Value = p18;
            end,

            Callback = function(p19) -- Line: 74, Name: Callback
                -- upvalues: Settings (copy)
                p19:Select(Settings.PS_VISUALIZER_QUALITY_TYPE.Value);
            end,

            Arguments = { { "Modern", "Simple" } }
        },
        {
            Name = "Ground Wave Enabled",
            Type = "Toggle",
            ValueName = "PS_GROUND_WAVE",

            Updated = function(p20, p21) -- Line: 86, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_GROUND_WAVE.Value = p21;
            end,

            Callback = function(p22) -- Line: 89, Name: Callback
                -- upvalues: Settings (copy)
                p22:Toggle(Settings.PS_GROUND_WAVE.Value);
            end
        },
        {
            Name = "Slider Controls",
            Type = "Border"
        },
        {
            Name = "Visualizer Scaling",
            Type = "Slider",
            ValueName = "PS_VISUALIZER_SCALING",

            Updated = function(p23, p24) -- Line: 99, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_VISUALIZER_SCALING.Value = p24;
            end,

            Callback = function(p25) -- Line: 102, Name: Callback
                -- upvalues: Settings (copy)
                p25:SetText(Settings.PS_VISUALIZER_SCALING.Value);
                p25.Slider:Set(Settings.PS_VISUALIZER_SCALING.Value);
            end,

            Arguments = { 0, 100, true }
        },
        {
            Name = "Visualizer Divisions",
            Type = "Slider",
            ValueName = "PS_VISUALIZER_DIVISIONS",

            Updated = function(p26, p27) -- Line: 111, Name: Updated
                -- upvalues: Settings (copy)
                Settings.PS_VISUALIZER_DIVISIONS.Value = p27;
            end,

            Callback = function(p28) -- Line: 114, Name: Callback
                -- upvalues: Settings (copy)
                p28:SetText(Settings.PS_VISUALIZER_DIVISIONS.Value);
                p28.Slider:Set(Settings.PS_VISUALIZER_DIVISIONS.Value);
            end,

            Arguments = { 1, 16, true }
        }
    };
end;