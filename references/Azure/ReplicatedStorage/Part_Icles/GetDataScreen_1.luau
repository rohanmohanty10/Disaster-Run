 
 

return {
    readSound = function(p1, p2) -- Line: 12, Name: readSound
        p1.Lifetime = p2:GetAttribute("Lifetime") or NumberRange.new(0);
        p1.Rate = p2:GetAttribute("Rate") or 10;
        p1.SndVolume = p2:GetAttribute("SndVolume");
        p1.SndPlaybackSpeed = p2:GetAttribute("SndPlaybackSpeed");
        p1.SndTimescale = p2:GetAttribute("SndTimescale");
        p1.RollOffMin = p2:GetAttribute("RollOffMin") or 10;
        p1.RollOffMax = p2:GetAttribute("RollOffMax") or 10000;
        p1.Looped = p2:GetAttribute("Looped") == true;
        p1.StartOffset = p2:GetAttribute("StartOffset") or 0;
        p1.Local2D = p2:GetAttribute("Local2D") == true;

        return p1;
    end,

    readCameraShake = function(p3, p4) -- Line: 27, Name: readCameraShake
        p3.PartLife = 0;
        p3.Lifetime = p4:GetAttribute("Lifetime") or NumberRange.new(0.5);
        p3.Rate = p4:GetAttribute("Rate") or 10;
        p3.ShakeAmplitude = p4:GetAttribute("ShakeAmplitude");
        p3.ShakeRotAmplitude = p4:GetAttribute("ShakeRotAmplitude");
        local Attribute = p4:GetAttribute("ShakeFrequency");

        if type(Attribute) == "number" then
            Attribute = NumberSequence.new(Attribute);
        end;

        p3.ShakeFrequency = Attribute;
        p3.ShakeFalloff = p4:GetAttribute("ShakeFalloff") or 0;
        p3.Timescale = p4:GetAttribute("Timescale");

        return p3;
    end,

    readDistortion = function(p5, p6) -- Line: 43, Name: readDistortion
        p5.PartLife = 0;
        p5.Lifetime = p6:GetAttribute("Lifetime") or NumberRange.new(0.5);
        p5.Rate = p6:GetAttribute("Rate") or 10;
        p5.FieldKind = p6:GetAttribute("FieldKind") or "Ripple";
        p5.Amplitude = p6:GetAttribute("Amplitude");
        p5.Transparency = p6:GetAttribute("Transparency");
        p5.Wavelength = p6:GetAttribute("Wavelength") or 1.5;
        p5.Speed = p6:GetAttribute("Speed") or 3;
        p5.Direction = p6:GetAttribute("Direction") or 0;
        p5.NoiseScale = p6:GetAttribute("NoiseScale") or 2;
        p5.LensRadius = p6:GetAttribute("LensRadius") or 1.5;
        p5.EpicenterMode = p6:GetAttribute("EpicenterMode") or "WorldPoint";
        p5.Falloff = p6:GetAttribute("Falloff") or 0;
        p5.Strength = p6:GetAttribute("Strength") or 1;
        p5.Amplify = p6:GetAttribute("Amplify") or 0;
        p5.AllowOverdrive = p6:GetAttribute("AllowOverdrive") == true;
        p5.Resolution = p6:GetAttribute("Resolution") or 24;
        p5.Timescale = p6:GetAttribute("Timescale");

        return p5;
    end
};